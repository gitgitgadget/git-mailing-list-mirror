From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: msysgit: merge, stat
Date: Tue, 14 Aug 2007 23:03:54 +0200
Message-ID: <557AE5F5-E937-4CA8-9280-C33CB640B458@zib.de>
References: <2C573942-DD22-46EC-AE4A-1334450A7C4D@zib.de> <Pine.LNX.4.64.0708131743360.25989@racer.site> <7vzm0vfbw0.fsf@assigned-by-dhcp.cox.net> <AAF0E632-AC7D-49E0-A332-96F78EABB1F6@zib.de> <7vfy2nf67h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708141013540.25989@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 23:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL3Ya-0007dG-A6
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 23:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbXHNVDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 17:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758193AbXHNVDx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 17:03:53 -0400
Received: from mailer.zib.de ([130.73.108.11]:39963 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043AbXHNVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 17:03:52 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7EL3IWD008786;
	Tue, 14 Aug 2007 23:03:18 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db19c78.pool.einsundeins.de [77.177.156.120])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7EL38Cm006725
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 14 Aug 2007 23:03:17 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708141013540.25989@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55856>


On Aug 14, 2007, at 11:22 AM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 13 Aug 2007, Junio C Hamano wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>>> Wait a minute.
>>>>
>>>> What does the above "After a 'git merge'" exactly mean?  After a
>>>> successful automerge that made a commit, of stopped in the
>>>> middle because of conflicts?  I am getting an impression that
>>>> Steffen is talking about the former, but if that is the case,
>>>> somebody is seriously confused.
>>>
>>> Yes. I'm talking about a successful merge that made a commit.
>>>
>>>> When "merge-recursive" with a 3-way file level merge in core
>>>> writes the result out to the work tree, it uses a cache entry
>>>> that is stat clean (see merge-recursive.c::make_cache_entry(),
>>>> refresh option is passed and it calls refresh_cache_entry() to
>>>> obtain the cached stat bits).  The traditional "read-tree -m -u"
>>>> followed by merge-one-file of course runs "git update-index"
>>>> inside merge-one-file script and cleanly merged paths should be
>>>> stat clean after a merge.
>>>
>>> Well, they are not with msysgit. At least not all, or not always.
>>> I'm not completely sure about the details, but the problem
>>> happens frequently, near to always.
>>
>> Johannes, is this something you want me to look at?  I do not
>> know how much read-cache.c and other low level routines of
>> Windows version deviated from the mainline.
>
> I am reasonably sure that we did not deviate that much in lstat().  
> And in
> stat() we do not deviate at all; this is provided by mscrt.dll.
>
> Steffen, could you come up with a test script showing the behaviour  
> you
> described?  Then we could test where the problem comes from.

Not really.

If I run

--- snip ---
git init &&
echo 1 > a1 &&
git add a1 &&
git commit -m 1 a1 &&

git checkout -b A master &&
echo A > a1 &&
git commit -m A a1 &&

git checkout -b B master &&
echo B > b1 &&
git add b1 &&
git commit -m B b1 &&

git merge A &&
git diff
--- snip ---

it outputs

diff --git a/a1 b/a1

I planned to pack this into a test script. I started
with the following, which is not yet a full test script.

--- snip ---
#!/bin/sh

test_description='Test is work tree is clean after merge'
. ./test-lib.sh

test_expect_success 'sucessful merge should yield index in sync with  
work tree.' '
echo 1 > a1 &&
git add a1 &&
git commit -m 1 a1 &&

git checkout -b A master &&
echo A > a1 &&
git commit -m A a1 &&

git checkout -b B master &&
echo B > b1 &&
git add b1 &&
git commit -m B b1 &&

git merge A &&
git diff'

test_done
--- snip ---

But if I run the testscript with '-v', git diff doesn't
report anything. I can't tell you why.

	Steffen
