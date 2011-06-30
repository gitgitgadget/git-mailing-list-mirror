From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] git-submodule.sh: preserve stdin for the command spawned by foreach
Date: Wed, 29 Jun 2011 19:34:58 -0500
Message-ID: <1309394098-18618-2-git-send-email-drafnel@gmail.com>
References: <1309394098-18618-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 30 02:36:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc5Eo-0002R2-Tw
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 02:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab1F3Afu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 20:35:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53024 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab1F3Aft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 20:35:49 -0400
Received: by yia27 with SMTP id 27so686115yia.19
        for <git@vger.kernel.org>; Wed, 29 Jun 2011 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RXw4+X/QNxQf85JWblIUJscsa4Omr7cr/Z4JPnITLgg=;
        b=x/Gsgq86svd5ZcBo86LrVD2kz6mvNex8XS0w40azq10FR/64OYKdgCgmOOuiwLDpFG
         vyTKh7YPz/KwevbmMgvMPChHu2sbX3bPqwtz9FEG31ffmPR2eX+6VfwO2QIWOhygj9KM
         GPCZbUmwWIDHv+Ix0ljQpkpcyFvl/MiSFbB7U=
Received: by 10.236.103.18 with SMTP id e18mr1839800yhg.183.1309394148380;
        Wed, 29 Jun 2011 17:35:48 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id c63sm1256009yhe.4.2011.06.29.17.35.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Jun 2011 17:35:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1309394098-18618-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176465>

The user-supplied command spawned by 'submodule foreach' loses its
connection to the original standard input.  Instead, it is connected to the
output of a pipe within the git-submodule script.  The user-supplied
command supplied to 'submodule foreach' is spawned within a while loop
which is being piped into.  Due to the way shells implement piping output
to a while loop, a subshell is created with its standard input attached to
the output of the pipe.  This results in all of the commands executed
within the while loop to have their stdins modified in the same way,
including the user-supplied command.

This can cause a problem if the command requires reading from stdin or if
it changes its behavior based on whether stdin is a tty or not.  For
example, this problem was noticed when trying to execute the following:

   git submodule foreach git shortlog --since=two.weeks.ago

which printed a message about entering the first submodule and produced no
further output and exited with a status of zero.  In this case, shortlog
detected that it was not connected to a tty, and since no revision was
supplied as an argument, it attempted to read the list of revisions from
standard input.  Instead, it slurped up the list of submodules that was
being piped to the enclosing while loop and caused that loop to end early
without processing the remaining submodules.

Work around this behavior by saving the original standard input file
descriptor before the while loop, and restoring it when spawning the
user-supplied command.

This fixes the tests in t7407.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-submodule.sh             |    6 +++++-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d189a24..5013270 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -300,6 +300,10 @@ cmd_foreach()
 
 	toplevel=$(pwd)
 
+	# dup stdin so that it can be restored when running the external
+	# command in the subshell (and a recursive call to this function)
+	exec 3<&0
+
 	module_list |
 	while read mode sha1 stage path
 	do
@@ -316,7 +320,7 @@ cmd_foreach()
 				then
 					cmd_foreach "--recursive" "$@"
 				fi
-			) ||
+			) <&3 3<&- ||
 			die "Stopping at '$path'; script returned non-zero status."
 		fi
 	done
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index e8d21b5..835a506 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -292,7 +292,7 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 	)
 '
 
-test_expect_failure 'command passed to foreach retains notion of stdin' '
+test_expect_success 'command passed to foreach retains notion of stdin' '
 	(
 		cd super &&
 		git submodule foreach echo success >../expected &&
@@ -301,7 +301,7 @@ test_expect_failure 'command passed to foreach retains notion of stdin' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'command passed to foreach --recursive retains notion of stdin' '
+test_expect_success 'command passed to foreach --recursive retains notion of stdin' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive echo success >../expected &&
-- 
1.7.6
