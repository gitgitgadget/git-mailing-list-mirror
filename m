From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: handle broken commit headers gracefully
Date: Wed, 17 Apr 2013 14:55:29 -0700
Message-ID: <7vsj2oesa6.fsf@alter.siamese.dyndns.org>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
	<516D93C4.1000100@lsrfire.ath.cx>
	<7v61zml0ow.fsf@alter.siamese.dyndns.org>
	<516DBE2E.4060201@lsrfire.ath.cx>
	<7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
	<7vli8hhgmn.fsf@alter.siamese.dyndns.org>
	<20130417063942.GA27703@sigill.intra.peff.net>
	<516EE300.7020200@lsrfire.ath.cx> <516EEB12.5050209@lsrfire.ath.cx>
	<20130417210713.GB635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 17 23:55:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USaKH-0005dn-7M
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 23:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966929Ab3DQVzd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Apr 2013 17:55:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966683Ab3DQVzc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 17:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D58561749C;
	Wed, 17 Apr 2013 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1pR6Pg38x1nd
	+9JRdFgLZspdhmo=; b=m4oPMCkxOBLtcGtPBp/UqPDhaH3dOTIhpJvixtkizSLL
	Z2MpcS5S1fUBKDU2QvqPxNdbH6QAVKB6Q1mVw5Vaj4wYS3FDhmNe53HSkCWsB/XC
	rdrd3Z1IZ57IpBWI2haP/X7NbR/a48BZICpWADFqh2H0BO/RU3l1nZI6KpT41xU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NzAgXb
	9rfO2pMvW9wa276XwRwJqnb3oXRrWuutqZzK7wvOEYesCiDge6N6xZdyxzGz9LmW
	APmKct+BoWX0OkuqazeBYKvPyW64YMKmoqsZUTFF/4EqiHVHRubbPwZLUoXe7Xca
	vunOYXQxeBKaqvcfCaMC4x4cCXG6VxtDj0p3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C83A51749B;
	Wed, 17 Apr 2013 21:55:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B7421749A;
	Wed, 17 Apr 2013 21:55:31 +0000 (UTC)
In-Reply-To: <20130417210713.GB635@sigill.intra.peff.net> (Jeff King's message
	of "Wed, 17 Apr 2013 17:07:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85D7E30C-A7A9-11E2-BB07-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221577>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 17, 2013 at 08:33:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Minimal patch, test case missing.  It's a bit sad that the old commi=
t
>> parser of blame handled Ivan's specific corruption (extra "-<>" afte=
r
>> email) gracefully because it used the spaces as cutting points inste=
ad
>> of "<" and ">".
>
> That may mean there is room for improvement in split_ident_line to
> be more resilient in removing cruft. With something like:
>
>   Name <email@host>-<> 123456789 -0000
>
> it would obviously be nice to find the date timestamp there, but I
> wonder what the "email" field should return? The full broken string, =
or
> just "email@host"?

Or you can imagine nastier input strings, like

   Name <>-<email@host> 123456789 -0000
   Name <ema>-<il@host> 123456789 -0000
   Name <email@host~ 1234>56789 -0000

I am afraid that at some point "we should salvage as much as we
can", which is a worthy goal, becomes a losing proposition.
