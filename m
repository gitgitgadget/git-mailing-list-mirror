From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/6] builtin/verify-tag: replace name argument with sha1
Date: Wed, 06 Apr 2016 09:27:55 -0700
Message-ID: <xmqqa8l6zoqc.fsf@gitster.mtv.corp.google.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 06 18:28:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqJI-0008IZ-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcDFQ2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:28:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750928AbcDFQ17 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:27:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A17A552303;
	Wed,  6 Apr 2016 12:27:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oic0wVY/k9e3f4+ZYjKkpack970=; b=OGHt/N
	w8guYo3WK5g+56Ih2Of6jaD8KiqASCc5cy09Jrtn9astJRqecs/s+nlH+K3J665Z
	j/VTubHxO7GjjV2XfcVm/AnYbrfYPfJwDfDfDcZ28mqseRCwANRhdIBEnRABW2Wv
	TVXnDtcTuAhL+sTM3ecAFy5REDbCNHZKTEKFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOT74uXQS1TZrncu0D5MS+nczskzGO3d
	+IiTRbPhpr3OO2LELpxXrVmIbABIAJrh4mhHPahzAfrgGvbt9/yL3uALrxcm65f8
	OFLU6svsSZ7Zu/QFEqQ+e89OkrakxeSQbFcaXY8cM1zAvM7qFSlAvOdea88sMt+7
	jQeXMeecnkw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9899C52302;
	Wed,  6 Apr 2016 12:27:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E84EA52301;
	Wed,  6 Apr 2016 12:27:56 -0400 (EDT)
In-Reply-To: <1459872449-7537-5-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Tue, 5 Apr 2016 12:07:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 853E88D4-FC14-11E5-99C9-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290846>

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> This change is meant to prepare verify_tag for libification. Many
> existing modules/commands already do the refname to sha1 resolution, so
> should avoid resolving the refname twice. To avoid breaking
> builtin/verify-tag, we move the refname resolution outside of the
> verify_tag() call.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/verify-tag.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 1ca9a05..7a7c376 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -42,25 +42,23 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
>  	return ret;
>  }
>  
> -static int verify_tag(const char *name, unsigned flags)
> +static int verify_tag(const unsigned char *sha1, unsigned flags)
>  {
>  	enum object_type type;
> -	unsigned char sha1[20];
>  	char *buf;
> +	char *hex_sha1;
>  	unsigned long size;
>  	int ret;
>  
> -	if (get_sha1(name, sha1))
> -		return error("tag '%s' not found.", name);
> -
> +	hex_sha1 = sha1_to_hex(sha1);
>  	type = sha1_object_info(sha1, NULL);
>  	if (type != OBJ_TAG)
>  		return error("%s: cannot verify a non-tag object of type %s.",
> -				name, typename(type));
> +				hex_sha1, typename(type));

So, if I said

    $ git verify-tag master

the code used to take "master" from argv[], fed it to verify_tag()
as parameter 'name', turned it to the object name of the commit,
noticed that it is not a tag, and complained that "master: cannot verify".

With this rewrite, the same invocation would cause "master" to be
turned into the object name, which is passed to verify_tag() and the
complaint is an overlong

    76bece327f490cb344b95ae8f869cbeb89a4d20b: cannot verify a non-tag object of type commit

That does not sound like a good change at all.

If you want to support a future caller of a libified version of
verify_tag() that has a raw object name but not the original name,
I'd suggest to make this function keep parameter 'name' while adding
the new parameter 'sha1'.  Then, the error reporting may become:

	return error("%s: cannot verify a non-tag object of type '%s'",
		     name ? name : sha1_to_hex(sha1), typename(type));

and the output would still be useful.  Further improvements may be

 - rename 'name' to 'report_name' to clarify that the parameter is
   only used for reporting, and that the tag object to verify is
   always identified by the new 'sha1' parameter.

 - use find_unique_abbrev() to shorten the fallback name displayed
   in the error message.
