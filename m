From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/6] verify-tag: prepare verify_tag for libification
Date: Tue, 19 Apr 2016 12:36:28 -0700
Message-ID: <xmqq7fft1jcz.fsf@gitster.mtv.corp.google.com>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
	<1461088041-19264-5-git-send-email-santiago@nyu.edu>
	<CAPig+cTO_vC1_N79G9yMkiyjYtEeBdsivz-A4jOMw0r-vRWWaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Santiago Torres <santiago@nyu.edu>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asbRr-0002Bz-Vx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148AbcDSTgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:36:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933066AbcDSTgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:36:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FD38142DD;
	Tue, 19 Apr 2016 15:36:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y3ip0kWw7mH0CNTJyvV0bcUL9Dk=; b=vSkdV9
	VgPogaCUwXJVz/vFAwBPCGRTo3a30BDNJbRwMKUsw696wTlAaBSpw5qxgmFk4IM+
	YfGMUGdRpJb24AYkz8ktYgFefTsn7RtJfB3gxxi2Gs7JStkau6F5d1IzecRGYKAL
	GXxa49bQjS/YLPgU5kLDBMKEkBsQFf3i3Rx1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gnJil/evMm6cb2i2OkCg5WEZI75Bdq5I
	H1wpYIRVbqJ56T1Ot54mqNDWXCB0muR4VOMc9ltZLRPnqtkFY7b1ojGdpidvyoud
	pstTrCpwbFBrlr/q/VsbZ6YSKnGLWDUbR8aBGtPyKAeXz8iJJrWLH2FO4695XUn1
	9FQDI1YAQWQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 563CD142DC;
	Tue, 19 Apr 2016 15:36:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD3F2142DB;
	Tue, 19 Apr 2016 15:36:29 -0400 (EDT)
In-Reply-To: <CAPig+cTO_vC1_N79G9yMkiyjYtEeBdsivz-A4jOMw0r-vRWWaw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 Apr 2016 15:05:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0394A406-0666-11E6-9D6E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291913>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I'd have probably called this "display_name", but then I suppose it
> suffers the same issue Junio mentioned previously about it sounding
> like a boolean. Anyhow, as long as Junio is happy with it, that's what
> matters.

No ;-) I am just trying to help people come up with patches in a
better shape.  Somehow "display name" does not bother me as much as
"report name" did.  name_to_report may be a mouthful, but it conveys
what it is clearly, and I think it is good enough.
>
> This version of the patch is nicely improved. One nit below.
>
>> Signed-off-by: Santiago Torres <santiago@nyu.edu>
>> ---
>> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
>> @@ -80,6 +83,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>  {
>>         int i = 1, verbose = 0, had_error = 0;
>>         unsigned flags = 0;
>> +       unsigned char sha1[20];
>> +       const char *name;
>
> Mentioned previously[1]: These two declarations could be moved inside
> the while-loop scope (below).
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/291813

Yup.

>
>>         const struct option verify_tag_options[] = {
>>                 OPT__VERBOSE(&verbose, N_("print tag contents")),
>>                 OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
>> @@ -96,8 +101,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>>         if (verbose)
>>                 flags |= GPG_VERIFY_VERBOSE;
>>
>> -       while (i < argc)
>> -               if (verify_tag(argv[i++], flags))
>> +       while (i < argc) {
>> +               name = argv[i++];
>> +               if (get_sha1(name, sha1))
>> +                       had_error = !!error("tag '%s' not found.", name);
>> +               else if (verify_tag(sha1, name, flags))
>>                         had_error = 1;
>> +       }
>>         return had_error;
>>  }
>> --
>> 2.8.0
