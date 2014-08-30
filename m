From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] stash: prefer --quiet over shell redirection
Date: Sat, 30 Aug 2014 12:30:29 -0700
Message-ID: <1409427029-65886-2-git-send-email-davvid@gmail.com>
References: <1409427029-65886-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNoLZ-0002y0-9X
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 21:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaH3T3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 15:29:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44752 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaH3T3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 15:29:48 -0400
Received: by mail-pd0-f177.google.com with SMTP id r10so2819821pdi.22
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2+711l/ePNEkMopN92QKK4CwcEdMMF32r0Nfs5tSS4=;
        b=qq+rsoUQV+NIc0+UgY0kFkeq6BqfqCF8365SIshc/EXfnk5ZUJx/JyhD3Z2NMnDBMi
         fcuaheoQSpYI7nXkMkfTX5APhNOyn4VbvnxzNHGLYwwmm5cCeh4fiQJuhxu28nibWxzM
         CYquFjWiOp3hV6aTk3+j3lLzfSmmpmzgWFKkKbs1QxK7yhnYltvpqwlLQdobqkRF6vZK
         ywezoICDJ5d9hzUACjJZloPjuduAWRzesEuK0Nk4TCdP4Y6kROykImyVLHDkMwSBWXX2
         pPap7kimO+Fe+u13SzuZWgRAo+E/6bntTzaxg9hxVi5SquAd746g+spTyjWL3mi0Yxhv
         pZAw==
X-Received: by 10.70.7.164 with SMTP id k4mr26727000pda.6.1409426987740;
        Sat, 30 Aug 2014 12:29:47 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dh14sm11898336pac.17.2014.08.30.12.29.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 30 Aug 2014 12:29:47 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.29.g9b751c4
In-Reply-To: <1409427029-65886-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256260>

Use `git rev-parse --quiet` instead of redirecting to /dev/null.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bcc757b..5a5185b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -50,7 +50,7 @@ clear_stash () {
 	then
 		die "$(gettext "git stash clear with parameters is unimplemented")"
 	fi
-	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
+	if current=$(git rev-parse --quiet --verify $ref_stash)
 	then
 		git update-ref -d $ref_stash $current
 	fi
@@ -67,7 +67,7 @@ create_stash () {
 	fi
 
 	# state of the base commit
-	if b_commit=$(git rev-parse --verify HEAD)
+	if b_commit=$(git rev-parse --quiet --verify HEAD)
 	then
 		head=$(git rev-list --oneline -n 1 HEAD --)
 	else
@@ -292,7 +292,7 @@ save_stash () {
 }
 
 have_stash () {
-	git rev-parse --verify $ref_stash >/dev/null 2>&1
+	git rev-parse --quiet --verify $ref_stash
 }
 
 list_stash () {
@@ -392,12 +392,12 @@ parse_flags_and_rev()
 		;;
 	esac
 
-	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
+	REV=$(git rev-parse --quiet --symbolic --verify "$1") || {
 		reference="$1"
 		die "$(eval_gettext "\$reference is not valid reference")"
 	}
 
-	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
+	i_commit=$(git rev-parse --quiet --verify "$REV^2") &&
 	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
 	s=$1 &&
 	w_commit=$1 &&
@@ -409,7 +409,7 @@ parse_flags_and_rev()
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
 
-	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
+	u_commit=$(git rev-parse --quiet --verify "$REV^3") &&
 	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
 }
 
@@ -531,7 +531,7 @@ drop_stash () {
 		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
 
 	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
+	git rev-parse --quiet --verify "$ref_stash@{0}" || clear_stash
 }
 
 apply_to_branch () {
-- 
2.1.0.29.g9b751c4
