From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 22 Nov 2007 18:56:23 +0100
Message-ID: <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> <7vsl2y90pm.fsf@gitster.siamese.dyndns.org> <52415F60-C080-4260-86CD-32A379482341@zib.de> <474552D6.5060305@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 18:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvGHI-0006GE-Op
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 18:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbXKVRze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 12:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXKVRze
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 12:55:34 -0500
Received: from mailer.zib.de ([130.73.108.11]:54630 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbXKVRzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 12:55:33 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAMHtBuS004579;
	Thu, 22 Nov 2007 18:55:11 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAMHtAim008666
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 22 Nov 2007 18:55:10 +0100 (MET)
In-Reply-To: <474552D6.5060305@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65833>


On Nov 22, 2007, at 10:58 AM, Johannes Sixt wrote:

> Steffen Prohaska schrieb:
>> On Nov 22, 2007, at 8:52 AM, Junio C Hamano wrote:
>>> I suspect that if there are even earlier callers than these
>>> early parts in the codepaths (handle_options, enter_repo, and
>>> setup_git_directory_gently), maybe these earlier callers are
>>> doing something wrong.  Logically, if you are somewhere very
>>> early in the codepath that you can still change the value of
>>> GIT_DIR, you shouldn't have assumed the unknown value of GIT_DIR
>>> and cached locations relative to that directory, no?  What are
>>> the problematic callers?  What values do they access and why?
>> I thought about these questions, too.  But only very briefly.
>> I did not analyze the code path that lead to calls of getenv().
>> I'm not sure if it's really necessary.  Calling set_git_dir()
>> looks more sensible too me than the old code.  I believe using
>> set_git_dir() is the safer choice, and should not do any harm.
>> So I stopped analyzing too much, and instead proposed to use
>> set_git_dir().
>
> Junio's point is this: If we stumble over a dangling pointer that  
> getenv() produced, then this has obviously happened before setenv 
> (GIT_DIR), and caching that pointer is probably the wrong thing to  
> do anyway (because it refers to the wrong GIT_DIR) and needs to be  
> fixed.

I see your point.  It is probably more important to investigate
this than I recognized at a first glance.


> So the task is to find those traps. Dmitry obviously stumbled over  
> one case, but I haven't ever encountered any problems with the  
> current code. But then this might be sheer luck. And I'm not a  
> heavy user of export GIT_DIR=foo, either. Do *you* know a  
> problematic case?

No.  I only stumbled over the code, when I reviewed differences
between msysgit and mingw.  I rarely use GIT_DIR=foo.  Actually,
I can't remember the last time I did.


>> Interesting, though, is to find out if we have other potentially
>> dangerous calls to getenv() that are not removed by this patch.
>
> Side note for other readers: This is a Windows specific problem for  
> the moment because its getenv() does not behave well.

Yes, and apparently even nobody knows how to trigger the problem
on Windows.  At this point, we only know that caching getenv()
calls is unsafe, while on Unix it is safe (at least for BSD
it's documented to be safe).

	Steffen
