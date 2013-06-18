From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Wed, 19 Jun 2013 01:36:46 +0530
Message-ID: <1371586006-16289-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2EI-0002fW-L8
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222Ab3FRUJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:09:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34745 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3FRUJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:09:56 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so4359423pab.31
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=L0egZJpOMnYSsEACL2/MUZ5R/Zz7yxpyA/L7sug/ZnA=;
        b=YHYb9zRKt/QscfvErZF2c4hbD9tyEiJft41VnlH9D15/cmEr77NLZVnROcq26graQj
         a9HY6i84RsfWrNXxQEhJKe6Y5VuL/nmlZjniWLJIZF8ORo8Xlil8AcOsXzKG5UbWYXHT
         SD8k4G08R/igp7ogLakFYkj3ogrhKRQ0KRL7Z7+KFN3YtllpiD/hHIEkepF3wtrWhNX8
         Jd11DipIGalJosjW6W0Va3EcRkT93MHA66SlIPtJE/STkj01xUKy5Hg4Kc7BV5ctomjo
         +A7D4vFtWhTovEvYAx9JFl0nfahnvv+LS85J6SPIZvBKjbfBG8MR4/GLEined9C5uubE
         CuRQ==
X-Received: by 10.66.245.110 with SMTP id xn14mr3472440pac.130.1371586195599;
        Tue, 18 Jun 2013 13:09:55 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id qi1sm21062995pac.21.2013.06.18.13.09.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 13:09:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.g1f0e7d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228309>

416fda6 (build: do not install git-remote-testpy, 2013-05-24) added
git-remote-testpy to NO_INSTALL, with the intent of excluding it from
the default install.  This is typically meant for scripts in contrib/
with their own testsuite and Makefile (e.g. git remote-bzr, git
remote-hg).  Unfortunately, git-remote-testpy.py is a toplevel script
without its own Makefile; its testsuite is located in
t/t5800-remote-testpy.sh.

What this means is that git-remote-testpy is not built by default (when
'make' is invoked), but t5800 runs by default (like every other test in
t/).  As a result, a new contributor cloning git.git and running 'make
test' for the first time will notice test failures.  Fix this
unpleasantness by patching t5800 to check for git-remote-testpy as a
prerequisite.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Candidate for maint?

 t/t5800-remote-testpy.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t5800-remote-testpy.sh b/t/t5800-remote-testpy.sh
index 1e683d4..9df35b5 100755
--- a/t/t5800-remote-testpy.sh
+++ b/t/t5800-remote-testpy.sh
@@ -12,6 +12,11 @@ if ! test_have_prereq PYTHON ; then
 	test_done
 fi
 
+if ! test -e "$GIT_BUILD_DIR/git-remote-testpy"; then
+	skip_all='skipping python remote-helper tests, git-remote-testpy not built'
+	test_done
+fi
+
 "$PYTHON_PATH" -c '
 import sys
 if sys.hexversion < 0x02040000:
-- 
1.8.3.1.379.g1f0e7d7
