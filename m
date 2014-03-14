From: Uwe Storbeck <uwe@ibr.ch>
Subject: Corner case bug caused by shell dependent behavior
Date: Fri, 14 Mar 2014 01:02:13 +0100
Message-ID: <20140314000213.GA3739@ibr.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 01:12:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOFjS-0000pN-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 01:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaCNAMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 20:12:09 -0400
Received: from gate.ibr.ch ([83.150.36.130]:44059 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbaCNAMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 20:12:08 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2014 20:12:08 EDT
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 4889E17F5A
	for <git@vger.kernel.org>; Fri, 14 Mar 2014 01:02:14 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id 6F0341544E
	for <git@vger.kernel.org>; Fri, 14 Mar 2014 01:02:13 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id EECA6D0A7A; Fri, 14 Mar 2014 01:02:13 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244063>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

When your system shell (/bin/sh) is a dash control sequences in
strings get interpreted by the echo command. A commit message
which ends with the string '\n' may result in a garbage line in
the todo list of an interactive rebase which causes the rebase
to fail.

To reproduce the behavior (with dash as /bin/sh):

  mkdir test && cd test && git init
  echo 1 >foo && git add foo
  git commit -m"this commit message ends with '\n'"
  echo 2 >foo && git commit -a --fixup HEAD
  git rebase -i --autosquash --root

Now the editor opens with garbage in line 3 which has to be
removed or the rebase fails.

The attached one-line patch fixes the bug. Be free to edit the
commit message when it's too long.

Maybe there are more places where it would be more robust to use
printf instead of echo.

Uwe

--rwEMma7ioTxnRzrJ
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-rebase-interactive-replace-echo-by-printf.patch"

>From 53262bc8a7a3ec9d9a6b0e8ecaaea598257b87fe Mon Sep 17 00:00:00 2001
From: Uwe Storbeck <uwe@ibr.ch>
Date: Fri, 14 Mar 2014 00:28:33 +0100
Subject: [PATCH] git-rebase--interactive: replace echo by printf

to avoid shell dependent behavior.

When your system shell (/bin/sh) is a dash control sequences in
strings get interpreted by the echo command. A commit message
which ends with the string '\n' may result in a garbage line in
the todo list of an interactive rebase which causes the rebase
to fail.

To reproduce the behavior (with dash as /bin/sh):

  mkdir test && cd test && git init
  echo 1 >foo && git add foo
  git commit -m"this commit message ends with '\n'"
  echo 2 >foo && git commit -a --fixup HEAD
  git rebase -i --autosquash --root

Now the editor opens with garbage in line 3 which has to be
removed or the rebase fails.
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1adae8..3ffe14c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -749,7 +749,7 @@ rearrange_squash () {
 					;;
 				esac
 			done
-			echo "$sha1 $action $prefix $rest"
+			printf "%s %s %s %s\n" "$sha1" "$action" "$prefix" "$rest"
 			# if it's a single word, try to resolve to a full sha1 and
 			# emit a second copy. This allows us to match on both message
 			# and on sha1 prefix
-- 
1.9.0


--rwEMma7ioTxnRzrJ--
