From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 00/12] Improve git-am test coverage
Date: Sun, 19 Jul 2015 23:49:06 +0800
Message-ID: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:49:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqP-0005a9-UP
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbbGSPt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:49:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34910 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbbGSPt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:49:27 -0400
Received: by pabkd10 with SMTP id kd10so16948646pab.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JCTnRnA3YjIZfTZcQ8gczMO07QWsXawQoSPLLfZ5L7Q=;
        b=snVtRipxdnprrE2KBs7SZfk/UEBY5LrzI1Wa31+dN9WAW9RVLR9Kxu9ujpVF9RE+5K
         KjIGBQxV67b9rb7j1EkmNIvjYIEU1HBREhsvar+/Vcv6uJxVJKMRU7A+L7LDALUK3gTi
         jVQkgRMojrQgrABfAfxjibsWip4I2Iv7KoYvgfz88+UCZrTGyU6WbuaY93Jn+5X4eUty
         n7qtUVhttq2m1OgGoF1r2kHvgNINj4v5XQqYMY5+4Bd1SJ19sfyKUN3ZS1emD2Tddqqw
         ql3OXBbTEAO4QCius29Jea7DVbOzbp+448fvUqiB2xkHTI561zpFgbtkTKYMr1RpfPn1
         P36A==
X-Received: by 10.68.98.227 with SMTP id el3mr49365364pbb.32.1437320966721;
        Sun, 19 Jul 2015 08:49:26 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.49.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:49:25 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274213>

This is a very minor re-roll of [v2] that adds in the missing !MINGW prereq in
t3901.  Thanks Johannes Schindelin and Johannes Sixt for the reviews last
round. Interdiff below.

Previous versions:

[v1] http://thread.gmane.org/gmane.comp.version-control.git/273254
[v2] http://thread.gmane.org/gmane.comp.version-control.git/273507

Increase test coverage of git-am.sh to help prevent regressions that could
arise from the rewrite of git-am.sh to C. This patch series, along with
pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
67.3%[2].

No tests for git-am's interactive mode, though, as test_terminal does not seem
to attach a pseudo-tty to stdin(?), thus making git-am's "test -t 0" check
fail.

This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].

[1] http://pyokagan.github.io/git/20150430132408-a75942b//kcov-merged/git-am.eb79278e.html
[2] http://pyokagan.github.io/git/20150702173751-2fdae08//kcov-merged/git-am.eb79278e.html
[3] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (12):
  t4150: am.messageid really adds the message id
  t4150: am fails if index is dirty
  t4151: am --abort will keep dirty index intact
  t4150: am refuses patches when paused
  t4150: am --resolved fails if index has no changes
  t4150: am --resolved fails if index has unmerged entries
  t4150: am with applypatch-msg hook
  t4150: am with pre-applypatch hook
  t4150: am with post-applypatch hook
  t4150: tests for am --[no-]scissors
  t3418: non-interactive rebase --continue with rerere enabled
  t3901: test git-am encoding conversion

 t/t3418-rebase-continue.sh |  19 ++++
 t/t3901-i18n-patch.sh      |  62 +++++++++++++
 t/t4150-am.sh              | 217 +++++++++++++++++++++++++++++++++++++++++++++
 t/t4151-am-abort.sh        |  15 ++++
 4 files changed, 313 insertions(+)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index b49bdb7..509084e 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -262,7 +262,7 @@ test_expect_success 'am (U/U)' '
 	check_encoding 2
 '
 
-test_expect_success 'am (L/L)' '
+test_expect_success !MINGW 'am (L/L)' '
 	# Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
 	git config i18n.commitencoding ISO8859-1 &&
 	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&

-- 
2.5.0.rc2.110.gf2a5fc6
