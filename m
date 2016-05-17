From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Tue, 17 May 2016 11:58:03 -0700
Message-ID: <xmqq60ucwlz8.fsf@gitster.mtv.corp.google.com>
References: <573A993F.8020205@web.de>
	<1463503301-3634-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Tue May 17 20:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2kCB-0006rM-ET
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbcEQS6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:58:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751248AbcEQS6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:58:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BCC71B271;
	Tue, 17 May 2016 14:58:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dB8R5DpUsPSEyiDtaBQCSnGDU6A=; b=WBnHUs
	E0hWsBs3TJcMvi4dxmUDAJZ1AA2I+gau99KD/UU5qSeOt39KCaENoIuHTCz3qrs4
	wIdSetudKHrbAvSZ8IfG6cHjuJc+rHiQ1aK1qW5MF0tWnxzY3yRJhYt8qLu6C00b
	oevVIuTK3P9oK/T3oS8w6VgvaVDf5MbWYEY0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xQF79SwdaRJbcCQ01HUYXTMZ8hRQAoGF
	W2vU353zPQR6gp3zk+gRc9UXRdtS4T4BXJ+ZahYCc/6QiWNwuvDF5ipbMfqD/gxC
	vOq+YZw9MIFlAZrGGQF50pRfDcx/PurOQB5MWplXX+3dycCn/ZlwmdcDQMMJjBli
	XvlPDRFVJ0Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 72A501B270;
	Tue, 17 May 2016 14:58:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4BB41B26F;
	Tue, 17 May 2016 14:58:05 -0400 (EDT)
In-Reply-To: <1463503301-3634-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Tue, 17 May 2016 18:41:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49DF94BE-1C61-11E6-9D1E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294895>

tboegi@web.de writes:

>  #define HASH_WRITE_OBJECT 1
>  #define HASH_FORMAT_CHECK 2
> +#define HASH_CE_HAS_SHA1  4

How does one pronounce the words in this constant?  Does it make a
listener understand what this constant means?


/*
 * We need a comment around here to say what these two
 * parameters mean.  I am guessing that (1) if sha1 is not NULL,
 * path is ignored and the function inspects if it has CR; (2)
 * otherwise it checks the index entry at path and inspects if
 * it has CR.
 */
>  
> -static int has_cr_in_index(const char *path)
> +static int has_cr_in_index(const char *path, const unsigned char *sha1)
>  {

This makes me seriously wonder if it is a good idea to modify this
function like this.  (1) means this function is not about IN INDEX
at all!

Perhaps add a "static int blob_has_cr(const unsigned char *sha1)"
and call it from the real caller you added that wants to call this
butchered two-param version that has sha1 is a better solution?

> -static int crlf_to_git(const char *path, const char *src, size_t len,
> +static int crlf_to_git(const char *path, const unsigned char *sha1,
> +		       const char *src, size_t len,
>  		       struct strbuf *buf,
>  		       enum crlf_action crlf_action, enum safe_crlf checksafe)
>  {
> @@ -260,7 +267,7 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>  			 * If the file in the index has any CR in it, do not convert.
>  			 * This is the new safer autocrlf handling.
>  			 */
> -			if (has_cr_in_index(path))
> +			if (has_cr_in_index(path, sha1))

I think this change is too ugly.  The new "sha1" parameter is
telling us that "in order to see if the indexed version has CR, do
not look at the index, but look at the contents of this blob".

But wouldn't the result become more understandable if instead we
passed a new parameter "cr-state-for-conversion" that takes UNKNOWN,
HAS_CR, or NO_CR to this function?

In other words, what if, when the caller knows it does not care
what's in the index but wants to instead see if a different blob has
CR, we make it the caller's responsibility to figure it out by
calling blob_has_cr() before calling into this codepath and pass the
result of that check down?  When cr-state-for-conversion is UNKNOWN,
this code knows that it needs to call has_cr_in_index(path) to
figure it out itself.  Otherwise, it can and should use the
caller-supplied value without asking has_cr_in_index(path).
