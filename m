From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Thu, 13 Nov 2014 09:50:24 +0100
Message-ID: <546470D0.3080809@kdbg.org>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com> <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net> <5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 09:50:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoq6s-0001eg-ND
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 09:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbaKMIu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 03:50:29 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:46510 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932070AbaKMIu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 03:50:28 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jdc2n5DJ9z5tlP;
	Thu, 13 Nov 2014 09:50:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20141112215923.GB6801@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.11.2014 22:59, schrieb Jeff King:
> On Wed, Nov 12, 2014 at 09:20:22PM +0100, Johannes Sixt wrote:
>
>> Am 09.11.2014 um 02:59 schrieb Jeff King:
>>>   test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
>>> -	test_when_finished "git branch -d a || git branch -d a/b" &&
>>> +	test_when_finished "git branch -d one || git branch -d one/two" &&
>>>
>>> -	git branch a/b master &&
>>> -	echo "a/b@{0} branch: Created from master" >expect &&
>>> -	git log -g --format="%gd %gs" a/b >actual &&
>>> +	git branch one/two master &&
>>> +	echo "one/two@{0} branch: Created from master" >expect &&
>>> +	git log -g --format="%gd %gs" one/two >actual &&
>>>   	test_cmp expect actual &&
>>> -	git branch -d a/b &&
>>> +	git branch -d one/two &&
>>>
>>> -	# same as before, but we only create a reflog for "a" if
>>> +	# same as before, but we only create a reflog for "one" if
>>>   	# it already exists, which it does not
>>> -	git -c core.logallrefupdates=false branch a master &&
>>> +	git -c core.logallrefupdates=false branch one master &&
>>>   	: >expect &&
>>> -	git log -g --format="%gd %gs" a >actual &&
>>> +	git log -g --format="%gd %gs" one >actual &&
>>>   	test_cmp expect actual
>>>   '
>>>
>>
>> On Linux I observe
>>
>> Deleted branch one/two (was b60a214).
>> warning: unable to unlink .git/logs/refs/heads/one: Is a directory
>> Deleted branch one (was b60a214).
>> ok 15 - stale dirs do not cause d/f conflicts (reflogs off)
>>
>> (notice the warning)
>
> Yes, this is expected. The warning actually comes from the "git branch
> -d" run during cleanup. Branch "one" exists but has no reflog. Instead
> there is a crufty dir call "logs/refs/heads/one". The deletion process
> blindly calls "unlink" on it and complains when it fails for reasons
> other than ENOENT.
>
> We could suppress that warning, but I didn't think it was really worth
> the bother. This is such a funny setup (reflogs on, then off, then on,
> _and_ a d/f conflict in the branches) that I doubt it will come up much.
>
> I seem to recall that ancient versions of SunOS used to do bad things
> when you called "unlink" on a directory, but I do not know if that is
> still the case (I also would doubt this is the only place in git where
> we blindly do an "unlink if you can" without actually checking the file.
>
>> but on Windows the test fails with
>>
>> Deleted branch one/two (was b60a214).
>> error: Unable to append to .git/logs/refs/heads/one: Permission denied
>> fatal: Cannot update the ref 'refs/heads/one'.
>> not ok 15 - stale dirs do not cause d/f conflicts (reflogs off)
>
> That looks more like it is failing the actual test (i.e., the creation
> of branch "one" when there is cruft in the reflog). My guess is that
> calling open() on a directory is giving us EACCES instead of EISDIR. Can
> you verify that?
>
> If that is the case, then this isn't a new breakage, I think, but just
> code we weren't previously exercising. It would be interesting to know
> whether:
>
>    git config core.logallrefupdates true
>    git branch one/two
>    git branch -d one/two
>    git branch one
>
> works (even without my patch). If so, then there's probably something
> else going on.

Don't know what you mean with "my patch" (the one I was responding to 
touches only t1410). But the sequence works as expected with a version 
built in September:

C:\Temp\gittest>git init
Initialized empty Git repository in C:/Temp/gittest/.git/

C:\Temp\gittest>git commit --allow-empty -m init
[master (root-commit) 2e78994] init

C:\Temp\gittest>git branch one/two

C:\Temp\gittest>git branch -d one/two
Deleted branch one/two (was 2e78994).

C:\Temp\gittest>git branch one

C:\Temp\gittest>git version
git version 2.1.0.rc2.1268.g12ef091

> The relevant bits are in log_ref_setup. We try to open() once, and
> accept EISDIR as a hint that we may need to remove an empty directory
> and try again. If Windows gives us EACCES, then we may need to have that
> trigger the same code.

Thanks, that is a starting point.

-- Hannes
