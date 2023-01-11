Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FECC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjAKSip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjAKSii (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 13:38:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CECBEB4
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 10:38:37 -0800 (PST)
Received: (qmail 30100 invoked by uid 109); 11 Jan 2023 18:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Jan 2023 18:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7779 invoked by uid 111); 11 Jan 2023 18:38:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Jan 2023 13:38:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Jan 2023 13:38:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] convert trivial uses of strncmp() to skip_prefix()
Message-ID: <Y78CLLu9YN+MyY2/@coredump.intra.peff.net>
References: <Y7lyga5g2leSmWQd@coredump.intra.peff.net>
 <Y7lzFG9gyDrOE4Xt@coredump.intra.peff.net>
 <Y7l0mq6khtlgxGca@coredump.intra.peff.net>
 <e525342d-5900-1870-f176-da4eef083143@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e525342d-5900-1870-f176-da4eef083143@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 07, 2023 at 10:29:28PM +0100, René Scharfe wrote:

> > So it will prefix-match any of the options, even if there are
> > ambiguities. E.g.:
> >
> >   git -c core.whitespace=-t show
> >
> > will turn off "trailing-space", even though it would also match
> > "tab-in-indent". It would be easy enough to fix it to require the whole
> > name, but I wasn't sure if this prefix-matching was supposed to be a
> > feature (it doesn't seem to be documented anywhere, though).
> 
> Abbreviations are being used:
> 
>    $ git grep whitespace= .gitattributes
>    .gitattributes:* whitespace=!indent,trail,space
>    .gitattributes:*.[ch] whitespace=indent,trail,space diff=cpp
>    .gitattributes:*.sh whitespace=indent,trail,space eol=lf
> 
> (Full names: trailing-space, space-before-tab, indent-with-non-tab.)

Ah, right, I should have checked to see if _we_ are using them before
guessing whether anyone else might be.

> a9cc857ada (War on whitespace: first, a bit of retreat., 2007-11-02)
> added this function.  Its commit message says:
> 
>    "You can specify the desired types of errors to be detected by
>     listing their names (unique abbreviations are accepted)
>     separated by comma."

Thanks, I dug around for something like that but somehow missed it.

So yeah, we definitely want to keep this abbreviation feature working.
The only question is whether we ought to detect ambiguous ones. I think
something like this would work, though I wonder if is even worth
bothering about. I did not even see this in the wild, but it was just a
curiosity while I was adjusting something else in the function:

diff --git a/ws.c b/ws.c
index 46a77bcad6..f4efd66209 100644
--- a/ws.c
+++ b/ws.c
@@ -29,6 +29,7 @@ unsigned parse_whitespace_rule(const char *string)
 		int i;
 		size_t len;
 		const char *ep;
+		struct whitespace_rule *matched = NULL;
 		int negated = 0;
 
 		string = string + strspn(string, ", \t\n\r");
@@ -43,15 +44,27 @@ unsigned parse_whitespace_rule(const char *string)
 		if (!len)
 			break;
 		for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
-			if (strncmp(whitespace_rule_names[i].rule_name,
-				    string, len))
+			struct whitespace_rule *cur = &whitespace_rule_names[i];
+			if (strncmp(cur->rule_name, string, len))
 				continue;
+			if (matched) {
+				warning("ignoring ambiguous whitespace rule '%.*s'"
+					" (matches '%s' and '%s')",
+					(int)len, string,
+					matched->rule_name, cur->rule_name);
+				matched = NULL;
+				break;
+			}
+			matched = cur;
+		}
+
+		if (matched) {
 			if (negated)
-				rule &= ~whitespace_rule_names[i].rule_bits;
+				rule &= ~matched->rule_bits;
 			else
-				rule |= whitespace_rule_names[i].rule_bits;
-			break;
+				rule |= matched->rule_bits;
 		}
+
 		if (strncmp(string, "tabwidth=", 9) == 0) {
 			unsigned tabwidth = atoi(string + 9);
 			if (0 < tabwidth && tabwidth < 0100) {

-Peff
