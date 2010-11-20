From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 09/15] vcs-svn: Delay read of per-path properties
Date: Fri, 19 Nov 2010 18:52:28 -0600
Message-ID: <20101120005228.GJ17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:53:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbhh-0002gi-KM
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0KTAxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:53:17 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64956 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694Ab0KTAxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:53:16 -0500
Received: by gwb20 with SMTP id 20so367971gwb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JNvcUfEzGgRlU2FmdHwf4mHFHjuUlulw8/sGpF0Eu4Q=;
        b=UtryoseVJRilzn/E4nl5Fjgx/gCmKr6+qm0pU1lbSsyqWnpwqe+ufHYVQdn1P8a2r7
         gd6heaouSQ9yNIk8UJX+w6tu6xe8hCj3lapuswWKshrV2XyuhI1iHZzJUmuwPF4ooNYb
         TvoD8l408kJxtbje9M/cT4FlaIOOq3l68XNVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cnIFmnUQ9kzj9PZLSe4Di+/ZV+VKuqZE/C61yCUR/Ji+fECnRJVJ4y3S9Jp3DtNpIs
         jFdpxfGxTjPDx6JrFhXYRLJnKL+FOcYnN5eOeJyLomhx2DX0gtFR2rHrN4Axmw+IREeh
         ePwcpgR69VVEOKphRgGoc4DfVJeHljtAdxByQ=
Received: by 10.151.10.7 with SMTP id n7mr4624657ybi.228.1290214395634;
        Fri, 19 Nov 2010 16:53:15 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k2sm191933ybj.20.2010.11.19.16.53.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:53:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161809>

The mode for each file in an svn-format dump is kept in the properties
section.  The properties section is read as soon as possible to allow
the correct mode to be filled in when registering the file with the
repo_tree lib.

To support nodes with a missing properties section, svn-fe determines
the mode in three stages:

 - The kind (directory or file) of the node is read from the dump and
   used to make an initial estimate (040000 or 100644).
 - Properties are read in and allowed to override this for symlinks
   and executables.
 - If there is no properties section, the mode from the previous
   content of the path is left alone, overriding the above
   considerations.

This is a bit of a mess, and worse, it would get even more complicated
once we start to support property deltas.  If we could only register
the file with a provisional value for mode and then change it later
when properties say so, the procedure would be much simpler.

... oh, right, we can.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   42 +++++++++++++++++++-----------------------
 1 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index e40be58..4fdfcbb 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -150,7 +150,8 @@ static void read_props(void)
 
 static void handle_node(void)
 {
-	uint32_t old_mode = 0, mark = 0;
+	uint32_t mark = 0;
+	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 
 	if (node_ctx.text_delta || node_ctx.prop_delta)
@@ -171,32 +172,27 @@ static void handle_node(void)
 		node_ctx.action = NODEACT_ADD;
 	}
 
-	if (have_props && node_ctx.propLength)
-		read_props();
+	if (node_ctx.srcRev) {
+		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
+		node_ctx.action = NODEACT_CHANGE;
+	}
 
-	if (node_ctx.srcRev)
-		old_mode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
-
-	if (mark && node_ctx.type == REPO_MODE_DIR)
+	if (mark && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 
-	if (node_ctx.action == NODEACT_CHANGE) {
-		if (have_props)
-			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
-		else if (mark)
-			old_mode = repo_modify_path(node_ctx.dst, 0, mark);
-	} else if (node_ctx.action == NODEACT_ADD) {
-		if (node_ctx.srcRev && have_props)
-			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
-		else if (node_ctx.srcRev && mark)
-			old_mode = repo_modify_path(node_ctx.dst, 0, mark);
-		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
-			 mark)
-			repo_add(node_ctx.dst, node_ctx.type, mark);
-	}
+	if (node_ctx.action == NODEACT_CHANGE)
+		node_ctx.type = repo_modify_path(node_ctx.dst, 0, mark);
+	else	/* Node-action: add */
+		repo_add(node_ctx.dst, type, mark);
 
-	if (!have_props && old_mode)
-		node_ctx.type = old_mode;
+	if (have_props) {
+		const uint32_t old_mode = node_ctx.type;
+		node_ctx.type = type;
+		if (node_ctx.propLength)
+			read_props();
+		if (node_ctx.type != old_mode)
+			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
+	}
 
 	if (mark)
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength);
-- 
1.7.2.3
