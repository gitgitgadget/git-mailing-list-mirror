From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: missing objects -- prevention
Date: Sat, 12 Jan 2013 06:39:52 +0530
Message-ID: <CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
	<20130111164202.GB5219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtpcG-0008Ts-RD
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 02:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab3ALBJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 20:09:54 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46424 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab3ALBJx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 20:09:53 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so3113645iea.12
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 17:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AOpbfsfuazDLljvqwkNnspP2fuO4fVNrCQnKFxNN8KQ=;
        b=NaD4UliYJCoJqYhTkr56c1OT2YeEQcHxrtmpL9xiZbXJmFeRbAGz8RDr45tGqZvN6y
         /M0UcDvimMIfztd1M9EI1yeY0VHnKRmnSgB0aH/9v4B3g58S//0+5RO6mccfh75eg14n
         tHb+8JKyORAdC82vOyrUjWeMqinhVlRBHSbJbCYqMu08PcQtpr6ThKQrb8vBmPdABY4G
         hwWSld4C4EkgAJK/Sv8Iw4R3YZ6f0RfTTlTbhtSAKzxrSrIienq3kEWLjVNNymZCexqv
         10eXQkQqF5yMAB8YfbgLIYl13PAW5fDDLE+thGplUJqG+jUk/KseFFkC3PyYRP+Vyi3L
         8Wmw==
Received: by 10.50.197.169 with SMTP id iv9mr858941igc.32.1357952992956; Fri,
 11 Jan 2013 17:09:52 -0800 (PST)
Received: by 10.50.30.164 with HTTP; Fri, 11 Jan 2013 17:09:52 -0800 (PST)
In-Reply-To: <20130111164202.GB5219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213254>

Thanks for the very detailed answer.

On Fri, Jan 11, 2013 at 10:12 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 11, 2013 at 04:40:38PM +0530, Sitaram Chamarty wrote:
>
>> I find a lot of info on how to recover from and/or repair a repo that
>> has missing (or corrupted) objects.
>>
>> What I need is info on common reasons (other than disk errors -- we've
>> checked for those) for such errors to occur, any preventive measures
>> we can take, and so on.
>
> I don't think any race can cause corruption of the object or packfiles
> because of the way they are written. At GitHub, every case of file-level
> corruption we've seen has been a filesystem issue.
>
> So I think the main thing systemic/race issue to worry about is missing
> objects. And since git only deletes objects during a prune (assuming you
> are using git-gc or "repack -A" so that repack cannot drop objects), I
> think prune is the only thing to watch out for.

No one runs anything manually under normal conditions.  If there's any
gc happening, it's gc --auto.

> The --expire time saves us from the obvious races where you write object
> X but have not yet referenced it, and a simultaneous prune wants to
> delete it. However, it's possible that you have an old object that is
> unreferenced, but would become referenced as a result of an in-progress
> operation. For example, commit X is unreferenced and ready to be pruned,
> you build commit Y on top of it, but before you write the ref, git-prune
> removes X.
>
> The server-side version of that would happen via receive-pack, and is
> even more unlikely, because X would have to be referenced initially for
> us to advertise it. So it's something like:
>
>   1. The repo has a ref R pointing at commit X.
>
>   2. A user starts a push to another ref, Q, of commit Y that builds on
>      X. Git advertises ref R, so the sender knows they do not need to
>      send X, but only Y. The user then proceeds to send the packfile
>      (which might take a very long time).
>
>   3. Meanwhile, another user deletes ref R. X becomes unreferenced.

The gitolite logs show that no deletion of refs has happened.

>   4. After step 3 but before step 2 has finished, somebody runs prune
>      (this might sound unlikely, but if you kick off a "gc" job after
>      each push, or after N pushes, it's not so unlikely).  It sees that
>      X is unreferenced, and it may very well be older than the --expire
>      setting. Prune deletes X.
>
>   5. The packfile in (2) arrives, and receive-pack attempts to update
>      the refs.
>
> So it's even a bit more unlikely than the local case, because
> receive-pack would not otherwise build on dangling objects. You have
> to race steps (2) and (3) just to create the situation.
>
> Then we have an extra protection in the form of
> check_everything_connected, which receive-pack runs before writing the
> refs into place. So if step 4 happens while the packfile is being sent
> (which is the most likely case, since it is the longest stretch of
> receive-pack's time), we would still catch it there and reject the push
> (annoying to the user, but the repo remains consistent).
>
> However, that's not foolproof. We might hit step 4 after we've checked
> that everything is connected but right before we write the ref. In which
> case we drop X, which has just become referenced, and we have a missing
> object.
>
> So I think it's possible. But I have never actually seen it in practice,
> and come up with this scenario only by brainstorming "what could go
> wrong" scenarios.
>
> This could be mitigated if there was a "proposed refs" storage.
> Receive-pack would write a note saying "consider Y for pruning purposes,
> but it's not really referenced yet", check connectivity for Y against
> the current refs, and then eventually write Y to its real ref (or reject
> it if there are problems). Prune would either run before the "proposed"
> note is written, which would mean it deletes X, but the connectivity
> check fails. Or it would run after, in which case it would leave X
> alone.
>
>> For example, can *any* type of network error or race condition cause
>> this?  (Say, can one push writes an object, then fails an update
>> check, and a later push succeeds and races against a gc that removes
>> the unreachable object?)  Or... the repo is pretty large -- about 6-7
>> GB, so could size cause a race that would not show up on a smaller
>> repo?
>
> The above is the only open issue I know about. I don't think it is
> dependent on repo size, but the window is widened for a really large
> push, because rev-list takes longer to run. It does not widen if you
> have receive.fsckobjects set, because that happens before we do the
> connectivity check (and the connectivity check is run in a sub-process,
> so the race timer starts when we exec rev-list, which may open and mmap
> packfiles or otherwise cache the presence of X in memory).
>
>> Anything else I can watch out for or caution the team about?
>
> That's the only open issue I know about for missing objects.
>
> There is a race with simultaneously deleting and packing refs. It
> doesn't cause object db corruption, but it will cause refs to "rewind"
> back to their packed versions. I have seen that one in practice (though
> relatively rare). I fixed it in b3f1280, which is not yet in any
> released version.

This is for the packed-refs file right?  And it could result in a ref
getting deleted right?

I said above that the gitolite logs say no ref was deleted.  What if
the ref "deletion" happened because of this race, making the rest of
your 4-step scenario above possible?

>> The symptom is usually a disk space crunch caused by tmp_pack_* files
>> left around by auto-gc.  Presumably the missing objects failed the gc
>> and so it left the files around, and they eventually accumulate enough
>> to cause disk full errors.  (If a gc ever succeeded, I suspect these
>> files would go away, but that requires manual intervention).
>
> Gc shouldn't be leaving around tmp_pack_* unless it is actually dying
> during the pack-objects phase. In my experience, stale tmp_pack_*
> objects are more likely a sign of a failed push (e.g., the client hangs

Oh.  I did not know that!  That explains why I sometimes saw that even
when there were less than 6700 loose objects (i.e., auto-gc should not
have kicked in at all).

> up in the middle, or fsck rejects the pack). We have historically left

fsck... you mean if I had 'receive.fsckObjects' true, right?  I don't.
 Should I?  Would it help this overall situation?  As I understand it,
thats only about the internals of each object to check corruption, and
cannot detect a *missing* object on the local object store.

> them in place to facilitate analysis of the failure.
>
> At GitHub, we've taken to just cleaning them up aggressively (I think
> after an hour), though I am tempted to put in an optional signal/atexit

OK; I'll do the same then.  I suppose a cron job is the best way; I
didn't find any config for expiring these files.

Thanks again for your help.  I'm going to treat it (for now) as a
disk/fs error after hearing from you about the other possibility I
mentioned above, although I find it hard to believe one repo can be
hit buy *two* races occurring together!

> handler to clean them up when index-pack fails. The forensics are
> occasionally interesting (e.g., finding weird fsck problems), but large
> pushes can waste a lot of disk space in the interim.
>
> -Peff



-- 
Sitaram
