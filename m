From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:45:54 -0500
Message-ID: <4D594E32.3090208@xiplink.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <m3mxm28v3i.fsf@localhost.localdomain> <201102140036.42197.johan@herland.net> <201102141040.35819.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 16:45:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp0cP-0008QR-6b
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab1BNPpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:45:36 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:49500 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1BNPpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 10:45:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp48.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id A2D581686A6;
	Mon, 14 Feb 2011 10:45:34 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp48.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 33A02168657;
	Mon, 14 Feb 2011 10:45:34 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <201102141040.35819.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166729>

On 11-02-14 04:40 AM, Jakub Narebski wrote:
> On Mon, 14 Feb 2011, Johan Herland wrote:
>> On Friday 11 February 2011, Jakub Narebski wrote:
>>> Johan Herland <johan@herland.net> writes:
> 
>>>> - Lack of consistency in the ref namespace (refs/remotes/$remote/* vs.
>>>> refs/tags/*). Also not clear from the current layout where to add new
>>>> types of refs (e.g. notes, replace). My proposal tries to address this
>>>> issue.
>>>
>>> The lack of consistency is there because tags should USUALLY be global
>>> (there should be only one v1.7.4), while branch names should be local
>>> (my 'master' branch is not your 'master' branch).
>>>
>>> In some cases, like joining or subtree-merging unrelated projects we
>>> would want local / per-remote tags: 'v1.7.4' in main project is not
>>> 'v1.7.4' in 'foo' subproject (in 'foo' remote).  Currently we lack a
>>> way to specify that (the 'autofollow' refspec proposal, default
>>> behaviour would be equivalent to '~refs/tags/*:refs/tags/*"), and lack
>>> support from porcelain: MY PROPOSAL is to add '--use-separate-tags'
>>> (like old '--use-separate-remote') to "git clone" and "git remote add",
>>> and perhaps '--alternate' as equivalent to '--no-separate-tags' to
>>> "git remote add".
>>
>> That requires you to know about the (potential) tag collision (and remember 
>> to use your option) before fetching from the remote repo.
> 
> No, what you need to know at te point of adding remote with "git remote add"
> is to know whether the repository is alternative / extra repository of the
> same project (common tags), or whether it is separate project (separate
> tags).
> 
> Which you should know at this point.
>  
>> Also, even with your added option - which we can use when interfacing 
>> unrelated projects from a single repo - the expectation (common case) is 
>> still that Git will pollute your local tag namespace with remote tags. Some 
>> of us consider this a bug/misfeature in its own right. And we hold that 
>> opinion while still agreeing with you that tags "should USUALLY be global".
> 
> I don't think the distinction is between local and per-remote tags.  It
> is about local (your own) bookmarking tags versus global repository tags
> (_not_ per-remote) for marking releases.
> 
> I guess that current layout might be not best, but per-remote tags isn't it
> either, in my opinion.
> 
> 
> Please consider this use case:
> 
> Let's assume that current maintainer steps aside for a bit, and new interim
> temporary maintainer takes mantle.  One would add new remote _temporarily_,
> but one would want for tags that temporary maintainer created to be as good
> as tags from 'origin' remote... and not be deleted when you remove temp
> remote and its remote-tracking branches.

I take it that "origin" here refers to the first maintainer's repository.

I suggest that the correct thing to do in this case is to change the URL of
the "origin" remote.  Because really that's what you want: the temp
maintainer's repo is the equivalent of the first maintainer's repo.  When the
first maintainer returns he'll update his own repo to match the temp
maintainer's, then everyone can switch their remotes back to the original
repo.  (Perhaps git-remote could even learn an "import-tags" subcommand to
help the original maintainer here.)

For me, having more than one remote be *simultaneously* authoritative for a
set of tags is the unusual case.  I find that most projects, no matter how
decentralized, need to agree upon the project's "official" history, and that
such agreement is almost always encapsulated within a single, "official"
repository.  To have more than one is, frankly, insane.

So to me it seems completely natural to think of a project's "official" tags
as the ones that are obtained from the project's "official" repository.  It
follows that tags should subscribe to the same remote-ref model as branches.
 The benefits are powerful: consistency; deals naturally with imported
histories from different repositories; and allows automatic propagation of
updated (i.e. moved) tags from remotes to clones (yes tags *should* never
move, but they do, often for good reason and occasionally as part of a
project's natural evolution).

There have been several comments disparaging per-remote tags, but people are
clearly dissatisfied with the status quo.  Can anyone propose another
alternative?

		M.
