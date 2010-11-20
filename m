From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/15] vcs-svn: Use mark to indicate nodes with included text
Date: Fri, 19 Nov 2010 18:48:51 -0600
Message-ID: <20101120004851.GF17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbeB-000131-Ve
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab0KTAtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:49:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62601 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755461Ab0KTAtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:49:39 -0500
Received: by yxf34 with SMTP id 34so3100437yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=G2jAquZU2lWZtChYVhM7uVDIjzIgXoMRK3ytbnRGoXU=;
        b=mib4Tl8qO6a6zxVlJD4+fsuPJaRNR4sZkHpc1wBkmMZv4o//6LozeT+Z6IR1UpFmMM
         xp6/HyGTpiSdTgViC+OcxbIyahWD4cpI7+Tj017MVGO2tWj3360yeoF89f8II/JysKEi
         0DTjpDg1Ew8FXXoZTwI1ufy+14TC5+LA9eKls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gP92G5wPOieMF4bBL5A5Gkr5RQcdMF1D3sp3sS1TYD8Fe9ar7ZA6Tlitq2D38Pws2s
         S/EP4hn1z80Eo1guhFeJqPsL3vusw7RAukUMR7W1i9s9XgXIIyEg7v7ozVJGeOZEe9Qz
         gXQsZAZEikI4KYGD+noPs22DRYUeK6C+Q1zDY=
Received: by 10.101.163.5 with SMTP id q5mr1943133ano.262.1290214178528;
        Fri, 19 Nov 2010 16:49:38 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b25sm2442722anb.23.2010.11.19.16.49.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:49:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161805>

Allocate a mark if needed as soon as possible so later code can use
"if (mark)" to check if this node has text attached rather than
explicitly checking for Text-content-length.

While at it, reject directory nodes with text attached; the presence
of such a node would indicate a bug in the dump generator or svn-fe's
understanding.  In the long term, it would be nice to be able to
continue parsing and save the error for later, but for now it is
simpler to error out right away.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 45f0e47..844076b 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -156,15 +156,17 @@ static void handle_node(void)
 	if (node_ctx.text_delta || node_ctx.prop_delta)
 		die("text and property deltas not supported");
 
+	if (node_ctx.textLength != LENGTH_UNKNOWN)
+		mark = next_blob_mark();
+
 	if (have_props && node_ctx.propLength)
 		read_props();
 
 	if (node_ctx.srcRev)
 		old_mode = repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
 
-	if (node_ctx.textLength != LENGTH_UNKNOWN &&
-	    node_ctx.type != REPO_MODE_DIR)
-		mark = next_blob_mark();
+	if (mark && node_ctx.type == REPO_MODE_DIR)
+		die("invalid dump: directories cannot have text attached");
 
 	if (node_ctx.action == NODEACT_DELETE) {
 		repo_delete(node_ctx.dst);
@@ -175,15 +177,15 @@ static void handle_node(void)
 			repo_replace(node_ctx.dst, mark);
 		else if (have_props)
 			repo_modify(node_ctx.dst, node_ctx.type, mark);
-		else if (node_ctx.textLength != LENGTH_UNKNOWN)
+		else if (mark)
 			old_mode = repo_replace(node_ctx.dst, mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
 		if (node_ctx.srcRev && have_props)
 			repo_modify(node_ctx.dst, node_ctx.type, mark);
-		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
+		else if (node_ctx.srcRev && mark)
 			old_mode = repo_replace(node_ctx.dst, mark);
 		else if ((node_ctx.type == REPO_MODE_DIR && !node_ctx.srcRev) ||
-			 node_ctx.textLength != LENGTH_UNKNOWN)
+			 mark)
 			repo_add(node_ctx.dst, node_ctx.type, mark);
 	}
 
@@ -192,8 +194,6 @@ static void handle_node(void)
 
 	if (mark)
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength);
-	else if (node_ctx.textLength != LENGTH_UNKNOWN)
-		buffer_skip_bytes(node_ctx.textLength);
 }
 
 static void handle_revision(void)
-- 
1.7.2.3
