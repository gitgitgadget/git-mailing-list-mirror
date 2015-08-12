From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: proper remote ref namespaces
Date: Wed, 12 Aug 2015 11:18:29 -0400
Message-ID: <55CB63C5.8090708@xiplink.com>
References: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPXvS-0004oG-4I
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 17:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbbHLP0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 11:26:41 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:47691 "EHLO
	smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932165AbbHLP0k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 11:26:40 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2015 11:26:40 EDT
Received: from smtp19.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp19.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0BF711801D2;
	Wed, 12 Aug 2015 11:18:25 -0400 (EDT)
Received: by smtp19.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BF25F1801AE;
	Wed, 12 Aug 2015 11:18:24 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.4.2);
	Wed, 12 Aug 2015 15:18:25 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
In-Reply-To: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275774>

On 15-08-12 02:43 AM, Jacob Keller wrote:
> Hello,
> 
> Recently there was some discussion about git-notes and how we do not fetch
> notes from remotes by default. The big problem with doing so is because
> refs/remotes/* hierarchy is only setup for branches (heads), so we don't
> have any clean location to put them.
> 
> Around the time of git 1.8.0, Johan Herland made a proposal for remotes to
> put all their refs in refs/remtoes/*, by moving heads into 
> refs/remotes/<remote>heads/* [1]

Thanks for resurrecting this discussion.  I feel this is a fundamental
inconsistency in git's core design.  Not a fatal flaw by any means, but
something that keeps git from reaching its full potential.

> In addition, his proposal was to include remote tags into 
> refs/remotes/<remote>/tags and also refs/remotes/<remote>/replace and 
> notes similarly.
> 
> During this discussion there was many people who liked the idea, and 
> others who rejected it. The main rejection reason  was two fold:
> 
> (a) tags are "global" per project, so their namespace should be treated
> global as it is now.
> 
> The proposal's counter to this is that tags aren't guaranteed to be 
> global, because today two remotes you fetch might have tags that are the
> same name with different pointers. This is currently hidden, and git
> silently picks the tag it fetched first.
> 
> (b) script compatibility, as changing the ref layout  such that new git
> can't work with old repository would be bad
> 
> the counter to this, is that we make git smart enough to recognize old 
> remote format, and continue to work with it. Scripts which depend on this
> layout will break, but that may not be such a huge concern.
> 
> Personally, I think this proposal at least for heads, notes, replace, and
> other remote refs we'd like to pull is very useful. I don't rightly know
> the answer for tags. The linked discussion below covers several pages of
> back and forth between a few people about which method is best.
> 
> I like the idea of simplifying tags and branches and notes and others to
> all fetch the same way. local stuff is in refs/heads or refs/notes and
> remote stuff is (by default) in refs/remotes/<remote>/tags etc
> 
> But it does bring up some discussion as today we "auto follow" tags into
> refs/tags, and it can get weird for tags since now "ambiguous" tags must
> mean if there are tags of same name which point to different refs,

The tags would be disambiguated by their remote name, e.g. "origin/tags/v5.6"
vs. "hacker/tags/v5.6".  The change would actually simplify tag auto-following.

> and we'd need to teach a bunch of logic to the ref lookup code.

Not a lot.  Existing DWIMery already handles ambiguous branches, by
preferring a local branch name over any remote ones.  The only teaching
that's really needed is to resolve shorthand like "origin/v5.6" to
"refs/remotes/origin/tags/v5.6" (i.e. to look for anything matching
"refs/remotes/origin/*/v5.6") but that doesn't seem very difficult.

There is the question of how the user can even know if there's ambiguity.
Aside from paying attention to "git fetch" output, I think we could extend
"git tag" (and "git branch") in the case where the user specifies an existing
tag (or branch).  Right now both commands fail because the name already
exists.  All we need to do is extend that error message a bit, e.g.:

	> git tag v5.6
	fatal: tag 'next' already exists as
	v5.6 -> a3a0e5d67d554a685abd897bc3ce4ffa4e74c812
	origin/v5.6 remoteX/v5.6 -> 504346bbf9b02387b51f232f4db9c1860789b135
	hacker/v5.6 -> fb4aa3533f81700789b3fb119e527410678e8d8d

Here we see that our local v5.6, and hacker's v5.6, are unique, but origin
and remoteX both have the same v5.6.

Well, same-ish.  I think those SHA IDs should be the things the tags point
at, not the tag objects' IDs.  This keeps things consistent between
lightweight and annotated/signed tags.  It does mean though that origin/v5.6
and remoteX/v5.6 might be different tag objects that happen to point at the
same thing.  I'm not sure the distinction is all that germane, and it's
something that the user could disambiguate with "git tag -v" or "git show".

> I am looking at ways to help git-notes be easier to use, so that we by 
> default fetch notes, and enable easier merge, since we'd have default 
> locations to merge from and to. This would make the sharing of notes a lot
> easier, which is one of their primary sticking points.. you can't really
> share them without *everyone* working to do it the same way you do. By
> making a default policy, sharing becomes natural, and users can easily add
> *public* notes to commits for things such as bug ids and other things
> which are not discovered until after the commit is created.
> 
> In addition, the easy ability to share replaces might also be helpful, 
> though IMHO not as valuable as git-notes.
> 
> I think that the only logical refs layout is 
> "refs/remotes/<remote>/(heads|tags|notes|replace)"
> 
> and adding "refs/remote-notes" and "refs/remote-replace" is not really a
> clean solution.
> 
> Given that the 1.8.0 proposal mostly died, does anyone have any thoughts
> now?
> 
> The proposal suggested by Johan makes sense to me, and I believe we can
> code up logic to make it easy for new git to keep logic of the old 
> layout.
> 
> Personally, I think the best solution is to only store that layout for a
> given clone, using a config option that defaults to false, where new-git
> sets it to true for all clones. Then, provide a command to renew
> remotes-layout that does this if the user wishes. Thus, clones for the old
> style will be handled, and new clones would have the new layout. (ie: no
> mixing layouts in a single repository).
> 
> I'm really not sure if this is the best solution, but seems like the 
> cleanest solution.

I think that proposal is good.  Perhaps something like
config.remoterefslayout, where 0 means the existing layout and 1 is the new
layout (with larger numbers reserved for future changes).

Implementing the new layout should, I think, just involve changing the
default fetch refspecs when adding a remote.

Then it's just a matter of making the test suite pass.  :)

		M.
