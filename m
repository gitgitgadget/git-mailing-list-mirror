From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 22 Nov 2007 09:31:49 +0100
Message-ID: <52415F60-C080-4260-86CD-32A379482341@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> <7vsl2y90pm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7T7-0006yC-9W
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbXKVIbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbXKVIbM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:31:12 -0500
Received: from mailer.zib.de ([130.73.108.11]:63580 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbXKVIbL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:31:11 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAM8UZm0008115;
	Thu, 22 Nov 2007 09:30:35 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAM8UYV6018473
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 09:30:34 +0100 (MET)
In-Reply-To: <7vsl2y90pm.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65754>


On Nov 22, 2007, at 8:52 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Nov 22, 2007, at 3:34 AM, Junio C Hamano wrote:
>>
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> Does this not have a fundamental issue?  When you call other git
>>>> programs
>>>> with run_command(), you _need_ GIT_DIR to be set, no?
>>>
>>> It is much worse.  set_git_dir() does not just setenv() but does
>>> setup_git_env() as well.
>>
>> What do your comments mean?
>>
>> My understanding is that set_git_dir() sets the environment and
>> then calls setup_git_env() to cache all pointers.  This call
>> updates dangling pointer if they have been cached earlier.
>
> Well, I was agreeing with you.  "Worse" was about what the
> current code does _not_ do.
>
> If there are earlier calls that obtain locations relative to the
> earlier definition of GIT_DIR, the locations they obtained are
> not just stored in memory that is "dangling" (which was what
> your proposed log message described) but they are also
> inconsistent with the updated definition of GIT_DIR.
>
> I suspect Johannes mistook set_git_dir() was only local
> (i.e. per calling process) matter without noticing that it has
> its own setenv() when he made that comment, hence my response to
> point out that the current code only calls setenv(), but
> set_git_dir() does setup_git_env() too, which should hide the
> inconsistency problem.
>
> HOWEVER.
>
> I suspect that if there are even earlier callers than these
> early parts in the codepaths (handle_options, enter_repo, and
> setup_git_directory_gently), maybe these earlier callers are
> doing something wrong.  Logically, if you are somewhere very
> early in the codepath that you can still change the value of
> GIT_DIR, you shouldn't have assumed the unknown value of GIT_DIR
> and cached locations relative to that directory, no?  What are
> the problematic callers?  What values do they access and why?


I thought about these questions, too.  But only very briefly.
I did not analyze the code path that lead to calls of getenv().

I'm not sure if it's really necessary.  Calling set_git_dir()
looks more sensible too me than the old code.  I believe using
set_git_dir() is the safer choice, and should not do any harm.
So I stopped analyzing too much, and instead proposed to use
set_git_dir().

Interesting, though, is to find out if we have other potentially
dangerous calls to getenv() that are not removed by this patch.

	Steffen
