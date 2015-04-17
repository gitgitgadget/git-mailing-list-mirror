From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Fri, 17 Apr 2015 09:21:31 -0700
Message-ID: <xmqqd232hgj8.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117143-4882-1-git-send-email-karthik.188@gmail.com>
	<xmqqmw29jg78.fsf@gitster.dls.corp.google.com>
	<20150415221824.GB27566@peff.net> <20150417142310.GA12479@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 22:21:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjClQ-0000dh-Md
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbDQUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 16:21:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751896AbbDQUVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 16:21:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5241F48662;
	Fri, 17 Apr 2015 16:21:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T+6+lRL3V95Bo12bpiV1OmMCmOE=; b=jL5ptm
	TSCREwoAY5apgQuqHslqSVUxJ1rfEAPY4Vl6lvxxGtWCIpAXj6O8Z+39gESCGKIu
	O19Uq+hiOCXvtf3fWASHlxYp+ZYGVFVFedQCOI/1V+8KJFdDHjynL6ahgab/sRu8
	VOczU6AqjSqv8R9u8JO3hC5T/o1UhedUeZ1Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fFRv2wVc+I+hQNnpSiQ7kfBSkAMZujm8
	UDBl9ZYg7RsZ08geOrGVx89WuFAUdbDLi5PmdVMrv71kgKDkkr3PCEedwTe4qb5X
	m1oBFrP0Ve0bP9BRyOxyZSoaS4RV1GSxrPggR1EJAwkFh8MU8LrJ8579b3p3NLue
	BCXysmafty8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A9E748661;
	Fri, 17 Apr 2015 16:21:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1443B49E01;
	Fri, 17 Apr 2015 12:21:33 -0400 (EDT)
In-Reply-To: <20150417142310.GA12479@peff.net> (Jeff King's message of "Fri,
	17 Apr 2015 10:23:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFCB0328-E51D-11E4-9C6E-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267386>

Jeff King <peff@peff.net> writes:

> If there _is_ a performance implication to worry about here, I think it
> would be that we are doing an extra malloc/free.

Thanks for reminding me; yes, that also worried me.

> I'm not sure I
> understand why we are copying it at all. The original code copied from
> the hdr into type[10] so that we could NUL-terminate it, which was
> required for type_from_string().

Sounds like a good plan.

>
> But now we use type_from_string_gently, which can accept a length[1]. So
> we could just count the bytes to the first space and pass the original
> buffer along with that length, no?
>
> -Peff
>
> [1] Not related to your patch, but it looks like type_from_string_gently
>     is overly lax. It does a strncmp() with the length of the candidate
>     name, but does not check that we consumed all of the matching name.
>     So "tr" would match "tree", "comm" would match "commit", and so
>     forth.
