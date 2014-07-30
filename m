From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] refs.c: refactor resolve_ref_unsafe() to use strbuf internally
Date: Wed, 30 Jul 2014 12:53:35 -0700
Message-ID: <xmqqlhray668.fsf@gitster.dls.corp.google.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
	<1406285039-22469-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSvymyM3G+LujopPAVtaXVYN_mYJ0pxPkvb2pvLsq+e-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZwb-0005V1-GE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbaG3Txp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:53:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51201 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbaG3Txo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:53:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D1142D23F;
	Wed, 30 Jul 2014 15:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vwUS4Nvy/LUl7vYRpFNRbSYNPFQ=; b=ETI583
	o1wFqah2tFaoz9ogHbywdyydJdbTvEK3ttTuzfJZSOgXVSXghWWiJnR5btaCO449
	Z3NdVH5rXVkCES1nqpYNx240pzxHqgeqmEyrIJv6/J+FBPNG3rhZx/SFugvj3FHd
	md0nvZI65lFZHMCJN32vdBqqqYzqxiWfz759Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NmtgHq8Gcg8cgPlyiHlYxtLS0G3xUIx6
	RJEDAzIXM6zNCoTB/UN5cscv7qYPpc/Gv056ggUKiHe+XBQwKp4VXcXNch9ehO3j
	GeXr536kefzIdk8Iem0IF8VU/L4sYl6V63Iq/fjg6ZMEPkhOxtUniOQTx13J+8Gw
	6pBbD98smpE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33BC82D23E;
	Wed, 30 Jul 2014 15:53:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 620A42D231;
	Wed, 30 Jul 2014 15:53:37 -0400 (EDT)
In-Reply-To: <CAPig+cSvymyM3G+LujopPAVtaXVYN_mYJ0pxPkvb2pvLsq+e-A@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 25 Jul 2014 11:55:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 32430744-1823-11E4-8564-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254516>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
>>  {
>> -       const char *ret = resolve_ref_unsafe(ref, sha1, reading, flag);
>> -       return ret ? xstrdup(ret) : NULL;
>> +       struct strbuf buf = STRBUF_INIT;
>> +       if (!resolve_ref(ref, &buf, sha1, reading, flag))
>> +               return buf.buf;
>
> return strbuf_detach(&buf, NULL);

Yeah, the end result is the same, but it is a very good discipline.
