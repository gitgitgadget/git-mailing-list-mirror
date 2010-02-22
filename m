From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL for any error.
Date: Mon, 22 Feb 2010 08:36:19 +0100
Message-ID: <vpq7hq5n2mk.fsf@bauges.imag.fr>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
	<1266621718-4879-5-git-send-email-Matthieu.Moy@imag.fr>
	<7v4olbpyh3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjT2e-0003wq-7T
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab0BVHtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:49:01 -0500
Received: from imag.imag.fr ([129.88.30.1]:48993 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab0BVHtB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:49:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1M7aJau019256
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 08:36:19 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjSq3-0002cu-CH; Mon, 22 Feb 2010 08:36:19 +0100
In-Reply-To: <7v4olbpyh3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 20 Feb 2010 10\:13\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 22 Feb 2010 08:36:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140642>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  path.c |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/path.c b/path.c
>> index 005b836..2886eb6 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -222,7 +222,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>>  	}
>>  	/* We return the null string if we can't find a unique file name.  */
>>  	pattern[0] = '\0';
>> -	errno = EINVAL;
>> +	/* Make sure errno signals an error on failure */
>> +	if (errno <= 0)
>> +		errno = EINVAL;
>>  	return -1;
>>  }
>
> Please explain this change a bit better.

I think we agree about the

-	errno = EINVAL;

part. Setting errno to EINVAL unconditionally means discarding the
errno left from open(), so we can't know the reason for failure
anymore with this line.

> Because TMP_MAX is non-zero, you are always reading from errno left by
> open() in the loop, so the above paragraph is a misunderstanding.  But
> that needs to be in the log message, no?

Will add a sentence, yes.

> I think you are trying to avoid stomping on the errno when we broke out of
> the loop early, due to getting an error.  But errno is always valid at
> this point in this codepath, and errno.h macros shall expand to integer
> constant expressions with type int, distinct positive values.  So I think
> you can safely remove the assignment without "if (errno <= 0)".  Returning
> EINVAL from a variant of mkstemp when the error is anything but "The last
> six characters were not XXXXXX" is wrong.

Just removing the line would work with the current code, but this "if
(errno <= 0) errno = EINVAL;" allows enforcing the invariant that
errno > 0 when reaching "return -1" in a simple and reliable way (i.e.
changing the for loop later cannot break this invariant by mistake).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
