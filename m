From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 30 Apr 2014 09:35:25 +0200
Message-ID: <1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
Cc: David Kastrup <dak@gnu.org>, d9ba@mailtor.net, jrnieder@gmail.com,
	peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 30 09:39:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfP6t-0004i9-GH
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 09:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbaD3HjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 03:39:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46477 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbaD3HjC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 03:39:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3U7ZRs8005533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Apr 2014 09:35:27 +0200
Received: from anie.imag.fr (ensi-vpn-253.imag.fr [129.88.57.253])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3U7ZRSq002398;
	Wed, 30 Apr 2014 09:35:27 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1WfP39-000897-Oj; Wed, 30 Apr 2014 09:35:27 +0200
X-Mailer: git-send-email 1.9.2.698.ge58c0c2.dirty
In-Reply-To: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Apr 2014 09:35:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3U7ZRs8005533
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1399448130.92637@sfNi9rLAOjaaH2rArPMaWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247682>

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
This is just a rewrite of PATCH v1 on top of master instead of pu.

 Documentation/config.txt | 13 ++++++++-----
 git-sh-setup.sh          |  2 +-
 pager.c                  |  2 +-
 perl/Git/SVN/Log.pm      |  2 +-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..5484d9d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -553,14 +553,17 @@ core.pager::
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
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 5f28b32..9447980 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -160,7 +160,7 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	: ${LESS=-FRSX}
+	: ${LESS=-FRX}
 	: ${LV=-c}
 	export LESS LV
 
diff --git a/pager.c b/pager.c
index 0cc75a8..f75e8ae 100644
--- a/pager.c
+++ b/pager.c
@@ -85,7 +85,7 @@ void setup_pager(void)
 		int i = 0;
 
 		if (!getenv("LESS"))
-			env[i++] = "LESS=FRSX";
+			env[i++] = "LESS=FRX";
 		if (!getenv("LV"))
 			env[i++] = "LV=-c";
 		env[i] = NULL;
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
