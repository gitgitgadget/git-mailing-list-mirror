From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/10] vcs-svn: prepare to eliminate repo_tree structure
Date: Fri, 10 Dec 2010 04:28:06 -0600
Message-ID: <20101210102806.GH26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:28:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0DN-0004z4-Ta
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab0LJK2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:28:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43164 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab0LJK2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:28:24 -0500
Received: by yxt3 with SMTP id 3so1934191yxt.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e1jtUFwtcfzrbPLwwvlEEa8MnuZyp9+KFy7H1ukT1dQ=;
        b=Tqckx6QCqf6Aw6LAqAP7htKg0uo+FxHVXQ8RSII4jM1rW5IfalSQFcv2H4mINLFPQ1
         J1ccvcZj+R2oiG4xmMFGsEiUxgEqrmjoZ3u2xSZF0JxVyK7lSDyKNJj46UwuFPmXICk3
         NbBWWuGL5n6pClZapYFR4vWHXGZGWkqOw2K8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VWPtDIOWFNqLPkLUpZDfTyNlYjfysOPQ/6INsBJyg2Q9nx8/aFGWT+kSKwyO9FpCMA
         ItqweEszEKWk6pdsjZ6kJCedeolFD5eERWgoe0LGcdrSf6bddSIIpiEQhPlwufc8QQl8
         VMIs94LYXzAFgHHbTQcD0Mi9SuMc8RZrPtODs=
Received: by 10.90.70.2 with SMTP id s2mr872388aga.184.1291976903469;
        Fri, 10 Dec 2010 02:28:23 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id 37sm3158988anr.4.2010.12.10.02.28.21
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:28:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163403>

Currently svn-fe processes each commit in two stages: first decide
on the correct content for all paths and export the relevant blobs,
then export a commit with the result.

But we can keep less state and simplify svn-fe a great deal by
doing exporting the commit in one stage: use 'inline' blobs for
each path and remember nothing.  This way, the repo_tree structure
could be eliminated, and we would get support for incremental
imports 'for free'.

Reorganize handle_node() along these lines.  This is just a code
cleanup; the functional change to repo_tree will come later.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index da968fa..649a468 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -201,11 +201,12 @@ static void handle_node(void)
 	uint32_t mark = 0, old_mode, old_mark;
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
+	const int have_text = node_ctx.textLength != LENGTH_UNKNOWN;
 
-	if (node_ctx.textLength != LENGTH_UNKNOWN)
+	if (have_text)
 		mark = next_blob_mark();
 	if (node_ctx.action == NODEACT_DELETE) {
-		if (mark || have_props || node_ctx.srcRev)
+		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
 		return repo_delete(node_ctx.dst);
@@ -219,8 +220,13 @@ static void handle_node(void)
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
-	if (mark && type == REPO_MODE_DIR)
+	if (have_text && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
+
+	/*
+	 * Find old content (old_mark) and decide on the new content (mark)
+	 * and mode (node_ctx.type).
+	 */
 	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
@@ -228,7 +234,9 @@ static void handle_node(void)
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
 		old_mark = repo_read_path(node_ctx.dst);
-		mode = repo_modify_path(node_ctx.dst, 0, mark);
+		if (!have_text)
+			mark = old_mark;
+		mode = repo_modify_path(node_ctx.dst, 0, 0);
 		if (!mode)
 			die("invalid dump: path to be modified is missing");
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
@@ -237,23 +245,29 @@ static void handle_node(void)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (!mark && type != REPO_MODE_DIR)
+		if (!have_text && type != REPO_MODE_DIR)
 			die("invalid dump: adds node without text");
-		repo_add(node_ctx.dst, type, mark);
 		old_mark = 0;
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
+
+	/*
+	 * Adjust mode to reflect properties.
+	 */
 	old_mode = node_ctx.type;
 	if (have_props) {
 		if (!node_ctx.prop_delta)
 			node_ctx.type = type;
 		if (node_ctx.propLength)
 			read_props();
-		if (node_ctx.type != old_mode)
-			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 	}
-	if (!mark)
+
+	/*
+	 * Save the result.
+	 */
+	repo_add(node_ctx.dst, node_ctx.type, mark);
+	if (!have_text)
 		return;
 	if (!node_ctx.text_delta) {
 		fast_export_blob(node_ctx.type, mark, node_ctx.textLength, &input);
-- 
1.7.2.4
