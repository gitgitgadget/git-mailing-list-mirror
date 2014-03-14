From: Uwe Storbeck <uwe@ibr.ch>
Subject: [PATCH v2] rebase -i: replace an echo command by printf
Date: Sat, 15 Mar 2014 00:56:43 +0100
Message-ID: <20140314235642.GA6917@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 00:56:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOby5-0006tQ-PE
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 00:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbaCNX4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 19:56:45 -0400
Received: from gate.ibr.ch ([83.150.36.130]:47254 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754963AbaCNX4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 19:56:45 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 10EC913B62A
	for <git@vger.kernel.org>; Sat, 15 Mar 2014 00:56:44 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id 8D3F5153F5
	for <git@vger.kernel.org>; Sat, 15 Mar 2014 00:56:43 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 6BF3DD0AF7; Sat, 15 Mar 2014 00:56:43 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244125>

to avoid shell dependent behavior.

When your system shell (/bin/sh) is a dash backslash sequences
in strings are interpreted by the echo command. A commit message
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

Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43c19e0..43631b4 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -739,7 +739,7 @@ rearrange_squash () {
 					;;
 				esac
 			done
-			echo "$sha1 $action $prefix $rest"
+			printf '%s %s %s %s\n' "$sha1" "$action" "$prefix" "$rest"
 			# if it's a single word, try to resolve to a full sha1 and
 			# emit a second copy. This allows us to match on both message
 			# and on sha1 prefix
-- 
1.9.0
