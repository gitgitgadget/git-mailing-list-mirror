From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/7] convert: auto_crlf=false and no attributes set: same as binary
Date: Mon, 08 Feb 2016 10:27:06 -0800
Message-ID: <xmqqzivb83d1.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454688807-20871-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon Feb 08 19:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSqWo-0003EI-MA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 19:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbcBHS1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 13:27:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750982AbcBHS1I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 13:27:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35E6A40447;
	Mon,  8 Feb 2016 13:27:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W3QASRfeViiA
	080RYAEvxJXVViw=; b=pZfwpRpZ3kSGDJV7VQd4XDdKdMjQ0QbeZDLSS6lJi+Yl
	OoU4Lp+64Q4RijTiFndEPm5+L70BU5bptcvKBsun4zGlhQk1yy+X0HUIrkA2db5B
	Z+XBnV1XQVrGd5lsDOGe1CKNZL++oahJYZezwraThUIQIJwDfUyN3LjrpHSGAyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ThlOgo
	vX2s5jaqdtP8+Q3fnu9+Pi2KpbHjEhp0gxeYgWx4s1HNqMYinYTN1kCst1crI4K9
	MqG0PVrPr3F7nLScJcvkI627i2Jil0EgBVxGCm7Vrn7JdSKRR+0xpzoGavvO1evZ
	xDfdG9zE8imVUHoTB7ua2Nd9ZJUf2DNHaOFXY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D73540444;
	Mon,  8 Feb 2016 13:27:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A4B5040443;
	Mon,  8 Feb 2016 13:27:07 -0500 (EST)
In-Reply-To: <1454688807-20871-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 5 Feb 2016 17:13:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F724058-CE91-11E5-8B8A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285787>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When core.autocrlf is set to false, and no attributes are set, the fi=
le
> is treated as binary.

This, and also on the title, I know by "binary" you mean "no
conversion is attempted", and it is the word used in the code around
there, but it still makes my heart skip a beat every time I read
this sentence--it is not like we do not treat the contents as text
after all.

In any case, I take the above sentence the statement of the fact,
describing how the world currently is, not declaring a new world
order.

> Simplify the logic and remove duplicated code when dealing with
> (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALSE) b=
y
> setting crlf_action=3DCRLF_BINARY already in convert_attrs().

I looked at all the places where CRLF_BINARY is checked.  The ones
that are in this patch are clearly where "Is it BINARY?" and "Is
AUTO_CRLF_FALSE and CRLF_GUESS both true?" mean the same thing, so
this is a correct simplification to these places.

It is not easy to see what the effect of this change to the other
places that use CRLF_BINARY, though.

 * output_eol() used to return EOL_UNSET when auto_crlf is not in
   effect and CRLF_GUESS is.  The function will see CRLF_BINARY with
   this patch in such a case, and returns EOL_UNSET.  So there is no
   change to the function and its callers.

 * convert_attrs() has "If BINARY don't do anything and return".
   Will the patch change behaviour for the "not-autocrlf,
   CRLF_GUESS" case in this codepath?  I think ca->crlf_action used
   to be left as CRLF_GUESS here before the patch, and now by the
   time the control flow reaches here it is already CRLF_BINARY.
   Would it affect the callers, and if so how?

 * get_convert_attr_ascii() would change the behaviour, right?  It
   runs convert_attrs(), and with this change a path without
   attribute when autocrlf is not in effect would get BINARY and
   would show "-text", while the code before this change would give
   an empty string.  Am I misreading the code, or is the change
   intended?

Thanks.
