From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wincred: fix get credential if username has @
Date: Wed, 19 Nov 2014 14:41:10 -0800
Message-ID: <xmqq1toyreyh.fsf@gitster.dls.corp.google.com>
References: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
	<1416433652-6840-1-git-send-email-margtu-fivt@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Karsten Blees <blees@dcon.de>
To: Aleksey Vasenev <margtu-fivt@ya.ru>
X-From: git-owner@vger.kernel.org Wed Nov 19 23:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDwD-0007D9-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 23:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbaKSWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 17:41:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758389AbaKSWlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 17:41:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 99A0920BCA;
	Wed, 19 Nov 2014 17:41:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8W0Ahup4jwWb5WzIVjiB7oyCX30=; b=kypice
	LNIbP/AFyH66yyauqki1ascba7nPEtCjH5SRQiYJUT1y7jQc3LsUQu3XP5oRXCX6
	+oBMT0yrDeSI0KqvTveSZ3KuychVGcR+mXD2Jds2QeXBddwp1GapLIOgQKARPUJs
	yJJ8WUMkN87LUlmP71jxIpOvS6MREdfnAxwoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JXjNzq0fY5agr0oVcXPo4t7yE3g09vyL
	s8hWeDqiBzIzQ1G0WJQdpLWCRUOzjhKvJIL8f3RqU1RTvpf9V08c2LTfsDaa+FRl
	I+Tnmg+hNR9eqwl63svIGtkQ5nHeVVAfAuY+354BJUoDW+Cr7pmA9yHX7XKeRkbB
	DGvigCtlhOU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D82020BC9;
	Wed, 19 Nov 2014 17:41:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E574220BC8;
	Wed, 19 Nov 2014 17:41:11 -0500 (EST)
In-Reply-To: <1416433652-6840-1-git-send-email-margtu-fivt@ya.ru> (Aleksey
	Vasenev's message of "Thu, 20 Nov 2014 00:47:32 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 297FD3C2-703D-11E4-9BA3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aleksey Vasenev <margtu-fivt@ya.ru> writes:

>> To: git@vger.kernel.org
>> Cc: Junio C Hamano <gitster@pobox.com>, Aleksey Vasenev <margtu-fivt@ya.ru>

Sorry, but I am hardly qualified to review this one, especially
without any log message that explains what breaks and how it breaks
with the current code, which may lead the reader to understand how
the updated code fixes the issue.  Cc'ing me does not help us very
much.

    $ git shortlog --no-merges -n contrib/credential/wincred/

gives me a few names who may be able to give us some inputs, so I'll
Cc them.

Thanks.

> Signed-off-by: Aleksey Vasenev <margtu-fivt@ya.ru>
> ---
>  .../credential/wincred/git-credential-wincred.c    | 25 +++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index a1d38f0..0061340 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -111,14 +111,23 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>   * Match an (optional) expected string and a delimiter in the target string,
>   * consuming the matched text by updating the target pointer.
>   */
> -static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
> +
> +static LPCWSTR wcsstr_last(LPCWSTR str, LPCWSTR find)
> +{
> +	LPCWSTR res = NULL, pos;
> +	for (pos = wcsstr(str, find); pos; pos = wcsstr(pos + 1, find))
> +		res = pos;
> +	return res;
> +}
> +
> +static int match_part_with_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim, int last)
>  {
>  	LPCWSTR delim_pos, start = *ptarget;
>  	int len;
>  
>  	/* find start of delimiter (or end-of-string if delim is empty) */
>  	if (*delim)
> -		delim_pos = wcsstr(start, delim);
> +		delim_pos = last ? wcsstr_last(start, delim) : wcsstr(start, delim);
>  	else
>  		delim_pos = start + wcslen(start);
>  
> @@ -138,6 +147,16 @@ static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
>  	return !want || (!wcsncmp(want, start, len) && !want[len]);
>  }
>  
> +static int match_part(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
> +{
> +	return match_part_with_last(ptarget, want, delim, 0);
> +}
> +
> +static int match_part_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
> +{
> +	return match_part_with_last(ptarget, want, delim, 1);
> +}
> +
>  static int match_cred(const CREDENTIALW *cred)
>  {
>  	LPCWSTR target = cred->TargetName;
> @@ -146,7 +165,7 @@ static int match_cred(const CREDENTIALW *cred)
>  
>  	return match_part(&target, L"git", L":") &&
>  		match_part(&target, protocol, L"://") &&
> -		match_part(&target, wusername, L"@") &&
> +		match_part_last(&target, wusername, L"@") &&
>  		match_part(&target, host, L"/") &&
>  		match_part(&target, path, L"");
>  }
