From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Tue, 27 Jan 2015 18:35:41 +0100
Message-ID: <54C7CC6D.80906@web.de>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>	<CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>	<xmqqegqlnelu.fsf@gitster.dls.corp.google.com>	<CAGXKyzEPWrbRFOhvCBm=2Z50zso85G50z-nLd_wyzyeEADQSmw@mail.gmail.com>	<xmqqa916nq4p.fsf@gitster.dls.corp.google.com>	<CAGXKyzEYVsz-nRs52pTKo+6JLBiO9daU_C3qev3H43=Vzuygiw@mail.gmail.com> <xmqqtwzem776.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?ISO-8859-15?Q?Nguye=5E=7En_Th=E1i_Ngo=2Ec?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGA3N-0001HO-1a
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 18:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbbA0Rft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 12:35:49 -0500
Received: from mout.web.de ([212.227.15.14]:62936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbA0Rfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 12:35:48 -0500
Received: from [192.168.178.41] ([79.211.105.105]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Mbdf3-1Xx7CO22YH-00J5X3; Tue, 27 Jan 2015 18:35:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqtwzem776.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:i5PD5o5sMOtBcJlXFIhPB0yDq7wZ2solPq/oOZ6aobsbLgSE533
 QXZgjs5pb3Th/iO0r4Gzfn8DffOBJq59aEPEwj/B3y7Y5CGc+Z65E7ySXJnmUIpF3eH8jNG
 LmKJuR7udd34MCaA2IfbN2d+0IRAIyf1Uiw+nD5SIe/Pj4Z5cBbFDwUSh0QYA0lYSjXJafG
 s6N8twhL89mevpSCJOdEA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263080>

Am 26.01.2015 um 06:39 schrieb Junio C Hamano:
> Craig Silverstein <csilvers@khanacademy.org> writes:
>
>> This patch, in adding submodule support, I expect would be
>> similarly useful to people even though it, also, imposes those
>> same constraints to the submodule's config files.
>
> I would expect that you would see exactly the same issue with Duy's
> multiple work tree series.  This is not limited to new-workdir.
>
> The right way to look at this is to fix what "git submodule" does;
> its use of "config" that is shared across branches is the root cause
> of the trouble.  No other part of Git keeps data that needs to be
> per-branch (or more specifically "tied to the working tree state")
> in .git/config in such a way that leaving it stale when the working
> tree state changes breaks the system.

I'm not sure what submodule config shared across branches you are
referring to here, the only two things that submodules by default
store in .git/config are the url (to mark the submodule initialized)
and the update setting (which I believe should be copied there in
the first place, but changing that in a correct and backwards
compatible would take some effort). This means you'll init (or
deinit) a submodule in all multiple worktrees at the same time, but
having the url setting in .git/config is a feature, not a bug.

And if you are talking about the core.worktree setting in
.git/modules/<submodule_name>/config, I proposed way to get rid of
that when we moved the submodule .git directory there (but that
wasn't accepted):

    http://permalink.gmane.org/gmane.comp.version-control.git/188007

Additionally I suspect submodules are just the first to suffer,
other worktree specific config (like e.g. EOL settings) affecting
all multiple worktrees at the same time when changed in a single
worktree might easily confuse other users too.

> One way to do so might be to move the bits it stores in the config
> file to somewhere else that is more closely tied to the checkout
> state and handle that similar to .git/index and .git/HEAD when it
> comes to multiple work-trees.

Yup, the idea of separating config entries into worktree and repo
specific files sounds like the solution for these problems.
