Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A71A20986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbcI0PTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:19:39 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:60721 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751263AbcI0PTh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 11:19:37 -0400
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id AD789314C065;
        Tue, 27 Sep 2016 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=uycHk
        qRJ8/wVwcV/Ir6W2Xq2MGA=; b=iocr2gKOZPMqIQk4HAkjL7J8fiRsqnxvHrrdK
        ni7S+LKi+RPMH6yPejr+pQDxlGE9VFTgvvKP71BK6q7pwnoWHab/AXe4VD6Ct+qF
        hEHWr7k6/Orp7nYSUp7aqyZfXOdRg8y7hK6QIiKuXsFmJoy96EWFKF2zIgvmOc/2
        6kOLCw=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 0BA7C314C064;
        Tue, 27 Sep 2016 08:19:35 -0700 (PDT)
Message-ID: <1474989574.26902.7.camel@frank>
Subject: Re: [PATCH 2/2] fsck: handle bad trees like other errors
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 11:19:34 -0400
In-Reply-To: <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
         <1474918365-10937-3-git-send-email-novalis@novalis.org>
         <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-09-27 at 01:27 -0400, Jeff King wrote:
> > -static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
> > +static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
> >  {
> 
> I know we used the "err" strbuf pattern in the ref code, and it makes
> sense there where we have a lot of different functions with public
> interfaces. But here, we literally just feed the result to die() or
> warning(). I wonder if a nicer interface would be:
> 
>   typedef void (*err_fn)(const char *, ...);
> 
>   static int decode_tree_entry(struct tree_desc *desc,
>                                const char *buf, unsigned long size,
> 			       err_fn err)
>   {
>          ...
>          if (size < 23 || buf[size - 21]) {
> 	        err("too-short tree object");
> 		return -1;
> 	 }
>   }
> 
> I dunno. Maybe that is overengineering. I guess we only hit the strbufs
> in the error path (which used to die!), so nobody really cares that much
> about the extra allocation.

I don't really like err_fn because:
(a) without a baton, it's somewhat less general (or less thread-safe)
than the strbuf approach and
(b) with a baton, it's two arguments instead of one.

Thanks for all of the rest of the commentary; I've incorporated it and
will re-roll shortly.


