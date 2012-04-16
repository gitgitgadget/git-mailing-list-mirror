From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Mon, 16 Apr 2012 10:58:21 -0400
Message-ID: <4F8C338D.1050805@xiplink.com>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com> <20120413211350.GD7919@sigill.intra.peff.net> <20120413215316.GA19826@burratino> <7vy5pz1cjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 16:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnNF-00035v-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 16:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab2DPO5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 10:57:45 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:48349 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab2DPO5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 10:57:44 -0400
X-Greylist: delayed 1901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2012 10:57:44 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id B7EF619047C;
	Mon, 16 Apr 2012 10:57:43 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5D89B19037A;
	Mon, 16 Apr 2012 10:57:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7vy5pz1cjk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195640>

On 12-04-13 06:39 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Jeff King wrote:
>>
>>> Hmm. The ref->name we are comparing here is the local side. So if I am
>>> fetching a new branch "foo" from the remote into a local
>>> "refs/remotes/origin/foo" tracking ref, it used to say:
>>>
>>>     From ../parent
>>>      * [new branch]      master     -> origin/master
>>>
>>> Now it says:
>>>
>>>     From ../parent
>>>      * [new ref]         master     -> origin/master
>>>
>>> while refs/remotes/* are not technically branches in our side, I think
>>> from the user's perspective, it is true that we have fetched a branch.
>>> Should we be calling refs/remotes/* branches, too? Should we be checking
>>> the remote's name for the item instead of the local one?
>>
>> The former sounds sensible.  Then once the default refspec learns to
>> fetch into separate refs/remotes/origin/heads/* and
>> refs/remotes/origin/notes/* namespaces the logic could be updated to
>> write [new branch] or [new note collection] according to the
>> situation.
> 
> If we give 'new branch' label for this case because we store it in our
> 'refs/remotes/*', a natural extension of it would be to redefine the rule
> to narrow it to 'refs/remotes/*/heads/*' for using 'branch' when we
> introduce 'new notes collection' label to give refs we are going to store
> in 'refs/remotes/origin/notes/*'.  That is consistent with the former.
> 
> If we give 'new branch' label because refs/heads/master on the originating
> end is what is shown on the line, a natural extension would be to use 'new
> notes collection' label when we are fetching from refs/notes/* on the
> originating end, and it does not matter where we store it, either our own
> refs/notes/* or refs/remotes/origin/notes/*.  That is consistent with the
> latter.
> 
> There is no concensus if refs/remotes/origin/notes/* hierarchy is a good
> idea or not, but your argument does not support either side between the
> former or the latter anyway, so I think it is irrelevant point to raise in
> this discussion.
> 
> The choice between the two really depends on what information we are
> trying to convey with this label.  Are we saying "Hey, we now have a new
> 'branch' on our side"?  Or are we saying "We found a new 'branch' over
> there"?  It is unclear and you can argue both ways. Although I personally
> think it is the latter, I do not have a strong opinion either way.

I think git should describe what it finds in the remote repo, because as a
published repo it's refs are more likely to follow the standard layout.

The local repo is more likely to be configured with a fetch refspec like
	+refs/heads/*:refs/crazy/*
In such a case there's no point in keying off of the local names.

Git is better off describing what's appeared in the remote repo, and not
worrying about describing how the user might've mapped those things to local
refs.

(That said, patching fetch.c to do that is a bit beyond me at the moment.
Where would I find the remote's name for the ref?)

> I am actually fine with just saying '[new]' without indicating what kind
> at all, because the label is there only to fill the space where old..new
> object names are usually shown.  We don't even say "[rejected branch]",
> just "[rejected]" in the same place.

I'd be disappointed if git didn't take the extra step to tell me a bit more
about what's going on.  I like to see what kinds of new refs the remote has.

		M.
