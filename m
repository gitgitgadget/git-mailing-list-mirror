From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATH] cg-Xlib: Fix problem with cg-update and deleted files
Date: Mon, 30 May 2005 18:43:39 +0200
Message-ID: <20050530164339.GD28681@diku.dk>
References: <1117466600.7072.188.camel@pegasus> <20050530163957.GC28681@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 18:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcnK9-0007z5-Eg
	for gcvg-git@gmane.org; Mon, 30 May 2005 18:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVE3Qno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVE3Qnn
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 12:43:43 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:31435 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261647AbVE3Qnl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 12:43:41 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B495D6E2636; Mon, 30 May 2005 18:43:07 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7725B6E26D8; Mon, 30 May 2005 18:43:07 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 28EE861FE0; Mon, 30 May 2005 18:43:40 +0200 (CEST)
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <20050530163957.GC28681@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jonas Fonseca <fonseca@diku.dk> wrote Mon, May 30, 2005:
> Marcel Holtmann <marcel@holtmann.org> wrote Mon, May 30, 2005:
> > with the latest cg-update and pulling the linux-2.6 repository I saw
> > problems with deleted files:
> 
> I've only tested it in a small test script ...

... which of course is no the best thing. Here's one with -z option.

Update tree_timewarp()s git-diff-tree logic to handle the diff-format
header and file both being NUL separated.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

diff --git a/cg-Xlib b/cg-Xlib
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -73,10 +73,15 @@ tree_timewarp () {
 	echo "$branch" > $_git/HEAD
 
 	# Kill gone files
-	git-diff-tree -z -r $base $branch | egrep -z '^:([^ ][^ ]* ){4}D' | xargs -0 bash -c '
+	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
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
