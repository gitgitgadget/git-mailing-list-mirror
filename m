From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/12] vcs-svn: handle_node: use repo_read_path
Date: Sun, 6 Mar 2011 17:08:51 -0600
Message-ID: <20110306230851.GF24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN4P-000840-FS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab1CFXI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:08:57 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52265 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1CFXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:08:56 -0500
Received: by ywj3 with SMTP id 3so1416645ywj.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n9z0Q61K6W4FzpixtNgYtcbySsxu3bmWJ3H36Cio/iQ=;
        b=qEeT0/CiDU2qb07nyUxtMkWu3nN+zLknx7K8wOtLuK3uurFciWUlthwcuISrRzERCw
         /KwazVC+I2lp488pdad5zGTUn5+5jrppCFtWVR9w/OR171LL8/93aGCxlq6SoVDh0n6T
         OjqkRMOxcfaD1cX5svo/p0X7JsIZM/YQeov8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eiEmecYVeWb1eLV+8Qkqpu88Pg582btrYCOKETNMdtP9xRfjXhAMySwyYyPYLzsyE1
         pT+nTjPpdUyrbALSJgc4vapaE0bfhzVozZROEvvMJ/gKOCC6M5q+W5Bw/aqeVEn0a23F
         Jg1icE9RZQ+6f/UNtnytBYn09KssGGqBzQxmY=
Received: by 10.150.62.1 with SMTP id k1mr1645387yba.382.1299452935878;
        Sun, 06 Mar 2011 15:08:55 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.sbcglobal.net [69.209.66.207])
        by mx.google.com with ESMTPS id 17sm106017ybk.0.2011.03.06.15.08.54
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:08:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168551>

Date: Fri, 10 Dec 2010 04:28:06 -0600

svn-fe processes each commit in two stages: first decide on the
correct content for all paths and export the relevant blobs, then
export a commit with the result.

We can keep less state and simplify svn-fe a great deal by doing
exporting the commit in one stage: use 'inline' blobs for each path
and remember nothing.  This way, the repo_tree structure could be
eliminated, and we would get support for incremental imports 'for
free'.

Reorganize handle_node() along these lines.  This is just a code
cleanup; the functional changes to repo_tree and handle_revision
will come later.

[db: backported to apply without text delta support]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index ee7c0bb..f07376f 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -201,13 +201,14 @@ static void handle_node(void)
 	uint32_t mark = 0;
 	const uint32_t type = node_ctx.type;
 	const int have_props = node_ctx.propLength != LENGTH_UNKNOWN;
+	const int have_text = node_ctx.textLength != LENGTH_UNKNOWN;
 
 	if (node_ctx.text_delta)
 		die("text deltas not supported");
-	if (node_ctx.textLength != LENGTH_UNKNOWN)
+	if (have_text)
 		mark = next_blob_mark();
 	if (node_ctx.action == NODEACT_DELETE) {
-		if (mark || have_props || node_ctx.srcRev)
+		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
 		return repo_delete(node_ctx.dst);
@@ -221,13 +222,20 @@ static void handle_node(void)
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
-	if (mark && type == REPO_MODE_DIR)
+	if (have_text && type == REPO_MODE_DIR)
 		die("invalid dump: directories cannot have text attached");
+
+	/*
+	 * Decide on the new content (mark) and mode (node_ctx.type).
+	 */
 	if (node_ctx.action == NODEACT_CHANGE && !~*node_ctx.dst) {
 		if (type != REPO_MODE_DIR)
 			die("invalid dump: root of tree is not a regular file");
 	} else if (node_ctx.action == NODEACT_CHANGE) {
-		uint32_t mode = repo_modify_path(node_ctx.dst, 0, mark);
+		uint32_t mode;
+		if (!have_text)
+			mark = repo_read_path(node_ctx.dst);
+		mode = repo_modify_path(node_ctx.dst, 0, 0);
 		if (!mode)
 			die("invalid dump: path to be modified is missing");
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
@@ -236,22 +244,27 @@ static void handle_node(void)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (!mark && type != REPO_MODE_DIR)
+		if (!have_text && type != REPO_MODE_DIR)
 			die("invalid dump: adds node without text");
-		repo_add(node_ctx.dst, type, mark);
 	} else {
 		die("invalid dump: Node-path block lacks Node-action");
 	}
+
+	/*
+	 * Adjust mode to reflect properties.
+	 */
 	if (have_props) {
-		const uint32_t old_mode = node_ctx.type;
 		if (!node_ctx.prop_delta)
 			node_ctx.type = type;
 		if (node_ctx.propLength)
 			read_props();
-		if (node_ctx.type != old_mode)
-			repo_modify_path(node_ctx.dst, node_ctx.type, mark);
 	}
-	if (mark)
+
+	/*
+	 * Save the result.
+	 */
+	repo_add(node_ctx.dst, node_ctx.type, mark);
+	if (have_text)
 		fast_export_blob(node_ctx.type, mark,
 				 node_ctx.textLength, &input);
 }
-- 
1.7.4.1
