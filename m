From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Thu, 18 Nov 2010 19:42:41 +0100
Message-ID: <20101118184241.GN3693@efreet.light.src>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:42:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9Ra-0003tU-Go
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab0KRSmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:42:45 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:40386 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0KRSmo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:42:44 -0500
X-ASG-Debug-ID: 1290105761-0706ee840001-QuoKaX
Received: from efreet.light.src (152-31-80-78.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id Ho2bCaTyhfB4DwPD; Thu, 18 Nov 2010 19:42:41 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PJ9RR-00047h-I4; Thu, 18 Nov 2010 19:42:41 +0100
X-ASG-Orig-Subj: Re: [BUG?] push to mirrior interferes with parallel operations
Content-Disposition: inline
In-Reply-To: <20101118175007.GA26505@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1290105761
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8393 1.0000 2.6012
X-Barracuda-Spam-Score: 2.60
X-Barracuda-Spam-Status: No, SCORE=2.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.47003
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161703>

On Thu, Nov 18, 2010 at 12:50:08 -0500, Jeff King wrote:
> On Thu, Nov 18, 2010 at 08:39:17AM +0100, Jan Hudec wrote:
> >
> What is happening, I believe, is that push is trying to
> opportunistically update your local tracking branches.

Indeed.

> So the first issue is that you do not have the usual branches-in-heads,
> tracking-branches-in-remotes setup. Instead it is looking at your fetch
> refspec:
> 
> >     [remote "backup"]
> > 	url = /mnt/server/path/to/repo.git
> > 	fetch = +refs/*:refs/*
> > 	mirror = true
> 
> and trying to update everything in refs/* with what it just pushed.
> Usually this is a no-op, since it is the same as the value we just
> pushed, but as you found out, it is in a race with concurrent commands.
> 
> I think we don't want to be doing the opportunistic update in this case.
> But what is the correct rule for deciding not to do it? I can think of a
> few possibilities:
> 
>  1. When the mirror option is used. But this doesn't help people who
>     have a broad fetch refspec they have configured without mirror.

The above config is what is created by default by 'git remote add --mirror'.
So I expect the problem to be somewhat common with mirror and a lot rarer
without.

Which brings the yet another question, namely whether it actually makes sense
to set the fetch for a mirror remote. Note that any call to fetch will almost
inevitably abort with "reusing to pull to checked out ref in non-bare
repository" error.

>  2. When the RHS of a fetch refspec is something that is being pushed.
>     But this doesn't cover the case of pushing local "refs/heads/foo" to
>     remote "refs/heads/bar", and then having it update "refs/heads/bar"
>     locally.
> 
>  3. When the ref to be updated is not in refs/remotes. This feels a
>     little hack-ish, but I think would work the best in practice. The
>     refs/remotes hierarchy is supposed to just be a cache of remote
>     state, so really it is the only place such an opportunistic update
>     should be safe. People who are doing exotic things like fetching
>     directly into refs/heads will have to live without the opportunistic
>     update.

In my case it wouldn't actually help. The race was between push to mirror and
fetch from actual upstream (which happened to be svn via git-svn, but it
would happen with git upstream too) and the incorrectly rewound ref was
'refs/remotes/svn/trunk'.

A combination of 2 *and* 3 would work. I.e. update only remotes and only if
they are not being pushed.

What would work on the other hand -- and be very conservative approach --
would be to only do oportunistic update if the fetch *option* has
'refs/remotes/<something>' on the right side.

> The second issue I mentioned is that transport_update_tracking_ref does
> not actually check the old sha1 of the ref it is updating. The usual
> practice in git to avoid holding long locks is:
> 
>   1. lock ref, read sha1, unlock ref
>   2. do stuff to make a new sha1, remembering old sha1
>   3. lock ref, read sha1, check that it equals old sha1, write new sha1,
>      unlock
> 
> We don't do that here.
> [...]
> So really we would need to read the current value of the tracking ref at
> the beginning of the push. But that is inefficient, and it is not
> actually atomic with the push we are doing.

Indeed, it does not sound reasonable. Plus I don't think it would actually do
what we want. In the case of pushing 'refs/heads/foo' -> 'refs/heads/bar' and
updating local 'refs/heads/bar', it's not clear whether it should be updated
or not.

In fact the problem is not in the race, but in the fact, that push updates
refs, that may have other purpose than tracking the particular remote. The
problem is in some cases we don't know whether a ref is purely tracking
*that* remote or not.

> So I think it is OK to keep this the way it is, and assume that
> update_tracking_ref is about overwriting whatever is there. The real
> problem in your case is that the things it is overwriting are actually
> precious heads, not just a remote cache.

Well, in my case it actually was a remote cache. But of different remote.

There are two common cases:

 1. The mirror case, where we don't want to do the oportunistic update at
    all.

 2. The regular case of remote tracking branches, in which case the
    'remote.<name>.fetch' option matches ".*:refs/remotes/[^*]+/.*"

and than there is a see of various strange hand-crafted setups, where it's
not obvious whether user actually wants the oportunistic update or not.

Thus I see two options to change the oportunistic update:

 1. Don't do oportunistic update with mirror. That keeps the other cases work
    as they do now. Hopefuly users are aware of the behaviour when they
    hand-craft such setups.

 2. Only do oportunistic update when the fetch specification matches
    ".*:refs/remotes/[^*]+/.*". That way oportunistic update will only happen
    if the remote has it's own section in refs/remotes, so we can assume
    nothing else is touching it.

and the third option (similar to the first, but done at different point):

 3. Don't set 'fetch' for mirror remotes in non-bare repositories, since
    non-bare repositories can't be treated as mirrors of something.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
