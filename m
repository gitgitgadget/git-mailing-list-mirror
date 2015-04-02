From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Thu, 02 Apr 2015 12:12:34 -0700
Message-ID: <xmqqbnj6jqe5.fsf@gitster.dls.corp.google.com>
References: <551D1F99.5040306@gmail.com>
	<1427972288-15298-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:12:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkXr-0005Bu-TD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbDBTMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:12:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753829AbbDBTMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 15:12:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5722B436A6;
	Thu,  2 Apr 2015 15:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7FihcPIMLJo9bPiFy3JhHjkxETs=; b=vGPL03
	nbsgnOYF+5wA9L04WHo6ynIidy2erb4XR73sZZhKEVBbQZlR5lE0n7WsSbrzkLED
	XCaWjFcRBRT03Op2b6KWh11+rJPWIwYPJUuHCfCLX4ecG8gNjmKRRmeSI2ExPi02
	CKD7gIBI4+PbGc+VPVdFB6w2cd/DWWeuiVgIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eikeVcK2oMHBscC/4h7isIBIHINQm+1r
	VieaBNJYHv3LufycxW8GQFDzp/pbvG1IaLL0bFNQ2tkYW+IOlb/WMCkef6c/lWZT
	zJCVVeLbbTNh23PoM3yh7DrH89C0tl6lGUpN2px9fmd5fK14BnXQ2apBbctHmTDK
	qJnLaUdpZAk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F8DA436A3;
	Thu,  2 Apr 2015 15:12:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A56DA436A2;
	Thu,  2 Apr 2015 15:12:35 -0400 (EDT)
In-Reply-To: <1427972288-15298-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 2 Apr 2015 16:28:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38946AE2-D96C-11E4-9B3A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266658>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
> +					unsigned long mapsize,
> +					struct strbuf *header)
> +{
> +	unsigned char buffer[32], *cp;
> +	unsigned long bufsiz = sizeof(buffer);
> +	int status;
> +
> +	status = unpack_sha1_header(stream, map, mapsize, buffer, bufsiz);

I briefly wondered if this can return Z_BUF_ERROR, but it is OK
because we do not call inflate with Z_FINISH in unpack_sha1_header()
for obvious reasons ;-)

> +	if (status) {
> +		strbuf_add(header, buffer, stream->next_out - buffer);
> +		return status;
> +	}

> +	do {
> +		status = git_inflate(stream, 0);
> +		strbuf_add(header, buffer, stream->next_out - buffer);
> +		for (cp = buffer; cp < stream->next_out; cp++)
> +			if (!*cp)
> +				/* Found the NUL at the end of the header */
> +				return 0;
> +		stream->next_out = buffer;
> +		stream->avail_out = bufsiz;
> +	} while (status != Z_STREAM_END);
> +	return -1;
> +}

OK.

> @@ -1614,27 +1642,24 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
>   * too permissive for what we want to check. So do an anal
>   * object header parse by hand.
>   */
> -int parse_sha1_header(const char *hdr, unsigned long *sizep)
> +int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
> +			       unsigned int flags)
>  {
> -	char type[10];
> -	int i;
> +	struct strbuf typename = STRBUF_INIT;
>  	unsigned long size;
> +	int type;
>  
>  	/*
>  	 * The type can be at most ten bytes (including the

Is this still a valid comment?

>  	 * terminating '\0' that we add), and is followed by
>  	 * a space.
>  	 */
> -	i = 0;
>  	for (;;) {
>  		char c = *hdr++;
>  		if (c == ' ')
>  			break;
> -		type[i++] = c;
> -		if (i >= sizeof(type))
> -			return -1;
> +		strbuf_addch(&typename, c);
>  	}
> -	type[i] = 0;
>  
>  	/*
>  	 * The length must follow immediately, and be in canonical
