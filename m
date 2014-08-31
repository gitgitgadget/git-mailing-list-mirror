From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] stash: prefer --quiet over shell redirection
Date: Sun, 31 Aug 2014 00:42:53 -0700
Message-ID: <1409470973-67707-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 09:42:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNzm6-0003Hi-QG
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 09:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbaHaHmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 03:42:07 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63921 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaHaHmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 03:42:05 -0400
Received: by mail-pd0-f179.google.com with SMTP id z10so3589365pdj.38
        for <git@vger.kernel.org>; Sun, 31 Aug 2014 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+iXJHheP0os/WF09p8oD7/RLY1oAV7f02Ukphz9+77A=;
        b=cXc/Ho9kCHsa7VnV1SzaRGDpBbfCAHUhc0cfJB3E9t5UfjqAhNedGlUT8vUszkjRKZ
         IJlM0HjafDmjytFS4vV9ahOgnTSo4riRAmmcPpcGiZOoy0zZjzqTjo/LdxE2L2BsbFJx
         FXRSlLYR0AUzXaW2OiFJv4ik9XWU2R9GBWxfsAd6UxC1fx2ve/UpUuP5vSza4DNI8WNK
         TFG4raycyPVm1M0dE0pEEoUJ7eabT1UW7HvhiVEiUolKbveBEHQfUFA2H83hMnPKGtJ4
         +4UworHSYQ0wjjTivAqSR5b48faplCuKVZP/ET3nA9KIsDneu1oNYyvoxstM9pHOZbSW
         Z6bQ==
X-Received: by 10.68.238.69 with SMTP id vi5mr29061537pbc.0.1409470924487;
        Sun, 31 Aug 2014 00:42:04 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id c3sm7004789pdj.6.2014.08.31.00.42.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 31 Aug 2014 00:42:03 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.29.g9b751c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256282>

Use `git rev-parse --verify --quiet` instead of redirecting
stderr to /dev/null.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-stash.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..2ff8b94 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -50,7 +50,7 @@ clear_stash () {
 	then
 		die "$(gettext "git stash clear with parameters is unimplemented")"
 	fi
-	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=$(git rev-parse --verify --quiet $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -292,7 +292,7 @@ save_stash () {
 }
 
 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
 list_stash () {
@@ -392,12 +392,12 @@ parse_flags_and_rev()
 		;;
 	esac
 
-	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
+	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
 		reference="$1"
 		die "$(eval_gettext "\$reference is not valid reference")"
 	}
 
-	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
+	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
 	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
 	s=$1 &&
 	w_commit=$1 &&
@@ -409,7 +409,7 @@ parse_flags_and_rev()
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
 
-	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
+	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
 	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
 }
 
@@ -531,7 +531,8 @@ drop_stash () {
 		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
 
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
+	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
+	clear_stash
 }
 
 apply_to_branch () {
-- 
2.1.0.29.g9b751c4
