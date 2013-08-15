From: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
Subject: [PATCH] Add command `git bisect state` that checks if the current bisection process has reached the first bad commit.
Date: Fri, 16 Aug 2013 00:35:12 +0200
Message-ID: <1376606112-1712-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 00:45:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA6I3-00067j-MN
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 00:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab3HOWpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Aug 2013 18:45:06 -0400
Received: from smtp-3.sys.kth.se ([130.237.48.192]:55746 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3HOWpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 18:45:05 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2013 18:45:05 EDT
Received: from mailscan-3.sys.kth.se (mailscan-3.sys.kth.se [130.237.48.170])
	by smtp-3.sys.kth.se (Postfix) with ESMTP id 60E5922E8;
	Fri, 16 Aug 2013 00:35:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-3.sys.kth.se ([130.237.48.192])
	by mailscan-3.sys.kth.se (mailscan-3.sys.kth.se [130.237.48.170]) (amavisd-new, port 10024)
	with LMTP id ut6ufuGzqYBA; Fri, 16 Aug 2013 00:35:31 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-3.sys.kth.se (Postfix) with ESMTPSA id 1656520C6;
	Fri, 16 Aug 2013 00:35:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232384>

This can be used for automated bisection without a check script.

Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
---
 Documentation/git-bisect.txt | 13 +++++++++++++
 git-bisect.sh                | 11 ++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.tx=
t
index f986c5c..ca8c09d 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -25,6 +25,7 @@ on the subcommand:
  git bisect visualize
  git bisect replay <logfile>
  git bisect log
+ git bisect state
  git bisect run <cmd>...
=20
 This command uses 'git rev-list --bisect' to help drive the
@@ -104,6 +105,18 @@ For example, `git bisect reset HEAD` will leave yo=
u on the current
 bisection commit and avoid switching commits at all, while `git bisect
 reset bisect/bad` will check out the first bad revision.
=20
+Bisect state
+~~~~~~~~~~~~~~~~
+
+To see the bisection process has finnished, issue the following comman=
d:
+
+------------
+$ git bisect state
+------------
+
+Exit successfully (i.e., with return code 0), if and only if the curre=
nt
+bisection has reached the first bad or possible first bad commit.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
=20
diff --git a/git-bisect.sh b/git-bisect.sh
index 9f064b6..6ddda34 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|run=
]'
+USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|run=
|state]'
 LONG_USAGE=3D'git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>.=
=2E.]
@@ -23,6 +23,8 @@ git bisect log
 	show bisect log.
 git bisect run <cmd>...
 	use <cmd>... to automatically bisect.
+git bisect state
+	check if the bisection is complete.
=20
 Please use "git help bisect" to get the full man page.'
=20
@@ -491,6 +493,11 @@ bisect_log () {
 	cat "$GIT_DIR/BISECT_LOG"
 }
=20
+bisect_complete_state () {
+	cat "$GIT_DIR/BISECT_LOG" | tail -n 1 | grep -E '^# (possible |)first=
 bad commit:' > /dev/null
+	exit $?
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -519,6 +526,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	state)
+		bisect_complete_state ;;
 	*)
 		usage ;;
 	esac
--=20
1.8.3.4
