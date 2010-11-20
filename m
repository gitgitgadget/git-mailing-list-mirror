From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/15] vcs-svn: Unclutter handle_node by introducing
 have_props var
Date: Fri, 19 Nov 2010 18:47:41 -0600
Message-ID: <20101120004740.GE17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbd4-0000Ma-GN
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab0KTAsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:48:30 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64096 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab0KTAs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:48:29 -0500
Received: by yxf34 with SMTP id 34so3100161yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=n/RBIbM7eOiEYJBi0RxBBiEi+/4r6p1liKVwH8Y5fGo=;
        b=WRdxGY2SPoeU5yAWHvl7390WFFELPRU0PHoU6JdTBo3WqDOTidlAvxZpvSl0H/JtfX
         jy9FyiOMWqVyVAghhf4mTAXDVNDigjvcJKXfInUzumYIGF8Nvw/G2jjWm9dG2dofw0UM
         sgccMjR+wo9/aBBmk3EQFWnG3iSwosyZ8BSM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T2vR06snBPdjAyIsdExSfYK/qtETZk8JAXoarmEp5WXjX+Yay8TDzq7rf5dGUOCouz
         ZODx7nWVK3O2PZ6hDgD4AzJDhXRTRy16b/S8g2O3ACcP8J2tqkKWAY5tA2hf5tyTSZw6
         d+kWL56f8qWvweaO9cyNhLyLUbSOMsARLZ+oI=
Received: by 10.100.164.5 with SMTP id m5mr1956780ane.132.1290214108431;
        Fri, 19 Nov 2010 16:48:28 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 28sm2445106anv.6.2010.11.19.16.48.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:48:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161804>

It is possible for a path node in an SVN-format dump file to leave out
the properties section.  svn-fe handles this by carrying over the
properties (in particular, file type) from the old version of that
node.

To support this, handle_node tests several times whether a
Prop-content-length field is present.  Ancient Subversion actually
leaves out the Prop-content-length field even for nodes with
properties, so that's not quite the right check.  Besides, this detail
of mechanism is distracting when the question at hand is instead what
content the new node should have.

So introduce a local have_props variable.  The semantics are the same
as before; the adaptations to support ancient streams that leave out
the prop-content-length can wait until someone needs them.

Signed-off-by: Jonathan Nieder <jrnieer@gmail.com>
---
 vcs-svn/svndump.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 1fb7f82..45f0e47 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -151,11 +151,12 @@ static void read_props(void)
 static void handle_node(void)
 {
 	uint32_t old_mode = 0, mark = 0;
+	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
 
 	if (node_ctx.text_delta || node_ctx.prop_delta)
 		die("text and property deltas not supported");
 
-	if (node_ctx.propLength != LENGTH_UNKNOWN && node_ctx.propLength)
+	if (have_props && node_ctx.propLength)
 		read_props();
 
 	if (node_ctx.srcRev)
@@ -172,12 +173,12 @@ static void handle_node(void)
 		if (node_ctx.action == NODEACT_REPLACE &&
 		    node_ctx.type == REPO_MODE_DIR)
 			repo_replace(node_ctx.dst, mark);
-		else if (node_ctx.propLength != LENGTH_UNKNOWN)
+		else if (have_props)
 			repo_modify(node_ctx.dst, node_ctx.type, mark);
 		else if (node_ctx.textLength != LENGTH_UNKNOWN)
 			old_mode = repo_replace(node_ctx.dst, mark);
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (node_ctx.srcRev && node_ctx.propLength != LENGTH_UNKNOWN)
+		if (node_ctx.srcRev && have_props)
 			repo_modify(node_ctx.dst, node_ctx.type, mark);
 		else if (node_ctx.srcRev && node_ctx.textLength != LENGTH_UNKNOWN)
 			old_mode = repo_replace(node_ctx.dst, mark);
@@ -186,7 +187,7 @@ static void handle_node(void)
 			repo_add(node_ctx.dst, node_ctx.type, mark);
 	}
 
-	if (node_ctx.propLength == LENGTH_UNKNOWN && old_mode)
+	if (!have_props && old_mode)
 		node_ctx.type = old_mode;
 
 	if (mark)
-- 
1.7.2.3
