Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE681F453
	for <e@80x24.org>; Thu, 27 Sep 2018 14:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI0VHq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:07:46 -0400
Received: from ao2.it ([92.243.12.208]:34413 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbeI0VHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=EcgWxffSVLubqZfeuWg3NrpI20QbuSj4SFZWuxpBSbE=;
        b=nlvJtXpxmq+Tyzbb70aeS0+Io8MCS0xPC1ncDN0RA0Le0oKsKMYuVSYc+hwNxxsznM5dbjq1S8dcYZ1jWo3UqihgoP+glzFLX51KCR3v1z2dGEJs1Pjaixy/OF7tWJAWtFY8cf7xXkj0qh0U0pNyms7Ixah7OIcqbhJxOMI5xU8xZ9U8++PomPmzQ9CVrNvsq/W2xSQOdzttdHK0T7RrE17bllshuDAqNPbMx0OvsntANiWsk1roih9oWB8gYFeE00pIaRthAyOtMF+WPvyTee+y0gUi+v2SffRI/qtHFLI5nUdw7Tz6EG6WeOQX8krUnAxmxhnhmBaqTfME4wK63Q==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g5XYw-0006S1-0Z; Thu, 27 Sep 2018 16:46:42 +0200
Date:   Thu, 27 Sep 2018 16:49:06 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
Message-Id: <20180927164906.d3bd6ae0aeb4210d4fcf92ea@ao2.it>
In-Reply-To: <xmqq5zyyyg9q.fsf@gitster-ct.c.googlers.com>
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it>
        <20180918171257.GC27036@localhost>
        <20180920173552.6109014827a062dcf3821632@ao2.it>
        <xmqq5zyyyg9q.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 21 Sep 2018 09:19:45 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> > Protecting the problematic submodules function could work for now, but
> > I'd like to have more comments, my proposal is:
> >
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 601f801158..52b45de749 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -427,6 +427,11 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
> >         if (repo_submodule_init(&submodule, superproject, path))
> >                 return 0;
> >
> > +       grep_read_lock();
> > +       /*
> > +        * NEEDSWORK: repo_read_gitmodules accesses the object store which is
> > +        * global, thus it needs to be protected.
> > +        */
> >         repo_read_gitmodules(&submodule);
> >
> >         /*
> > @@ -439,7 +444,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
> >          * store is no longer global and instead is a member of the repository
> >          * object.
> >          */
> > -       grep_read_lock();
> >         add_to_alternates_memory(submodule.objects->objectdir);
> >         grep_read_unlock();
> 
> I think this is in line with how the grep codepath protects itself
> when doing anything that accesses the object store.
> 

Thanks for the comment.

However, after confirming with Stefan Beller, I think we are going to
solve the corruption issue by removing this call to
repo_read_gitmodules(), which is not strictly necessary:

https://public-inbox.org/git/CAGZ79kZaomuE3p1puznM1x+hu-w4O+ZqeGUODBDj=-R3Z1hDzg@mail.gmail.com/

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
