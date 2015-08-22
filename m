From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] checkout(-index): do not checkout i-t-a entries
Date: Sat, 22 Aug 2015 08:08:08 +0700
Message-ID: <1440205700-19749-6-git-send-email-pclouds@gmail.com>
References: <xmqqy4j80wdb.fsf@gitster.dls.corp.google.com>
 <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxIy-0004yK-7V
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbbHVBJC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:09:02 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35483 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbHVBJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:09:01 -0400
Received: by pacdd16 with SMTP id dd16so54731083pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jKySagnPBnowXGfVoIWfhtiESK/3PJgW7GBb7lYjfXg=;
        b=sxINlwEWsrFM6ohXtSYW2nMr4pAe4XhV6KsU8mrYg8SGkdo61IvuAY9xrUUrI89/mT
         hp7mFPC2Q3QSm5T3Dv/gveI0MnPi2inl81Ncpnn6Ei7SL5RwoaJ1DqqFrvywx3VhrqDr
         ghwZl5XJG0hIVPoDiRQBI+Ah4dECxZfIQHV028OVueKNckYJuo+z8ZmqqLbhgmYOY3Ii
         fgoHr5ECCuHTRP4boCK3lLTy9IjhdIQhHPf5bvbWyPKeHrdyy4OlS6iY6XBIDPUtsTuB
         Ct49pnQacmQ9nxlfxtTfwv1BTMmOsSkgJyDBJj8pXa4KDlYMztFhhaTmlstv/wAeUwUI
         rZBw==
X-Received: by 10.66.141.199 with SMTP id rq7mr22152191pab.57.1440205740607;
        Fri, 21 Aug 2015 18:09:00 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id jr12sm9100267pbb.91.2015.08.21.18.08.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:08:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:08:57 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276357>

The cached blob of i-t-a entries are empty blob. By checkout, we delete
the content we have. Don't do it.

This is done higher up instead of inside checkout_entry() because we
would have limited options in there: silently ignore, loudly ignore,
die. At higher level we can do better reporting. For example, "git
checkout -- foo" will complain that "foo" does not match pathspec, just
like when "foo" is not registered with "git add -N"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout-index.c |  5 ++++-
 builtin/checkout.c       |  2 ++
 t/t2203-add-intent.sh    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..eca975d 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -56,7 +56,8 @@ static int checkout_file(const char *name, const char=
 *prefix)
 	while (pos < active_nr) {
 		struct cache_entry *ce =3D active_cache[pos];
 		if (ce_namelen(ce) !=3D namelen ||
-		    memcmp(ce->name, name, namelen))
+		    memcmp(ce->name, name, namelen) ||
+		    ce_intent_to_add(ce))
 			break;
 		has_same_name =3D 1;
 		pos++;
@@ -99,6 +100,8 @@ static void checkout_all(const char *prefix, int pre=
fix_length)
 		if (ce_stage(ce) !=3D checkout_stage
 		    && (CHECKOUT_ALL !=3D checkout_stage || !ce_stage(ce)))
 			continue;
+		if (ce_intent_to_add(ce))
+			continue;
 		if (prefix && *prefix &&
 		    (ce_namelen(ce) <=3D prefix_length ||
 		     memcmp(prefix, ce->name, prefix_length)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index e1403be..02889d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -300,6 +300,8 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 			 * anything to this entry at all.
 			 */
 			continue;
+		if (ce_intent_to_add(ce))
+			continue;
 		/*
 		 * Either this entry came from the tree-ish we are
 		 * checking the paths out of, or we are checking out
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 96c8755..d0f36a4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -111,5 +111,39 @@ test_expect_success 'apply:check_preimage() not cr=
eating empty file' '
 	)
 '
=20
+test_expect_success 'checkout ignores i-t-a' '
+	git init checkout &&
+	(
+		cd checkout &&
+		echo data >file &&
+		git add -N file &&
+		test_must_fail git checkout -- file &&
+		echo data >expected &&
+		test_cmp expected file
+	)
+'
+
+test_expect_success 'checkout-index ignores i-t-a' '
+	(
+		cd checkout &&
+		git checkout-index file &&
+		echo data >expected &&
+		test_cmp expected file
+	)
+'
+
+test_expect_success 'checkout-index --all ignores i-t-a' '
+	(
+		cd checkout &&
+		echo data >anotherfile &&
+		git add anotherfile &&
+		rm anotherfile &&
+		git checkout-index --all &&
+		echo data >expected &&
+		test_cmp expected file &&
+		test_cmp expected anotherfile
+	)
+'
+
 test_done
=20
--=20
2.3.0.rc1.137.g477eb31
