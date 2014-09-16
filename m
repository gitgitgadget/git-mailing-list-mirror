From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 3/3] stash: prefer --quiet over shell redirection of the standard error stream
Date: Mon, 15 Sep 2014 20:24:10 -0700
Message-ID: <1410837850-5169-3-git-send-email-davvid@gmail.com>
References: <1410837850-5169-1-git-send-email-davvid@gmail.com>
 <1410837850-5169-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 05:24:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTjNV-0000h4-QD
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 05:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbaIPDYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 23:24:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47388 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbaIPDYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 23:24:24 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so7983790pad.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9BT+gP+9ZwFO2XxMMQoYsU4ivLsOpyTegFNqyhf1Ys=;
        b=pzqBcbtw7mX2sJV70wFhLcFJ4UAWOfoBEcM3EVPaV6qfSN/LmiG8nJKO1QwafCbqfC
         b9tS6XwTzq0gfA21sDoYuWI4IaXuBduoPCb4gfk6tBOK1NTRnQtPyKww8my5xB1xg0I4
         Z9Q41DYyCpZx/Dhp/VK0j4lZLufg+lpQvEx4UR9iQujU4/anDEOZcPhCYLgcpoDMChBk
         6HShs3fPwSYhbrsJaeD3wGq2FmcZOyFTLJU8dg9t3Z5pgAfrw44MaBvIJYd+UFdgI5iH
         jlpuPqYBRscflEhi+gjckLro/QHG+w+A8cIm2P1a7s329a5NQnKNjnOJjJQDRXaFBDEK
         K24A==
X-Received: by 10.66.197.132 with SMTP id iu4mr11103595pac.132.1410837863677;
        Mon, 15 Sep 2014 20:24:23 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id v1sm12633581pdp.76.2014.09.15.20.24.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 20:24:23 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
In-Reply-To: <1410837850-5169-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257126>

Use `git rev-parse --verify --quiet` instead of redirecting
stderr to /dev/null.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is unchanged from when it was first written,
but is now correct thanks to the preceding patch.

 git-stash.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9c1ba8e..7ece0f1 100755
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
2.1.0.30.g05c535b.dirty
