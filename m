Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C870C2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 14:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbcF0OyG (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 10:54:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751860AbcF0OyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 10:54:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 647CA27096;
	Mon, 27 Jun 2016 10:54:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EyF7ZSCy97RY
	8/KQJz3bPagAUhg=; b=TqnebdUePXLlGPhQ586tEek8fnnAE/xQSb+sUWIRniVh
	n4qPtaICMkz8PdAYCEjI7QYOjY5MM532JgRf8Jwn86pLjrnKklxS4Isr+gKzz3s0
	XN0NjwoDeRlaYlKhyMTBm18R1sRAUYML+yVIpkzAsqNVw17o6JP3pNqZ/36AZ/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HctWN1
	1LQyoyNjm7DdCy7vuPdthJ6MriHGsp/y0iDP6m34qHsehZmktdZ8Lya9QmozO6Pg
	sIveW3kkSN/1ffA9AhC4qSYOus5bkz76zM3KhOONuEy7tygWB1iKw4E+FEcwfAxI
	Nm3xI3hhe+8D85gQszpzj0hcV9X4V/MHjBB38=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CC6927095;
	Mon, 27 Jun 2016 10:54:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4D8D27092;
	Mon, 27 Jun 2016 10:54:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 07:53:59 -0700
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Sat, 25 Jun 2016 07:22:26 +0200")
Message-ID: <xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCE6E41A-3C76-11E6-8FC2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v2 fixes Junio's and Jeff's comments (both good). The sharing "!icase
> || ascii_only" is made a separate commit (6/12) because I think it
> takes some seconds to realize that the conversion is correct and it's
> technically not needed in 5/12 (and it's sort of the opposite of 1/12)
>
> Interdiff

OK.  regcomp_or_die() does make the code simpler.

> diff --git a/grep.c b/grep.c
> index cb058a5..92587a8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -432,15 +432,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
>  	ascii_only     = !has_non_ascii(p->pattern);
>  
> +	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
>  		p->fixed = !icase || ascii_only;
>  	else
>  		p->fixed = 0;
>  
> @@ -449,6 +442,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
>  		kwsincr(p->kws, p->pattern, p->patternlen);
>  		kwsprep(p->kws);
>  		return;
> +	} else if (opt->fixed) {
> +		compile_fixed_regexp(p, opt);
> +		return;
>  	}

This if/elseif/else cascade made a lot simpler and while the
discussion is fresh in my brain it makes sense, but it may deserve a
bit of commenting.

And while attempting to do so, I found one possible issue there.

Can't p->ignore_case be true even when opt->regflags does not have
REG_ICASE?  The user never asked us to do a regexp match in such a
case, and the logical place to compensate for that case would be
inside compile_fixed_regexp(), where we use regexp engine behind
user's back for our convenience, I would think.

In the current code, compile_fixed_regexp() is only called when we
want ICASE, but hardcoding that assumption to it unnecessarily robs
flexibility (and the function name does not tell us it is only for
icase in the first place), so I taught it to do the REG_ICASE thing
only when opt->ignore_case is set.

How does this look?


 grep.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 92587a8..3a3a9f4 100644
--- a/grep.c
+++ b/grep.c
@@ -407,17 +407,21 @@ static int is_fixed(const char *s, size_t len)
 static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int err;
+	int regflags;
 
 	basic_regex_quote_buf(&sb, p->pattern);
-	err = regcomp(&p->regexp, sb.buf, opt->regflags & ~REG_EXTENDED);
+	regflags = opt->regflags & ~REG_EXTENDED;
+	if (opt->ignore_case)
+		regflags |= REG_ICASE;
+	err = regcomp(&p->regexp, sb.buf, regflags);
 	if (opt->debug)
 		fprintf(stderr, "fixed %s\n", sb.buf);
 	strbuf_release(&sb);
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
 		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
 }
@@ -425,38 +429,55 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int icase, ascii_only;
 	int err;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
+	/*
+	 * Even when -F (fixed) asks us to do a non-regexp search, we
+	 * may not be able to correctly case-fold when -i
+	 * (ignore-case) is asked (in which case, we'll synthesize a
+	 * regexp to match the pattern that matches regexp special
+	 * characters literally, while ignoring case differences).  On
+	 * the other hand, even without -F, if the pattern does not
+	 * have any regexp special characters and there is no need for
+	 * case-folding search, we can internally turn it into a
+	 * simple string match using kws.  p->fixed tells us if we
+	 * want to use kws.
+	 */
 	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
 	else
 		p->fixed = 0;
 
 	if (p->fixed) {
 		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
 	} else if (opt->fixed) {
+		/*
+		 * We only come here when the pattern has the regexp
+		 * special characters in it, which need to be matched
+		 * literally, while ignoring case.
+		 */
 		compile_fixed_regexp(p, opt);
 		return;
 	}
 
 	if (opt->pcre) {
 		compile_pcre_regexp(p, opt);
 		return;
 	}
 
 	err = regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &p->regexp, errbuf, 1024);
 		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
 }
