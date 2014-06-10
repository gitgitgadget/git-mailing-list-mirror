From: Phil Hord <hordp@cisco.com>
Subject: Re: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted
 merge
Date: Tue, 10 Jun 2014 14:51:47 -0400
Message-ID: <539753C3.2020101@cisco.com>
References: <xmqqvbsrf4hd.fsf@gitster.dls.corp.google.com>	<5395CD04.2050303@gmail.com> <xmqq8up4abs3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 20:51:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuR9G-00086D-3M
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 20:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbaFJSvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 14:51:50 -0400
Received: from alln-iport-4.cisco.com ([173.37.142.91]:14492 "EHLO
	alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaFJSvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 14:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2362; q=dns/txt; s=iport;
  t=1402426309; x=1403635909;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=agdMxjC7itYFr78b9KpidDwHZUUF/kXyCQVF8T3+TqA=;
  b=iIlu1VCrdRUKzYw+c9JwHyk4Bvih144Dh2lwN2tw1bzRlMgh2AW7T5D8
   Hr8X2g1kxlmWLkfV6D3+j+mv8T1R1ENBDuIEMh7L13a5felzc9NXzlfMS
   yx17lOe9P+RDI+XDacczblTVZ/7/GqfDuGCInRVhuRlZDsNLiv9PhBlty
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwKAGFTl1OtJV2d/2dsb2JhbABZgw2sFAEBBpkSAYEKFnWEAwEBAQRHMQEQCxgJFg8JAwIBAgEPNgYBDAEFAgEBiCoDEbNak2wNhUcXhVaGUYIiB4RBAQOWGoIQgXqGdoZWhXmDWA
X-IronPort-AV: E=Sophos;i="4.98,1010,1392163200"; 
   d="scan'208";a="51938374"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by alln-iport-4.cisco.com with ESMTP; 10 Jun 2014 18:51:48 +0000
Received: from [64.100.104.110] (dhcp-64-100-104-110.cisco.com [64.100.104.110])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id s5AIplkt003917;
	Tue, 10 Jun 2014 18:51:48 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqq8up4abs3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251214>


On 06/10/2014 01:56 PM, Junio C Hamano wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>
>> On 05/27/2014 08:42 PM, Junio C Hamano wrote:
>>> Fabian Ruch <bafain@gmail.com> writes:
>>>> [..]
>>>>
>>>> In order to signal the three possible situations (not only success and
>>>> failure to complete) after a pick through porcelain commands such as
>>>> `cherry-pick`, exit with a return value that is neither 0 nor 1. -1 was
>>>> chosen in line with the other situations in which the sequencer
>>>> encounters an error.
>>> Hmph... do we still pass negative to exit() anywhere in our codebase?
>> No, but I thought `cmd_cherry_pick` would just forward the `return -1` from the
>> sequencer to the shell. I had another look and found that `cmd_cherry_pick`
>> calls `die` instead. Now, the commit inserts 128 as exit status in
>> `fast_forward_to`.
>>
>> Would it be appropriate to mention the choice of exit status in the coding
>> guidelines? I didn't know that the int-argument to exit(3) gets truncated and
>> that this is why it is a general rule to only use values in the range from 0 to
>> 255 with exit(3).
> I personally do not think of a reason why it is necessary to mention
> how the argument to exit(3) is expected to be used by the system, but
> if it is common not to know it, I guess it would not hurt to have a
> single paragraph with at most two lines.
>
> In any case, I agree that exiting with 1 that signals "failed with
> conflict" can be confusing to the caller.  Can we have a test to
> demonstrate when this fix matters?

I think you are asking for a test and not for clarification.  But a test
was provided in 3/3 in this series.  Was it not related directly enough?

For clarification, this tri-state return value matters when the caller
is planning to do some cleanup and needs to handle the fallout
correctly.  Maybe changing this return value is not the correct way
forward, though.  It might be better if the caller could examine the
result after-the-fact instead.  This would require some reliable state
functions which I recall were somewhat scattered last time I looked. 
Also I cannot think of a reliable test for "the previous cherry-pick
failed during pre-condition checks" and I'm not sure anything should
exist to track this in .git outside of the return value for this function. 
