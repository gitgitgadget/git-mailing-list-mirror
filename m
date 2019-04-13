Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C4420248
	for <e@80x24.org>; Sat, 13 Apr 2019 01:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDMBY1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 21:24:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:57056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726902AbfDMBY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 21:24:27 -0400
Received: (qmail 21361 invoked by uid 109); 13 Apr 2019 01:24:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 01:24:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11481 invoked by uid 111); 13 Apr 2019 01:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Apr 2019 21:24:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2019 21:24:24 -0400
Date:   Fri, 12 Apr 2019 21:24:24 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH] *.h: remove extern from function declarations
Message-ID: <20190413012424.GA2040@sigill.intra.peff.net>
References: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 04:48:21PM -0700, Denton Liu wrote:

> Junio mentioned that there was a push to drop extern from function
> declarations in headers[1]. I decided to do a mass refactoring so we
> could get rid of everything at once, although I'm not sure if that's
> welcome. But I'll send the patch anyway since I already wrote it.

The bothersome thing with a mass change is that it probably conflicts
with topics in flight.  Like for example, my patch that removes all of
the externs in packfile.h. :)

Merging with pu is a good way to gauge the damage (though it's not the
whole story, as there are other long-running forks like
git-for-windows).

> I merged my change with "pu" and these are the files that it conflicts
> with:

So it sounds like you did that and the result is not _too_ bad. But I'm
not sure about doing it automatically with sed. For example...

> diff --git a/packfile.h b/packfile.h
> index d70c6d9afb..dab50405e0 100644
> --- a/packfile.h
> +++ b/packfile.h
> [...]
> @@ -43,10 +43,10 @@ void for_each_file_in_pack_dir(const char *objdir,
>  #define PACKDIR_FILE_PACK 1
>  #define PACKDIR_FILE_IDX 2
>  #define PACKDIR_FILE_GARBAGE 4
> -extern void (*report_garbage)(unsigned seen_bits, const char *path);
> +void (*report_garbage)(unsigned seen_bits, const char *path);

This one is a function pointer, and so the extern is actually changing
the visibility of the declared variable. It needs to stay.

(I didn't read the whole patch carefully, but I knew to look for this
one in particular since I had to deal with it in my patch, too).

-Peff
