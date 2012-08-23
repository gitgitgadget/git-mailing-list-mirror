From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 23:09:27 +0100
Organization: OPDS
Message-ID: <40BA082AE16542A8B5E1F83167322A1B@PhilipOakley>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <20120823092624.GG6963@sigill.intra.peff.net> <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley> <20120823195648.GB15268@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <mhagger@alum.mit.edu>, "Junio C Hamano" <gitster@pobox.com>,
	<git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 00:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4fb8-0007KI-JN
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 00:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab2HWWJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 18:09:10 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:53680 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653Ab2HWWJH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 18:09:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuYKAMmoNlBZ8ryP/2dsb2JhbABFhgGFP64OBAEDeYEIghsFAQEEAQgBARkVHgEBFA0LAgMFAgEDDgYBAQICAgUhAgIUAQQaBgcXBhMIAgECAwGHdgqmapMjgSGJZxQBDXCEbTJgA41ckSaGZoJkgVcB
X-IronPort-AV: E=Sophos;i="4.80,301,1344207600"; 
   d="scan'208";a="401763273"
Received: from host-89-242-188-143.as13285.net (HELO PhilipOakley) ([89.242.188.143])
  by out1.ip01ir2.opaltelecom.net with SMTP; 23 Aug 2012 23:09:05 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204176>

From: "Jeff King" <peff@peff.net>
Sent: Thursday, August 23, 2012 8:56 PM
> On Thu, Aug 23, 2012 at 08:13:29PM +0100, Philip Oakley wrote:
>
>> >>I'm still suspicious about the logic related to args.fetch_all and
>> >>args.depth, but I don't think I've made anything worse.
>> >
>> >I think the point of that is that when doing "git fetch-pack --all
>> >--depth=1", the meaning of "--all" is changed from "all refs" to
>> >"everything but tags".
>> >
>>
>> There is a comment in \git\Documentation\technical\shallow.txt that
>> "- If you deepen a history, you'd want to get the tags of the
>>  newly stored (but older!) commits. This does not work right now."
>> which may be the source of this restriction. That is, how is the 
>> depth
>> of the tag fetching to be restricted to the requested depth count?
>> [assuming I've undestood the problem correctly]
>
> I don't think this is about deepening, but rather about making sure we
> remain shallow for the initial fetch. Remember that this is on the
> "fetch-pack --all" code path, which used to be used by "git clone" 
> when
> it was a shell script (these days, clone is a C builtin and will
> actually feed the list of refs to fetch-pack).

OK

>
> This code blames back to:
>
> commit 4bcb310c2539b66d535e87508d1b7a90fe29c083
> Author: Alexandre Julliard <julliard@winehq.org>
> Date:   Fri Nov 24 16:00:13 2006 +0100
>
>    fetch-pack: Do not fetch tags for shallow clones.
>
>    A better fix may be to only fetch tags that point to commits that 
> we
>    are downloading, but git-clone doesn't have support for following
>    tags. This will happen automatically on the next git-fetch though.
>
> So it is about making sure that "git clone --depth=1" does not
> accidentally pull a single commit from v1.0, v1.1, v1.2, and so forth,
> losing the purpose of using --depth in the first place. These days it 
> is
> largely irrelevant, since this code path is not followed by clone, and
> clone will automatically restrict its list of fetched refs to a single
> branch if --depth is used.
>
> The bug that shallow.txt talks about (and which is mentioned in that
> commit message) is that we will not properly auto-follow tags during
> such a clone (i.e., when we fetch a tag because it is pointing to a
> commit that we already have or are already pulling). I'm not sure if
> that is still the case or not. But assuming your workflow is something
> like:
>
>  [make an initial, cheap clone]
>  git clone --depth=1 $repo
>
>  [the next day, you do a regular fetch, which will just get new stuff
>   on top of what you already have]
>  git fetch
>
> Then that second fetch will auto-follow the tags, anyway. And that is
> what the commit message is pointing: it's a bug, but one you can work
> around.

I hadn't appreciated that the fetch would limit itself to the original 
shallow
depth. I'd gained  the impression that one need to use the --depth to
control what was being fetched.

>
>> It may be (?) that it is a good time to think about a 'datedepth'
>> capability to bypass the current counted-depth shallow fetch that can
>> cause so much trouble. With a date limited depth the relevant tags
>> could also be fetched.
>
> I don't have anything against such an idea, but I think it is 
> orthogonal
> to the issue being discussed here.
OK. I'll stick it on my slow-burner pile ;-)

>
> -Peff
