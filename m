Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA46208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 10:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbdHKKWO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 06:22:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752190AbdHKKWO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 06:22:14 -0400
Received: (qmail 2355 invoked by uid 109); 11 Aug 2017 10:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 10:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18886 invoked by uid 111); 11 Aug 2017 10:22:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Aug 2017 06:22:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Aug 2017 06:22:12 -0400
Date:   Fri, 11 Aug 2017 06:22:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: free buffers on error in fsck_obj()
Message-ID: <20170811102211.iqyfdro5zywtdj3n@sigill.intra.peff.net>
References: <c7f5b84b-b7b7-c9ed-601d-686b37ffe61c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7f5b84b-b7b7-c9ed-601d-686b37ffe61c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:42:10AM +0200, René Scharfe wrote:

> Move the code for releasing tree buffers and commit buffers in
> fsck_obj() to the end of the function and make sure it's executed no
> matter of an error is encountered or not.

This looks good to me.

> @@ -374,7 +369,12 @@ static int fsck_obj(struct object *obj)
>  		}
>  	}
>  
> -	return 0;
> +out:
> +	if (obj->type == OBJ_TREE)
> +		free_tree_buffer((struct tree *)obj);
> +	if (obj->type == OBJ_COMMIT)
> +		free_commit_buffer((struct commit *)obj);
> +	return err;
>  }

The second one could be "else if". But then, the same could be said of
the rest of the function (and fsck_object() that we call). It probably
doesn't really matter in practice.

-Peff
