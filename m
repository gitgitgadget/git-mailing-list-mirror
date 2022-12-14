Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F25CC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiLNQX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiLNQX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 11:23:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C32F6415
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 08:23:54 -0800 (PST)
Received: (qmail 26035 invoked by uid 109); 14 Dec 2022 16:23:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 16:23:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19996 invoked by uid 111); 14 Dec 2022 16:23:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 11:23:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 11:23:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] ref-filter: truncate atom names in error messages
Message-ID: <Y5n4mb/S/RORb+N7@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you pass a bogus argument to %(refname), you may end up with a
message like this:

  $ git for-each-ref --format='%(refname:foo)'
  fatal: unrecognized %(refname:foo) argument: foo

which is confusing. It should just say:

  fatal: unrecognized %(refname) argument: foo

which is clearer, and is consistent with most other atom parsers. Those
other parsers do not have the same problem because they pass the atom
name from a string literal in the parser function. But because the
parser for %(refname) also handles %(upstream) and %(push), it instead
uses atom->name, which includes the arguments. The oid atom parser which
handles %(tree), %(parent), etc suffers from the same problem.

It seems like the cleanest fix would be for atom->name to be _just_ the
name, since there's already a separate "args" field. But since that
field is also used for other things, we can't change it easily (e.g.,
it's how we find things in the used_atoms array, and clearly %(refname)
and %(refname:short) are not the same thing).

Instead, we'll teach our error_bad_arg() function to stop at the first
":". This is a little hacky, as we're effectively re-parsing the name,
but the format is simple enough to do this as a one-liner, and this
localizes the change to the error-reporting code.

We'll give the same treatment to err_no_arg(). None of its callers use
this atom->name trick, but it's worth future-proofing it while we're
here.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            | 12 ++++++++----
 t/t6300-for-each-ref.sh |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 271d619da9..f40bc4d9c9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -230,13 +230,17 @@ static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
 
 static int err_no_arg(struct strbuf *sb, const char *name)
 {
-	strbuf_addf(sb, _("%%(%s) does not take arguments"), name);
+	size_t namelen = strchrnul(name, ':') - name;
+	strbuf_addf(sb, _("%%(%.*s) does not take arguments"),
+		    (int)namelen, name);
 	return -1;
 }
 
 static int err_bad_arg(struct strbuf *sb, const char *name, const char *arg)
 {
-	strbuf_addf(sb, _("unrecognized %%(%s) argument: %s"), name, arg);
+	size_t namelen = strchrnul(name, ':') - name;
+	strbuf_addf(sb, _("unrecognized %%(%.*s) argument: %s"),
+		    (int)namelen, name, arg);
 	return -1;
 }
 
@@ -274,7 +278,7 @@ static int refname_atom_parser_internal(struct refname_atom *atom, const char *a
 		if (strtol_i(arg, 10, &atom->rstrip))
 			return strbuf_addf_ret(err, -1, _("Integer value expected refname:rstrip=%s"), arg);
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), name, arg);
+		return err_bad_arg(err, name, arg);
 	return 0;
 }
 
@@ -471,7 +475,7 @@ static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
 		if (atom->u.oid.length < MINIMUM_ABBREV)
 			atom->u.oid.length = MINIMUM_ABBREV;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), atom->name, arg);
+		return err_bad_arg(err, atom->name, arg);
 	return 0;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 010ba5a2cb..2ae1fc721b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1254,6 +1254,12 @@ test_expect_success 'subject atom rejects unknown arguments' '
 	test_cmp expect err
 '
 
+test_expect_success 'refname atom rejects unknown arguments' '
+	test_must_fail git for-each-ref --format="%(refname:foo)" 2>err &&
+	echo "fatal: unrecognized %(refname) argument: foo" >expect &&
+	test_cmp expect err
+'
+
 test_expect_success 'trailer parsing not fooled by --- line' '
 	git commit --allow-empty -F - <<-\EOF &&
 	this is the subject
-- 
2.39.0.550.g5015380a67

