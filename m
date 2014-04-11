From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH 2/3] Revert "rebase: fix run_specific_rebase's use of "return" on FreeBSD"
Date: Fri, 11 Apr 2014 01:28:18 -0700
Message-ID: <1cc6896f60ac6495f949d9921e659f2@74d39fa044aa309eaea14b9f57fe79c>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 10:28:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWpJ-0003Iw-QT
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 10:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbaDKI2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 04:28:33 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:49703 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbaDKI23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 04:28:29 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so5099969pbc.16
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtL3xq0nUUlwU21hCG9TW7a7B01HO+L/9DAmb1qFnpA=;
        b=hm6SeSc7wdqmDDQlxjFOaXPKDSgdVTQtYX32MHtfwcu5MSN1+8YzCeiIjHf/UVxvOt
         4Qjr0AUixM6LvOOGmOUsrtNWI9HGmdp7z4v1iEXXWiFUR4wz72hfXlEU9GCs1tQYazIS
         CQrHfMxDRsu80fakg0+ZjRz86o466sTCLTCv50IHL5otIPzzjeopcSxxw/Fzwut9S9OY
         CLqivHD8vYK7QLro+Hn/v4vT0X4/DrHhVh25JTcm4pBhkEopVXy4cpG9ANXvVtqTySj/
         ORrLpu1XnCJHnI3y8NUa28GCm+mVgBRAgAQOMy6bV02mEDoBp1C3FXm14FPWRrvlLWnD
         LBhA==
X-Received: by 10.68.202.230 with SMTP id kl6mr25755933pbc.55.1397204908859;
        Fri, 11 Apr 2014 01:28:28 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ky8sm14002027pbc.64.2014.04.11.01.28.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 01:28:28 -0700 (PDT)
In-Reply-To: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246072>

This reverts commit 99855ddf4bd319cd06a0524e755ab1c1b7d39f3b.

The workaround 99855ddf introduced to deal with problematic
"return" statements in scripts run by "dot" commands located
inside functions only handles one part of the problem.  The
issue has now been addressed by not using "return" statements
in this way in the git-rebase--*.sh scripts.

This workaround is therefore no longer necessary, so clean
up the code by reverting it.

Conflicts:
        git-rebase.sh

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

---
 git-rebase.sh | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 8a3efa29..07e2bd48 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -169,22 +169,13 @@ You can run "git stash pop" or "git stash drop" at any time.
 	rm -rf "$state_dir"
 }
 
-run_specific_rebase_internal () {
+run_specific_rebase () {
 	if [ "$interactive_rebase" = implied ]; then
 		GIT_EDITOR=:
 		export GIT_EDITOR
 		autosquash=
 	fi
-	# On FreeBSD, the shell's "return" returns from the current
-	# function, not from the current file inclusion.
-	# run_specific_rebase_internal has the file inclusion as a
-	# last statement, so POSIX and FreeBSD's return will do the
-	# same thing.
 	. git-rebase--$type
-}
-
-run_specific_rebase () {
-	run_specific_rebase_internal
 	ret=$?
 	if test $ret -eq 0
 	then
-- 
tg: (1bb252a9..) t/revert-99855ddf (depends on: t/freebsd-sh-return)
