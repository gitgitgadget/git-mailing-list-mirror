From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Adding push configuration to .git/config
Date: Thu, 22 Nov 2007 08:08:35 +0100
Message-ID: <C297CFC3-8DD0-4EEE-8FD3-BF997F6E269A@zib.de>
References: <20071121105517.GA11875@denkbrett.schottelius.org> <7vabp79hjt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:09:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6BS-00032t-4Z
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXKVHIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbXKVHIu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:08:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:55967 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbXKVHIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 02:08:50 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAM77Mqr000153;
	Thu, 22 Nov 2007 08:07:22 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1bcfd.pool.einsundeins.de [77.177.188.253])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAM77Li8028072
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 08:07:21 +0100 (MET)
In-Reply-To: <7vabp79hjt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65743>


On Nov 22, 2007, at 2:48 AM, Junio C Hamano wrote:

> Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
> writes:
>
>> Nice would be
>>
>> [branch "master"]
>>    remote-push          = origin
>>    remote-push-merge    = another_branch
>>
>> And thus perhaps also changing the existing specs:
>>
>>    remote = ... to remote-fetch = ...
>>    merge = ... to remote-fetch-merge =
>
> I do not think doing this is worth it, not because I think a
> single branch.$name.remote should be good enough for everybody,
> but because once you need a separate remote each for fetching
> and pushing, there is no reason to say one per direction is
> enough.
>
> An alternative could be to split [remote "name"] url into two
> variants, fetch-url and push-url.  While fetching by default
> from two places without telling from which one does not make any
> sense, pushing by default to two different places is quite a
> normal thing to do, and we already do support more than one url
> entries in [remote "name"] section used for pushing.
>
> If we were to do this, it might also make sense to rename the
> word 'origin' we use for the default remote name to 'default' or
> something.  People with shared repository workflow would fetch
> from one repository and push back to the same repository, so the
> distinction would not matter, but for others who need something
> like you suggest, the default repository for fetching and
> pushing are different, and while you may still consider where
> you fetch from your 'origin', where you push into is not your
> 'origin' anymore.

I like this idea.

But in addition, we should have a branch.$name.push line that
can contain a remote head to push to.  This can be used to
manage push's default on a per-branch basis.  So, different
branches can have different default refspecs, even when they
refer to the same remote.

The default remote of "git push" is either origin, or it is
specified in the branch configuration.  The following rules
would then be used to find the refspecs to push.  The first
rule that matches wins:
1) Command line overrides (e.g. "--all", "--current").
2) Check if branch.$name.push entry is available.
    (Would we allow multiple entries?)
3) Check if remote.$remotename.push entries are available.
4) Use default rule, which pushes matching branches.

	Steffen
