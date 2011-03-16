From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] valgrind: ignore SSE-based strlen invalid reads
Date: Wed, 16 Mar 2011 13:18:04 -0700
Message-ID: <7vr5a67rb7.fsf@alter.siamese.dyndns.org>
References: <20110316112547.GA15739@elie>
 <1300275961-5798-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzxAm-0006hs-Kl
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1CPUST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 16:18:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab1CPUSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 16:18:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E068488D;
	Wed, 16 Mar 2011 16:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pdxcY2B+mLYG
	GQJrO8V+vRRmpX0=; b=NImP++sucfRyRHrNyHWDg/NuigHSouJS4K7kUs7sFxMc
	tT6uOgV5RCnlpdcQSs3EWfMolU69uowqQcXxlSSzcNdZZZ9YSa9t75FhDJMu9xB9
	FJkm7I8C1RYZwCl5xitnPG3+UtX4r1SQ2F4Z51vqAM/Vus+GR59twmlCimOPQns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i0mmKK
	qrF0HB1BLizCVOBQRoxnlsB3FsG3QJQXwXgfvdHGhQUN6tL7AlRE/OW9vTmzKMEO
	vXJuVaixu4MUsgGzNn0drGfTJOpXjoQOik9BhyfurMtuMRTgSiWpwvagFPF9GHXl
	6TS8yCcQGGrte5e7LLmI9/wRu9m6FC5SjcU9I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BA48488C;
	Wed, 16 Mar 2011 16:19:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 300D14889; Wed, 16 Mar 2011
 16:19:39 -0400 (EDT)
In-Reply-To: <1300275961-5798-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 16 Mar 2011 12:46:01
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB463A1E-500A-11E0-B629-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169188>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Some versions of strlen use SSE to speed up the calculation and load =
4
> bytes at a time, even if it means reading past the end of the
> allocated memory. This read is safe and when the strlen function is
> inlined, it is not replaced by valgrind, which reports a
> false-possitive.
>
> Tell valgrind to ignore this particular error, as the read is, in
> fact, safe. Current upstream-released version 2.6.1 is affected. Some
> distributions have this fixed in their latest versions.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>
>>>  I think 3.6.1 doesn't need it, as Debian's 1:3.5.0+3.6.0svn2010060=
9-1
>>> version is reportedly fixed.
>>
>>Ah, nice.  A phrase like "some versions of valgrind before 3.6.1"
>>would be fine with me fwiw. :)
>
> I just downloaded and compiled the upstream release 2.6.1 and it's
> still affected (it does fix some other related
> false-positives). Fedorea rawhide has the fix in, according to their
> bug tracker. I haven't tested the reportedly-fixed version in Debian
> yet.

I take it that you meant 3.6.1 in both places above?

This somehow reminds me of my past life where I saw a buggy implementat=
ion
of strlen() in the C library loaded one word too many from memory, and
segfaulted even when the string ended before the end of a mapped page w=
hen
the next page was unmapped.

Anyway, nice digging.
