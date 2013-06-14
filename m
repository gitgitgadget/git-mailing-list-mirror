From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] rebase: use peel_committish() where appropriate
Date: Fri, 14 Jun 2013 18:47:52 +0530
Message-ID: <1371215872-9796-4-git-send-email-artagnon@gmail.com>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:20:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTv7-0004tR-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab3FNNT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:19:56 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:46491 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3FNNTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:19:55 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so564002pbb.6
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=35cD748f552BHHWOWKbJWzuAppnNA+u2uNA03tVt5c0=;
        b=yOjHEW5mISsH3TUMs5WPFv4b8CwDhlPrgnnY8Orgv9NRuu1NC2vEwGtsk6JLlUkT6i
         WBdtYr/DOL8U7Zfw2R1dgHH20QOsjg+7M2bcSNJmsxruE2lSIT0dQ4Ao/SWuxHakTi16
         EtZFqiqgoUNi2gjvehLyS2VI/90P4nLus9V7i96XRwV5JyxF27ZkgzDA0S/Ej0fnU0K/
         9qCcR3h4I6xmPq40JHllZUXhZCz9bk0MBX1xi9okiRNVFu28V4mSlvpqHMrJI8+G+gPS
         7eqymPXbMpl61TTC6NmvTG8RP+E0SrwRHF5DxZ+qFFtwwkNtgQcWw6YYsoKFUiKphQB4
         hioA==
X-Received: by 10.66.161.41 with SMTP id xp9mr1888015pab.166.1371215993772;
        Fri, 14 Jun 2013 06:19:53 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id i16sm2422081pag.18.2013.06.14.06.19.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:19:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g12ca056.dirty
In-Reply-To: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227829>

The revisions specified on the command-line as <onto> and <upstream>
arguments could be of the form :/quuxery; so, use peel_committish() to
resolve them.  The failing tests in t/rebase and t/rebase-interactive
now pass.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh                 | 4 ++--
 t/t3400-rebase.sh             | 2 +-
 t/t3404-rebase-interactive.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index d0c11a9..6987b9b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -434,7 +434,7 @@ then
 		shift
 		;;
 	esac
-	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+	upstream=$(peel_committish "${upstream_name}") ||
 	die "$(eval_gettext "invalid upstream \$upstream_name")"
 	upstream_arg="$upstream_name"
 else
@@ -470,7 +470,7 @@ case "$onto_name" in
 	fi
 	;;
 *)
-	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	onto=$(peel_committish "$onto_name") ||
 	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
 	;;
 esac
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 81ec517..cbca71e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,7 +88,7 @@ test_expect_success 'rebase fast-forward to master' '
 	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
-test_expect_failure 'rebase, with <onto> and <upstream> specified as :/quuxery' '
+test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase my-topic-branch^ &&
 	upstream=$(git rev-parse ":/Add B") &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index eb241f5..86917d1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,7 +947,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-test_expect_failure 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
+test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase branch1 &&
 	upstream=$(git rev-parse ":/J") &&
-- 
1.8.3.1.381.g12ca056.dirty
