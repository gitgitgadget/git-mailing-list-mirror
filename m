From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 25 Mar 2015 12:27:45 -0700
Message-ID: <xmqqvbho27ym.fsf@gitster.dls.corp.google.com>
References: <5512618B.2060402@gmail.com>
	<1427268105-16901-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:27:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaqy0-0004Ve-GX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 20:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbbCYT1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 15:27:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751787AbbCYT1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 15:27:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 054E643900;
	Wed, 25 Mar 2015 15:27:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5eXHj9K4bMYnPs7O7N42D+qHtz8=; b=ZUpxsg
	b1XgVWxs9yfO9bpLYXJ5JI9HogOKocf4aIbp9cJ2obtqBjx1mktqVg6Ee66ZO9XK
	HQK6BXjpkpKXwdlR9rbLsP+0ERkPb+qQyJ9uN/Rmo+l/l3AIiQYPWSD61VxLMqH9
	QqueC890GAdftiy/PzOfFiBDlYxFz3TemxqrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOrN9dBfZuxgyb43Z5ZuaxkqyixUB3Tn
	ERNFHMqOfO0Nzlk+4HiSGOrfBEFFEHcGbNc6sg7Nb6WSHwGpjP6H0Wh8GcPBjF+5
	bQVMWOFSBp/h5BD4CFdG1/azatJTdrjrxrKJ3QMV7eleuY8x/vRt/U0ald1Y3IPo
	rjVlq4l0N6o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F12EE438FF;
	Wed, 25 Mar 2015 15:27:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7501E438F9;
	Wed, 25 Mar 2015 15:27:46 -0400 (EDT)
In-Reply-To: <1427268105-16901-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 25 Mar 2015 12:51:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0427DADE-D325-11E4-9944-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266294>

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
> +
> +	if (status) {
> +		strbuf_add(header, buffer, stream->next_out - buffer);
> +		return status;
> +	}
> +
> +	do {
> +		status = git_inflate(stream, 0);
> +		strbuf_add(header, buffer, stream->next_out - buffer);
> +		for (cp = buffer; cp < stream->next_out; cp++)
> +			if (!*cp)
> +				/* Found the NUL at the end of the header */
> +				return 0;
> +		stream->next_out = buffer;
> +		stream->avail_out = bufsiz;
> +	} while (status == Z_OK);
> +	return -1;

A caller of unpack_sha1_header() gets the return from git_inflate();
I wonder if we should be returning "status" here for consistency,
perhaps?
