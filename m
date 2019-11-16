Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3C61F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 01:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKPBBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 20:01:05 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36596 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbfKPBBF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 Nov 2019 20:01:05 -0500
X-IronPort-AV: E=Sophos;i="5.68,310,1569276000"; 
   d="scan'208";a="412064964"
Received: from ip65-46-187-134.z187-46-65.customer.algx.net (HELO hadrien) ([65.46.187.134])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 02:00:31 +0100
Date:   Fri, 15 Nov 2019 20:00:29 -0500 (EST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>, git@vger.kernel.org,
        =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
In-Reply-To: <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
Message-ID: <alpine.DEB.2.21.1911152000170.8961@hadrien>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de> <5189f847-1af1-f050-6c72-576a977f6f12@web.de> <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com> <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de> <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de> <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de> <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de> <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de> <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
 <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1173424402-1573866031=:8961"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1173424402-1573866031=:8961
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 15 Nov 2019, Markus Elfring wrote:

> > --- array-released.diff	2019-11-14 21:29:11.020576916 +0100
> > +++ array-reduced1.diff	2019-11-14 21:45:58.931956527 +0100
> > @@ -6,24 +6,10 @@
> >   	r->entry_count = t->entry_count;
> >   	r->delta_depth = t->delta_depth;
> >  -	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
> > -+	COPY_ARRAY(r->entries, t->entries, t->entry_count);
> > ++	memcpy(r->entries,t->entries,t->entry_count*sizeof(*(t->entries)));
> >   	release_tree_content(t);
> >   	return r;
> >   }
>
> It took a while to become more aware of software development challenges
> for the safe data processing with the semantic patch language also
> at such a source code place.
> https://github.com/git/git/blob/3edfcc65fdfc708c1c8f1d314885eecf9beb9b67/fast-import.c#L640
>
> I got the impression that the Coccinelle software is occasionally able
> to determine from the search specification “sizeof(T)” the corresponding
> data type for code like “*(t->entries)”.

It can determine the type of t->entries if it has access to the definition
of the type of t.  This type may be in a header file.  If you want
Coccinelle to be able to find this information you can use the option
--all-includes or --recursive-includes.  It will be more efficient with
the option --include-headers-for-types.

julia

> But it seems that there are circumstances to consider where the desired
> data type was not automatically determined.
> Thus the data processing  can become safer by explicitly expressing
> the case distinction for the handling of expressions.
>
> Adjusted transformation rule:
> @@
> type T;
> T* dst_ptr, src_ptr;
> T[] dst_arr, src_arr;
> expression n, x;
> @@
> -memcpy
> +COPY_ARRAY
>        (
> (       dst_ptr
> |       dst_arr
> )
>        ,
> (       src_ptr
> |       src_arr
> )
>        ,
> -       (n) * \( sizeof(T) \| sizeof(*(x)) \)
> +       n
>        )
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1173424402-1573866031=:8961--
