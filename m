From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Thu, 23 Apr 2015 00:32:43 +0200
Message-ID: <5538218B.4010400@web.de>
References: <55300D2C.9030903@web.de>	<1429319946-19890-1-git-send-email-pclouds@gmail.com>	<5533A567.7070301@web.de>	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>	<xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>	<CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>	<xmqq8udlgpey.fsf@gitster.dls.corp.google.com>	<5537F31D.4090704@web.de> <xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:33:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl3CX-0002Zm-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 00:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934369AbbDVWc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 18:32:58 -0400
Received: from mout.web.de ([212.227.15.14]:65222 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766AbbDVWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 18:32:56 -0400
Received: from [192.168.178.41] ([79.211.126.117]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M40na-1ZcbaX2oOw-00raoh; Thu, 23 Apr 2015 00:32:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:V04BR31XMDcST0JQbSHFQvvX/JfDu8OqwzRcila+3zWS4wRCsHO
 91ludrGKMOc3RA2lkiQJoWYXa6XqGwkvLPYzBqgwmjROmqHpXB7Ki00HXc4Fsbubmxuf7o6
 yIc+O23lvOzWpIRbRspq2ZnuM1bBPFmmLKzDnEv0+Ct+rWPw6B0mwCQHFD/+31S4uU2o0qf
 bFnuOiH7eWK0YDGdfE/Xg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267650>

Am 22.04.2015 um 21:58 schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> Am 21.04.2015 um 23:08 schrieb Junio C Hamano:
>>
>>> I looked at the test script update.  The new test does (I am
>>> rephrasing to make it clearer):
>>>
>>>       mkdir -p dir/ectory
>>>       git init dir/ectory ;# a new directory inside top-level project
>>>       (
>>>           cd dir/ectory &&
>>>           >test && git add test && git commit -m test
>>>       )
>>>       git add dir/ectory
>>>
>>> to set it up.  At this point, the top-level index knows dir/ectory
>>> is a submodule.
>>>
>>> Then the test goes on to turn it a non submodule by
>>>
>>>       mv dir/ectory/.git dir/ectory/dotgit
>>> ...
>>
>> We already do (2) in the cases you describe:
>>
>>     $ git add subrepo/a
>>     fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
>>     $ git -C subrepo add a
>>     fatal: Pathspec 'a' is in submodule 'subrepo'
>> ...
>> So I'd vote to have (2) also for "git -C subrepo add .", which
>> is what started this thread.
>
> Does having "mv subrepo/.git subrepo/dotgit" before that "git add"
> change your conclusion?
>
> It is very clear to me that without that "mv" step, (2) is
> absolutely the right thing to do, and I agree with you.

Huh? Without that mv all files would simply be added to the
submodule repo and this would be a non-issue ... what am I
missing? I'm just advocating to let "git add ." in a submodule
without a .git behave like "git add <file>" already does.

> But it is unclear if we should still do (2) when "subrepo/.git" is
> no longer there.  That has to be done manually and it may be an
> indication that is clear enough that the end user wants the
> directory to be a normal directory without any submodule involved,
> in which case it may match the expectation of the user better to
> just nuke the corresponding 160000 entry in the index and replace it
> with files in there.  I dunno.

The user having removed subrepo/.git is just one reason for that.
Another is a user adding a file in an unpopulated work tree of a
not initialized submodule. I doubt that simply nuking the 160000
entry would be the right thing to do in this case, I expect this
to be a pilot error we should barf about ;-)
