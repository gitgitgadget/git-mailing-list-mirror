Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B174C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBNQBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNQBe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 11:01:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF8129
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 08:01:32 -0800 (PST)
Received: (qmail 31586 invoked by uid 109); 14 Feb 2023 16:01:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 16:01:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1997 invoked by uid 111); 14 Feb 2023 16:01:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 11:01:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 11:01:31 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <Y+uwW0I0k7urZ3do@coredump.intra.peff.net>
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
 <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
 <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g>
 <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g>
 <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 01:55:32AM -0500, Eric Sunshine wrote:

> On Tue, Feb 14, 2023 at 1:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > Using (presumably) valid LANG codes results in the buggy truncated
> > > output, but "LANG=C" produces the correct result:
> > >
> > >   $ for i in C en_US fr_FR de_DE ru_RU zh_CN; do printf "$i: " &&
> > > LANG=$i.UTF-8 git symbolic-ref --short HEAD; done
> > >   C: 测试-加-增加-加-增加
> > >   en_US: 测试-?
> > >   fr_FR: 测试-?
> > >   de_DE: 测试-?
> > >   ru_RU: 测试-?
> > >   zh_CN: 测试-?
> >
> > So the system cares more than just "is this a valid UTF-8 sequence?"
> > but somehow knows that the given sequence is a valid Chinese and not
> > valid English?  ---oh, no, zh_CN is rejected, but your earlier zh-CN
> > somehow was accepted?
> >
> > Now, it is beyond my ability to guess what macOS is internally doing
> > wrong X-<.
> 
> I  don't think the earlier incorrect "zh-CN" (in which I used "-"
> rather than "_") was accepted. Rather, the system simply didn't
> recognize it, thus presumably fell back to "C" locale. The same
> "correct" output results from any bogus LANG value:
> 
>   $ LANG=bogus git symbolic-ref --short HEAD
>   测试-加-增加-加-增加

Oof. So it is some weird locale thing that scanf is doing. I don't even
want to think about what the details could be. ;)

Since scanf is such a bad and error-prone interface in the first place
(and I'd actually like to put it on the banned list), what about just
parsing manually here? We are already implicitly assuming that each
rev-parse rule has a single "%.*s" in it. Armed with that knowledge,
it's not too hard to match using skip_prefix() and strip_suffix(). Or
with a little bit more custom code, we can avoid the step to pre-process
the rule strings completely. Something like:

 refs.c | 80 ++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/refs.c b/refs.c
index e31dbcda59..8ec7426c05 100644
--- a/refs.c
+++ b/refs.c
@@ -1310,55 +1310,59 @@ int update_ref(const char *msg, const char *refname,
 			       old_oid, flags, onerr);
 }
 
+/*
+ * Check that the string refname matches a rule of the form
+ * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
+ * "foo/%.*s/baz", and return the string "bar".
+ */
+static char *match_parse_rule(const char *refname, const char *rule)
+{
+	size_t len;
+
+	/*
+	 * Check that rule matches refname up to the first percent
+	 * in the rule. This is basically skip_prefix(), but
+	 * ending at percent in the prefix, rather than end-of-string.
+	 */
+	do {
+		if (!*rule)
+			BUG("rev-parse rule did not have percent");
+		if (*rule == '%')
+			break;
+	} while (*refname++ == *rule++);
+
+	/*
+	 * Check that we matched all the way to the "%" placeholder,
+	 * and skip past it within the rule string. If so, "refname" at
+	 * this point is the beginning of a potential match.
+	 */
+	if (!skip_prefix(rule, "%.*s", &rule))
+		return NULL;
+
+	/*
+	 * And now check that our suffix (if any) matches.
+	 */
+	if (!strip_suffix(refname, rule, &len))
+		return NULL;
+
+	return xmemdupz(refname, len);
+}
+
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 				   const char *refname, int strict)
 {
 	int i;
-	static char **scanf_fmts;
-	static int nr_rules;
 	char *short_name;
 	struct strbuf resolved_buf = STRBUF_INIT;
 
-	if (!nr_rules) {
-		/*
-		 * Pre-generate scanf formats from ref_rev_parse_rules[].
-		 * Generate a format suitable for scanf from a
-		 * ref_rev_parse_rules rule by interpolating "%s" at the
-		 * location of the "%.*s".
-		 */
-		size_t total_len = 0;
-		size_t offset = 0;
-
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
-			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
-
-		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), nr_rules), total_len));
-
-		offset = 0;
-		for (i = 0; i < nr_rules; i++) {
-			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += xsnprintf(scanf_fmts[i], total_len - offset,
-					    ref_rev_parse_rules[i], 2, "%s") + 1;
-		}
-	}
-
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
-	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
-
 	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
+	for (i = NUM_REV_PARSE_RULES - 1; i > 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
 		int short_name_len;
 
-		if (1 != sscanf(refname, scanf_fmts[i], short_name))
+		short_name = match_parse_rule(refname, ref_rev_parse_rules[i]);
+		if (!short_name)
 			continue;
 
 		short_name_len = strlen(short_name);
@@ -1368,7 +1372,7 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = nr_rules;
+			rules_to_fail = NUM_REV_PARSE_RULES;
 
 		/*
 		 * check if the short name resolves to a valid ref,
