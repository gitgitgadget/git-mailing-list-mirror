Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925C7C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbiLNQTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiLNQTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:19:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145627155
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:19:44 -0800 (PST)
Received: (qmail 25920 invoked by uid 109); 14 Dec 2022 16:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19954 invoked by uid 111); 14 Dec 2022 16:19:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:19:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:19:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] ref-filter: factor out "%(foo) does not take arguments"
 errors
Message-ID: <Y5n3n7Gp2gKNMln3@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many atom parsers give the same error message, differing only in the
name of the atom. If we use "%s does not take arguments", that should
make life easier for translators, as they only need to translate one
string. And in doing so, we can easily pull it into a helper function to
make sure they are all using the exact same string.

I've added a basic test here for %(HEAD), just to make sure this code is
exercised at all in the test suite. We could cover each such atom, but
the effort-to-reward ratio of trying to maintain an exhaustive list
doesn't seem worth it.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 16 +++++++++++-----
 t/t6300-for-each-ref.sh |  6 ++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 08ac5f886e..639b18ab36 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -228,6 +228,12 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
 	return ret;
 }
 
+static int err_no_arg(struct strbuf *sb, const char *name)
+{
+	strbuf_addf(sb, _("%%(%s) does not take arguments"), name);
+	return -1;
+}
+
 static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *color_value, struct strbuf *err)
 {
@@ -317,7 +323,7 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 				  const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
+		return err_no_arg(err, "objecttype");
 	if (*atom->name == '*')
 		oi_deref.info.typep = &oi_deref.type;
 	else
@@ -349,7 +355,7 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 				 const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
+		return err_no_arg(err, "deltabase");
 	if (*atom->name == '*')
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
@@ -361,7 +367,7 @@ static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(body) does not take arguments"));
+		return err_no_arg(err, "body");
 	atom->u.contents.option = C_BODY_DEP;
 	return 0;
 }
@@ -565,7 +571,7 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+		return err_no_arg(err, "rest");
 	format->use_rest = 1;
 	return 0;
 }
@@ -574,7 +580,7 @@ static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(HEAD) does not take arguments"));
+		return err_no_arg(err, "HEAD");
 	atom->u.head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 	return 0;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index fa38b87441..8d99658ef8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1242,6 +1242,12 @@ test_expect_success 'basic atom: rest must fail' '
 	test_must_fail git for-each-ref --format="%(rest)" refs/heads/main
 '
 
+test_expect_success 'HEAD atom does not take arguments' '
+	test_must_fail git for-each-ref --format="%(HEAD:foo)" 2>err &&
+	echo "fatal: %(HEAD) does not take arguments" >expect &&
+	test_cmp expect err
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
-- 
2.39.0.550.g5015380a67

