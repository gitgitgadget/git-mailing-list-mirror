From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/45] parse_pathspec and :(glob) magic
Date: Thu, 21 Mar 2013 10:50:02 -0700
Message-ID: <7vvc8kabhx.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <7v1ubaeyph.fsf@alter.siamese.dyndns.org>
 <20130321053326.GA17446@duynguyen-vnpc.dek-tpc.internal>
 <20130321054349.GA18101@duynguyen-vnpc.dek-tpc.internal>
 <7v4ng4br1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 18:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIjdP-000361-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 18:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab3CURuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 13:50:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902Ab3CURuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 13:50:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6644FA9F4;
	Thu, 21 Mar 2013 13:50:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CIn8un7uxJW4M1xLhMeaCu4pHYg=; b=r49u3q
	wL7YapTdyHM1UwIpVYyPMjG6X6tayPG5m+TWVjEJvkBf/TX2fBYUzvEWvppBZYJ7
	glZQzI2A1DbaD2KPyNGJqbUVlPILnBkLI9ueTU32kTQC6hlPWWHpx1J6y/3RoZZ9
	0wVhgRnVjM+mgDZdUoznv0R/fdv6Wp4GqmS/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UW6MABNqvYW/P31YI5Cw0Cx2AoUMGYeb
	+dhAnF2IuHdMUExuHtgOr+Qz2+Vt1wh8S6h/QgX1XMSX3xqPnorgtIg9uAhfIuDO
	HwPn1prW0k5VTCjwKzBwTf7jOTw6675XVCLTuOIJ3g/GCcBSWrjFuipiwNU081e0
	YN2uG+S0YZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A0A5A9F3;
	Thu, 21 Mar 2013 13:50:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4B66A9F1; Thu, 21 Mar 2013
 13:50:05 -0400 (EDT)
In-Reply-To: <7v4ng4br1y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Mar 2013 10:28:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3A2C036-924F-11E2-8CCB-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218746>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>>> I still can't reproduce it. But I think I found a bug that
>>> miscalculates prefix length from absolute paths. Does this "fix" your
>>> test?
>>>  ...
>> Nope, that one could cause more crashes. Try this
>>
>> -- 8< --
>> diff --git a/setup.c b/setup.c
>> index 3584f22..3d8eb97 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -14,6 +14,8 @@ char *prefix_path_gently(const char *prefix, int *p_len, const char *path)
>>  		const char *temp = real_path(path);
>>  		sanitized = xmalloc(len + strlen(temp) + 1);
>>  		strcpy(sanitized, temp);
>> +		if (p_len)
>> +			*p_len = 0;
>
> Yes, this one seems to. "$(pwd)/../src" was not handled correctly.
>
> The callchain to this locaiton would look like
>
> 	parse_pathspec() with prefix="docs/", prefixlen set to 5
>         -> prefix_pathspec(), &prefixlen passed down
>           -> prefix_path_gently(), p_len points at the above prefixlen
> 	     your "this should fix" patch sets *p_len to 0,
>              original leaves *p_len as 5.
>              -> normalize_path_copy_len() with p_len
> 	        *p_len is used here.
>
> Why could the test pass for you without it?  It doesn't look like a
> bug that depended on uninitialized memory or something from the
> above observation.

The change made to prefix_path_gently() in this series is beyond
"disgusting", especially with the above fix-up.

Sometimes it uses the original "len", sometimes it uses the fixed-up
*p_len (e.g. passes it down to normalize_path_copy_len()), and lets
normalize_path_copy_len() further update it, and thenit makes the
caller use the updated *p_len.

Does the caller know what the value in *p_len _mean_ after this
function returns?  Can it afford to lose the original length of the
prefix it saved in a variable, without getting confused?

I think any change that turns a value-passed argument in the
existing code into modifiable pointer-to-variable in this series
should add in-code comment to describe what the variable mean upon
entry and after return, just like normalize_path_copy_len() that was
built out of the original normalize_path_copy().  I didn't look if
there are many others, or if this is the only one that is tricky. it
is tricky that even the original author of the patch got it wrong
X-<.
