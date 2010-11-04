From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support pthread with no recursive mutex (SunOS 5.6)
Date: Thu, 04 Nov 2010 08:01:04 -0700
Message-ID: <7vvd4duo9b.fsf@alter.siamese.dyndns.org>
References: <20101102141227.GA3991@thor.il.thewrittenword.com>
 <20101102173510.GB5636@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 16:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE1zb-0006uV-5i
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 16:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355Ab0KDPok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 11:44:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0KDPoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 11:44:39 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2010 11:44:39 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7E373EAF;
	Thu,  4 Nov 2010 11:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=zlgE6DnIIXqKKERnriG5Oi+XPuM=; b=xunv/4
	1RwjIT83PsCIrbnF9P9uvT8bRqgKul6iTnz0a4HOUii86MEEGjfcllwXyCYcjufF
	IJ/NXFzk+j8fV6mMIN6xddFcg+xq8uoQbOfa8fmQAezegVzfcP5HpqqclTN/pYD/
	D6z2b5toHelpBWFZYFGqgH6gF8IL+iK3gzByw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbUV8gVCbEzIONuI868iqmIuTS4YF+uK
	RVnd71DZmNLV6gUp7lAtwJhr+PhDQsGRpxWEVTLIq4CpN3igYJaMkkDMlQc967W4
	ZE3xDOcfR49OK/1TuBQk4Rdz/frCd1GMcMGo5Ld54cLzkK4Vxt04VyY43FppjipN
	SaBEB22p8Kk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59A253EAE;
	Thu,  4 Nov 2010 11:37:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 063783ABB; Thu,  4 Nov 2010
 11:01:06 -0400 (EDT)
In-Reply-To: <20101102173510.GB5636@burratino> (Jonathan Nieder's message of
 "Tue\, 2 Nov 2010 12\:35\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 784115CA-E829-11DF-9881-885E74564BB2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160728>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Gary,
>
> Gary V. Vaughan wrote:
>
>> Thanks for merging my last patch series into the new release.  git 1.7.3.2
>> now compiles correctly on all of our hosts, save Solaris 2.6 (SunOS 5.6)
>> which has no recursive mutex support in its pthreads.
>
> Nice.
>
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -1561,7 +1561,11 @@ static pthread_cond_t progress_cond;
>>   */
>>  static void init_threaded_search(void)
>>  {
>> +#ifndef NO_RECURSIVE_MUTEX
>>  	init_recursive_mutex(&read_mutex);
>> +#else
>> +	pthread_mutex_init(&read_mutex, NULL);
>> +#endif
>
> Wouldn't that defeat the purpose of using a recursive mutex in the first
> place?

Thanks for a sanity.

What might make sense is not NO_RECURSIVE_MUTEX but MUTEX_IS_RECURSIVE
(which would be the Windows case).  If Solaris 2.6 has mutex without
PTHREAD_MUTEX_RECURSIVE, and its mutex is already recursive without being
told anything special, then something like the above patch (#ifdef should
be in the definition of init_recursive_mutex() function, not its callsite,
by the way) would be a good thing to have, but I somehow doubt that it
would be the case...
