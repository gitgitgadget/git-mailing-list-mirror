X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Mon, 13 Nov 2006 18:34:39 +0100
Message-ID: <81b0412b0611130934u67f4da98rd39412b07f2169c0@mail.gmail.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
	 <Pine.LNX.4.63.0611131333000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 17:35:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NA77P2MfkqhHLdM9OL1CVJgK4SDFTR9kxJQ2rpgJmfW5aTgsA1XZdZbEu7lt63G3aTbjUqwRUKrfjq40+vdK8TS4u1xEuw5LvaJnWtog0yJiNv5G9b62i3IzGKzvIfs1SjF7EwqT4NOQ0kEJXrslty0ZCnkjW+olXOXTpUpw6qw=
In-Reply-To: <Pine.LNX.4.63.0611131333000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31303>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjfho-00048y-EW for gcvg-git@gmane.org; Mon, 13 Nov
 2006 18:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755276AbWKMReo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbWKMReo
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 12:34:44 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:35302 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1755276AbWKMRen
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 12:34:43 -0500
Received: by wr-out-0506.google.com with SMTP id i30so65131wra for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 09:34:42 -0800 (PST)
Received: by 10.78.127.6 with SMTP id z6mr802242huc.1163439279723; Mon, 13
 Nov 2006 09:34:39 -0800 (PST)
Received: by 10.78.135.19 with HTTP; Mon, 13 Nov 2006 09:34:39 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

> This looks to me as if you have NO_MMAP=1 set in your Makefile (which I
> also do automatically when compiling on cygwin).

Kind of. I use mmap (from cygwin) in specially selected places.
I remember posting the patches once.

> The old problem: Windows does not have fork.

As if it have anything non-fubar at all...

> <digression> And before somebody starts cygwin bashing: don't. It is not
> cygwin's problem, it is Windows'.

I didn't bash cygwin. I just pity the whole effort (and myself, atm).

> And I think that a mmap() of 332MB would not fail.

It does not in isolated environment. It just fails in my particular context.
And before anyone suggests: yes, CreateFileMapping, and VirtualAlloc were
tried. They do return errors suggesting the same reason (ENOMEM).

> Long time ago (to be precise, July 18th), Linus suggested (in Message-Id:
> <Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>) to find out which mmap()
> calls are _not_ used before a fork(), and not emulate them by malloc().
>
> I never came around to do that, but maybe others do?

I'm trying to find some time to make Shawn's sliding window work.
It looks promising (patches, not the time).


On 11/13/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 7 Nov 2006, Alex Riesen wrote:
>
> > For me, it fails even on 332Mb pack:
> >
> > $ git reset --hard 61bb7fcb
> > fatal: packfile .git/objects/pack/pack-ad37...pack cannot be mapped.
> >
> > Instrumenting the code reveals that it fails on 348876870 bytes.
> > Strangely enough, a cygwin program which just reads that pack
> > many times without freeing the mem goes up to 1395507480 (1330Mb).
> >
> > If I replace the malloc (cygwin) with native VirtualAlloc(MEM_COMMIT)
> > it reports that "Not enough storage is available to process this command",
> > which is just ENOMEM, I think.
>
> This looks to me as if you have NO_MMAP=1 set in your Makefile (which I
> also do automatically when compiling on cygwin).
>
> The old problem: Windows does not have fork.
>
> <digression> And before somebody starts cygwin bashing: don't. It is not
> cygwin's problem, it is Windows'. The cygwin people worked long and hard
> on something truly useful, and it helps me _every_ time I have to work on
> a Windows platform (which _is_ utter crap). Some problems of Windows are
> so unhideable though, that even cygwin cannot work around them.
> </digression>
>
> Cygwin provides a mmap(), which works remarkably well even with the
> emulated fork(), but one thing is not possible: since mmap()ed files
> have to be _reopened_ after a fork(), and git uses the
> open-temp-file-then-delete-it-but-continue-to-use-it paradigm quite often,
> we work around it by setting NO_MMAP=1. Again, this is _not_ Cygwin's
> fault!
>
> And I think that a mmap() of 332MB would not fail.
>
> Long time ago (to be precise, July 18th), Linus suggested (in Message-Id:
> <Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>) to find out which mmap()
> calls are _not_ used before a fork(), and not emulate them by malloc().
>
> I never came around to do that, but maybe others do?
>
> Ciao,
> Dscho
>
