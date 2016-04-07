From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 07 Apr 2016 12:37:53 -0700
Message-ID: <xmqq8u0pyzu6.fsf@gitster.mtv.corp.google.com>
References: <5706A489.7070101@jupiterrise.com>
	<xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
	<xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
	<20160407190709.GC4478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:38:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFks-0004Hh-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbcDGTiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:38:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755544AbcDGTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:37:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B9FF52F95;
	Thu,  7 Apr 2016 15:37:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5tKhT0/1eVr2Dt6LzkXNU3x2ng=; b=Cjo06w
	Ndu+dMqDbT0YN+OOSIONL3NqJXHh4Fs/+r/JnX3HUWeKX1KP2xRU/AUPKSOU5rRd
	XEizHyU24XMyEuYBp3769wPg5v15gXXJ+KIEwwhSG60e2PXRC7THWDCyPHTqa87k
	Osfb3z4/4QcsCegAsYh4cwrO5epKL4xLtWDGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ibu/kGvhw9efIttZfmoK4+RtciTxOcR3
	6I3F6HtpLWmXr6Oq07pc9x5dmJltSNUYaH0KqMD7jQU7cu/9cfXRhsZzH9ZaTMvH
	yM7bWN4KgAL9INDA9jJ2MmP3pB3UUdZrgdRqFY4+Ksbs2cXUyoNmuvDOiwj3CCvo
	nIiZphD7tVs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2376852F94;
	Thu,  7 Apr 2016 15:37:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9910C52F91;
	Thu,  7 Apr 2016 15:37:54 -0400 (EDT)
In-Reply-To: <20160407190709.GC4478@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 7 Apr 2016 15:07:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3932E3C4-FCF8-11E5-9D93-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290978>

Jeff King <peff@peff.net> writes:

>> So perhaps this is all we need to fix your box.
>> 
>>  setup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/setup.c b/setup.c
>> index 3439ec6..b6c8aab 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -103,7 +103,7 @@ char *prefix_path_gently(const char *prefix, int len,
>>  			return NULL;
>>  		}
>>  	} else {
>> -		sanitized = xstrfmt("%.*s%s", len, prefix, path);
>> +		sanitized = xstrfmt("%.*s%s", len, prefix ? prefix : "", path);
>>  		if (remaining_prefix)
>>  			*remaining_prefix = len;
>>  		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
>
> The original pre-75faa45ae0230b321bf72027b2274315d7e14e34 version
> checked "if (len)", but I think this should be equally right.

That's a good point.  The original had

-               sanitized = xmalloc(len + strlen(path) + 1);
-               if (len)
-                       memcpy(sanitized, prefix, len);
-               strcpy(sanitized + len, path);
+               sanitized = xstrfmt("%.*s%s", len, prefix, path);

and for a brief moment I was wondering why the strlen() did not
barf, until I realized that was on path not prefix.

-- >8 --
Subject: setup.c: do not feed NULL to "%.*s" even with the precision 0

A recent update 75faa45a (replace trivial malloc + sprintf / strcpy
calls with xstrfmt, 2015-09-24) rewrote

	prepare an empty buffer
	if (len)
        	append the first len bytes of "prefix" to the buffer
	append "path" to the buffer

that computed "path", optionally prefixed by "prefix", into

	xstrfmt("%.*s%s", len, prefix, path);

However, passing a NULL pointer to the printf(3) family of functions
to format it with %s conversion, even with the precision 0, i.e.

	xstrfmt("%.*s", 0, NULL)

yields undefined results, at least on some platforms.  

Avoid this problem by substituting prefix with "" when len==0, as
prefix can legally be NULL in that case.  This would mimick the
intent of the original code better.

Reported-by: "Tom G. Christensen" <tgc@jupiterrise.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 3439ec6..b4a92fe 100644
--- a/setup.c
+++ b/setup.c
@@ -103,7 +103,7 @@ char *prefix_path_gently(const char *prefix, int len,
 			return NULL;
 		}
 	} else {
-		sanitized = xstrfmt("%.*s%s", len, prefix, path);
+		sanitized = xstrfmt("%.*s%s", len, len ? prefix : "", path);
 		if (remaining_prefix)
 			*remaining_prefix = len;
 		if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
