Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272781F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfHVNXi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:23:38 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:41317 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731267AbfHVNXi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 09:23:38 -0400
Received: from tri.shiar.net ([IPv6:2001:982:11b7:1:dacb:8aff:fee3:29ec])
        by smtp-cloud7.xs4all.net with ESMTP
        id 0n3uicvVpThuu0n3vikag0; Thu, 22 Aug 2019 15:23:35 +0200
Received: by tri.shiar.net (Postfix, from userid 1000)
        id A7058297341; Thu, 22 Aug 2019 15:23:34 +0200 (CEST)
Date:   Thu, 22 Aug 2019 15:23:34 +0200
From:   Mischa POSLAWSKY <git@shiar.nl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH] ref-filter: initialize empty name or email fields
Message-ID: <20190822132334.GA28725@shiar.net>
References: <20190817215107.13733-1-git@shiar.nl>
 <xmqqimqtxcou.fsf@gitster-ct.c.googlers.com>
 <xmqq4l2bx06p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4l2bx06p.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt 1.10.1 + Vim 8.1 (Debian 10.0 GNU/Linux 4.9.0-6-amd64)
X-URL:  http://shiar.nl/
X-Accept-Language: nl, eo, en
X-CMAE-Envelope: MS4wfDEHtDuiY9S/TEqFYN1Q9gF8+FygZgZ/JQQM64AAZXwWK6LSXlwcaXxUmV4v5Igiji0kzxw1GH76yuLXBfjwnvaBmNd1S+lGaY72gkBnVAAsLC8McaM/
 UmfhNI3fNwnR3bcDAflxBN4kO/f4yo+GOHu7uf8OPpKgPJQTXzBWqv4nNTI1Lr9pBeciyQ1rUQL3d6/Oh6kc5A1/AyBtGXZPwzNHZiFdC7N/LjG/4IQpNZcW
 xVqpl/PWG+/nIY7NC8el6k/U+JvB5Zq6RlNiXjq9H3g+rqQaVMXl2oPtDiczO15Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Mischa POSLAWSKY <git@shiar.nl> writes:
> >
> >> Formatting $(taggername) on headerless tags such as v0.99 in Git
> >> causes a SIGABRT with error "munmap_chunk(): invalid pointer",
> >> because of an oversight in commit f0062d3b74 (ref-filter: free
> >> item->value and item->value->s, 2018-10-19).
> >>
> >> Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
> >> ---
> >> If I understand correctly, such tags cannot be produced normally anymore.
> >> Therefore I'm unsure how to make tests, and if that is even warranted.
> >
> > Thanks for spotting.
> >
> > I am not sure if the approach taken by this patch is the right one,
> > though.  I didn't follow the call/dataflow thoroughly, but if we
> > replace unfree-able "" with NULL in these places, wouldn't
> > fill_missing_values() take care of them?
> 
> I think replacing these "" with NULL would be safe, but there are
> many places that return xstrdup("") from inside the callees of
> populate_value(), so the patch presented here would be more
> consistent with the current practice, I think.

Indeed, I just copied the existing style.  Returning NULL seems to work,
but not something I'm confident to clean up here.

> So let's take the patch as is, at least for now.  Thanks.

Thank you!

> >>  ref-filter.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/ref-filter.c b/ref-filter.c
> >> index f27cfc8c3e..7338cfc671 100644
> >> --- a/ref-filter.c
> >> +++ b/ref-filter.c
> >> @@ -1028,7 +1028,7 @@ static const char *copy_name(const char *buf)
> >>  		if (!strncmp(cp, " <", 2))
> >>  			return xmemdupz(buf, cp - buf);
> >>  	}
> >> -	return "";
> >> +	return xstrdup("");
> >>  }
> >>  
> >>  static const char *copy_email(const char *buf)
> >> @@ -1036,10 +1036,10 @@ static const char *copy_email(const char *buf)
> >>  	const char *email = strchr(buf, '<');
> >>  	const char *eoemail;
> >>  	if (!email)
> >> -		return "";
> >> +		return xstrdup("");
> >>  	eoemail = strchr(email, '>');
> >>  	if (!eoemail)
> >> -		return "";
> >> +		return xstrdup("");
> >>  	return xmemdupz(email, eoemail + 1 - email);
> >>  }
