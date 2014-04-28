From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 10:34:22 +0200
Message-ID: <1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20140425154722.GC11479@google.com>
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, jrnieder@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 28 10:36:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weh2q-0002Wb-DR
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbaD1If6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:35:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47796 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbaD1Ie4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:34:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3S8YOkT030319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Apr 2014 10:34:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3S8YOo8001941;
	Mon, 28 Apr 2014 10:34:24 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Weh16-0006Kk-KY; Mon, 28 Apr 2014 10:34:24 +0200
X-Mailer: git-send-email 1.9.2.698.ge58c0c2.dirty
In-Reply-To: <20140425154722.GC11479@google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Apr 2014 10:34:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3S8YOkT030319
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1399278865.29297@jhKnuy5Z+bZs/m+BsxqwlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247243>

By default, Git used to set $LESS to -FRSX if $LESS was not set by the
user. The FRX flags actually make sense for Git (F and X because Git
sometimes pipes short output to less, and R because Git pipes colored
output). The S flag (chop long lines), on the other hand, is not related
to Git and is a matter of user preference. Git should not decide for the
user to change LESS's default.

More specifically, the S flag harms users who review untrusted code
within a pager, since a patch looking like:

-old code;
+new good code; [... lots of tabs ...] malicious code;

would appear identical to:

-old code;
+new good code;

Users who prefer the old behavior can still set the $LESS environment
variable to -FRSX explicitly, or set core.pager to 'less -S'.

The documentation in config.txt is made a bit longer to keep both an
example setting the 'S' flag (needed to recover the old behavior) and an
example showing how to unset a flag set by Git.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> We agree here.  So, does someone who actually wants this change want to
> propose a patch? :)

Here you are.

 Documentation/config.txt | 13 ++++++++-----
 Makefile                 |  6 +++---
 perl/Git/SVN/Log.pm      |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e30561d..b7f92ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -560,14 +560,17 @@ core.pager::
 	configuration, then `$PAGER`, and then the default chosen at
 	compile time (usually 'less').
 +
-When the `LESS` environment variable is unset, Git sets it to `FRSX`
+When the `LESS` environment variable is unset, Git sets it to `FRX`
 (if `LESS` environment variable is set, Git does not change it at
 all).  If you want to selectively override Git's default setting
-for `LESS`, you can set `core.pager` to e.g. `less -+S`.  This will
+for `LESS`, you can set `core.pager` to e.g. `less -S`.  This will
 be passed to the shell by Git, which will translate the final
-command to `LESS=FRSX less -+S`. The environment tells the command
-to set the `S` option to chop long lines but the command line
-resets it to the default to fold long lines.
+command to `LESS=FRX less -S`. The environment does not set the
+`S` option but the command line does, instructing less to truncate
+long lines. Similarly, setting `core.pager` to `less -+F` will
+deactivate the `F` option specified by the environment from the
+command-line, deactivating the "quit if one screen" behavior of
+`less`.
 +
 Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with
diff --git a/Makefile b/Makefile
index a3b298e..cd3cdf6 100644
--- a/Makefile
+++ b/Makefile
@@ -344,9 +344,9 @@ all::
 # Define PAGER_ENV to a SP separated VAR=VAL pairs to define
 # default environment variables to be passed when a pager is spawned, e.g.
 #
-#    PAGER_ENV = LESS=-FRSX LV=-c
+#    PAGER_ENV = LESS=-FRX LV=-c
 #
-# to say "export LESS=-FRSX (and LV=-c) if the environment variable
+# to say "export LESS=-FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
 
 GIT-VERSION-FILE: FORCE
@@ -1518,7 +1518,7 @@ NO_PYTHON = NoThanks
 endif
 
 ifndef PAGER_ENV
-PAGER_ENV = LESS=-FRSX LV=-c
+PAGER_ENV = LESS=-FRX LV=-c
 endif
 
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
diff --git a/perl/Git/SVN/Log.pm b/perl/Git/SVN/Log.pm
index 34f2869..6641053 100644
--- a/perl/Git/SVN/Log.pm
+++ b/perl/Git/SVN/Log.pm
@@ -116,7 +116,7 @@ sub run_pager {
 		return;
 	}
 	open STDIN, '<&', $rfd or fatal "Can't redirect stdin: $!";
-	$ENV{LESS} ||= 'FRSX';
+	$ENV{LESS} ||= 'FRX';
 	$ENV{LV} ||= '-c';
 	exec $pager or fatal "Can't run pager: $! ($pager)";
 }
-- 
1.9.2.698.ge58c0c2.dirty
