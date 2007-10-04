From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to chmod.
Date: Wed, 03 Oct 2007 23:23:22 -0700
Message-ID: <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>
References: <20071003105501.GD7085@admingilde.org>
	<470388DC.4040504@viscovery.net>
	<20071003231941.GA20800@admingilde.org>
	<Pine.LNX.4.64.0710040053380.28395@racer.site>
	<470482A2.3080907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 04 08:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdK7a-00089T-8t
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 08:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbXJDGXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 02:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbXJDGXd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 02:23:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:35323 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbXJDGXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 02:23:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id DADD0141745;
	Thu,  4 Oct 2007 02:23:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 152841415A5;
	Thu,  4 Oct 2007 02:23:46 -0400 (EDT)
In-Reply-To: <470482A2.3080907@op5.se> (Andreas Ericsson's message of "Thu, 04
	Oct 2007 08:05:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59921>

Andreas Ericsson <ae@op5.se> writes:

> Johannes Schindelin wrote:
>> Hi,
>>
>> On Thu, 4 Oct 2007, Martin Waitz wrote:
>>
>>> -		filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>> +		/* test that new files are not created with X bit */
>>> +		filemode = !(st1.st_mode & S_IXUSR);
>>> +		/* test that we can modify the X bit */
>>> +		filemode &= (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>>
>> Should that not be &&=?
>>
>
> I should think |=

Is it?

The issue that started the thread was that chmod + stat check we
originally had would say executable bit "seems to be" kept,
while that is only true until the information is cached at VFS
layer.

We create config file without asking for executable bit, so if
we read it back as executable then that is a sure sign that the
filesystem does not know what it is talking about, and we set
filemode to zero in such a case.  Similarly, if the chmod + stat
check says we cannot set executable bit and read it back, then
we also know the filesystem does not know about filemode.

So I think we can write it like this (indentation aside)...

filemode = !( (st1.st_mode & S_IXUSR)
        	/* we did not ask for x-bit -- bogus FS */
	    || chmod(path, st1.st_mode & S_IXUSR)
        	/* it does not let us flip x-bit -- bogus FS */
	    || lstat(path, &st2)
        	/* it does not let us read back -- bogus FS */
	    || (st1.st_mode == st2.st_mode)
	        /* it forgets we flipped -- bogus FS */
	    );
