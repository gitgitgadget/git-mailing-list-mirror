Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15312E69
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964454; cv=none; b=cbkJ2ct8gfujMG0HpbDyvOQGzVdYKmAhGwNHWYH9hUTEsNUi03dnyHaV3YE5EXNXvTZs4tGhTTIWrJ9dGM+3gVxW4hZVkNPgm0a77A6kQ99EzcTsUi7yjLt37XlFwL3RfQxpid7S3YCIWZf+sOwOPjVD+M5eKhNuvJ7sDGwwwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964454; c=relaxed/simple;
	bh=raiGIpcgI4Kh+puNk0SuwB+zXK2QtIm/CGcnqJTRiBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpiTP2dX77MKbVcBTgd1crqnwy5Kp1/IHbhU4u7n64zUcZdlmN5BlmQcAYN4NT/VktOzvZGZ9l1T4tzJXWl9OLqrLKwCLzUotDICcibMLmDozuaPDF++VN0j2zlUN95qF95KLmW8oxWDwWS6WHipEMjq9xcPxhQXI9eZpAzdpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12289 invoked by uid 109); 22 Jan 2024 23:00:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jan 2024 23:00:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10271 invoked by uid 111); 22 Jan 2024 23:00:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 18:00:52 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 18:00:51 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Bug?] "git diff --no-rename A B"
Message-ID: <20240122230051.GB814674@coredump.intra.peff.net>
References: <xmqq34uvtpob.fsf@gitster.g>
 <20240120011800.GF117170@coredump.intra.peff.net>
 <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <579fd5bc-3bfd-427f-b22d-dab5e7e56eb2@web.de>

On Sat, Jan 20, 2024 at 03:39:38PM +0100, René Scharfe wrote:

> > The issue is that we have "--rename-empty", which of course also
> > provides "--no-rename-empty". And parse-options is happy to let you
> > abbreviate names as long as they are unambiguous. But "--no-rename" _is_
> > ambiguous with "--no-renames". Why don't we catch it?
> 
> Because diff_opt_parse() passes PARSE_OPT_KEEP_UNKNOWN_OPT, which makes
> parse_long_opt() skip abbreviation detection.  Which it does since
> baa4adc66a (parse-options: disable option abbreviation with
> PARSE_OPT_KEEP_UNKNOWN, 2019-01-27).

OK, it makes sense to me that we should avoid abbreviation entirely with
KEEP_UNKNOWN_OPT, for the reasons given in that commit. But if adding
--rename fixed it, is there another bug lurking? That is, would we do
the wrong thing on a case without KEEP_UNKNOWN_OPT but which had
"--renames" and "--no-rename" defined? Or was it simply the
inconsistency in how KEEP_UNKNOWN_OPT is being applied?

I think it might just be the latter. If I do this:

diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index ded8116cc5..e908c7386d 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -124,6 +124,7 @@ int cmd__parse_options(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
 		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
+		OPT_BOOL(0, "do-it", &boolean, "'do' ambiguous with 'doubt'"),
 		{ OPTION_SET_INT, 'B', "no-fear", &boolean, NULL,
 		  "be brave", PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
 		OPT_COUNTUP('b', "boolean", &boolean, "increment by one"),

then running:

  t/helper/test-tool parse-options --do

correctly complains about the ambiguity (though amusingly it mentions
"--no-no-doubt" in the error message). And if I add KEEP_UNKNOWN_OPT,
then it gives the wrong behavior. But curiously it does so even with
your patch applied. So I think there may be further fixes needed.

-Peff
