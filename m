From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Tue, 1 Jan 2008 19:52:30 +0100
Message-ID: <0FFA1D0A-DB70-446C-9C43-A6FBAEFE7CA4@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> <7vsl2y90pm.fsf@gitster.siamese.dyndns.org> <52415F60-C080-4260-86CD-32A379482341@zib.de> <474552D6.5060305@viscovery.net> <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 19:52:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9mEC-0001IC-Sm
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 19:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbYAASwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 13:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYAASwM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 13:52:12 -0500
Received: from mailer.zib.de ([130.73.108.11]:62026 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbYAASwL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 13:52:11 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m01IpNZx017829;
	Tue, 1 Jan 2008 19:51:24 +0100 (CET)
Received: from [192.168.178.21] (brln-4db823e6.pool.einsundeins.de [77.184.35.230])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m01IpMR7005065
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 1 Jan 2008 19:51:22 +0100 (MET)
In-Reply-To: <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69441>

Eventually I found some time to investigate this issue ...


On Nov 22, 2007, at 6:56 PM, Steffen Prohaska wrote:

>
> On Nov 22, 2007, at 10:58 AM, Johannes Sixt wrote:
>
>> Steffen Prohaska schrieb:
>>> On Nov 22, 2007, at 8:52 AM, Junio C Hamano wrote:
>>>> I suspect that if there are even earlier callers than these
>>>> early parts in the codepaths (handle_options, enter_repo, and
>>>> setup_git_directory_gently), maybe these earlier callers are
>>>> doing something wrong.  Logically, if you are somewhere very
>>>> early in the codepath that you can still change the value of
>>>> GIT_DIR, you shouldn't have assumed the unknown value of GIT_DIR
>>>> and cached locations relative to that directory, no?  What are
>>>> the problematic callers?  What values do they access and why?
>>> I thought about these questions, too.  But only very briefly.
>>> I did not analyze the code path that lead to calls of getenv().
>>> I'm not sure if it's really necessary.  Calling set_git_dir()
>>> looks more sensible too me than the old code.  I believe using
>>> set_git_dir() is the safer choice, and should not do any harm.
>>> So I stopped analyzing too much, and instead proposed to use
>>> set_git_dir().
>>
>> Junio's point is this: If we stumble over a dangling pointer that  
>> getenv() produced, then this has obviously happened before setenv 
>> (GIT_DIR), and caching that pointer is probably the wrong thing to  
>> do anyway (because it refers to the wrong GIT_DIR) and needs to be  
>> fixed.
>
> I see your point.  It is probably more important to investigate
> this than I recognized at a first glance.

I instrumented the code to verify if setenv(GIT_DIR) is called after
setup_git_env().  This is not the case for all tests.

I also searched for problematic code paths.

setup_git_directory_gently() looks correct.  It explicitly calls
getenv(GIT_DIR_ENVIRONMENT); but uses the value returned in a
safe manner.  It does not cache the result and the only code path
that calls set_git_dir() does not access the return value of the
getenv() call after the call to set_git_dir().

setup_work_tree() looks correct, too.  Here, get_git_dir() is
called, which implicitly results in caching the pointer returned
from getenv(GIT_DIR_ENVIRONMENT).  But the result of get_git_dir() is
neither cached nor used after a subsequent call to set_git_dir().

So, I don't find any obvious problems.


>>> Interesting, though, is to find out if we have other potentially
>>> dangerous calls to getenv() that are not removed by this patch.
>>
>> Side note for other readers: This is a Windows specific problem  
>> for the moment because its getenv() does not behave well.
>
> Yes, and apparently even nobody knows how to trigger the problem
> on Windows.  At this point, we only know that caching getenv()
> calls is unsafe, while on Unix it is safe (at least for BSD
> it's documented to be safe).

In conclusion, using setenv() as in the original code instead of
set_git_dir() should be safe and this patch is not needed.

I tend to revert the changes in msysgit and see if we hit any
problems.  But I'll wait until 1.5.4 is released.

	Steffen
