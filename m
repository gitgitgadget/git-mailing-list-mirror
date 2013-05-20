From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 19:03:52 +0200
Message-ID: <CALKQrgd3=5Rb5wbDGTV7PQfcingimYf08yEHcbfSCkjGDUU_Ng@mail.gmail.com>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
	<7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 19:04:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeTVD-0001Hb-VQ
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342Ab3ETRD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:03:59 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:54813 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3ETRD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:03:58 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeTV6-000DKO-V2
	for git@vger.kernel.org; Mon, 20 May 2013 19:03:56 +0200
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UeQx6-000FYX-N2
	for git@vger.kernel.org; Mon, 20 May 2013 16:20:40 +0200
Received: by mail-oa0-f49.google.com with SMTP id k14so7851782oag.22
        for <git@vger.kernel.org>; Mon, 20 May 2013 10:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ccL94nsdlrdMftb/PX+a7v4s4t7WZXtSFemdVuVhqZI=;
        b=hQN/LuoXzvYztUqxFqFXbOhUjX2kEmhR0bBubsVFH8Kxbaarr4jCyRaAA8IpTD0VL5
         FWWsYp7DeX7mdJHfd4YOb48dJQv+qlFqFfJKaBo53t2lapfsJ7KXwER/rODKsBn8BVfg
         puoucYUWje8xQf8TgvLPb64c0F1vm+IJSthDR43VLOqn5ocHu2RNtsZwhsT1EAxm0DxT
         UvMKLG6qmomXaxHR+lAq71rrL9mwtn4mJCMnXa1F5zTiEqE+NOJon43jeesHQDxlXMm4
         zG9SPkYYogjnwC87nyRQXsFAT+KVwYLunOpawQGiaqF5xa6R3BoVhIvDc8u2a4jCCWlF
         q7Dw==
X-Received: by 10.182.215.130 with SMTP id oi2mr3257856obc.97.1369069432881;
 Mon, 20 May 2013 10:03:52 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Mon, 20 May 2013 10:03:52 -0700 (PDT)
In-Reply-To: <7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224964>

On Mon, May 20, 2013 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> For server-class installations we need ref storage that can be read
>> (and updated?) atomically, and the current system of loose + packed
>> files won't work since reading (and updating) more than a single file
>> is not an atomic operation. Trivially, one could resolve this by
>> dropping loose refs, and always using a single packed-refs file, but
>> that would make it prohibitively expensive to update refs (the entire
>> packed-refs file must be rewritten for every update).
>>
>> Now, observe that we don't have these race conditions in the object
>> database, because it is an add-only immutable data store.
>>
>> What if we stored the refs as a tree object in the object database,
>> referenced by a single (loose) ref?
>
> What is the cost of updating a single branch with that scheme?
>
> Doesn't it end up recording roughly the same amount of information
> as updating a single packed-refs file that is flat, but with the
> need to open a few tree objects (top-level, refs/, and refs/heads/),
> writing out a blob that stores the object name at the tip, computing
> the updated trees (refs/heads/, refs/ and top-level), and then
> finally doing the compare-and-swap of that single loose ref?

Yes, except that when you update packed-refs, you have to write out
the _entire_ file, whereas with this scheme you only have to write out
the part of the refs hierarchy you actually touched (e.g. rewriting
refs/heads/foo would not have to write out anything inside
refs/tags/*). If you have small number of branches, and a huge number
of tags, this scheme might end up being cheaper than writing the
entire packed-refs. But in general, it's probably much more expensive
to go via the odb.

> You may guarantee atomicity but it is the same granularity of
> atomicity as a single packed-refs file.

Yes, as I argued elsewhere in this thread: It seems that _any_
filesystem-based solution must resort to having all updates depend on
a single file in order to guarantee atomicity.

> When you are updating a
> branch while somebody else is updating a tag, of course you do not
> have to look at refs/tags/ in your operation and you can write out
> your final packed-refs equivalent tree to the object database
> without racing with the other process, but the top-level you come up
> with and the top-level the other process comes up with (which has
> an up-to-date refs/tags/ part, but has a stale refs/heads/ part from
> your point of view) have to race to update that single loose ref,
> and one of you have to back out.

True.

> That "backing out" can be made more intelligently than just dying
> with "compare and swap failed--please retry" message, e.g. you at
> that point notice what you started with, what the other party did
> while you were working on (i.e. updating refs/tags/), and three-way
> merge the refs tree, and in cases where "all refs recorded as loose
> refs" scheme wouldn't have resulted in problematic conflict, such a
> three-way merge would resolve trivially (you updated refs/heads/ and
> the update by the other process to refs/tags/ would not conflict
> with what you did).  But the same three-way merge scheme can be
> employed with the current flat single packed-refs scheme, can't it?

Yes. (albeit without reusing the machinery we already have for doing
three-way merges)

> Even worse, what is the cost of looking up the value of a single
> branch?  You would need to open a few tree objects and the leaf blob
> that records the object name the ref points at, wouldn't you?

Yes. Probably a showstopper, although single branch/ref lookup might
not be so common on server side, as it is on the user side.

> Right now, such a look-up is either opening a single small file and
> reading the first 41 bytes off of it, and falling back (when the ref
> in question is packed) to read a single packed-refs file and finding
> the ref you want from it.
>
> So...

Yep...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
