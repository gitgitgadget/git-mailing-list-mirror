Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E5E320286
	for <e@80x24.org>; Wed, 13 Sep 2017 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdIMPWL (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 11:22:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:36890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752527AbdIMPWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 11:22:07 -0400
Received: (qmail 15518 invoked by uid 109); 13 Sep 2017 15:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 15:22:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15129 invoked by uid 111); 13 Sep 2017 15:22:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 11:22:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 11:22:05 -0400
Date:   Wed, 13 Sep 2017 11:22:05 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
Message-ID: <20170913152205.sw3i5xzsynx62nea@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
 <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
 <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net>
 <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
 <20170913145154.423zqe6antzccclk@sigill.intra.peff.net>
 <CANgJU+XvJA2LYgFgmJZw7BR4-7qobvOh5zOSAVzGFOTsJ=Z8ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+XvJA2LYgFgmJZw7BR4-7qobvOh5zOSAVzGFOTsJ=Z8ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 05:18:56PM +0200, demerphq wrote:

> > Hmph. That is very disturbing. But with that information I should be
> > able to track down the culprit. Thanks for digging.
> 
> FWIW, I see that git_config_set_multivar_in_file_gently() uses
> write_in_full() which in turn uses xwrite(), but the latter has the
> following comment on it:
> 
> /*
>  * xwrite() is the same a write(), but it automatically restarts write()
>  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
>  * GUARANTEE that "len" bytes is written even if the operation is successful.
>  */
> 
> I suspect that at this point I am not adding much value here, so I
> will leave it at this.

No, the problem is in this line:

                                 if (write_in_full(fd, contents + copy_begin,
                                                   copy_end - copy_begin) <
                                     copy_end - copy_begin)
                                          goto write_err_out;

write_in_full() returns -1 on error (_not_ how many bytes were actually
written). So its return is a signed ssize_t. But the result of the
pointer subtraction "copy_end - copy_begin" is an unsigned ptrdiff_t.
The compiler promotes the signed to an unsigned, so the condition can
never be true (the "-1" becomes the highest possible value).

I have the fix, but I'm searching the code base for other instances of
the same error.

-Peff
