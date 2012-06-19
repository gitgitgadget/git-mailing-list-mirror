From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 17:43:00 -0400
Message-ID: <4FE0F264.1040703@xiplink.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com> <4FE0D5D5.3020408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:43:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Cg-0001Ap-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab2FSVnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:43:04 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:33846 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab2FSVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:43:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 34AD82000C2;
	Tue, 19 Jun 2012 17:43:02 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DDA86200097;
	Tue, 19 Jun 2012 17:43:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <4FE0D5D5.3020408@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200253>

On 12-06-19 03:41 PM, Jens Lehmann wrote:
> Am 19.06.2012 16:07, schrieb Marc Branchaud:
>> On 12-06-18 06:12 PM, Junio C Hamano wrote:
>>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>>> That would be bad for our situation.  As I said, our automated build system
>>>> uses detached HEADs a lot.  Erroring-out in this case would break us.  It's
>>>> really only the near-ubiquity of the name "origin" that has kept things
>>>> working so far.
> 
> And the "submodule add" documentation clearly talks about relative
> submodule URLs being relative to the superproject's origin.

This whole thing seems a bit weird...

So user A adds a submodule with <repository> "../others/thing.git".  Clearly
user A has some remote in mind when they added this submodule.

But consider user B, who cloned the super-repo from the same remote that user
A had in mind when creating the submodule.  If user B then checks out a
non-tracking branch (or a branch that tracks a different remote) and then
tries to initialize/update the submodule, user B will get an error.

To me this is clearly wrong.  It's also wrong to error-out and expect the
user to fix it.  Should the user temporarily set their branch's remote to the
right place, initialize the submodule, then undo the branch setting?  Should
the user check our a branch that tracks the correct remote, initialize the
submodule, then check out their branch?  Both of those "solutions" look
pretty weak to me.

I'm starting to think that maybe "git submodule init" (and "update") should
learn a --remote option.  That way at least user B could tell git what to do.

> Your buildbot could also check if an origin is configured and use the
> magic in your patch to configure one to the URL of the first remote it
> finds if it isn't before initializing the submodules.

Yes, it seems my assumptions about how to determine the default remote
shouldn't be coded into git.  But dang it, the current fallback to "origin"
is really lame.

>>> That reliance of "origin" is what made me think that "not guessing
>>> and blindly assuming" a wrong thing to do.
>>
>> I think git can do better than erroring out, though.
> 
> Hmm, but guessing and using the first remote it finds (which might or
> might not be the one used in the initial clone) doesn't sound like a
> terribly good idea.

Fair enough, but I still think it's better than guessing that the right
remote is "origin".  :)

>> Sure, but I feel it did that already when it cloned.  It seems reasonable for
>> the submodules to default to using the remote specified when the super-repo
>> was cloned.
> 
> Is there a way to reliably tell that remote without relying e.g. on
> the implementation details of git config (e.g. it could sort remotes
> alphabetically some day)? What happens if someone changes the config
> later? A lot of ambiguity here ...

Yes, I agree.

Should there perhaps be some kind of "cloned from this remote" setting in the
config?

> And I think origin should always be the second choice if it exists,
> the first being the remote configured for the checked out branch.

Do you mean "the origin(al) remote repository" or just "the remote named
'origin'"?

> This gives the user the opportunity to say "Oh, I screwed up using
> 'git clone -o', let's set origin to the upstream repo". But should we
> try to guess the remote the superproject was cloned from as third
> option? I am not convinced.

Maybe I'm misinterpreting you.  Are you attaching a special meaning to a
remote named "origin"?

		M.
