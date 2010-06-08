From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFT PATCH 2/2] win32: optimize pthread_cond_broadcast
Date: Tue, 08 Jun 2010 18:37:06 +0200
Message-ID: <4C0E71B2.1060904@gnu.org>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org> <1275917892-16437-3-git-send-email-bonzini@gnu.org> <4C0E7015.8030504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:37:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1nj-0002R3-1d
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0FHQhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:37:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52214 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab0FHQhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:37:13 -0400
Received: by wyf28 with SMTP id 28so214538wyf.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QTejkfQLoYQK1U3Yifk8oyd5dE3hAoeM8lNPnAn8+Wk=;
        b=EOTM1NISMHt2XZQj77AHZ1AYoDzYpv/4bXAZe+rdJrnk4BTUQCDuipQhjNaLafm91h
         +kUCVvlpCbxL6o/WsUPNNlmIi0ec3aPD6OXzNmDHPGukRXl2h9vZM8kEZkTZFGOMK0xX
         mjDdS9b1VklL+7tb8ssOvnVXBjVY5cN3+08Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=t7pC1Q18ZjTt+poAzeV2dOagAE55MEnq0EyXDYr4Cb+Uy7PGPApThEWcutjIAxHDvd
         ehFUfTAfE/O76RpTUMAjLw+e8mhU0KoIvqN6FcPPQNbBc166OW2ZiEFgQWSRIKaJAS9Y
         G65X62/9rSKjCUZH/06dF5/9LfhgFN/YNu0h8=
Received: by 10.227.136.147 with SMTP id r19mr4408271wbt.218.1276015030929;
        Tue, 08 Jun 2010 09:37:10 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id u36sm48102287wbv.0.2010.06.08.09.37.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 09:37:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-3.fc13 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <4C0E7015.8030504@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148692>

On 06/08/2010 06:30 PM, Johannes Sixt wrote:
> Am 07.06.2010 15:38, schrieb Paolo Bonzini:
>> @@ -172,9 +172,10 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
>> * As in pthread_cond_signal, access to cond->waiters and
>> * cond->was_broadcast is locked via the external mutex.
>> */
>> -
>> - if ((cond->was_broadcast = cond->waiters> 0)) {
>> + if (cond->waiters> 0) {
>> BOOLEAN result;
>> + cond->was_broadcast = cond->waiters> 1;
>> +
>
> It is possible that you set was_broadcast to 1 here, while another
> thread still sees was_broadcast == 0 in cond_wait.

That still cannot happen, because pthread_cond_wait will be locked on 
the semaphore until the ReleaseSemaphore.  The only race that exists is 
between broadcast/signal's ReleaseSemaphore and wait's 
WaitForSingleObject.  This is benign, and exists before my patch.  But 
in all cases the code before ReleaseSemaphore is serialized WRT to the 
code after wait's WaitForSingleObject.

> That said, as long as this series buys performance only at the expense
> of clarity, I'm rather opposed to it because we do not call cond_wait
> and cond_broadcast in time-critical paths.

Yes, it is less clear indeed.  I tried to compensate with comments but 
that was not enough apparently.  As I said I did this patch for another 
project where condvars are used in time-critical paths; if you do not 
want to keep it, that's not a problem.

Paolo
