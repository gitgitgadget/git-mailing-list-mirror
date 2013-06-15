From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Sat, 15 Jun 2013 18:13:11 +0530
Message-ID: <1371300192-6222-2-git-send-email-artagnon@gmail.com>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:45:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnprN-0001iF-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab3FOMpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:45:17 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:50040 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab3FOMpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:45:08 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so1385472pdi.2
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ty87l2ZmkVxJ13BfiYfPh4EMzF23GN3QFnlCextoVPQ=;
        b=YXoCdwJqL7GYlavv+QD5E9DEMTH80evEwyNUyQvE4zckhyBoYasPiSClM40la9ndKc
         zEa3Kt+VY7h731xs8p8lFGki9bROh/2J3tZh7qTJtSSrjyIXCnVisrPNYzJq4i2WZa6v
         OZ52nQRZBiUMuYeixeO9CDx101lf3cEmdycnnfidPjv5BMXHK20xmtn4VKE+wH4DEGNx
         THwg2NncXI+vsSrlUsQLBSiPdecG4tCVOljVL2AJ0d6PgqgeAPRZFPD5+C6I6P11+CX2
         GCF5dr4WPY8aopDTG7GpRejcM1GAn4nfXlylsZgLre4QI6rihcvUT0uHJCFI/u5ZSrS3
         H49w==
X-Received: by 10.68.176.37 with SMTP id cf5mr6253540pbc.173.1371300307647;
        Sat, 15 Jun 2013 05:45:07 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pl9sm6194950pbc.5.2013.06.15.05.45.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 05:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.383.g8881048.dirty
In-Reply-To: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227947>

The following bug has been observed:

  $ git am  # no input file
  ^C
  $ git am --abort
  Resolve operation not in progress, we are not resuming.

This happens because the following test fails:

  test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"

and the codepath for an "am in-progress" is not executed.  It falls back
to the codepath that treats this as a "fresh execution".  Before
rr/rebase-autostash, this condition was

  test -d "$dotest"

It would incorrectly execute the "normal" am --abort codepath:

  git read-tree --reset -u HEAD ORIG_HEAD
  git reset ORIG_HEAD

by incorrectly assuming that an am is "in progress" (i.e. ORIG_HEAD
etc. was written during the previous execution).

Notice that

  $ git am
  ^C

executes nothing of significance, is equivalent to

  $ mkdir .git/rebase-apply

Therefore, the correct solution is to treat .git/rebase-apply as a
"stray directory" and remove it on --abort in the fresh-execution
codepath.  Also ensure that we're not called with --rebasing from
git-rebase--am.sh; in that case, it is the responsibility of the caller
to handle and stray directories.

While at it, tell the user to run "git am --abort" to get rid of the
stray $dotest directory, if she attempts anything else.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh     | 17 +++++++++++++++++
 t/t4150-am.sh |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 1cf3d1d..91a2bcc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -506,6 +506,23 @@ then
 	esac
 	rm -f "$dotest/dirtyindex"
 else
+	# Possible stray $dotest directory in the independent-run
+	# case; in the --rebasing case, it is upto the caller
+	# (git-rebase--am) to take care of stray directories.
+	if test -d "$dotest" && test -z "$rebasing"
+	then
+	case "$skip,$resolved,$abort" in
+	,,t)
+		rm -fr "$dotest"
+		exit 0
+		;;
+	*)
+		die "$(eval_gettext "Stray \$dotest directory found.
+Use \"git am --abort\" to remove it.")"
+		;;
+	esac
+	fi
+
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" = "" ||
 		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 12f6b02..6c2cc3e 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -363,6 +363,12 @@ test_expect_success 'am --skip works' '
 	test_cmp expected another
 '
 
+test_expect_success 'am --abort removes a stray directory' '
+	mkdir .git/rebase-apply &&
+	git am --abort &&
+	test_path_is_missing .git/rebase-apply
+'
+
 test_expect_success 'am --resolved works' '
 	echo goodbye >expected &&
 	rm -fr .git/rebase-apply &&
-- 
1.8.3.1.383.g8881048.dirty
