Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877387F7
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705713484; cv=none; b=KjGMui9qrhJyy+ZBG+z8oUu/I+qUl1+b2llR2yUQ9Pu2Th+qI4GXhKFSSz4U7T8J7Ul9l888XSAwaNFknl4Se7rCPYauvR8k/Ip8PZ06bgqld4S3pTsgU9Gmk6KWHBr4oMx+Vhz82aGJjv6gO+r+NtYTu0zAVxasaBCxBb/qiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705713484; c=relaxed/simple;
	bh=GTorcxBt3RCFhxi3ZusGMQn7+e1890FkKJfRJxmql6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5xbpcAujEwWVN0rJddylmbKah1/jPVm7zz6ClAQbjDFA17MDOGeBQeDlXvRTjOpHBfINb9UjZGexo/z/Ey6fFA1vXUiDw4Fl3o31BkiZdfjcjlbFftjTZY6UYGOg/PG+Q/bIHlAmi0RKulWFw+mGWhXnaBfwyFCJ67Yj+8WL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 622 invoked by uid 109); 20 Jan 2024 01:18:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Jan 2024 01:18:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6936 invoked by uid 111); 20 Jan 2024 01:18:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jan 2024 20:18:02 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Jan 2024 20:18:00 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug?] "git diff --no-rename A B"
Message-ID: <20240120011800.GF117170@coredump.intra.peff.net>
References: <xmqq34uvtpob.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34uvtpob.fsf@gitster.g>

On Wed, Jan 17, 2024 at 05:07:16PM -0800, Junio C Hamano wrote:

> When the user misspells "--no-renames" as "--no-rename", it seems
> that the rename detection (which is ont by default these days) still
> kicks in, which means the misspelt option is silently ignored.
> Should we show an error message instead?

I wondered if "--no-foo" complained, and it does. I think this is a
subtle corner case in parse-options.

The issue is that we have "--rename-empty", which of course also
provides "--no-rename-empty". And parse-options is happy to let you
abbreviate names as long as they are unambiguous. But "--no-rename" _is_
ambiguous with "--no-renames". Why don't we catch it?

I'd guess it is because we do not have "--renames" as an option, but
explicitly generate an entry for "--no-renames" (since the non-negative
version is actually "--find-renames"). I know there is some special code
to handle these pre-negated cases, but I would not be surprised if the
ambiguity checker does not.

So I think it's likely just a bug in parse-options which should be
fixed.

We could also work around it by providing --renames. ;) E.g., if we let
the find-renames callback handle negation, then --renames becomes a
synonym, like so:

diff --git a/diff.c b/diff.c
index a89a6a6128..cdec9bfbd9 100644
--- a/diff.c
+++ b/diff.c
@@ -5292,7 +5292,11 @@ static int diff_opt_find_renames(const struct option *opt,
 {
 	struct diff_options *options = opt->value;
 
-	BUG_ON_OPT_NEG(unset);
+	if (unset) {
+		options->detect_rename = 0;
+		return 0;
+	}
+
 	if (!arg)
 		arg = "";
 	options->rename_score = parse_rename_score(&arg);
@@ -5686,7 +5690,7 @@ struct option *add_diff_options(const struct option *opts,
 			       diff_opt_break_rewrites),
 		OPT_CALLBACK_F('M', "find-renames", options, N_("<n>"),
 			       N_("detect renames"),
-			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       PARSE_OPT_OPTARG,
 			       diff_opt_find_renames),
 		OPT_SET_INT_F('D', "irreversible-delete", &options->irreversible_delete,
 			      N_("omit the preimage for deletes"),
@@ -5697,9 +5701,10 @@ struct option *add_diff_options(const struct option *opts,
 			       diff_opt_find_copies),
 		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
 			 N_("use unmodified files as source to find copies")),
-		OPT_SET_INT_F(0, "no-renames", &options->detect_rename,
-			      N_("disable rename detection"),
-			      0, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "renames", options, N_("<n>"),
+			       N_("synonym for --find-renames"),
+			       PARSE_OPT_OPTARG,
+			       diff_opt_find_renames),
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
 		OPT_CALLBACK_F(0, "follow", options, NULL,

And you get the expected output:

  $ git show f920b0289b --oneline --raw --no-rename
  error: ambiguous option: no-rename (could be --no-renames or --no-rename-empty)

And as a bonus, now "--renames" works. :) It might pollute the output of
"-h" more, but I am not sure if we ever actually show these diff options
via "-h" (they are parsed quite indirectly, and "-h" is handled by the
main command's parse-options list).

Still, it seems like it's worth fixing the parse-options bug.

-Peff
