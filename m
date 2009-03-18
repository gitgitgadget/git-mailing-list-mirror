From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy operation
Date: Wed, 18 Mar 2009 08:56:09 +0100
Message-ID: <49C0A919.7070606@viscovery.net>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net> <20090317202818.GA13458@blimp.localdomain> <7v63i7ridk.fsf@gitster.siamese.dyndns.org> <20090317213820.GC13458@blimp.localdomain> <7vmybjl1l6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljqen-0003yv-QN
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZCRH4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 03:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbZCRH4R
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:56:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61396 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbZCRH4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 03:56:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjqdG-0002GT-5r; Wed, 18 Mar 2009 08:56:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E71FC69F; Wed, 18 Mar 2009 08:56:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vmybjl1l6.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113598>

Junio C Hamano schrieb:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>> So that Cygwin port can continue work around its supporting
>> library and get access to its faked file attributes.
>>
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>> ...
>> diff --git a/builtin-init-db.c b/builtin-init-db.c
>> index ee3911f..f3f781b 100644
>> --- a/builtin-init-db.c
>> +++ b/builtin-init-db.c
>> @@ -66,7 +66,7 @@ static void copy_templates_1(char *path, int baselen,
>>  		else
>>  			exists = 1;
>>  
>> -		if (lstat(template, &st_template))
>> +		if (lstat_for_copy(template, &st_template))
>>  			die("cannot stat template %s", template);
>>  
>>  		if (S_ISDIR(st_template.st_mode)) {
> 
> Yuck; that's a bit too ugly for generic code.  Will there be other places
> that this needs to be used?  If so, we'd probably need to encourage its
> use where appropriate, which is even uglier but we cannot avoid it...
> 
> Also when the underlying system does not know the executable bit, how
> would this help?  I thought that earlier you said the part that checks if
> it wants to execute hooks with access(X_OK) will fail, so...

The "underlying system" in this case is Cygwin, and it *does* have an
executable bit.

But the FS gymnastics that implement it are slow and affect all lstat()
calls, so we have replaced lstat() with a simpler and faster
implementation. Only that the replacement doesn't know about the X bit
anymore; it always returns mode 0666.

Therefore, if a file is created whose mode is influenced by the fast
lstat(), then it will always be non-X. The access(, X_OK) call on the hook
script would do the right thing if only the script were created with the
correct mode. access(, X_OK) fails because the file was created with non-X
permissions.

-- Hannes
