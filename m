From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Wed, 04 Mar 2015 12:58:23 -0800
Message-ID: <xmqqy4nc7a4w.fsf@gitster.dls.corp.google.com>
References: <54F5888B.7040400@gmail.com>
	<1425377556-25332-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:59:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGOG-0000PF-BO
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbCDU7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:59:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751806AbbCDU73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:59:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 000903BB12;
	Wed,  4 Mar 2015 15:59:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VtQ4kpihi6TsrLD+90zOunRM+4A=; b=fzmPoh
	/l+vug7kxPhK56XHtVhWQVP+/LvaQYVBE2+5N+t4dtPl1qnUItsMcfhAOEQi9ndT
	niFlO95G8CCWOdqEKtUB85kX6TKMNgmFG5/sJorQdNAc4CUdwYl8SMQMTdIvwFt8
	XwAqnSxsxmXa0F1KYfSPVITzPLsO1cPmQ6Gvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EDSdA7u4Crl37/qDjD5Zc82vHqTV797u
	luhjg5k/3LrU8kKrkgjrrthjXnrLIhJq6cyVQv6KhJuzIKz2umxhsn483ZyTAW4+
	9+W0wEKVeuZRzRdvVNvPaJeYdBF+JIxDsP0fMr0y1tXAqfQ3CDKe3OIRkq44sa+5
	p709ooWBMLA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECFB73BB11;
	Wed,  4 Mar 2015 15:59:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 759263BA9C;
	Wed,  4 Mar 2015 15:58:24 -0500 (EST)
In-Reply-To: <1425377556-25332-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 3 Mar 2015 15:42:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32C86270-C2B1-11E4-8B88-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264776>

Karthik Nayak <karthik.188@gmail.com> writes:

> add "sha1_object_info_literally()" which is to be used when
> the "literally" option is given to get the type of object
> and print it, using "sha1_object_info_extended()".
>
> add "unpack_sha1_header_literally()" to unpack sha headers
> which may be greater than 32 bytes, which is the threshold
> for a regular object header.
>
> modify "sha1_loose_object_info()" to include a flag argument
> and also include changes to call "unpack_sha1_header_literally()"
> when the literally flag is passed. Also copies the obtained
> type to the typename field of object_info.
>
> modify "sha1_object_info_extended()" to call the function
> "sha1_loose_object_info()" with flags.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  sha1_file.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 7 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 69a60ec..1068ca0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1564,6 +1564,36 @@ int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long ma
>  	return git_inflate(stream, 0);
>  }
>  
> +static int unpack_sha1_header_literally(git_zstream *stream, unsigned char *map,
> +					unsigned long mapsize,
> +					struct strbuf *header)
> +{
> +...
> +}

Looks suspiciously familiar...

> +int sha1_object_info_literally(const unsigned char *sha1)
> +{
> +	enum object_type type;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct object_info oi = {NULL};
> +
> +	oi.typename = &sb;
> +	oi.typep = &type;
> +	if (sha1_object_info_extended(sha1, &oi, LOOKUP_LITERALLY) < 0)
> +		return -1;
> +	if (*oi.typep > 0)
> +		printf("%s\n", typename(*oi.typep));
> +	else
> +		printf("%s\n", oi.typename->buf);
> +	strbuf_release(oi.typename);
> +	return 0;
> +}
> +

NAK.

Please don't add end-user facing final output to sha1_file.c;
instead have the caller use a helper function like this one to
extract necessary information and perform the end-user interaction
there.
