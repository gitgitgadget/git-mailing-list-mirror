From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATH] cg-Xlib: Fix problem with cg-update and deleted files
Date: Mon, 30 May 2005 18:39:57 +0200
Message-ID: <20050530163957.GC28681@diku.dk>
References: <1117466600.7072.188.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 18:38:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcnGm-0007SO-9a
	for gcvg-git@gmane.org; Mon, 30 May 2005 18:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVE3QkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 12:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVE3QkD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 12:40:03 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:58570 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261644AbVE3Qj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 12:39:58 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 68EA16E1DB6; Mon, 30 May 2005 18:39:25 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D5EF6E1CFC; Mon, 30 May 2005 18:39:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D568761FE0; Mon, 30 May 2005 18:39:57 +0200 (CEST)
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1117466600.7072.188.camel@pegasus>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote Mon, May 30, 2005:
> with the latest cg-update and pulling the linux-2.6 repository I saw
> problems with deleted files:

Update tree_timewarp()s git-diff-tree logic to handle the diff-format
header and file both being NUL separated.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

I've only tested it in a small test script ...

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -73,10 +73,15 @@ tree_timewarp () {
 	echo "$branch" > $_git/HEAD
 
 	# Kill gone files
-	git-diff-tree -z -r $base $branch | egrep -z '^:([^ ][^ ]* ){4}D' | xargs -0 bash -c '
+	git-diff-tree -r $base $branch | xargs -0 bash -c '
 		while [ "$1" ]; do
-			rm -- "$(echo "$1" | cut -f 2)"
-			shift
+			header="$1"; shift
+			file="$1"; shift
+
+			# match ":100755 000000 14d43b1abf... 000000000... D"
+			if echo "$header" | egrep "^:([^ ][^ ]* ){4}D" >/dev/null; then
+				rm -- "$file"
+			fi
 		done
 	' padding
 	git-checkout-cache -f -a
-- 
Jonas Fonseca
