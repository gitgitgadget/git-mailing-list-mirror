From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Wed, 01 Feb 2012 20:14:32 -0800
Message-ID: <7vipjpzxav.fsf@alter.siamese.dyndns.org>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 05:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rso4H-0003aU-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 05:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab2BBEOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 23:14:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755165Ab2BBEOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 23:14:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A9D96033;
	Wed,  1 Feb 2012 23:14:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tsuk1EUeGqFmM3NPqo4eBfmi7AI=; b=iYdCt+
	wQgsfJio4mNqBwIZHUfXBmq7kXTuijUR/+FP1h3mnHtUvfX4Nf/InIPft5tbiRnc
	UzMIlLhALaF5jmrtBXxVMqr7q3hG5zdFA3S2CPqmLAojQKPfCS8fws9ZYpT2gul1
	jpt8Umfz8K2spBJ9KQh8ux2ef3nbe9zkOvm/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/b38otCQDJZ01Vea/B6XNtmrKKzUtT+
	3sFE7JfwXXibCufzOABbi0GIVJkaG3crLPn6m9NPSJhh7bxT/rCA3ftrFK3T6sEk
	6hJSBZL96FOyz1pU9jLx/aYoYYHN/lV7v9n3oVJSPUMq4+pHw6aY0S0Mfhb3s+Xp
	6rwX5X/Nkks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E506032;
	Wed,  1 Feb 2012 23:14:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 720FB6031; Wed,  1 Feb 2012
 23:14:33 -0500 (EST)
In-Reply-To: <20120131192053.GC12443@burratino> (Jonathan Nieder's message of
 "Tue, 31 Jan 2012 13:20:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 692A50EC-4D54-11E1-848A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189581>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks for tracking this down.  Interesting.  -Wtype-limits was split
> out from the default set of warnings (!) in gcc 4.3 to address
> <http://gcc.gnu.org/PR12963>, among other bugs (r124875, 2007-05-20).
>
> [...]
>> --- a/vcs-svn/fast_export.c
>> +++ b/vcs-svn/fast_export.c
>> @@ -300,7 +300,8 @@ void fast_export_blob_delta(uint32_t mode,
>>  				uint32_t len, struct line_buffer *input)
>>  {
>>  	long postimage_len;
>> -	if (len > maximum_signed_value_of_type(off_t))
>> +	uintmax_t delta_len = (uintmax_t) len;
>> +	if (delta_len > maximum_signed_value_of_type(off_t))
>>  		die("enormous delta");
>>  	postimage_len = apply_delta((off_t) len, input, old_data, old_mode);
>
> Is there some less ugly way to write the condition "if this value is
> not representable in this type"?
> 
> I guess I could live with something like the following (please don't
> take the names too seriously):
> ...
> What do you think?

I'd hold the branch in 'next' for now, until this gets resolved (one
possible resolution is to declare Ramsey's patch is good enough for now,
and do the follow-up later).
