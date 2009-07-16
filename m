From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 00:24:51 -0700
Message-ID: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
 <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr> <4A5ED22B.6050101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLL3-000487-7k
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZGPHZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbZGPHZA
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:25:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60147 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZGPHZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:25:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87A0D8868;
	Thu, 16 Jul 2009 03:24:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F0118867; Thu, 16 Jul 2009
 03:24:53 -0400 (EDT)
In-Reply-To: <4A5ED22B.6050101@gmail.com> (Stephen Boyd's message of "Thu\,
 16 Jul 2009 00\:09\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C508F138-71D9-11DE-9ACC-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123376>

Stephen Boyd <bebarino@gmail.com> writes:

> Nicolas Sebrecht wrote:
>> diff --git a/git-am.sh b/git-am.sh
>> index d64d997..2b55ddc 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -162,6 +162,17 @@ check_patch_format () {
>>  		return 0
>>  	fi
>>  
>> +	# Then, accept what really looks like (series of) email(s).
>> +	# the first sed select headers but the folded ones
>> +	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
>> +	# this one is necessary for the next 'grep -v'
>> +	sed -e '/^$/d' |
>> +	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' ||
>> +	{
>> +		patch_format=mbox
>> +		return 0
>> +	}
>> +
>>  	# otherwise, check the first few lines of the first patch to try
>>  	# to detect its format
>>  	{
>
> This fails t4150-am.sh #10 (am -3 -q is quiet). You should redirect the
> output of the sed and grep to /dev/null like Junio did in his "how about
> this" patch.

Honestly speaking, I do not understand why Nicolas changed my patch at
all.

This patch wastes an extra sed process, introduces [[:blank::]] where
space and tab inside [] is perfectly adequate, and we know the latter is
understood by everybody's sed.

The worst part is that this check was moved before the most common case of
mbox file for which none of the overhead for this this extra processing is
necessary.

Admittedly, it was a "something like this" patch and wasn't tested at all,
and I would not be entirely surprised if he saw some breakages in it after
testing with my patch, but if that was the case, some comment after ---
would have been very helpful.  Nicolas?

> Also, writing some tests would be helpful.

That is true.  A test would illustrate why this more expensive test must
come before the existing cheaper tests for common cases (if such a
breakage was the reason his patch looks different from mine), for example.
