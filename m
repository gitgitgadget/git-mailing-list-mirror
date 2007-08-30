From: "Tom Clarke" <tom@u2i.com>
Subject: Add --rebase option to git-pull?
Date: Thu, 30 Aug 2007 14:40:54 +0200
Message-ID: <550f9510708300540u13c77201oe7cbe599c6773364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 14:41:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjKW-0004Pj-2U
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbXH3Mk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbXH3Mk4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:40:56 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:16557 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbXH3Mkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:40:55 -0400
Received: by py-out-1112.google.com with SMTP id u77so2842777pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 05:40:54 -0700 (PDT)
Received: by 10.35.49.1 with SMTP id b1mr570267pyk.1188477654348;
        Thu, 30 Aug 2007 05:40:54 -0700 (PDT)
Received: by 10.35.86.2 with HTTP; Thu, 30 Aug 2007 05:40:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57037>

Hi,

I'm in the process of setting up a git environment with a number of
shared branches. To avoid putting unnecessary merges into the trunk,
we'd like to normally use rebase when updating private branches. I
wondered if it would be possible to automatically determine the
correct remote branch to rebase against.

The most logical place to do this seemed to be in git-pull, so I
experimented with adding a '--rebase' option, per the (rough) diff
below.

I'm quite new to git, so is this a good strategy?

-Tom


commit 60b7318c2ebb7ee2bd1afb02f1fc925a29e1b214
Author: Tom Clarke <tom@u2i.com>
Date:   Thu Aug 30 14:39:34 2007 +0200

    Added --rebase option to pull

diff --git a/git-pull.sh b/git-pull.sh
index 5e96d1f..233a1d9 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -15,7 +15,7 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
        die "You are in the middle of a conflicted merge."

-strategy_args= no_summary= no_commit= squash=
+strategy_args= no_summary= no_commit= squash= rebase=false
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
        case "$1" in
@@ -29,6 +29,8 @@ do
                no_commit=--no-commit ;;
        --sq|--squ|--squa|--squas|--squash)
                squash=--squash ;;
+       --re|--reb|--reba|--rebase)
+               rebase=true ;;
        -s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
                --strateg=*|--strategy=*|\
        -s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -119,5 +121,10 @@ then
 fi

 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
-exec git-merge $no_summary $no_commit $squash $strategy_args \
+if test $rebase != "false"
+then
+    exec git-rebase $strategy_args $merge_head
+else
+    exec git-merge $no_summary $no_commit $squash $strategy_args \
        "$merge_name" HEAD $merge_head
+fi
