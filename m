From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Wed, 27 Jan 2010 10:50:07 -0800
Message-ID: <7viqanqt5s.fsf@alter.siamese.dyndns.org>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
 <7vockgzliv.fsf@alter.siamese.dyndns.org>
 <20100127102417.GD6262@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 19:50:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaCyA-0003sD-3D
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 19:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab0A0SuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 13:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061Ab0A0SuU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 13:50:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab0A0SuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 13:50:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66D6F94B82;
	Wed, 27 Jan 2010 13:50:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/FdqJocgW7Gsp3FuhmeYbB9F/6Y=; b=NmFBzO
	QxLW1SWkniGNoew6f+gYRJCxiTHCqfhIuIk8gjIVtwl6FcSR7abZLkLhCrzf6cHN
	qnz/wVyq6Qi/M+IbWu79RT96CEgU7lJVwijYljPadw0UPrnAjlIxP3qQMruWDdGt
	d4NITsfmtvz8123Nq/gBgLgkTyEeV7pY6i42c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mx09YwBaA3LQFF2Oolk6QIFm3hKWhVuv
	VS2pnCBMQYtkNRpz+Z0BvvyXVR6UqJGKW+5lN49223+yFa7sten6u3IlDWTey2AS
	CUT58JIAd0PddzSB6b4rw4byr2FMcYVzhsLJJaKr7ZviEOzHQXtVg+ws8/TW6YCi
	Gfgeructfak=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FC3894B7F;
	Wed, 27 Jan 2010 13:50:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A68C94B7B; Wed, 27 Jan
 2010 13:50:09 -0500 (EST)
In-Reply-To: <20100127102417.GD6262@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 27 Jan 2010 05\:24\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD3A4886-0B74-11DF-A517-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138183>

Jeff King <peff@peff.net> writes:

> A minor nit, but wouldn't:
>
>   int approxidate_careful(const char *str, unsigned long *out);
>
> returning an error code be the more usual pattern for a function with
> error-plus-output (your approxidate wrapper would have to be a function then,
> not a macro)?

I don't have strong preference either way; the one in the patch was
modelled after setup_git_directory_gently(&nongit_ok), and slightly easier
to work with for existing callers that don't care enough.

>> @@ -413,8 +413,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>  		} else if (0 <= nth)
>>  			at_time = 0;
>>  		else {
>> +			int errors = 0;
>>  			char *tmp = xstrndup(str + at + 2, reflog_len);
>> -			at_time = approxidate(tmp);
>> +			at_time = approxidate_careful(tmp, &errors);
>> +			if (errors)
>> +				die("Bogus timestamp '%s'", tmp);
>>  			free(tmp);
>
> I was just going to "return -1" here, which yields:
>
>   $ git show @{bogosity}
>   fatal: ambiguous argument '@{bogosity}': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions
>
> instead of
>
>   $ git show @{bogosity}
>   fatal: Bogus timestamp 'bogosity'

Good point.  Let's change it to silently return -1 and let the caller take
care of it.  Perhaps there are some callers that say "does this name an
object?  If not, let's try pathname".

>> +test_expect_success '@{30.years.ago} shows old' '
>> +	check_at @{30.years.ago} one
>
> Side note: I chose this because we needed to go back from the current
> time beyond where test_tick would place the commit. Which means this
> test has a 2035 bug. :)

Can't we use an absolute date, given that test_tick gives fixed timestamp
sequence to pretend as if we were still in 2005 when we are running these
tests?

 sha1_name.c          |    4 ++--
 t/t0101-at-syntax.sh |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f4a74fe..04fb3b8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -398,9 +398,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 			int errors = 0;
 			char *tmp = xstrndup(str + at + 2, reflog_len);
 			at_time = approxidate_careful(tmp, &errors);
-			if (errors)
-				die("Bogus timestamp '%s'", tmp);
 			free(tmp);
+			if (errors)
+				return -1;
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
index ccabc37..5e298c5 100755
--- a/t/t0101-at-syntax.sh
+++ b/t/t0101-at-syntax.sh
@@ -26,8 +26,8 @@ test_expect_success '@{now} shows current' '
 	check_at @{now} two
 '
 
-test_expect_success '@{30.years.ago} shows old' '
-	check_at @{30.years.ago} one
+test_expect_success '@{2001-09-17} (before the first commit) shows old' '
+	check_at @{2001-09-17} one
 '
 
 test_expect_success 'silly approxidates work' '
