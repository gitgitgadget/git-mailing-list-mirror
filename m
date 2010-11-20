From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/15] vcs-svn: Replace = Delete + Add
Date: Fri, 19 Nov 2010 18:49:55 -0600
Message-ID: <20101120004955.GH17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:50:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbfE-0001Yz-Rf
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab0KTAuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:50:44 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41830 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab0KTAun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:50:43 -0500
Received: by gxk23 with SMTP id 23so3102264gxk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6JZBNaXJqib4Ckw86pg6YVR46cHzRcUt9wzi/liyb2Y=;
        b=Rv21v0oVUv/yjlRyiFcWPxvjmhV/WHwG7WqXYFzwiVsbX8NRUxtbvdyfvQiIMzd1l4
         d8pbdwWwfKw91k+u/YNr5YyzqUvR1+d+mQ+CxZjw0/CYY8QbwylvMhRvMfD9j9z+AsWi
         8UZeq5EOnk8Tm77nivFux186tgg41ZoP9QqO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MqidI3jbzWiGJAYv//+uigN+YCRoNC77l/DEU0vpI97RaaG6Jfn1Lqlcm62P88ySU+
         0XSID1S0a8pC15A1jNvOjAn93enDdVQ110jmv4P7VMRErs8QX98xsFkpbn+fXoeWC6VP
         J3OUjCjvdmJ9FzN+QFNZAFDN+0lROjU90SJAo=
Received: by 10.91.63.36 with SMTP id q36mr2025119agk.158.1290214242568;
        Fri, 19 Nov 2010 16:50:42 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id j64sm1441722yha.24.2010.11.19.16.50.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:50:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161807>

Simplify by reducing the "Node-action: replace" case to "Node-action:
add".  This way, the main part of handle_node() only has to deal with
"add" and "change" nodes.

Functional change: replacing a symlink or executable without setting
properties will reset the mode.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I was happy to discover this.

 vcs-svn/svndump.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index bc70023..6a6aaf9 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -166,6 +166,11 @@ static void handle_node(void)
 		return repo_delete(node_ctx.dst);
 	}
 
+	if (node_ctx.action == NODEACT_REPLACE) {
+		repo_delete(node_ctx.dst);
+		node_ctx.action = NODEACT_ADD;
+	}
+
 	if (have_props && node_ctx.propLength)
 		read_props();
 
@@ -175,12 +180,8 @@ static void handle_node(void)
 	if (mark && node_ctx.type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
 
-	if (node_ctx.action == NODEACT_CHANGE ||
-			   node_ctx.action == NODEACT_REPLACE) {
-		if (node_ctx.action == NODEACT_REPLACE &&
-		    node_ctx.type == REPO_MODE_DIR)
-			repo_replace(node_ctx.dst, mark);
-		else if (have_props)
+	if (node_ctx.action == NODEACT_CHANGE) {
+		if (have_props)
 			repo_modify(node_ctx.dst, node_ctx.type, mark);
 		else if (mark)
 			old_mode = repo_replace(node_ctx.dst, mark);
-- 
1.7.2.3
