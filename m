From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Thu, 04 Oct 2007 12:33:05 +0200
Message-ID: <4704C161.3000006@op5.se>
References: <20071003105501.GD7085@admingilde.org>	<470388DC.4040504@viscovery.net>	<20071003231941.GA20800@admingilde.org>	<Pine.LNX.4.64.0710040053380.28395@racer.site>	<470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 12:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdO1C-0001ug-Pv
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 12:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbXJDKdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 06:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbXJDKdL
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 06:33:11 -0400
Received: from mail.op5.se ([193.201.96.20]:48955 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbXJDKdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 06:33:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C4D2919435D;
	Thu,  4 Oct 2007 12:33:07 +0200 (CEST)
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZBHpvP08kehP; Thu,  4 Oct 2007 12:33:06 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 5821019435A;
	Thu,  4 Oct 2007 12:33:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59937>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>> Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Thu, 4 Oct 2007, Martin Waitz wrote:
>>>
>>>> -		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>>> +		/* test that new files are not created with X bit */
>>>> +		filemode = !(st1.st_mode & S_IXUSR);
>>>> +		/* test that we can modify the X bit */
>>>> +		filemode &= (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>> Should that not be &&=?
>>>
>> I should think |=
> 
> Is it?
> 

Nopes. I misread the first expression and simply assumed that "filemode"
should be != 0 for FS not supporting the x bit. I'd rename the variable
to bogus_fs and flip the logic, but I have no strong opinion either way.

> 
> So I think we can write it like this (indentation aside)...
> 
> filemode = !( (st1.st_mode & S_IXUSR)
>         	/* we did not ask for x-bit -- bogus FS */
> 	    || chmod(path, st1.st_mode & S_IXUSR)
>         	/* it does not let us flip x-bit -- bogus FS */
> 	    || lstat(path, &st2)
>         	/* it does not let us read back -- bogus FS */
> 	    || (st1.st_mode == st2.st_mode)
> 	        /* it forgets we flipped -- bogus FS */
> 	    );

For "filemode=0 means FS doesn't support x-bit" it looks about right,
but kinda cumbersome to read.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
