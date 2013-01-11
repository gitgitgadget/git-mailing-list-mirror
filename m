From: Jeff King <peff@peff.net>
Subject: Re: missing objects -- prevention
Date: Fri, 11 Jan 2013 11:42:03 -0500
Message-ID: <20130111164202.GB5219@sigill.intra.peff.net>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:42:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tthga-00031Q-9R
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 17:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab3AKQmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 11:42:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57417 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3AKQmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 11:42:06 -0500
Received: (qmail 20797 invoked by uid 107); 11 Jan 2013 16:43:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jan 2013 11:43:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2013 11:42:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213224>

On Fri, Jan 11, 2013 at 04:40:38PM +0530, Sitaram Chamarty wrote:

> I find a lot of info on how to recover from and/or repair a repo that
> has missing (or corrupted) objects.
> 
> What I need is info on common reasons (other than disk errors -- we've
> checked for those) for such errors to occur, any preventive measures
> we can take, and so on.

I don't think any race can cause corruption of the object or packfiles
because of the way they are written. At GitHub, every case of file-level
corruption we've seen has been a filesystem issue.

So I think the main thing systemic/race issue to worry about is missing
objects. And since git only deletes objects during a prune (assuming you
are using git-gc or "repack -A" so that repack cannot drop objects), I
think prune is the only thing to watch out for.

The --expire time saves us from the obvious races where you write object
X but have not yet referenced it, and a simultaneous prune wants to
delete it. However, it's possible that you have an old object that is
unreferenced, but would become referenced as a result of an in-progress
operation. For example, commit X is unreferenced and ready to be pruned,
you build commit Y on top of it, but before you write the ref, git-prune
removes X.

The server-side version of that would happen via receive-pack, and is
even more unlikely, because X would have to be referenced initially for
us to advertise it. So it's something like:

  1. The repo has a ref R pointing at commit X.

  2. A user starts a push to another ref, Q, of commit Y that builds on
     X. Git advertises ref R, so the sender knows they do not need to
     send X, but only Y. The user then proceeds to send the packfile
     (which might take a very long time).

  3. Meanwhile, another user deletes ref R. X becomes unreferenced.

  4. After step 3 but before step 2 has finished, somebody runs prune
     (this might sound unlikely, but if you kick off a "gc" job after
     each push, or after N pushes, it's not so unlikely).  It sees that
     X is unreferenced, and it may very well be older than the --expire
     setting. Prune deletes X.

  5. The packfile in (2) arrives, and receive-pack attempts to update
     the refs.

So it's even a bit more unlikely than the local case, because
receive-pack would not otherwise build on dangling objects. You have
to race steps (2) and (3) just to create the situation.

Then we have an extra protection in the form of
check_everything_connected, which receive-pack runs before writing the
refs into place. So if step 4 happens while the packfile is being sent
(which is the most likely case, since it is the longest stretch of
receive-pack's time), we would still catch it there and reject the push
(annoying to the user, but the repo remains consistent).

However, that's not foolproof. We might hit step 4 after we've checked
that everything is connected but right before we write the ref. In which
case we drop X, which has just become referenced, and we have a missing
object.

So I think it's possible. But I have never actually seen it in practice,
and come up with this scenario only by brainstorming "what could go
wrong" scenarios.

This could be mitigated if there was a "proposed refs" storage.
Receive-pack would write a note saying "consider Y for pruning purposes,
but it's not really referenced yet", check connectivity for Y against
the current refs, and then eventually write Y to its real ref (or reject
it if there are problems). Prune would either run before the "proposed"
note is written, which would mean it deletes X, but the connectivity
check fails. Or it would run after, in which case it would leave X
alone.

> For example, can *any* type of network error or race condition cause
> this?  (Say, can one push writes an object, then fails an update
> check, and a later push succeeds and races against a gc that removes
> the unreachable object?)  Or... the repo is pretty large -- about 6-7
> GB, so could size cause a race that would not show up on a smaller
> repo?

The above is the only open issue I know about. I don't think it is
dependent on repo size, but the window is widened for a really large
push, because rev-list takes longer to run. It does not widen if you
have receive.fsckobjects set, because that happens before we do the
connectivity check (and the connectivity check is run in a sub-process,
so the race timer starts when we exec rev-list, which may open and mmap
packfiles or otherwise cache the presence of X in memory).

> Anything else I can watch out for or caution the team about?

That's the only open issue I know about for missing objects.

There is a race with simultaneously deleting and packing refs. It
doesn't cause object db corruption, but it will cause refs to "rewind"
back to their packed versions. I have seen that one in practice (though
relatively rare). I fixed it in b3f1280, which is not yet in any
released version.

> The symptom is usually a disk space crunch caused by tmp_pack_* files
> left around by auto-gc.  Presumably the missing objects failed the gc
> and so it left the files around, and they eventually accumulate enough
> to cause disk full errors.  (If a gc ever succeeded, I suspect these
> files would go away, but that requires manual intervention).

Gc shouldn't be leaving around tmp_pack_* unless it is actually dying
during the pack-objects phase. In my experience, stale tmp_pack_*
objects are more likely a sign of a failed push (e.g., the client hangs
up in the middle, or fsck rejects the pack). We have historically left
them in place to facilitate analysis of the failure.

At GitHub, we've taken to just cleaning them up aggressively (I think
after an hour), though I am tempted to put in an optional signal/atexit
handler to clean them up when index-pack fails. The forensics are
occasionally interesting (e.g., finding weird fsck problems), but large
pushes can waste a lot of disk space in the interim.

-Peff
