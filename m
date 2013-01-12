From: Jeff King <peff@peff.net>
Subject: Re: missing objects -- prevention
Date: Sat, 12 Jan 2013 08:13:58 -0500
Message-ID: <20130112131358.GB21875@sigill.intra.peff.net>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
 <20130111164202.GB5219@sigill.intra.peff.net>
 <CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 14:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu0un-00086B-7A
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 14:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab3ALNOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 08:14:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58874 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab3ALNOC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 08:14:02 -0500
Received: (qmail 30099 invoked by uid 107); 12 Jan 2013 13:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Jan 2013 08:15:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jan 2013 08:13:58 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213281>

On Sat, Jan 12, 2013 at 06:39:52AM +0530, Sitaram Chamarty wrote:

> >   1. The repo has a ref R pointing at commit X.
> >
> >   2. A user starts a push to another ref, Q, of commit Y that builds on
> >      X. Git advertises ref R, so the sender knows they do not need to
> >      send X, but only Y. The user then proceeds to send the packfile
> >      (which might take a very long time).
> >
> >   3. Meanwhile, another user deletes ref R. X becomes unreferenced.
> 
> The gitolite logs show that no deletion of refs has happened.

To be pedantic, step 3 could also be rewinding R to a commit before X.
Anything that causes X to become unreferenced.

> > There is a race with simultaneously deleting and packing refs. It
> > doesn't cause object db corruption, but it will cause refs to "rewind"
> > back to their packed versions. I have seen that one in practice (though
> > relatively rare). I fixed it in b3f1280, which is not yet in any
> > released version.
> 
> This is for the packed-refs file right?  And it could result in a ref
> getting deleted right?

Yes, if the ref was not previously packed, it could result in the ref
being deleted entirely.

> I said above that the gitolite logs say no ref was deleted.  What if
> the ref "deletion" happened because of this race, making the rest of
> your 4-step scenario above possible?

It's possible. I do want to highlight how unlikely it is, though.

> > up in the middle, or fsck rejects the pack). We have historically left
> 
> fsck... you mean if I had 'receive.fsckObjects' true, right?  I don't.
>  Should I?  Would it help this overall situation?  As I understand it,
> thats only about the internals of each object to check corruption, and
> cannot detect a *missing* object on the local object store.

Right, I meant if you have receive.fsckObjects on. It won't help this
situation at all, as we already do a connectivity check separate from
the fsck. But I do recommend it in general, just because it helps catch
bad objects before they gets disseminated to a wider audience (at which
point it is often infeasible to rewind history). And it has found git
bugs (e.g., null sha1s in tree entries).

> > At GitHub, we've taken to just cleaning them up aggressively (I think
> > after an hour), though I am tempted to put in an optional signal/atexit
> 
> OK; I'll do the same then.  I suppose a cron job is the best way; I
> didn't find any config for expiring these files.

If you run "git prune --expire=1.hour.ago", it should prune stale
tmp_pack_* files more than an hour old. But you may not be comfortable
with such a short expiration for the objects themselves. :)

> Thanks again for your help.  I'm going to treat it (for now) as a
> disk/fs error after hearing from you about the other possibility I
> mentioned above, although I find it hard to believe one repo can be
> hit buy *two* races occurring together!

Yeah, the race seems pretty unlikely (though it could be just the one
race with a rewind). As I said, I haven't actually ever seen it in
practice. In my experience, though, disk/fs issues do not manifest as
just missing objects, but as corrupted packfiles (e.g., the packfile
directory entry ends up pointing to the wrong inode, which is easy to
see because the inode's content is actually a reflog). And then of
course with the packfile unreadable, you have missing objects. But YMMV,
depending on the fs and what's happened to the machine to cause the fs
problem.

-Peff
