Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BFA720986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbcI0W5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:57:38 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:40106 "EHLO
        homiemail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751762AbcI0W5h (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 18:57:37 -0400
Received: from homiemail-a20.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTP id 387A27EC064;
        Tue, 27 Sep 2016 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=OBytV
        gO5LRPqOqcX5c4FV3xiI/I=; b=TuQ4gR2n7l90ZlxCHxLrPV6UiGV/gXcIOYQtB
        vlLscb+YAyuwFtftWQngHVA4bmSOhtLaww0vUj0Ce01iwSxB36mHO03vqCOk+ReT
        9HAAenT8+cjeffdkR7ZhL0h4gdB1MIyQ6qXsl5dYPYRMuexHDIxPE7w0HH1PCki9
        g9k9G8=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTPSA id A9F017EC063;
        Tue, 27 Sep 2016 15:57:35 -0700 (PDT)
Message-ID: <1475017054.13103.3.camel@frank>
Subject: Re: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad
 trees like other errors
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 18:57:34 -0400
In-Reply-To: <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
         <1474918365-10937-3-git-send-email-novalis@novalis.org>
         <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
         <1474989574.26902.7.camel@frank>
         <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-09-27 at 15:19 -0400, Jeff King wrote:
> On Tue, Sep 27, 2016 at 11:19:34AM -0400, David Turner wrote:
> 
> > >   typedef void (*err_fn)(const char *, ...);
> > > 
> > >   static int decode_tree_entry(struct tree_desc *desc,
> > >                                const char *buf, unsigned long size,
> > > 			       err_fn err)
> > >   {
> > >          ...
> > >          if (size < 23 || buf[size - 21]) {
> > > 	        err("too-short tree object");
> > > 		return -1;
> > > 	 }
> > >   }
> > > 
> > > I dunno. Maybe that is overengineering. I guess we only hit the strbufs
> > > in the error path (which used to die!), so nobody really cares that much
> > > about the extra allocation.
> > 
> > I don't really like err_fn because:
> > (a) without a baton, it's somewhat less general (or less thread-safe)
> > than the strbuf approach and
> > (b) with a baton, it's two arguments instead of one.
> 
> I'm going to ramble for a minute, and I don't think it's worth exploring
> for this patch series in particular, so feel free to ignore me.
> 
> I think this error concept could be extended fairly elegantly with
> something like:
> 
>   typedef void (*err_fn)(void *, const char *fmt, va_list ap)
>   struct error_context {
>         err_fn fn;
>         void *data;
>   };
> 
>   int report_error(struct error_context *err, const char *fmt, ...)
>   {
>         if (err->fn) {
>                 va_list ap;
>                 va_start(ap, fmt);
>                 err->fn(err->data, fmt, ap);
>                 va_end(ap);
>         }
>         return -1;
>   }
> 
> Then low-level functions just take a context and do:
> 
>   return report_error(&err, "some error: %s", foo);
> 
> And then the callers would pick one of a few generic error contexts:
> 
>   - passing NULL silences the errors

Overall, +1.

I guess I would rather have a sentinel value for silencing errors,
because I'm worried that someone might read NULL as "don't handle the
errors, just die".  Of course, code review would hopefully catch this,
but even so, it would be easier to read foo(x, y, silence_errors) than
foo(x, y, null).



