From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 11:44:56 +0100
Message-ID: <4F61C828.8060506@in.waw.pl>
References: <20120314141401.GC28595@in.waw.pl> <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl> <7v8vj2omiv.fsf@alter.siamese.dyndns.org> <20120315035405.GA4149@sigill.intra.peff.net> <7vk42ml5er.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 11:45:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S88BI-0008RP-EL
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 11:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760599Ab2COKpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 06:45:11 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:55801 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759198Ab2COKpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 06:45:10 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S88B5-00008B-VW; Thu, 15 Mar 2012 11:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vk42ml5er.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193210>

On 03/15/2012 07:55 AM, Junio C Hamano wrote:
> Jeff King<peff@peff.net>  writes:
>
>> On Wed, Mar 14, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
>>> This is probably not related to your patch, but
>>>
>>> 	GIT_TEST_CREDENTIAL_HELPER=cache sh t0303-*.sh
>>>
>>> passes OK for me while
>>>
>>> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
>>>
>>> seems to get stuck forever.
>>
>> It's because t0303 is the generic "test any helper" script, and does not
>> know how to clean up the credential-cache daemon. So the daemon sticks
>> around, holding onto a file descriptor that causes prove to hang.
>
> And the reason why "sh t0303-*.sh" version does not have this problem is...?

It does :)

In both cases git-credential-cache--daemon is running. It is stuck in 
poll() with a timeout of 30*1000 ms (credentail-cache--daemon.c:175). 
When running without prove, it is left in the background and terminates 
after 30 s. When running under prove, prove waits for 30 seconds for the 
process to end and then terminates.

I think that this delay is OK, as it happens only when running an 
explicitly requested test, and only under prove.

Zbyszek
