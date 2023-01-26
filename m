Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F8BC54EAA
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjAZUdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjAZUdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 15:33:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C942717
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 12:33:30 -0800 (PST)
Received: (qmail 25637 invoked by uid 109); 26 Jan 2023 20:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 20:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26576 invoked by uid 111); 26 Jan 2023 20:33:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 15:33:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 15:33:28 -0500
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
Subject: Re: [PATCH v7 08/12] test-http-server: add simple authentication
Message-ID: <Y9LjmMWjBQgNTsQq@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:46PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> +static int split_auth_param(const char *str, char **scheme, char **val)
> +{
> +	struct strbuf **p = strbuf_split_str(str, ':', 2);
> +
> +	if (!p[0])
> +		return -1;
> +
> +	/* trim trailing ':' */
> +	if (p[0]->len && p[0]->buf[p[0]->len - 1] == ':')
> +		strbuf_setlen(p[0], p[0]->len - 1);
> +
> +	*scheme = strbuf_detach(p[0], NULL);
> +	*val = p[1] ? strbuf_detach(p[1], NULL) : NULL;
> +
> +	strbuf_list_free(p);
> +	return 0;
> +}

Oh, I forgot one more Coverity-detected problem here when reviewing last
night. The early "return -1" here leaks "p" (there are no strbufs in the
resulting array, but strbuf_split_str() will still have allocated the
array). It needs a call to strbuf_list_free(p) there.

-Peff
