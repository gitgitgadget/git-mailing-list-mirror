From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] checkout(-index): do not checkout i-t-a entries
Date: Sun, 27 Dec 2015 08:51:31 +0700
Message-ID: <1451181092-26054-6-git-send-email-pclouds@gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 02:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD0VP-0006Rc-T1
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 02:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbbL0BwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 20:52:12 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33963 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbbL0Bv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 20:51:58 -0500
Received: by mail-pa0-f46.google.com with SMTP id uo6so70625225pac.1
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 17:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=S5hP3mvPEyHS9m7oTZPJa/fTMdqoURtjk+mPGKbOpw4=;
        b=nRRVriuG8e3ibLVZppIT6UfNud0G+Vs9qo9MpoNPZispVrYcVnKUvKEcr1XTMrymde
         sgsf4pO3tuG35UqQ+WaKIzvyskOJoBKxA5v8T3wgZFMmyt6PuaCG+pFPzj0skHDDd49P
         x6rTq+yx+U4JqgaK12GoCbH6+2oLIo493c9qOFF5M3CXJwcaqBJ4jSaQBObNlzl51Ete
         8UacrM5nz6ESiF0iNjN/73M3hNH933LdFGlZVYMA/ysRjFTN9fXBRtwEUXm0v3e9rFUR
         FU0hTipYsPynFJFWvQntMH1uOJipnE4Ew0EYw9+0r5FUCpOunmbtdzOps3YQtlaxl7R6
         rIKw==
X-Received: by 10.66.232.202 with SMTP id tq10mr66212915pac.156.1451181117585;
        Sat, 26 Dec 2015 17:51:57 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id y26sm945485pfi.89.2015.12.26.17.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 17:51:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 08:52:03 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283003>

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
 builtin/checkout-index.c | 12 ++++++++++--
 builtin/checkout.c       |  9 ++++++---
 t/t2203-add-intent.sh    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 9ca2da1..d9fe8f4 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -48,6 +48,7 @@ static int checkout_file(const char *name, const char=
 *prefix)
 	int pos =3D cache_name_pos(name, namelen);
 	int has_same_name =3D 0;
 	int did_checkout =3D 0;
+	int has_intent_to_add =3D 0;
 	int errs =3D 0;
=20
 	if (pos < 0)
@@ -56,8 +57,11 @@ static int checkout_file(const char *name, const cha=
r *prefix)
 	while (pos < active_nr) {
 		struct cache_entry *ce =3D active_cache[pos];
 		if (ce_namelen(ce) !=3D namelen ||
-		    memcmp(ce->name, name, namelen))
+		    memcmp(ce->name, name, namelen)) {
+			if (ce_intent_to_add(ce))
+				has_intent_to_add =3D 1;
 			break;
+		}
 		has_same_name =3D 1;
 		pos++;
 		if (ce_stage(ce) !=3D checkout_stage
@@ -77,7 +81,9 @@ static int checkout_file(const char *name, const char=
 *prefix)
=20
 	if (!state.quiet) {
 		fprintf(stderr, "git checkout-index: %s ", name);
-		if (!has_same_name)
+		if (has_intent_to_add)
+			fprintf(stderr, "is not yet in the cache");
+		else if (!has_same_name)
 			fprintf(stderr, "is not in the cache");
 		else if (checkout_stage)
 			fprintf(stderr, "does not exist at stage %d",
@@ -99,6 +105,8 @@ static void checkout_all(const char *prefix, int pre=
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
index 3e141fc..ac37d92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -328,12 +328,15 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
 	if (opts->merge)
 		unmerge_marked_index(&the_index);
=20
-	/* Any unmerged paths? */
 	for (pos =3D 0; pos < active_nr; pos++) {
-		const struct cache_entry *ce =3D active_cache[pos];
+		struct cache_entry *ce =3D active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
-			if (!ce_stage(ce))
+			if (!ce_stage(ce)) {
+				if (ce_intent_to_add(ce))
+					ce->ce_flags &=3D ~CE_MATCHED;
 				continue;
+			}
+			/* Unmerged paths */
 			if (opts->force) {
 				warning(_("path '%s' is unmerged"), ce->name);
 			} else if (opts->writeout_stage) {
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 96c8755..52e9f7f 100755
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
+		git checkout -- file &&
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
