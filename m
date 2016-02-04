From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 4 Feb 2016 01:54:44 +0000
Message-ID: <56B2AF64.5020502@ramsayjones.plus.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1454443734.5545.1.camel@twopensource.com>
 <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrhjpzc.fsf@gitster.mtv.corp.google.com>
 <1454548352.5545.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:55:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR98N-0001N3-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 02:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbcBDBy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 20:54:56 -0500
Received: from avasout04.plus.net ([212.159.14.19]:55951 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbcBDByz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 20:54:55 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id E1up1s0044mu3xa011uqZ7; Thu, 04 Feb 2016 01:54:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ybZZDoGAAAAA:8 a=6NG_XSeZAAAA:8 a=DmIzO2TVmBvZGRyLrFwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1454548352.5545.2.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285391>



On 04/02/16 01:12, David Turner wrote:
> On Wed, 2016-02-03 at 16:09 -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> David Turner <dturner@twopensource.com> writes:
>>>
>>>> Are there any more reviews on this?  I do have some changes from
>>>> this
>>>> set, but they're pretty minor so I don't want to post a new one
>>>> (unless
>>>> folks would rather see those changes before reviewing).  Let me
>>>> know.
>>>
>>> Thanks for pinging.  As this is a rather wide-ranging topic, it was
>>> not practical to intergrate with the rest of the topics in flight
>>> back then, but now it seems that this needs only one topic that
>>> still is in flight.  I'll queue this on top of a merge between
>>> 'master' and the tip of 'sb/submodule-parallel-update' and include
>>> in the daily integration cycle to make it easy for people to view
>>> the changes in wider context as necessary.
>>
>> I've re-applied the patches to rebuild the topic; when merged to
>> 'pu' it seemed to break some tests, but I didn't look too deeply
>> into it.
> 
> They were working for me as-of the time I sent them.  I guess something
> must have broken since.  I'll rebase, test, and send a new series.

I didn't spend too long looking at it, but I think this interacts with
Jeff's patch a2d5156c ("resolve_gitlink_ref: ignore non-repository paths",
22-01-2016) which introduces the new test in 't3000-ls-files-others.sh'
which fails for me.

The change which Jeff made to resolve_gitlink_ref() is effectively side-stepped
by the call to check_submodule_backend() in the new resolve_gitlink_ref().
(Jeff's change is now in the 'files' backend version of resolve_gitlink_ref()).

In the debugger, when the die() breakpoint is taken, the bt looks like:

(gdb) bt
#0  die (err=err@entry=0x57b38a "Invalid gitfile format: %s") at usage.c:99
#1  0x000000000050db64 in read_gitfile_gently (
    path=0x7ee770 "not-a-submodule/.git", 
    return_error_code=return_error_code@entry=0x0) at setup.c:558
#2  0x00000000004dfce8 in do_submodule_path (buf=0x7fffffffd220, 
    path=0x7ee750 "not-a-submodule/", fmt=0x5771d0 "%s", 
    args=args@entry=0x7fffffffd138) at path.c:469
#3  0x00000000004e05c2 in strbuf_git_path_submodule (
    buf=buf@entry=0x7fffffffd220, path=path@entry=0x7ee750 "not-a-submodule/", 
    fmt=fmt@entry=0x5771d0 "%s") at path.c:503
#4  0x00000000004edfdc in check_submodule_backend (
    submodule=submodule@entry=0x7ee750 "not-a-submodule/") at refs.c:316
#5  0x00000000004f01c2 in resolve_gitlink_ref (
    path=0x7ee750 "not-a-submodule/", refname=0x565040 "HEAD", 
    sha1=0x7fffffffd2a0 "\n") at refs.c:1407
#6  0x00000000004b0a07 in treat_directory (simplify=0x0, exclude=0, baselen=0, 
    len=16, dirname=0x7ee750 "not-a-submodule/", untracked=0x0, 
    dir=0x7fffffffdc10) at dir.c:1305
#7  treat_one_path (dir=dir@entry=0x7fffffffdc10, 
    untracked=untracked@entry=0x0, path=path@entry=0x7fffffffd330, 
    baselen=baselen@entry=0, simplify=simplify@entry=0x0, dtype=4, 
    de=de@entry=0x7eef60) at dir.c:1489
#8  0x00000000004b027e in treat_path (simplify=0x0, baselen=0, 
    path=0x7fffffffd330, cdir=0x7fffffffd350, untracked=0x0, 
    dir=0x7fffffffdc10) at dir.c:1550
#9  read_directory_recursive (dir=dir@entry=0x7fffffffdc10, 
    base=base@entry=0x54744a "", baselen=baselen@entry=0, untracked=0x0, 
    check_only=check_only@entry=0, simplify=simplify@entry=0x0) at dir.c:1697
#10 0x00000000004b0b67 in read_directory (dir=dir@entry=0x7fffffffdc10, 
    path=0x54744a "", len=len@entry=0, 
    pathspec=pathspec@entry=0x7c83c0 <pathspec>) at dir.c:2023
---Type <return> to continue, or q <return> to quit---

Note that the error code return pointer is NULL in the call to
read_gitfile_gently(). Also, note the call frames #4 and #5.

I have to go now ... Hope that helps.

ATB,
Ramsay Jones
