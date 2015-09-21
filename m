From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 56/67] avoid sprintf and strcpy with flex arrays
Date: Mon, 21 Sep 2015 13:11:09 -0400
Message-ID: <CAPig+cQwGHNPUG2MB2v5XXTQ+RP5L5J_EU4=nawzLjCN89s1ZQ@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160956.GD29753@sigill.intra.peff.net>
	<CAPig+cSL3W58TSYEAFz3twvxt_brB=kY=LEwX6m5RhBsg6VV6g@mail.gmail.com>
	<20150921151521.GA25286@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:11:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4cX-0006tg-1r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbbIURLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:11:12 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34044 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbbIURLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 13:11:10 -0400
Received: by vkhf67 with SMTP id f67so69226956vkh.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ff3mw6uwUTRlyvvuBk0Cmi95wcDxyEDBxWU0L8gicAc=;
        b=ViBGrF5HWy3zfNFqGgKUQ+/mJskBV9HnIj7y2uuz7kj32Hx+peWX4+Hi+DQ9/vRTyJ
         u907gNyhZ68keUnB7ukdVRhe4Y6avkt+6dOo35lGPphvBecazNxVhqTmVCF95mNucFct
         aGthE1YA6sA4u/klDSqkrOf3cSr1qFjNLijtFWCExuGMb4qMy8TsP8l3e06L84oTyW/w
         AYkXlTD4WszIWs8xh1yXGoARyKY5Gi1Sk0fB6rmLggNJ1Pcrl0UBtWzlDEVRteOBJ3Mo
         cKO93w8XzT/nqhvVodY7hyuMdhaH1RLS8szKQTXgOdY7G3Yqx3/2QYO//lU3QZqMu6iM
         C97A==
X-Received: by 10.31.56.193 with SMTP id f184mr13874354vka.115.1442855469731;
 Mon, 21 Sep 2015 10:11:09 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 10:11:09 -0700 (PDT)
In-Reply-To: <20150921151521.GA25286@sigill.intra.peff.net>
X-Google-Sender-Auth: WyMIGcsLYWKzPkn7xC7axBZ0cnQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278313>

On Mon, Sep 21, 2015 at 11:15 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 20, 2015 at 06:48:32PM -0400, Eric Sunshine wrote:
>> > diff --git a/archive.c b/archive.c
>> > index 01b0899..4ac86c8 100644
>> > --- a/archive.c
>> > +++ b/archive.c
>> > @@ -171,13 +171,14 @@ static void queue_directory(const unsigned char *sha1,
>> >                 unsigned mode, int stage, struct archiver_context *c)
>> >  {
>> >         struct directory *d;
>> > -       d = xmallocz(sizeof(*d) + base->len + 1 + strlen(filename));
>> > +       size_t len = base->len + 1 + strlen(filename) + 1;
>> > +       d = xmalloc(sizeof(*d) + len);
>>
>> Mental note: The new code makes this one longer than the original code...
>>
>> >         d->up      = c->bottom;
>> >         d->baselen = base->len;
>> >         d->mode    = mode;
>> >         d->stage   = stage;
>> >         c->bottom  = d;
>> > -       d->len = sprintf(d->path, "%.*s%s/", (int)base->len, base->buf, filename);
>> > +       d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
>>
>> Considering that we need space for the '/' and the NUL, the new code
>> seems to be correct, and the old code was under-allocating, right?
>
> Not quite. The original uses xmallocz, which handles the NUL itself. But
> the purpose of this patch is to pull the total length into a variable
> that we can use both for the malloc and for the xsnprintf, so we have
> to account for it ourselves.

Makes sense. I missed the "z" when reading the old code. Thanks for
the explanation.

>> > -       p = xcalloc(1, sizeof(*p) + strlen(tmp_file) + 2);
>> > -       strcpy(p->pack_name, tmp_file);
>> > +       namelen = strlen(tmp_file) + 2;
>>
>> You mentioned this specially in the commit message, but from a brief
>> read of the code, it's still not obvious (to me) why this is +2 rather
>> than +1. Since you're touching the code anyhow, perhaps add an in-code
>> comment explaining it?
>
> To be honest, I'm not sure what's going on with the "+ 2" here.
>
> In many cases with packed_git we allocate with "foo.idx" and want to be
> able to later write "foo.pack" into the same buffer. But here we are
> putting in a tmpfile name. This comes from 8455e48, but I don't see any
> clue there. I wonder if the "+2" was simply cargo-culted from other
> instances.

Ah, ok. I guess I misunderstood the commit message to mean or imply
that the +2 was correct and sensible and well-understood.

> I'm loath to change it in the middle of this patch, because it would be
> hard to see amidst the other changes. I'd rather make this a straight
> conversion, and worry about it in a separate patch.
