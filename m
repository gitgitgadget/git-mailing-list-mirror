From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 22 Nov 2007 10:58:46 +0100
Message-ID: <474552D6.5060305@viscovery.net>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> <7vsl2y90pm.fsf@gitster.siamese.dyndns.org> <52415F60-C080-4260-86CD-32A379482341@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8py-0007XT-5n
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbXKVJ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbXKVJ6x
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:58:53 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64398 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbXKVJ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:58:52 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iv8oz-0004W2-7v; Thu, 22 Nov 2007 10:58:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A9AB24E4; Thu, 22 Nov 2007 10:58:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <52415F60-C080-4260-86CD-32A379482341@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65768>

Steffen Prohaska schrieb:
> On Nov 22, 2007, at 8:52 AM, Junio C Hamano wrote:
>> I suspect that if there are even earlier callers than these
>> early parts in the codepaths (handle_options, enter_repo, and
>> setup_git_directory_gently), maybe these earlier callers are
>> doing something wrong.  Logically, if you are somewhere very
>> early in the codepath that you can still change the value of
>> GIT_DIR, you shouldn't have assumed the unknown value of GIT_DIR
>> and cached locations relative to that directory, no?  What are
>> the problematic callers?  What values do they access and why?
> 
> 
> I thought about these questions, too.  But only very briefly.
> I did not analyze the code path that lead to calls of getenv().
> 
> I'm not sure if it's really necessary.  Calling set_git_dir()
> looks more sensible too me than the old code.  I believe using
> set_git_dir() is the safer choice, and should not do any harm.
> So I stopped analyzing too much, and instead proposed to use
> set_git_dir().

Junio's point is this: If we stumble over a dangling pointer that getenv() 
produced, then this has obviously happened before setenv(GIT_DIR), and 
caching that pointer is probably the wrong thing to do anyway (because it 
refers to the wrong GIT_DIR) and needs to be fixed.

So the task is to find those traps. Dmitry obviously stumbled over one case, 
but I haven't ever encountered any problems with the current code. But then 
this might be sheer luck. And I'm not a heavy user of export GIT_DIR=foo, 
either. Do *you* know a problematic case?

> Interesting, though, is to find out if we have other potentially
> dangerous calls to getenv() that are not removed by this patch.

Side note for other readers: This is a Windows specific problem for the 
moment because its getenv() does not behave well.

-- Hannes
