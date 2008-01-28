From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 10:05:34 +0100
Message-ID: <479D9ADE.6010003@viscovery.net>
References: <47975FE6.4050709@viscovery.net>	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>	<alpine.LSU.1.00.0801272043040.23907@racer.site>	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>	<20080128003404.GA18276@lintop>	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>	<479D805E.3000209@viscovery.net> <7vprvmuykw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJPwo-0000ff-Pp
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbYA1JFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYA1JFk
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:05:40 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29765 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbYA1JFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:05:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJPvd-0007BY-S7; Mon, 28 Jan 2008 10:05:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0C709546; Mon, 28 Jan 2008 10:05:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vprvmuykw.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71866>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> The "problem" is not only with git-clean, but also in others, like
>> git-ls-files. Try this in you favorite repository:
>>
>>    $ git ls-files -o /*bin
>>
>> The output does not make a lot of sense. (Here it lists the contents of
>> /bin and /sbin.) Not that it hurts with ls-files, but
>>
>>    $ git clean -f /
>>
>> is basically a synonym for
>>
>>    $ rm -rf /
> 
> Yeah, /*bin is not inside the repository so it should not even
> be reported as "others".  Shouldn't the commands detect this and
> reject feeding such paths outside the work tree to the core,
> which always expect you to talk about paths inside?

That's what I had expected. But look:

   $ git ls-files -o /
   [... tons of file names ...]

   $ git ls-files -o ..
   fatal: '..' is outside repository

   $ git clean -n /    # with Shawn's patch
   Would remove /bin/
   [... etc ...]

   $ git clean -n ..
   fatal: '..' is outside repository

Some mechanism for this is already there; it's just not complete enough.

-- Hannes
