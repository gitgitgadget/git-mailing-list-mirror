Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B4C433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1626E60EFE
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 02:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbhJICoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 22:44:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244102AbhJICo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 22:44:29 -0400
Received: (qmail 7230 invoked by uid 109); 9 Oct 2021 02:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 Oct 2021 02:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28049 invoked by uid 111); 9 Oct 2021 02:42:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Oct 2021 22:42:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Oct 2021 22:42:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Message-ID: <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
 <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 10:36:02PM -0400, Jeff King wrote:

> If that were coupled with, say, an advise() call to explain that output
> and matching might be inaccurate (and show that _once_), that might
> might it more clear what's going on.
> 
> Now I am sympathetic to flooding the user with too many messages, and
> maybe reducing this to a single instance of "some commit messages could
> not be re-encoded; output and matching might be inaccurate" is the right
> thing. But in a sense, it's also working as designed: what you asked for
> is producing wrong output over and over, and Git is saying so.

The single-output version would perhaps be something like this:

diff --git a/pretty.c b/pretty.c
index 708b618cfe..c86f41bae7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -606,6 +606,21 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
+static void show_encoding_warning(const char *output_encoding)
+{
+	static int seen_warning;
+
+	if (seen_warning)
+		return;
+
+	seen_warning = 1;
+	warning("one or more commits could not be re-encoded to '%s'",
+		output_encoding);
+	advise("When re-encoding fails, some output may be in an unexpected\n"
+	       "encoding, and pattern matches against commit data may be\n"
+	       "inaccurate.");
+}
+
 const char *repo_logmsg_reencode(struct repository *r,
 				 const struct commit *commit,
 				 char **commit_encoding,
@@ -673,7 +688,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 	 * case we just return the commit message verbatim.
 	 */
 	if (!out) {
-		warning("unable to reencode commit to '%s'", output_encoding);
+		show_encoding_warning(output_encoding);
 		return msg;
 	}
 	return out;
