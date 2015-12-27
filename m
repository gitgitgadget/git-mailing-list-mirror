From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] apply: fix adding new files on i-t-a entries
Date: Sun, 27 Dec 2015 08:51:29 +0700
Message-ID: <1451181092-26054-4-git-send-email-pclouds@gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0VW-0006bw-2f
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbbL0BwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:52:10 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35906 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbbL0Bvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:51:45 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so51287031pff.3
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tMBe1psOAJ4UOjvyzfnJWqM1aJUNVU644SpILOBSkbg=;
        b=AI7X+K5FemsTReB/fpu0i7NnQoZEi+01DZQQRuEki7RyOZcbu2p7LnM/rNllVjC1F3
         eYVXDypp1/mrcpBnteP31MO5h1KUq27R287KlB7AB0Ulsw7fGtvej3SwaBLnaEptoR7q
         tq6goqhbRFnE9fyPWLsSkRo3hL0XdpyfWF6ggAgrPZjOvZEpH8MLyLhRFMHkCFVUjwSa
         lWfYQPT/zIchgF6YKb9xtsn0UwI/NZONhrXXBtRm6YMW97TGSXi5tdQdzfLJD8iWl2y7
         zZc/7ICVt2+39RoTtvgdhx69iH4scT2KfEJ26y3RD7DgZjEZQ73WfZqMy7ehqd58AbEO
         RoMw==
X-Received: by 10.98.70.12 with SMTP id t12mr42872241pfa.38.1451181105219;
        Sat, 26 Dec 2015 17:51:45 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id 19sm31610382pfj.16.2015.12.26.17.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:51:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:51:51 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283006>

Suppose that you came up with some contents to register at path F in
your working tree, told Git about your intention with "add -N F", and
then tried to apply a patch that wants to _create_ F:

Without this patch, we would say "F already exists so a patch to
create is incompatible with our current state".

With this patch, i-t-a entries are ignored and we do not say that, but
instead we'll hopefully trigger "does it exist in the working tree"
check, unless you are running under "--cached".

Which means that this change will not lead to data loss in the
"untracked" file F in the working tree that was merely added to the
index with i-t-a bit.

(commit message mostly from Junio)

Reported-by: Patrick Higgins <phiggins@google.com>
Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c       |  9 +++++----
 t/t2203-add-intent.sh | 13 +++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0769b09..315fce8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3550,10 +3550,11 @@ static int check_to_create(const char *new_name=
, int ok_if_exists)
 {
 	struct stat nst;
=20
-	if (check_index &&
-	    cache_name_pos(new_name, strlen(new_name)) >=3D 0 &&
-	    !ok_if_exists)
-		return EXISTS_IN_INDEX;
+	if (check_index && !ok_if_exists) {
+		int pos =3D cache_name_pos(new_name, strlen(new_name));
+		if (pos >=3D 0 && !ce_intent_to_add(active_cache[pos]))
+			return EXISTS_IN_INDEX;
+	}
 	if (cached)
 		return 0;
=20
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2a4a749..bb5ef2b 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -82,5 +82,18 @@ test_expect_success 'cache-tree invalidates i-t-a pa=
ths' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'apply adds new file on i-t-a entry' '
+	git init apply &&
+	(
+		cd apply &&
+		echo newcontent >newfile &&
+		git add newfile &&
+		git diff --cached >patch &&
+		rm .git/index &&
+		git add -N newfile &&
+		git apply --cached patch
+	)
+'
+
 test_done
=20
--=20
2.3.0.rc1.137.g477eb31
