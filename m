From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] vcs-svn: prepare to eliminate repo_tree structure
Date: Sun, 6 Mar 2011 06:52:59 -0600
Message-ID: <20110306125259.GA20010@elie>
References: <20101210102007.GA26298@burratino>
 <20101210102806.GH26331@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwDSf-0003yJ-UZ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 13:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab1CFMxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 07:53:09 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46502 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab1CFMxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 07:53:07 -0500
Received: by iwn34 with SMTP id 34so3198376iwn.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ICG85Bxz56Usxir6JFUatS/Y7nNz6OufMDdVPEvb+SQ=;
        b=UW9soY8WFqO3RiqUae6gNYMe8/qZtae5MkTHp50BAyJVAXV0rVyt//N9KUEFc9ZoAP
         65TXoLNtQwjG1Jbz1rt+a4Ea5+KDDlbUVA4E/bA0tcjSIDk5EumbbpNH2wDG8EB+8E3a
         YLr4At2MR+P0v718/S1FKAz/wa+l56WHNNrbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q8gKiYEPmNqKklKbNXg3OLfoRn/+fZ4Hwubskv54H9+nPTRlIsG2w+fFY+EZkTHa44
         ers3XzOlwdjd68t8l3Q9c1w1WNRVwyM9PsPBN6SVRiMF3W4GwOM/QbR4Rba+ZIwlqzd+
         5Lc8rWaIWm8n971Jw22MvM3tQ4mZb//FDmYD0=
Received: by 10.43.52.65 with SMTP id vl1mr3365228icb.343.1299415986266;
        Sun, 06 Mar 2011 04:53:06 -0800 (PST)
Received: from elie (adsl-69-209-74-158.dsl.chcgil.ameritech.net [69.209.74.158])
        by mx.google.com with ESMTPS id vm9sm332119icb.0.2011.03.06.04.53.04
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 04:53:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102806.GH26331@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168518>

Date: Fri, 10 Dec 2010 04:28:06 -0600

Currently svn-fe processes each commit in two stages: first decide on
the correct content for all paths and export the relevant blobs, then
export a commit with the result.

But we can keep less state and simplify svn-fe a great deal by doing
exporting the commit in one stage: use 'inline' blobs for each path
and remember nothing.  This way, the repo_tree structure could be
eliminated, and we would get support for incremental imports 'for
free'.

Reorganize handle_node() along these lines.  This is just a code
cleanup; the functional change to repo_tree will come later.

Backported by David Barr to apply without text delta support.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Jonathan Nieder wrote:

[...]
> @@ -228,7 +234,9 @@ static void handle_node(void)
>  	} else if (node_ctx.action == NODEACT_CHANGE) {
>  		uint32_t mode;
>  		old_mark = repo_read_path(node_ctx.dst);
> -		mode = repo_modify_path(node_ctx.dst, 0, mark);
> +		if (!have_text)
> +			mark = old_mark;
> +		mode = repo_modify_path(node_ctx.dst, 0, 0);
[...]

Backported so we can merge it a little sooner (thanks!).  It's very
similar to the original patch except there is no old_mark --- the
previous text at a path is useless until we learn to patch it (which
is a topic for another day).

David, may I have your sign-off on this series (the
vcs-svn-incremental branch)?

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
1.7.4.1.91.g15e19.dirty
