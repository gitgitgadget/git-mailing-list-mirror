From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Merging submodules - best merge-base
Date: Sat, 09 Mar 2013 18:45:56 +0100
Message-ID: <513B7554.4020700@web.de>
References: <op.ws2l3rgnrbppqq@cicero.linkoping.osa> <20130306181156.GA4114@sandbox-ub> <op.wtklj7e9rbppqq@cicero.linkoping.osa> <20130307185906.GA9661@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Bratell <bratell@opera.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Mar 09 18:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UENr0-0000zp-NG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 18:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788Ab3CIRqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 12:46:09 -0500
Received: from mout.web.de ([212.227.15.4]:51131 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3CIRqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 12:46:07 -0500
Received: from [192.168.178.41] ([91.3.183.52]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MLP5m-1UDpsc08G2-000vwL; Sat, 09 Mar 2013 18:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130307185906.GA9661@sandbox-ub.fritz.box>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:Q1DT+cXEa4UP63+SwPOscRE1ZWGX86I2taWIqMI+h1L
 TLtrhpa/DJjY/+657GrNGsfIxALDPPYordKNG/yvgRRhnKymza
 uvLE2dBOVGWl3CB5Zca/IUC6esOKqWjp7onj2BhzakcYdOX3mC
 bDYUKUus5i7H2R6P+aGKQA6V0uA9FQod9gShQHfzJPM1pcFeoG
 HIz/+An8m32FXEZf1RakQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217732>

Am 07.03.2013 19:59, schrieb Heiko Voigt:
> On Thu, Mar 07, 2013 at 10:49:09AM +0100, Daniel Bratell wrote:
>> Den 2013-03-06 19:12:05 skrev Heiko Voigt <hvoigt@hvoigt.net>:
>>
>>> On Mon, Feb 25, 2013 at 05:44:05PM +0100, Daniel Bratell wrote:
>>>> A submodule change can be merged, but only if the merge is a
>>>> "fast-forward" which I think is a fair demand, but currently it
>>>> checks if
>>>> it's a fast-forward from a commit that might not be very interesting
>>>> anymore.
>>>>
>>>> If two branches A and B split at a point when they used submodule commit
>>>> S1 (based on S), and both then switched to S2 (also based on S)
>>>> and B then
>>>> switched to S21, then it's today not possible to merge B into A, despite
>>>> S21 being a descendant of S2 and you get a conflict and this warning:
>>>>
>>>> warning: Failed to merge submodule S (commits don't follow merge-base)
>>>>
>>>> (attempt at ASCII gfx:
>>>>
>>>> Submodule tree:
>>>>
>>>> S ---- S1
>>>>   \
>>>>    \ - S2 -- S21
>>>>
>>>> Main tree:
>>>>
>>>> A' (uses S1) --- A (uses S2)
>>>>   \
>>>>    \ --- B' (uses S2) -- B (uses S21)
>>>>
>>>>
>>>> I would like it to end up as:
>>>>
>>>> A' (uses S1) --- A (uses S2) ------------ A+ (uses S21)
>>>>   \                                     /
>>>>    \ --- B' (uses S2) -- B (uses S21)- /
>>>>
>>>> And that should be legal since S21 is a descendant of S2.
>>>
>>> So to summarize what you are requesting: You want a submodule merge be
>>> two way in the view of the superproject and calculate the merge base
>>> in the submodule from the two commits that are going to be merged?
>>>
>>> It currently sounds logical but I have to think about it further and
>>> whether that might break other use cases.
>>
>> Maybe both could be legal even. The current code can't be all wrong,
>> and this case also seems to be straightforward.
> 
> Ok I have thought about it further and I did not come up with a simple
> (and stable) enough strategy that would allow your use case to merge
> cleanly without user interaction.
> 
> The problem is that your are actually doing a rewind from base to both
> tips. The fact that a rewind is there makes git suspicious and we simply
> give up. IMO, thats the right thing to do in such a situation.
> 
> What should a merge strategy do? It infers from two changes what the
> final intention might be. For submodules we can do that when the changes
> on both sides point forward. Since thats the typical progress of
> development. If not there is some reason for it we do not know about. So
> the merge gives up.
> 
> Please see this post about why we need to forbid rewinds from the
> initial design discussion:
> 
> http://article.gmane.org/gmane.comp.version-control.git/149003

I agree that rewinds are a very good reason not merge two branches using
a fast-forward strategy, but I believe Daniel's use case is a (and maybe
the only) valid exception to that rule: both branches contain *exactly*
the same rewind. In that case I don't see any problem to just do a fast
forward to S21, as both agree on the commits to rewind.
