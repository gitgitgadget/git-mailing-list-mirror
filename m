Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E76CA0EC7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjILBk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjILBkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3498179D9C
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694481421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVwJzT5W1uy0y0zICV8y1CEzmyDUjCkOdOMjvfyDn2s=;
        b=X+GFuz2D/yGtFmAGt0qaDgPpLJ+H+0ncsSrTgw0c2jgNgPNwRgpH4P3HzeWRKUiVvocKiI
        mfgjb8tfGBQ7NK/RtUSC7JUbGcQdiTSyBne+H7PhH9Ofw3I87QqUqeGgXEgKhlx5zY59tu
        Zt9xsHz6ntRBje7pFaKpcrh5oqFnzrY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-fLg-ggtVO6q0pezSDN3UGA-1; Mon, 11 Sep 2023 17:55:13 -0400
X-MC-Unique: fLg-ggtVO6q0pezSDN3UGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5A1E3C10142;
        Mon, 11 Sep 2023 21:55:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.151])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1B8810F1BE7;
        Mon, 11 Sep 2023 21:55:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 11 Sep 2023 23:54:20 +0200 (CEST)
Date:   Mon, 11 Sep 2023 23:54:16 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathias Krause <minipli@grsecurity.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] git-grep: improve the --show-function behaviour
Message-ID: <20230911215416.GA15714@redhat.com>
References: <20230911121126.GA17383@redhat.com>
 <20230911121211.GA17401@redhat.com>
 <e214eb9c-7576-f8f5-ef1d-3828affd47d8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e214eb9c-7576-f8f5-ef1d-3828affd47d8@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Thanks for feedback. I am already sleeping but let me try to reply anyway,
even if I don't really understand you.

On 09/11, René Scharfe wrote:
>
> Am 11.09.23 um 14:12 schrieb Oleg Nesterov:
> > show_funcname_line() returns when "lno <= opt->last_shown" and this
> > is not right in that the ->last_shown line (which matched the pattern)
> > can also have the actual function name we need to report.
> >
> > Change this code to check "lno < opt->last_shown". While at it, move
> > this check up to avoid the unnecessary "find the previous bol" loop.
> >
> > Note that --lno can't underflow, lno==0 is not possible in this loop.
> >
> > Simple test-case:
> >
> > 	$ cat TEST.c
> > 	void func(void);
> >
> > 	void func1(xxx)
> > 	{
> > 		use1(xxx);
> > 	}
> >
> > 	void func2(xxx)
> > 	{
> > 		use2(xxx);
> > 	}
> >
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
> Interesting idea to treat function lines as annotations of matches
> instead of as special context.

Sorry, I don't understand... Let me repeat I am not familiar with this
code and terminology. Could you spell please?

> Showing lines twice feels wasteful, but
> at least for -p it might be justifiable from that angle.

Just in case... say, "func1" is reported twice only when it is really
needed. From the "after the patch" output above:

	TEST.c:3:void func1(xxx)

this is what we already have without this patch

	TEST.c=3=void func1(xxx)

this is what we have with this patch because the next

	TEST.c:5:       use1(xxx);

line needs the proper funcname line, and without this patch it would be
"void func()" which has nothing to do with use1(xxx),

If I do, say,

	./git grep --untracked -pn func1 TEST.c

then (with or without this patch) the output is

	TEST.c=1=void func(void);
	TEST.c:3:void func1(xxx)

in this case there is no reason to report "=void func1(xxx)".


> Wouldn't you
> have to repeat function line 3 before the match in line 8, though?

Why?

> The reason for not repeating a matched function line was that it
> doesn't add much information under the assumption that it's easy to
> identify function lines visually.

But it is not. Lets look again at the "before the patch:" output above,

 	TEST.c=1=void func(void);
 	TEST.c:3:void func1(xxx)
 	TEST.c:5:       use1(xxx);
 	TEST.c:8:void func2(xxx)
 	TEST.c:10:      use2(xxx);

it looks as if every "xxx" match is inside the (unrelated) func().

OK, "visually" you can also notice the "void funcX(xxx)" declarations
and understand whats going on.

But a) I don't think this is always easy, and b) it is certainly not
easy when you use "git-grep -p" in scripts. Please see 0/1.

> The patch would need to update Documentation/git-grep.txt as well to
> reflect the changed output.

Hmm... From Documentation/git-grep.txt:

	-p::
	--show-function::
		Show the preceding line that contains the function name of
		the match, unless the matching line is a function name itself.
		...

this is still true after this patch. How do you think I should update this
section?

Oleg.

