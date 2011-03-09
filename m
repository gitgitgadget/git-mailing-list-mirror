From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Wed, 09 Mar 2011 11:20:17 -0800
Message-ID: <7vbp1kayoe.fsf@alter.siamese.dyndns.org>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxOvw-0000cv-3N
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab1CITU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:20:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1CITU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:20:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 508633464;
	Wed,  9 Mar 2011 14:21:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svyZ5HWc6suZ8sNfMkF+n5J1ve8=; b=vJMjdF
	fCUDLp7WSG0c6FhCvmpSmAHDed6OcpoUSMeRCY8qjFU/dSJKLe2SO9flWZkZXdq+
	FG6wqvBAKAUo+OPS5klLK1moI+5hKyRkS/tCkxZcmMzSW8lxAJ/t24p4pOboPZfU
	73LLgoWiF5VfnCg3d7MZMOephtY/ZWL8kjx1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sDeVPfEmh/CPhvr3wawoU9YweqZmzuba
	fGoJNtKUfdSB3LxNSp9JZxDH+/HUTiUOqcEDLleF1MBuKsOHnZ1w3KN5/U8ZTE41
	nJKooKYaqSwozc9qlVCDiPjRf5VIG/grxKJAxiEOdjHI+r6lBSD9ouCDWKABx2an
	BoHmbXXkf9M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E4F33463;
	Wed,  9 Mar 2011 14:21:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E5413462; Wed,  9 Mar 2011
 14:21:47 -0500 (EST)
In-Reply-To: <7vipvsaz27.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Mar 2011 11:12:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C334CC8-4A82-11E0-AD03-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168745>

Junio C Hamano <gitster@pobox.com> writes:

> The function is given "len" from the caller to specify the minimum length
> of the output the caller expects (i.e. even if 4 hexdigits is enough to
> identify the given commit in a small project, the caller can say it wants
> to see at least 7 hexdigits).  The loop without your patch finds the
> shortest prefix whose length is at least that given length that uniquely
> identifies the given object (or the shortest prefix that doesn't identify
> any existing object if the given sha1 does not exist in the repository).
> And then ensures the returned value is longer by the guard as an extra
> safety measure, so that later when the project grows, the disambiguation
> we find today has a better chance to survive.
> ...
> What am I missing?

I think what may be desirable is to honor the caller-supplied "len" a bit
better.  If an object is uniquely identifiable with only 4-hexdigit today,
and if the caller gives 7 as len and the guard is set to 3, we return 10
hexdigits with the current code.  We should instead return 7 hexdigits in
such a case, as that is in line with the "use 3 extra to give the
disambiguation we find today a better chance to survive".

Perhaps that was what you wanted to do, but I don't think that is what
your code actually does.

>
>>  sha1_name.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 709ff2e..6bb8942 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -197,6 +197,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>>  {
>>  	int status, exists;
>>  	static char hex[41];
>> +	int extra_len = unique_abbrev_extra_length;
>>  
>>  	exists = has_sha1_file(sha1);
>>  	memcpy(hex, sha1_to_hex(sha1), 40);
>> @@ -208,12 +209,14 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>>  		if (exists
>>  		    ? !status
>>  		    : status == SHORT_NAME_NOT_FOUND) {
>> -			int cut_at = len + unique_abbrev_extra_length;
>> +			int cut_at = len + extra_len;
>>  			cut_at = (cut_at < 40) ? cut_at : 40;
>>  			hex[cut_at] = 0;
>>  			return hex;
>>  		}
>>  		len++;
>> +		if (extra_len > 0)
>> +			extra_len--;
>>  	}
>>  	return hex;
>>  }
