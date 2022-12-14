Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12869C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiLNQU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiLNQUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:20:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD0275F9
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:20:20 -0800 (PST)
Received: (qmail 25939 invoked by uid 109); 14 Dec 2022 16:20:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:20:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19977 invoked by uid 111); 14 Dec 2022 16:20:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:20:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:20:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] ref-filter: factor out "unrecognized %(foo) arg" errors
Message-ID: <Y5n3w4A5x6RFXQfB@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atom parsers that take arguments generally have a catch-all for "this
arg is not recognized". Most of them use the same printf template, which
is good, because it makes life easier for translators. Let's pull this
template into a helper function, which makes the code in the parsers
shorter and avoids any possibility of differences.

As with the previous commit, we'll pick an arbitrary atom to make sure
the test suite covers this code.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 16 +++++++++++-----
 t/t6300-for-each-ref.sh |  6 ++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 639b18ab36..271d619da9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -234,6 +234,12 @@ static int err_no_arg(struct strbuf *sb, const char *name)
 	return -1;
 }
 
+static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
+{
+	strbuf_addf(sb, _("unrecognized %%(%s) argument: %s"), name, arg);
+	return -1;
+}
+
 static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 			     const char *color_value, struct strbuf *err)
 {
@@ -347,7 +353,7 @@ static int objectsize_atom_parser(struct ref_format *format, struct used_atom *a
 		else
 			oi.info.disk_sizep = &oi.disk_size;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "objectsize", arg);
+		return err_bad_arg(err, "objectsize", arg);
 	return 0;
 }
 
@@ -380,7 +386,7 @@ static int subject_atom_parser(struct ref_format *format, struct used_atom *atom
 	else if (!strcmp(arg, "sanitize"))
 		atom->u.contents.option = C_SUB_SANITIZE;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "subject", arg);
+		return err_bad_arg(err, "subject", arg);
 	return 0;
 }
 
@@ -434,7 +440,7 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
 			return strbuf_addf_ret(err, -1, _("positive value expected contents:lines=%s"), arg);
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "contents", arg);
+		return err_bad_arg(err, "contents", arg);
 	return 0;
 }
 
@@ -446,7 +452,7 @@ static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 	else if (!strcmp(arg, "size"))
 		atom->u.raw_data.option = RAW_LENGTH;
 	else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "raw", arg);
+		return err_bad_arg(err, "raw", arg);
 	return 0;
 }
 
@@ -563,7 +569,7 @@ static int if_atom_parser(struct ref_format *format, struct used_atom *atom,
 	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
 		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), "if", arg);
+		return err_bad_arg(err, "if", arg);
 	return 0;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8d99658ef8..010ba5a2cb 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1248,6 +1248,12 @@ test_expect_success 'HEAD atom does not take arguments' '
 	test_cmp expect err
 '
 
+test_expect_success 'subject atom rejects unknown arguments' '
+	test_must_fail git for-each-ref --format="%(subject:foo)" 2>err &&
+	echo "fatal: unrecognized %(subject) argument: foo" >expect &&
+	test_cmp expect err
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
-- 
2.39.0.550.g5015380a67

