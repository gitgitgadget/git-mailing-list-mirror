Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F67ECA5534
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 10:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbjIMKQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbjIMKQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 06:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A09019A9
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 03:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694600157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BR7E6seLAbN07grR/lHqW2KJnvdYBY8u7BKvTAG54w=;
        b=AGgcZL6dvNu9tumg9vDhTULt8gG/V7fMUCOGTHyriYJN3VKREG5tBy7D1tsXKNyNrYiCT/
        FwuYxk93u4Lf633q2N4lkEFgp7c5dzlKE0VP+PkP1T/F0vT1D6jFypc4E7M78oBHKsMtBn
        IlHurcUgNjSLtQIlE5tPaA0ru6Aw8yE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-B5_c2ygIOeOqu4tAQDIIZQ-1; Wed, 13 Sep 2023 06:15:56 -0400
X-MC-Unique: B5_c2ygIOeOqu4tAQDIIZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F403981652C;
        Wed, 13 Sep 2023 10:15:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id D5CFE6468B;
        Wed, 13 Sep 2023 10:15:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Sep 2023 12:15:03 +0200 (CEST)
Date:   Wed, 13 Sep 2023 12:15:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230913101501.GC535@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com>
 <20230912130429.GA9982@redhat.com>
 <20230912135124.GA11315@redhat.com>
 <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df05f761-c498-6930-bfd8-265f7e23d8ee@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, René Scharfe wrote:
>
> >> So perhaps git-grep needs another change, something like
> >>
> >> 	if (match_funcname(opt, gs, bol, end_of_line(...)))
> >> 		return;
> >>
> >> at the start of show_funcname_line(), but my patch does not change this
> >> behaviour.
>
> Yes, to make it match the documentation it would need something like
> that.  (Though I'd add a match_funcname() call before the
> show_funcname_line() call in grep_source_1() instead, as it already has
> the eol value.)

Yes, I too thought about this. Except I thought that it makes sense to
pass the additional "unsigned eol" argument to show_funcname_line().
But in any case show_pre_context() will need to calculate eol.

However this is just a minor detail, I am fine either way.

> > So, just in case, please see V2 below. In my opinion it _fixes_ the
> > current behaviour. With this patch
> >
> > 	$ ./git grep --untracked -pn func2 TEST1.c
> > 	TEST1.c:4:void func2()
>
> Indeed that matches the letter of the documentation.
>
> > 	$ ./git grep --untracked -pn xxx TEST2.c
> > 	TEST2.c:1:void func(xxx)
> > 	TEST2.c=1=void func(xxx)
> > 	TEST2.c:3:      use(xxx);
>
> That one as well.

So. Can I assume you agree with my patch ? ;)

> No, I think the documentation is wrong.

Well, to me it looks good, but only after this patch.

Oleg.

