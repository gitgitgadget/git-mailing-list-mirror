Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68A2C54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 09:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjAZJaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbjAZJaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 04:30:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6185F9EFB
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:30:07 -0800 (PST)
Received: (qmail 19040 invoked by uid 109); 26 Jan 2023 09:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 09:30:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21638 invoked by uid 111); 26 Jan 2023 09:30:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 04:30:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 04:30:05 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 06/12] test-http-server: add HTTP request parsing
Message-ID: <Y9JIHV7et/8bMvZY@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <43f1cdcbb82022521558dc649213eb4538364870.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43f1cdcbb82022521558dc649213eb4538364870.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:44PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> +#define REQ__INIT { \
> +     .start_line = STRBUF_INIT, \
> +     .uri_path = STRBUF_INIT, \
> +     .query_args = STRBUF_INIT, \
> +     .header_list = STRING_LIST_INIT_NODUP, \
> +     .content_type = NULL, \
> +     .content_length = 0, \
> +     .has_content_length = 0, \
> +}

We declare header_list as nodup, but later we put actual duplicated
strings in it:

> +             hp = strbuf_detach(&h, NULL);
> +             string_list_append(&req->header_list, hp);

So later when we free it:

> +static void req__release(struct req *req)
> +{
> +     strbuf_release(&req->start_line);
> +
> +     strbuf_release(&req->uri_path);
> +     strbuf_release(&req->query_args);
> +
> +     string_list_clear(&req->header_list, 0);
> +}

the strings will be leaked. There are a lot of solutions here, including
setting strdup_strings right before freeing. But it's probably
reasonable to just use INIT_DUP, and then when storing, just do:

  string_list_append(&req->header_list, h.buf);

Since "h" is filled by strbuf_getwholeline(), there's no need to erase
the contents. It should reset the buffer itself (and so you end up
re-using the same buffer, rather than freeing it for each loop).  You
will have to remember to strbuf_release() after the loop, though.

The leak isn't very big, and we hold onto it until the process ends
anyway, but it will probably cause the leak-detector to complain.

(Yet another solution would just be to dump the trace as we parse the
headers, rather than holding them, since that appears to be the only use
of header_list).

> +	/*
> +	 * Read the set of HTTP headers into a string-list.
> +	 */
> +	while (1) {
> +		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
> +			goto done;
> +		strbuf_trim_trailing_newline(&h);
> +
> +		if (!h.len)
> +			goto done; /* a blank line ends the header */
> +
> +		hp = strbuf_detach(&h, NULL);
> +		string_list_append(&req->header_list, hp);
> +
> +		/* also store common request headers as struct req members */
> +		if (skip_iprefix(hp, "Content-Type: ", &hv)) {
> +			req->content_type = hv;

I think this is stricter than necessary. The whitespace after the colon
is optional, but can also be longer than just one space (or could be a
tab). It's probably OK to be picky here since this is just for tests,
but we'd want to make sure we're not this picky on the client side.

> +		} else if (skip_iprefix(hp, "Content-Length: ", &hv)) {
> +			/*
> +			 * Content-Length is always non-negative, but has no
> +			 * upper bound according to RFC 7230 (§3.3.2).
> +			 */
> +			intmax_t len = 0;
> +			if (sscanf(hv, "%"PRIdMAX, &len) != 1 || len < 0 ||
> +			    len == INTMAX_MAX) {
> +				logerror("invalid content-length: '%s'", hv);
> +				result = WR_CLIENT_ERROR;
> +				goto done;
> +			}

We usually avoid sscanf because it's error-checking sucks. For example,
this will accept "123.garbage", but you can't tell because you have no
clue how far it got.  Something like strtoimax() is better. It probably
doesn't matter much since this is test code, though I do think in the
long run it would be nice to add scanf(), etc, to our list of banned
functions (there are one or two other uses currently, though, so that
isn't imminent).

-Peff
