Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE8CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 02:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjILCUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjILCTu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 22:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72DF013C117
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694482929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/Zg5bG8AHyptuQHjW0u6uz0VOkfQ4YAryyJTQwRvsU=;
        b=RPnmroUTOsVfxUiSia6uKvps0tHuTaaG6ypXab73zrZUw31NnypDmjhLl5ejbZeQS9tyWg
        0qkxzMcY8HLX6T7QhhXquuB4SbzJwVnY7qmhsQvcpSgeb6OaIVAFXEk8gNDAfToyA4RkSS
        1iidCmtph7ojtkrNZ1hODrL8j9skh4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-RbFngtPMNzejhh7If5tJVg-1; Mon, 11 Sep 2023 19:18:53 -0400
X-MC-Unique: RbFngtPMNzejhh7If5tJVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F2C53C0D858;
        Mon, 11 Sep 2023 23:18:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id 123244405A;
        Mon, 11 Sep 2023 23:18:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Sep 2023 01:18:00 +0200 (CEST)
Date:   Tue, 12 Sep 2023 01:17:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230911231756.GA2840@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq34zktk4h.fsf@gitster.g>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Junio C Hamano wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > 	$ git grep --untracked -pn xxx TEST.c
> >
> > before the patch:
> >
> > 	TEST.c=1=void func(void);
> > 	TEST.c:3:void func1(xxx)
> > 	TEST.c:5:       use1(xxx);
> > 	TEST.c:8:void func2(xxx)
> > 	TEST.c:10:      use2(xxx);
> >
> > after the patch:
> >
> > 	TEST.c=1=void func(void);
> > 	TEST.c:3:void func1(xxx)
> > 	TEST.c=3=void func1(xxx)
> > 	TEST.c:5:       use1(xxx);
> > 	TEST.c:8:void func2(xxx)
> > 	TEST.c=8=void func2(xxx)
> > 	TEST.c:10:      use2(xxx);
> >
> > which looks much better to me.
>
> The "better" is often subjective.

Sure. that is why I added "to me".

> The former is showing what is
> going on in the TEST.c code very clearly without wasting valuable
> vertical screen real estate, at least to me.

very clearly? As you probably understand this is subjective as well.
But yes, you too added "at least to me" ;)

However, certainly this is not true when you use git-grep in scripts,
please see 0/1.

> If we want to adopt
> the proposed behaviour, which I would recommend against, the same
> patch should update the documentation, which currently says
>
>     Show the preceding line that contains the function name of the
>     match, unless the matching line is a function name itself.

And I still don't think this patch changes the documented behaviour.
See my reply to Rene.

Again, if you do

	./git grep -pn --untracked func1 TEST.c

with this patch applied, the output is still

	TEST.c=1=void func(void);
	TEST.c:3:void func1(xxx)

which iiuc matches the documentation above.

Now,

	./git grep -pn --untracked xxx TEST.c

adds the additional

	TEST.c=3=void func1(xxx)
	...
	TEST.c=8=void func2(xxx)

but how does this contradict with the documentation above?

the matching lines are use1(xxx) and use2(xxx), there are NOT
"the matching line is a function name itself".

> As René said, I think -p/--show-function is a rather less used
> option in modern Git where "--function-context", which back in
> 2944e4e6 did not exist, tend to be a much more useful option,

Well, not to me. And you know, I am a git user too ;)

> but it still is a backward
> incompatible behaviour change that needs to be handled with care.

And this is what I still don't understand.

> Thanks.

Thanks,

Oleg.

