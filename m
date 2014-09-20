From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Sat, 20 Sep 2014 02:01:58 +0200
Message-ID: <CALKQrgd3PzwgxuhrTpNCi-zuOj3PYviknpKgfPYVWP6bNS8AqQ@mail.gmail.com>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
	<20140919093910.GA15891@peff.net>
	<CALKQrgc4nZdaXM-Ooh1pP4x4nZRLexJzLyaBmrgn+qVaQGCg+g@mail.gmail.com>
	<xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 02:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV880-0008U3-T6
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 02:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626AbaITACK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 20:02:10 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:56484 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485AbaITACJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 20:02:09 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XV87p-000EfZ-Of
	for git@vger.kernel.org; Sat, 20 Sep 2014 02:02:05 +0200
Received: by mail-pa0-f53.google.com with SMTP id hz1so1023750pad.26
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 17:01:58 -0700 (PDT)
X-Received: by 10.70.49.138 with SMTP id u10mr4969555pdn.6.1411171318339; Fri,
 19 Sep 2014 17:01:58 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Fri, 19 Sep 2014 17:01:58 -0700 (PDT)
In-Reply-To: <xmqqoaubmpvh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257310>

On Fri, Sep 19, 2014 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Fri, Sep 19, 2014 at 11:39 AM, Jeff King <peff@peff.net> wrote:
>>> On Fri, Sep 19, 2014 at 09:39:45AM +0200, Scott Chacon wrote:
>>>> Currently if you try to merge notes, the notes code ensures that the
>>>> reference is under the 'refs/notes' namespace. In order to do any sort
>>>> of collaborative workflow, this doesn't work well as you can't easily
>>>> have local notes refs seperate from remote notes refs.
>>>>
>>>> This patch changes the expand_notes_ref function to check for simply a
>>>> leading refs/ instead of refs/notes to check if we're being passed an
>>>> expanded notes reference. This would allow us to set up
>>>> refs/remotes-notes or otherwise keep mergeable notes references outside
>>>> of what would be contained in the notes push refspec.
>>>
>>> I think this change affects not just "git notes merge", but all of the
>>> notes lookups (including just "git notes show")....
>> ...
>> Additionally, I suggest adding another test demonstrating your use
>> case as well. Something like setting up a small scenario for notes
>> collaboration, and walking through the various steps:
>>
>>  - Creating a couple of repos where notes are added/edited
>>  - Setting up config to allow pushing and/or fetching notes
>>  - Performing the push/fetch
>>  - Merging with the corresponding local notes ref
>
> Is it our future direction to set up refs/remote-notes/<remote>/
> namespace?  If so, let's not do it piecemeail in an unorganized
> guerrilla fashion by starting with a stealth enabler with an
> associated test.  We risk not following through and leave the
> resulting user experience more puzzling if we go that way.
>
> By "stealth enabler" I mean the removal of refs/notes/ restriction
> that was originally done as a safety measure to avoid mistakes of
> storing notes outside.  The refs/remote-notes/ future direction
> declares that it is no longer a mistake to store notes outside
> refs/notes/, but that does not necessarily have to mean that
> anywhere under refs/ is fine.  It may make more sense to be explicit
> with the code touched here to allow traditional refs/notes/ and the
> new hierarchy only.  That way, we will still keep the "avoid
> mistakes" safety and enable the new layout at the same time.
>
> The most important first step for that to happen is to make sure we
> are on the same page on that future direction.  I personally think
> refs/remote-notes/<remote> that runs parallel to the remote tracking
> branch hierarchy refs/remotes/<remote> is a reasonable way to do
> this, but my words are no way final.

This has been discussed several times in the past, and - as I have
argued before - I believe Git would benefit from a more thorough
revamp of the ref namespace, one that would allow a straightforward
naming of _any_ kind of remote-tracking ref (heads, tags, notes,
whatever). The scheme I have proposed would map refs/<kind>/<name>
from a remote repo to a remote-tracking
refs/remotes/<remote>/<kind>/<name> in the local repo.

Having said that, I have clearly failed to find the time and
motivation to follow through on this topic, and although there was
some support for the idea, nobody else has stepped up to tackle it.
Unfortunately, that has left "git notes" in a sorry state when it
comes to sharing and collaboration. This has to stop. Fixing notes
sharing is much more important than whatever lofty ideas I might
have about how things should "ideally" be organized.

Therefore, you can count me in support of organizing remote-tracking
notes refs under refs/remote-notes/<remote>/<name>. In case of a more
thorough redesign of the ref namespace at some point in the future,
we will have to deal with a lot of "legacy" anyway, and adding
refs/remote-notes/<remote> will not considerably increase that
burden.

> Assuming that this is we all agree to go in that direction, let's
> make a list of things to be done to codify it, and do them.  For a
> starter, I think these are needed, perhaps?
>
>  - This patch (or an enhancement to keep some safety)
>
>  - Documentation updates to "git notes"
>
>  - Documentation updates to Documentation/gitrepository-layout.txt
>
>  - Update to "git clone" and "git remote add" to add a fetch refspec
>    refs/notes:refs/remote-refs/<remote>/*
>
>  - New tests you suggest

Sounds good to me. At least that would get us to the point where a
simple "git fetch" will also fetch notes updates, and you can then
choose to "git notes merge" them into your corresponding local notes
refs.

In addition to that we might want to consider streamlining things
further by having a single command (like "git pull") that performs
both fetching and merging. A complication here is that - unlike the
branch realm where HEAD points to our "current" branch - there is
not really a concept of a "current" notes ref, which could specify
_which_ remote-notes ref to merge and/or the parameters of that
merge. However, (as usual) I'm getting ahead of myself here. The
points you list above go more than halfway to making notes sharing
straightforward, and are in any case necessary prerequisites for
whatever might follow.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
