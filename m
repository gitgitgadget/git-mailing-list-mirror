From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 19:08:27 +0200
Message-ID: <CALKQrgfJht_rCJ98vBZ3Xo-Q4WLfXxo_rRc10sgWEXK7HNQXBg@mail.gmail.com>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
	<7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
	<20130520165942.GB27788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 20 19:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeTZd-0003e5-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab3ETRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:08:33 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:49190 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab3ETRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:08:32 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeTZW-000DMU-Rh
	for git@vger.kernel.org; Mon, 20 May 2013 19:08:30 +0200
Received: from mail-oa0-f42.google.com ([209.85.219.42])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeR1W-000Feo-Uf
	for git@vger.kernel.org; Mon, 20 May 2013 16:25:15 +0200
Received: by mail-oa0-f42.google.com with SMTP id i10so8014834oag.15
        for <git@vger.kernel.org>; Mon, 20 May 2013 10:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xEliIMeqLLZ7pm4p45yWBjYOOfNvY/JbFHsN+TRvFQo=;
        b=UBO18mTnzJdEQ3YuGp++cJJtQO4rkewgKQcELRou7bScO8C/iXfaFcE4rkBjmL6POa
         EzSQdBdfzbf+e6kVus9vAOoGAah4WqFgFTKr1Qzqoy5IfG5QU3h2dO01Kgma0SQD/Jfz
         TANatqZdXDkz8Z5tquBsJ0KzkhpwmJBVfZV9I80Q+kwlszVtKtVQPRrsBxn6M8xfGpNr
         RIrWg+2RKSTHp9G26Vydb43sBz3KtSpGdzPuc1LopaXl78o9KEPtbPMgFPPyi4NgIJpg
         nf0QHkJqYJg0oLr2sarhXkDroblvJ0tBNri8FGEsgmeNdq/9j47RRfxfqLKb/jFw6tEf
         9AkQ==
X-Received: by 10.60.162.70 with SMTP id xy6mr20263751oeb.117.1369069707134;
 Mon, 20 May 2013 10:08:27 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 10:08:27 -0700 (PDT)
In-Reply-To: <20130520165942.GB27788@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224965>

On Mon, May 20, 2013 at 6:59 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 20, 2013 at 09:37:30AM -0700, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>>
>> > For server-class installations we need ref storage that can be read
>> > (and updated?) atomically, and the current system of loose + packed
>> > files won't work since reading (and updating) more than a single file
>> > is not an atomic operation. Trivially, one could resolve this by
>> > dropping loose refs, and always using a single packed-refs file, but
>> > that would make it prohibitively expensive to update refs (the entire
>> > packed-refs file must be rewritten for every update).
>> >
>> > Now, observe that we don't have these race conditions in the object
>> > database, because it is an add-only immutable data store.
>> >
>> > What if we stored the refs as a tree object in the object database,
>> > referenced by a single (loose) ref?
>>
>> What is the cost of updating a single branch with that scheme?
>
> Yeah, I had the same thoughts as you here; I don't think this is really
> much better than updating a single packed-refs file. You may only
> have to touch log(N) of the entries to update the trees along the path
> to your ref (assuming you have a bushy refs/ tree; in practice, of
> course, you have a lot of entries in refs/heads/, so you do not quite
> get log behavior). So algorithmically it may be slightly better, but you
> pay a much higher constant, in that you are creating many tree objects
> along the path (and reading them on lookup).

True.

> But more importantly, it introduces contention between two unrelated
> refs that are being updated. Even if we reconcile the differences
> automatically (e.g., with a "merge-and-retry" strategy), that is going
> to be a serious performance regression for a busy repository, as we
> repeatedly try to reconcile the serialized updates to the refs/ root
> tree.
>
> Any transactional solution needs to have the equivalent of ref-level
> locking (i.e., row-level locking in a relational setting). It is OK for
> two simultaneous updates to different rows to happen in random order; we
> don't care about that level of atomicity. The important thing is that
> the _readers_ see transactions in consistent order; if we know that
> update B started after update A finished, then we must never see update
> A without update B reflected. And I think that is more or less a solved
> problem in the database world.
>
> That is what prevents:
>
>   git update-ref A B
>   git update-ref -d B
>
> from creating a view where the reader sees neither A nor B (which is
> what can happen with the current filesystem view).

All true. Just a last spasm from the dying notion that we could solve
this in the filesystem, without using "proper" database...

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
