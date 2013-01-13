From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: missing objects -- prevention
Date: Sun, 13 Jan 2013 06:26:53 +0530
Message-ID: <CAMK1S_iKARYqi_Dv90og0No7NN=WxFg+ixmRvnkvfdrcOi1r=Q@mail.gmail.com>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
	<20130111164202.GB5219@sigill.intra.peff.net>
	<CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
	<20130112131358.GB21875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 13 01:58:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuBu5-0006i0-Gq
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 01:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab3AMA4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 19:56:54 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38813 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3AMA4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 19:56:54 -0500
Received: by mail-ie0-f173.google.com with SMTP id e13so3790769iej.32
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 16:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xXclqXXHu1BMP/4ZrM+PPQOPmwSCb4Sac0fqHO+Pfmc=;
        b=YLylHwgskxfi1+s8TwsX6myvi9wuOU8eviPzegDK0RWHm30qCWOsKKwfzxp2OL/Cqv
         WZ/rTO70E8pYV8oyMpNk2fCn5G+pBxE+oBFYIqIiXn3cNP7sFwZyvFpMANUCMxCpntKB
         FTgZWduSWnoDyJCd8XL1GyOaMSsiq/P5zQd6WgNdPaquricVtC0ElwS/d2C8mV4zEuKC
         bC28KMhMDw0RwfxGEgpnjljBqh6RHMOMdD2ggU8jeJJIya4giFnXfrpXCBOtJniRMd5N
         RxiNojHo2555+SHERbs9F3yP+8mL9/wAb6OVOFIeZvj6BEq3P4MSFEYVOhX2ZXccrnDE
         SaAQ==
Received: by 10.43.110.132 with SMTP id ek4mr60374304icc.32.1358038613389;
 Sat, 12 Jan 2013 16:56:53 -0800 (PST)
Received: by 10.50.30.164 with HTTP; Sat, 12 Jan 2013 16:56:53 -0800 (PST)
In-Reply-To: <20130112131358.GB21875@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213317>

On Sat, Jan 12, 2013 at 6:43 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jan 12, 2013 at 06:39:52AM +0530, Sitaram Chamarty wrote:
>
>> >   1. The repo has a ref R pointing at commit X.
>> >
>> >   2. A user starts a push to another ref, Q, of commit Y that builds on
>> >      X. Git advertises ref R, so the sender knows they do not need to
>> >      send X, but only Y. The user then proceeds to send the packfile
>> >      (which might take a very long time).
>> >
>> >   3. Meanwhile, another user deletes ref R. X becomes unreferenced.
>>
>> The gitolite logs show that no deletion of refs has happened.
>
> To be pedantic, step 3 could also be rewinding R to a commit before X.
> Anything that causes X to become unreferenced.

Right, but there were no rewinds also; I should have mentioned that.
(Gitolite log files mark rewinds and deletes specially, so they're
easy to search.  There were two attempted rewinds but they failed the
gitolite update hook so -- while the new objects would have landed in
the object store -- the old ones were not dereferenced).

>> > There is a race with simultaneously deleting and packing refs. It
>> > doesn't cause object db corruption, but it will cause refs to "rewind"
>> > back to their packed versions. I have seen that one in practice (though
>> > relatively rare). I fixed it in b3f1280, which is not yet in any
>> > released version.
>>
>> This is for the packed-refs file right?  And it could result in a ref
>> getting deleted right?
>
> Yes, if the ref was not previously packed, it could result in the ref
> being deleted entirely.
>
>> I said above that the gitolite logs say no ref was deleted.  What if
>> the ref "deletion" happened because of this race, making the rest of
>> your 4-step scenario above possible?
>
> It's possible. I do want to highlight how unlikely it is, though.

Agreed.

>> > up in the middle, or fsck rejects the pack). We have historically left
>>
>> fsck... you mean if I had 'receive.fsckObjects' true, right?  I don't.
>>  Should I?  Would it help this overall situation?  As I understand it,
>> thats only about the internals of each object to check corruption, and
>> cannot detect a *missing* object on the local object store.
>
> Right, I meant if you have receive.fsckObjects on. It won't help this
> situation at all, as we already do a connectivity check separate from
> the fsck. But I do recommend it in general, just because it helps catch
> bad objects before they gets disseminated to a wider audience (at which
> point it is often infeasible to rewind history). And it has found git
> bugs (e.g., null sha1s in tree entries).

I will add this.  Any idea if there's a significant performance hit?

>> > At GitHub, we've taken to just cleaning them up aggressively (I think
>> > after an hour), though I am tempted to put in an optional signal/atexit
>>
>> OK; I'll do the same then.  I suppose a cron job is the best way; I
>> didn't find any config for expiring these files.
>
> If you run "git prune --expire=1.hour.ago", it should prune stale
> tmp_pack_* files more than an hour old. But you may not be comfortable
> with such a short expiration for the objects themselves. :)
>
>> Thanks again for your help.  I'm going to treat it (for now) as a
>> disk/fs error after hearing from you about the other possibility I
>> mentioned above, although I find it hard to believe one repo can be
>> hit buy *two* races occurring together!
>
> Yeah, the race seems pretty unlikely (though it could be just the one
> race with a rewind). As I said, I haven't actually ever seen it in
> practice. In my experience, though, disk/fs issues do not manifest as
> just missing objects, but as corrupted packfiles (e.g., the packfile
> directory entry ends up pointing to the wrong inode, which is easy to
> see because the inode's content is actually a reflog). And then of
> course with the packfile unreadable, you have missing objects. But YMMV,
> depending on the fs and what's happened to the machine to cause the fs
> problem.

That's always the hard part.  System admins (at the Unix level) insist
there's nothing wrong and no disk errors and so on...  that is why I
was interested in network errors causing problems and so on.

Anyway, now that I know the tmp_pack_* files are caused mostly by
failed pushes than by failed auto-gc, at least I can deal with the
immediate problem easily!

Thanks once again for your patient replies!

sitaram


-- 
Sitaram
