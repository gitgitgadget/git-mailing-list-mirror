Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A38CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 13:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjILNIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjILNIG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 09:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 996B710DC
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694523935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qp4BLtu/MGBtUsbt2EqPJKxBe17gnwX6gsLZW05FqeE=;
        b=Wdl6uOG0JXNjptX9VFPwK16ySePX/Qqvc3JF/0ISwHxTOmJYi6LLUYI47rr3fGUx4NJqxG
        t8XNzXmuhF03/izroJmaqeC1TM7skU4KJav10B+oFVw3Nu6IGZ+dLY8z2Slj7srNKlciWd
        t1sbjPcEUnbftOV8ZD3XORIN7PCP/bs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-7XoxBDiwO92bE5oh9YK4NA-1; Tue, 12 Sep 2023 09:05:29 -0400
X-MC-Unique: 7XoxBDiwO92bE5oh9YK4NA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A7BF3814E83;
        Tue, 12 Sep 2023 13:05:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.195])
        by smtp.corp.redhat.com (Postfix) with SMTP id E476A40C2064;
        Tue, 12 Sep 2023 13:05:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 12 Sep 2023 15:04:36 +0200 (CEST)
Date:   Tue, 12 Sep 2023 15:04:29 +0200
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
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230912130429.GA9982@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <xmqq34zktk4h.fsf@gitster.g>
 <20230911231756.GA2840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911231756.GA2840@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René, Junio,

I don't like the fact we can't understand each other ;) Could you
please explain why do you think this patch should update the docs?

Please forget about my patch for the moment. Lets start from the very
beginning:

	-p::
	--show-function::
		Show the preceding line that contains the function name of
		the match, unless the matching line is a function name itself.

and in my opinion, it is the current behaviour that doesn't match the
documentation.

-------------------------------------------------------------------------

	$ cat TEST1.c
	void func1()
	{
	}
	void func2()
	{
	}

	$ git grep --untracked -pn func2 TEST1.c
	TEST1.c=1=void func1()
	TEST1.c:4:void func2()

in this case the matching line is "void func2()" and it is also a function
name itself, in this case git-grep should not show "=void func1()" which is
"the preceding line that contains the function name of the match.

But it does. So perhaps git-grep needs another change, something like

	if (match_funcname(opt, gs, bol, end_of_line(...)))
		return;

at the start of show_funcname_line(), but my patch does not change this
behaviour.

--------------------------------------------------------------------------

	$ cat TEST2.c
	void func(xxx)
	{
		use(xxx);
	}

	$ git grep --untracked -pn xxx TEST2.c
	TEST2.c:1:void func(xxx)
	TEST2.c:3:      use(xxx)

the 2nd match is use(xxx) and it is not a function name itself, in this
case git-grep should "Show the preceding line that contains the function
name of the match.

But it doesn't. To me, this behaviour looks as

		Show the preceding line that contains the function name of
		the match, unless the _PREVIOUS_ matching line is a function
		name itself.

Now, with my patch we have

	$ ./git grep --untracked -pn xxx TEST2.c
	TEST2.c:1:void func(xxx)
	TEST2.c=1=void func(xxx)
	TEST2.c:3:      use(xxx);

and unless I am totatlly confused this does match the documentation.

Oleg.

