From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] sha1_file.c: support reading from a loose object of unknown type
Date: Wed, 25 Mar 2015 12:13:20 -0700
Message-ID: <xmqqzj7028mn.fsf@gitster.dls.corp.google.com>
References: <5512618B.2060402@gmail.com>
	<1427268105-16901-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaqk9-0002Vf-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 20:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbCYTNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 15:13:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbbCYTNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 15:13:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 274074355E;
	Wed, 25 Mar 2015 15:13:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3FJ0GMA4nnpfx+Co6Itq+48o05E=; b=My67a9
	sxBhCJlSoI5/eMEdeNAcIRtEejVJlx9g0lcctzOByvl6OrtAURfg/ktXkl0CkbNt
	+KMnoG057wMFJfBINzNEoJoRhLo0KmZNQxmkjLk5Aq99d/9rQCr2s027fPfcqvbK
	GoW+sjR9Uw08JUtdCFD4mwaGrpZy8HD+RtEKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JiGxf3cuPo0QzIEw7oZmGZ0tRZ2j5MQQ
	gHxNIY9MUXYn9VikafLFZtBRBPd6dNrIBrhxmD3afukn72+7crWKQnulvInXq9Zx
	fu8N7dK+0eFaKilNYLbkN8SWcUtLbroRboAjWlowWhjXDL7vNVPeINOhgZfTVlLm
	f2YG7QZFcGc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E08F4355B;
	Wed, 25 Mar 2015 15:13:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9533B43559;
	Wed, 25 Mar 2015 15:13:21 -0400 (EDT)
In-Reply-To: <1427268105-16901-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 25 Mar 2015 12:51:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00A7482E-D323-11E4-8A6C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266293>

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if ((flags & LOOKUP_LITERALLY)) {
> +		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, &hdrbuf) < 0)
> +			status = error("unable to unpack %s header with --literally",
> +				       sha1_to_hex(sha1));
> +		else if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
> +	} else {
> +		if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> +			status = error("unable to unpack %s header",
> +				       sha1_to_hex(sha1));
> +		else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
> +			status = error("unable to parse %s header", sha1_to_hex(sha1));
> +	}

I wonder if you can further reduce an unnecessary duplication in the
two "else if" clauses in the above, and if the result becomes easier
to read and maintain.  Perhaps

	if (((flags & LOOKUP_LITERALLY)
             ? unpack_sha1_header_to_strbuf(...)
             : unpack_sha1_header(...)) < 0)
		status = error(...);
	else if ((status = parse_sha1_header_extended(...)) < 0)
        	status = error(...);

or even

	status = 0;
	if (flags & LOOKUP_LITERALLY) {
		if (unpack_sha1_header_to_strbuf(...) < 0)
			status = error(...);
	} else {
		if (unpack_sha1_header(...) < 0)
			status = error(...);
	}
        if (!status) {
        	if (status = parse(...)) < 0)
	        	status = error(...);
	}

although I think the latter might be a bit harder to read.
