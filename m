From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 17:43:03 -0400
Message-ID: <4FE0F267.5070803@xiplink.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com> <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com> <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com> <7vipen191a.fsf@alter.siamese.dyndns.org> <20120619201259.GB14692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:43:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Ch-0001Ap-5y
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab2FSVnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 17:43:08 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:49185 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab2FSVnF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 17:43:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 4E3122000E0;
	Tue, 19 Jun 2012 17:43:04 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id BD77F2000AF;
	Tue, 19 Jun 2012 17:43:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120619201259.GB14692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200252>

On 12-06-19 04:12 PM, Jeff King wrote:
> On Tue, Jun 19, 2012 at 10:55:13AM -0700, Junio C Hamano wrote:
> 
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>>
>>> On 12-06-18 06:12 PM, Junio C Hamano wrote:
>>> ...
>>>> That reliance of "origin" is what made me think that "not guessing
>>>> and blindly assuming" a wrong thing to do.
>>>
>>> I think git can do better than erroring out, though.
>>>
>>>> It is OK that your build usesdetached HEAD, but if that is the case
>>>> shoudln't it be the one deciding which specific remote it wants to
>>>> take the updated sources from, and telling Git to do so?
>>>
>>> Sure, but I feel it did that already when it cloned.  It seems reasonable for
>>> the submodules to default to using the remote specified when the super-repo
>>> was cloned.
>>
>> I do not have a strong opinion either way, other than that I would
>> prefer predictable behaviour over "works most of the time provided
>> if the user does X, otherwise does this random thing".  And coming
>> from that standpoint, erroring out when there needs a guess involved
>> is certainly more predictable---it is a cop-out option for me in
>> areas of the system I do not have strong preferences.
> 
> One thing that makes me nervous about this patch is that it is not just a
> change to git-submodule, but rather to git-parse-remote.  So it could
> affect other parts of the system, too, where a guess might not be as
> desirable.
> 
> The number of affected code paths is fortunately quite small, since this
> is updating the shell library, and most of the remote-handling code is
> written in C these days. But it raises a few questions:
> 
>   1. git-pull can call into get_default_remote via get_remote_merge_branch.
>      Is it impacted by this change?

I imagine it is.

>   2. We install git-parse-remote as part of the plumbing API. Do we know
>      of any other 3rd-party scripts that use this interface and might be
>      affected?

I certainly don't know of any.

>   3. The C code sets up remote.c:default_remote_name, which defaults to
>      "origin". Should this be consistent with what git-parse-remote
>      does?

Yes, I think it should.

I think you're raising some good points, but I'm not in a good position to
evaluate the impacts on git-pull or 3rd-party apps.

I suggest git would be better off changing the way it finds the default
remote to:

	Use the currently checked-out branch's remote;
	or Use the remote specified in the original clone command[*];
	or use "origin".

[*] With some strong mechanism for identifying this remote.

I think this would make the default-remote concept work properly in more
cases, while still maintaining compatibility with current assumptions
(because folks who are happy with the arbitrary choice of "origin" probably
never used -o in their clone commands anyway).

I'd be fine with erroring-out (or just having no default remote) instead of
using "origin", but I suspect that would cause more headaches than it solves.

I'm happy to cobble together a patch, if we agree to move in this direction.

		M.
