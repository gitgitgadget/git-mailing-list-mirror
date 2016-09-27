Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EAB820986
	for <e@80x24.org>; Tue, 27 Sep 2016 12:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbcI0MiF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 08:38:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48771 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751939AbcI0MiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 08:38:04 -0400
Received: (qmail 11035 invoked by uid 109); 27 Sep 2016 12:38:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 12:38:03 +0000
Received: (qmail 15603 invoked by uid 111); 27 Sep 2016 12:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 08:38:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 08:38:01 -0400
Date:   Tue, 27 Sep 2016 08:38:01 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160927123801.3bpdg3hap3kzzfmv@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
 <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 09:36:23AM -0700, Linus Torvalds wrote:

> On Mon, Sep 26, 2016 at 5:00 AM, Jeff King <peff@peff.net> wrote:
> >
> > This patch teaches get_short_sha1() to list the sha1s of the
> > objects it found, along with a few bits of information that
> > may help the user decide which one they meant.
> 
> This looks very good to me, but I wonder if it couldn't be even more
> aggressive.
> 
> In particular, the only hashes that most people ever use in short form
> are commit hashes. Those are the ones you'd use in normal human
> interactions to point to something happening.
> 
> So when the disambiguation notices that there is ambiguity, but there
> is only _one_ commit, maybe it should just have an aggressive mode
> that says "use that as if it wasn't ambiguous".

You can basically get that by using "1234^{commit}" all the time, as
that turns on the committish disambiguator function (though it's not
quite the same, as it would pick a tag, too; you really want the
commit-only disambiguator). But presumably you'd want it on all the
time. See the patch below, which lets you do:

  git config --global core.disambiguate commit

and I think should do what you want. I'm up in the air on whether it is
a good idea or not, but then I do not usually run into ambiguous sha1s.

> And then have an explicit command (or flag) to do disambiguation for
> when you explicitly want it.

In my patch you can tweak the config variable off, though it might make
sense to also have some per-short-sha1 syntax.

> Rationale: you'd never care about short forms for tags. You'd just use
> the tag name. And while blob ID's certainly show up in short form in
> diff output (in the "index" line), very few people will use them. And
> tree hashes are basically never seen outside of any plumbing commands
> and then seldom in shortened form.

I think I do sometimes "git show $blob_sha1" based on a diff index line.
OTOH, I don't think of though as "long-term" references. I'm usually
trying to apply the patch at the time, so it's fairly fresh (it's true
that the short-sha1 may have been generated on the sender's side, who
has fewer objects, but I doubt that's a big problem in general; the real
issue is that it was unique at one point, and isn't a few years later).

But more importantly, any fallback like this should take a backseat to
context provided by the rest of git. So for instance, the index-building
in "am -3" uses the blob disambiguator, and should continue to do so
(and does with my patch).

> So I think it would make sense to default to a mode that just picks
> the commit hash if there is only one such hash. Sure, some command
> might want a "treeish", but a commit is still more likely than a tree
> or a tag.

By the same rule I just mentioned above, if you use the short sha1 in a
treeish context, it will look for any treeish (so "1234:foo" would
continue to look for any treeish, not just a commit). So that might not
be as desirable, but I think it does make sense (and of course it will
still tell you immediately what the options are, and you can decide what
to do).

-- >8 --
Subject: [PATCH] get_short_sha1: make default disambiguation configurable

When we find ambiguous short sha1s, we may get a
disambiguation rule from our caller's context. But if we
don't, we fall back to treating all sha1s the same, even
though most projects will tend to refer only to commits by
their short sha1s.

This patch introduces a configuration option that lets the
user pick a different fallback (e.g., only commits). It's
possible that we may want to make this the default, but it's
a good idea to start as a config option for two reasons:

  1. It lets people experiment with this and see if it's a
     good idea (i.e., the "tend to" above is an assumption;
     we don't really know if this will break some obscure
     cases).

  2. Even if we do flip the default, it gives people an
     escape hatch if it causes problems (you can sometimes
     override it by asking for "1234^{tree}", but not all
     combinations are possible).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                             |  2 ++
 config.c                            |  3 +++
 sha1_name.c                         | 32 ++++++++++++++++++++++++++++++++
 t/t1512-rev-parse-disambiguation.sh | 14 ++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/cache.h b/cache.h
index 5df0f33..b9583c4 100644
--- a/cache.h
+++ b/cache.h
@@ -1224,6 +1224,8 @@ extern int get_oid(const char *str, struct object_id *oid);
 typedef int each_abbrev_fn(const unsigned char *sha1, void *);
 extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 
+extern int set_disambiguate_hint_config(const char *var, const char *value);
+
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
  * starting at hex.  Write the 20-byte result to sha1 in binary form.
diff --git a/config.c b/config.c
index 1e4b617..83fdecb 100644
--- a/config.c
+++ b/config.c
@@ -841,6 +841,9 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.disambiguate"))
+		return set_disambiguate_hint_config(var, value);
+
 	if (!strcmp(var, "core.loosecompression")) {
 		int level = git_config_int(var, value);
 		if (level == -1)
diff --git a/sha1_name.c b/sha1_name.c
index 0513f14..3b647fd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -283,6 +283,36 @@ static int disambiguate_blob_only(const unsigned char *sha1, void *cb_data_unuse
 	return kind == OBJ_BLOB;
 }
 
+static disambiguate_hint_fn default_disambiguate_hint;
+
+int set_disambiguate_hint_config(const char *var, const char *value)
+{
+	static const struct {
+		const char *name;
+		disambiguate_hint_fn fn;
+	} hints[] = {
+		{ "none", NULL },
+		{ "commit", disambiguate_commit_only },
+		{ "committish", disambiguate_committish_only },
+		{ "tree", disambiguate_tree_only },
+		{ "treeish", disambiguate_treeish_only },
+		{ "blob", disambiguate_blob_only }
+	};
+	int i;
+
+	if (!value)
+		return config_error_nonbool(var);
+
+	for (i = 0; i < ARRAY_SIZE(hints); i++) {
+		if (!strcasecmp(value, hints[i].name)) {
+			default_disambiguate_hint = hints[i].fn;
+			return 0;
+		}
+	}
+
+	return error("unknown hint type for '%s': %s", var, value);
+}
+
 static int init_object_disambiguation(const char *name, int len,
 				      struct disambiguate_state *ds)
 {
@@ -373,6 +403,8 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 		ds.fn = disambiguate_treeish_only;
 	else if (flags & GET_SHA1_BLOB)
 		ds.fn = disambiguate_blob_only;
+	else
+		ds.fn = default_disambiguate_hint;
 
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index c5447ef..7c659eb 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -347,4 +347,18 @@ test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
 	test_line_count = 3 hints
 '
 
+test_expect_success 'core.disambiguate config can prefer types' '
+	# ambiguous between tree and tag
+	sha1=0000000000f &&
+	test_must_fail git rev-parse $sha1 &&
+	git rev-parse $sha1^{commit} &&
+	git -c core.disambiguate=committish rev-parse $sha1
+'
+
+test_expect_success 'core.disambiguate does not override context' '
+	# treeish ambiguous between tag and tree
+	test_must_fail \
+		git -c core.disambiguate=committish rev-parse $sha1^{tree}
+'
+
 test_done
-- 
2.10.0.564.g318c4ae

