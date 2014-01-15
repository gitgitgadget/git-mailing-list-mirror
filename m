From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] pull: add pull.ff configuration
Date: Wed, 15 Jan 2014 15:18:38 -0800
Message-ID: <1389827919-13608-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 00:18:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ZjT-0007Pf-N4
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbaAOXSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:18:42 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:45524 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaAOXSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 18:18:39 -0500
Received: by mail-pa0-f53.google.com with SMTP id lj1so1802803pab.26
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 15:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=C4sBquqG3hR8GXTwoToyblYWCgDbGnBgng3/tH0WS3E=;
        b=D4VQ2zacj3qPmAFFGNdy9v0Rk4x2ltezB+GsLQjZ36MgyNQJl4x4B2sfaqG1CL9B8o
         F8ElyMGTYOte/Wo34GNSc8VM4ElnBsd7agQ2CgGDqOhSchg+xMtAa1+WkrAXFY+a4FzV
         ZasBkH+MmdWjyyMzgqbTuufWE8IySEE2OO7aKyj5BYMlAcVJJmfhQHWkro07sU9OSSQz
         ay3Evh3lCu7iva787B6O98W+gOJuqM2Mh/sdgZU1L0cUkayZxuf+ItZ769nfRH8Zi+Hv
         iaqq3/15umnp6PRAR8B9+CQLK3ffXuePu5ffu5Pc5GshPGiMkc21cTHtW/6BIlYDuGJj
         qqmA==
X-Received: by 10.68.176.65 with SMTP id cg1mr5874779pbc.145.1389827918570;
        Wed, 15 Jan 2014 15:18:38 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id qw8sm10537189pbb.27.2014.01.15.15.18.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 15:18:37 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240488>

Add a `pull.ff` configuration option that is analogous
to the `merge.ff` option.

This allows us to control the fast-forward behavior for
pull-initiated merges only.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/config.txt     | 10 ++++++++++
 git-pull.sh                  | 15 +++++++++++++++
 t/t7601-merge-pull-config.sh | 21 +++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ed59853..23b0016 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1881,6 +1881,16 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
 
+pull.ff::
+	By default, Git does not create an extra merge commit when merging
+	a commit that is a descendant of the current commit. Instead, the
+	tip of the current branch is fast-forwarded. When set to `false`,
+	this variable tells Git to create an extra merge commit in such
+	a case (equivalent to giving the `--no-ff` option from the command
+	line). When set to `only`, only such fast-forward merges are
+	allowed (equivalent to giving the `--ff-only` option from the
+	command line).
+
 pull.rebase::
 	When true, rebase branches on top of the fetched branch, instead
 	of merging the default branch from the default remote when "git
diff --git a/git-pull.sh b/git-pull.sh
index f210d0a..7dbf6b1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -52,6 +52,21 @@ if test -z "$rebase"
 then
 	rebase=$(bool_or_string_config pull.rebase)
 fi
+
+# Setup default fast-forward options via `pull.ff`
+pull_ff=$(git config pull.ff)
+case "$pull_ff" in
+false)
+	no_ff=--no-ff
+	break
+	;;
+only)
+	ff_only=--ff-only
+	break
+	;;
+esac
+
+
 dry_run=
 while :
 do
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 830a4c3..f768c90 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -38,6 +38,27 @@ test_expect_success 'merge c1 with c2' '
 	test -f c2.c
 '
 
+test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
+	git reset --hard c0 &&
+	test_config pull.ff true &&
+	git pull . c1 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
+'
+
+test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
+	git reset --hard c0 &&
+	test_config pull.ff false &&
+	git pull . c1 &&
+	test "$(git rev-parse HEAD^1)" = "$(git rev-parse c0)" &&
+	test "$(git rev-parse HEAD^2)" = "$(git rev-parse c1)"
+'
+
+test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	test_must_fail git pull . c3
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
1.8.5.3.322.g71d2a99
