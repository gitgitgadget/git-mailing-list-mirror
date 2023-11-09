Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328D337157
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952023C03
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:35:09 -0800 (PST)
Received: (qmail 31353 invoked by uid 109); 9 Nov 2023 18:35:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 18:35:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8743 invoked by uid 111); 9 Nov 2023 18:35:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 13:35:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 13:35:06 -0500
From: Jeff King <peff@peff.net>
To: Simon Ser <contact@emersion.fr>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: fix ignored encode_email_headers for cover
 letter
Message-ID: <20231109183506.GB2711684@coredump.intra.peff.net>
References: <20231109111950.387219-1-contact@emersion.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231109111950.387219-1-contact@emersion.fr>

On Thu, Nov 09, 2023 at 11:19:56AM +0000, Simon Ser wrote:

> When writing the cover letter, the encode_email_headers option was
> ignored. That is, UTF-8 subject lines and email addresses were
> written out as-is, without any Q-encoding, even if
> --encode-email-headers was passed on the command line.
> 
> This is due to encode_email_headers not being copied over from
> struct rev_info to struct pretty_print_context. Fix that and add
> a test.

That makes sense, and your patch looks the right thing to do as an
immediate fix. But I have to wonder:

  1. Are there other bits that need to be copied? Grepping for other
     code that does the same thing, I see that show_log() and
     cmd_format_patch() copy a lot more. (For that matter, why doesn't
     make_cover_letter() just use the context set up by
     cmd_format_patch()?).

  2. Why are we copying this stuff at all? When we introduced the
     pretty-print context back in 6bf139440c (clean up calling
     conventions for pretty.c functions, 2011-05-26), the idea was just
     to keep all of the format options together. But later, 6d167fd7cc
     (pretty: use fmt_output_email_subject(), 2017-03-01) added a
     pointer to the rev_info directly. So could/should we just be using
     pp->rev->encode_email_headers here?

     Or if that field is not always set (or we want to override some
     elements), should there be a single helper function to initialize
     the pretty_print_context from a rev_info, that could be shared
     between spots like show_log() and make_cover_letter()?

I don't think that answering those questions needs to hold up your
patch. We can take it as a quick fix for a real bug, and then anybody
interested can dig further as a separate topic on top.

> diff --git a/builtin/log.c b/builtin/log.c
> index ba775d7b5cf8..87fd1c8560de 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1364,6 +1364,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
> +	pp.encode_email_headers = rev->encode_email_headers;
>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
>  	prepare_cover_text(&pp, description_file, branch_name, &sb,
>  			   encoding, need_8bit_cte);

This part looks obviously good.

> +test_expect_success 'cover letter with --cover-from-description subject (UTF-8 subject line)' '
> +	test_config branch.rebuild-1.description "Café?
> +
> +body" &&
> +	git checkout rebuild-1 &&
> +	git format-patch --stdout --cover-letter --cover-from-description subject --encode-email-headers main >actual &&
> +	grep "^Subject: \[PATCH 0/2\] =?UTF-8?q?Caf=C3=A9=3F?=$" actual &&
> +	! grep "Café" actual
> +'

The test looks correct to me.

Some of these long lines (and the in-string newlines!) make this ugly
and hard to read. But it is also just copying the already-ugly style of
nearby tests. So I'm OK with that. But a prettier version might be:

  test_expect_success 'cover letter respects --encode-email-headers' '
        test_config branch.rebuild-1.description "Café?" &&
        git checkout rebuild-1 &&
        git format-patch --stdout --encode-email-headers \
                --cover-letter --cover-from-description=subject \
                main >actual &&
        ...
  '

I also wondered if we could be just be testing this much more easily
with another header like "--to". But I guess that would be found in both
the cover letter and the actual patches (we also don't seem to encode
it even in the regular patches; is that a bug?).

-Peff
