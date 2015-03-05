From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally -t"
Date: Thu, 05 Mar 2015 15:45:42 -0800
Message-ID: <xmqq61af100p.fsf@gitster.dls.corp.google.com>
References: <54F89D90.6090505@gmail.com>
	<1425579560-18898-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTfSg-0007UT-DP
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 00:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbbCEXpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 18:45:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751009AbbCEXpp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 18:45:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EA153E1DF;
	Thu,  5 Mar 2015 18:45:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NtRNtP+rQ6A1/2a/ko2pTqFIIOk=; b=RtY6Np
	E9wpS/Zdmtm7BzRSo5iYERhIH+FpzUcu2xt2q9fdMnh3dCbsKYiaCTHmaBvg8P/4
	epbrQJ2s69XwnkC6REFMeqW0VyNAU9VwENYZ5EDbV53zRPAT/L0Uk6Vz8lSzVWLt
	DnyCbWSgoGlE09vT+khMEYGakitGkYdVLadfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KTxaM5i0LarSEn/5XtHucue9l65oE2uZ
	AP5ucMX8OENC13/TZsb87LZtOBzXMwxszaJdkXFi8ggCHU4ZiVOXUJ/3tOwjOOyv
	bdGt2fL73aEqK1aQ/ZCowKOl1NLJP27V9jPD46qhyxnRi5Xupym6DiOxgi41iOOe
	cegiNcURlbU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C04E3E1DE;
	Thu,  5 Mar 2015 18:45:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64393E1DD;
	Thu,  5 Mar 2015 18:45:43 -0500 (EST)
In-Reply-To: <1425579560-18898-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 5 Mar 2015 23:49:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD247946-C391-11E4-9599-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264881>

Karthik Nayak <karthik.188@gmail.com> writes:

> +const char *sha1_object_info_literally(const unsigned char *sha1)
> +{
> +	enum object_type type;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct object_info oi = {NULL};
> +
> +	oi.typename = &sb;
> +	oi.typep = &type;
> +	if (sha1_object_info_extended(sha1, &oi, LOOKUP_LITERALLY) < 0)
> +		return NULL;
> +	if (*oi.typep > 0) {
> +		strbuf_release(oi.typename);
> +		return typename(*oi.typep);
> +	}
> +	return oi.typename->buf;
> +}

After calling this function to ask the textual type of an object,
should the caller free the result it obtains from this function?

oi.typename points at the strbuf on stack and its buf member points
at an allocated piece of memory.  That must be freed.

On the other hand, typename(*oi.typep) is a pointer into static
piece of memory, which must never be freed.

This patch introduces this function without introducing any caller,
which makes it unnecessarily harder to judge if this problem is
caused by choosing a wrong calling convention, and/or if so what
better calling convention can be used to correct the problem, but
without looking at the caller that (presumably) will be introduced
in a later patch, I suspect that the caller should supply a pointer
to struct object_info, i.e. something along these lines:

    struct object_info oi = { NULL };
    struct strbuf sb = STRBUF_INIT;
    enum object_type type;

    ...

    oi.typename = &sb;
    sha1_object_info_literally(sha1, &oi);
    if (!sb.len)
        that is an error;
    else
        use sb.buf as the name;

    strbuf_release(&sb);

As sha1_object_info_extended() takes oi and fills oi.typename when
it is supplied for _all_ types, not just the bogus ones, a caller of
that function, including sha1_object_info_literally() and its
caller, shouldn't have to worry about "is that a known one?  then
use typename() to convert the enum type to a string.  Otherwise use
the oi.typename->buf" at all, I would think.
