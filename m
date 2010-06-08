From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFT PATCH 2/2] win32: optimize pthread_cond_broadcast
Date: Tue, 08 Jun 2010 20:46:17 +0200
Message-ID: <4C0E8FF9.7020500@viscovery.net>
References: <1275917892-16437-1-git-send-email-bonzini@gnu.org> <1275917892-16437-3-git-send-email-bonzini@gnu.org> <4C0E7015.8030504@viscovery.net> <4C0E71B2.1060904@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 08 20:46:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM3om-0000Pm-NT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 20:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab0FHSq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 14:46:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:22962 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752221Ab0FHSq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 14:46:26 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E8219CDF96;
	Tue,  8 Jun 2010 20:46:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <4C0E71B2.1060904@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148701>

Am 08.06.2010 18:37, schrieb Paolo Bonzini:
> On 06/08/2010 06:30 PM, Johannes Sixt wrote:
>> Am 07.06.2010 15:38, schrieb Paolo Bonzini:
>>> @@ -172,9 +172,10 @@ int pthread_cond_broadcast(pthread_cond_t *cond)
>>> * As in pthread_cond_signal, access to cond->waiters and
>>> * cond->was_broadcast is locked via the external mutex.
>>> */
>>> -
>>> - if ((cond->was_broadcast = cond->waiters> 0)) {
>>> + if (cond->waiters> 0) {
>>> BOOLEAN result;
>>> + cond->was_broadcast = cond->waiters> 1;
>>> +
>>
>> It is possible that you set was_broadcast to 1 here, while another
>> thread still sees was_broadcast == 0 in cond_wait.
>
> That still cannot happen, because pthread_cond_wait will be locked on
> the semaphore until the ReleaseSemaphore. The only race that exists is
> between broadcast/signal's ReleaseSemaphore and wait's
> WaitForSingleObject. This is benign, and exists before my patch. But in
> all cases the code before ReleaseSemaphore is serialized WRT to the code
> after wait's WaitForSingleObject.

I think I've stared at the code long enough now to see that you are right. 
All counterexamples that I thought I could make up to disprove you didn't 
do it :-)

-- Hannes
