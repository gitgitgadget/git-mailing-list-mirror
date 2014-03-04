From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit.c: use skip_prefix() instead of starts_with()
Date: Tue, 04 Mar 2014 12:38:32 -0800
Message-ID: <xmqqha7dk8c7.fsf@gitster.dls.corp.google.com>
References: <1393922540-13156-1-git-send-email-tanayabh@gmail.com>
	<8CB399B0-6781-4702-9EC5-0D0A0CCC3450@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:38:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKw6w-0006Ug-LR
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 21:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbaCDUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 15:38:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756456AbaCDUig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 15:38:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F28DA715A9;
	Tue,  4 Mar 2014 15:38:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0NU1Kc3lMRPN3hDiNrsqfPENY0=; b=kxyG/b
	dBFyWArJ5BTdCseZECRggebNLutAtHfAHlzPqnfy+yAhz+XOWLAnqJyBmPBWpAUe
	RpT/UqKAjsUJYI/Dd2+18WamTap3hYnREHhtxottJO25XFW+j21qAc5Wq1PesSaW
	OOP+Ytt1eo/OjoplWOwr8rFeirSSH/JZPQ2Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PTZ4wzY/8mkQEMIfr7Ww6dexpAQE3ZSQ
	mxZJ9NTuhoJexpexwVocH+gq4p4rDr4TpjAaFqtxX0iPWaccdQZjGLygMqCZGSUA
	fkBNxvLChif1HTJjRTxQoFJc95o/NLtrJNOglkgpttSEl7A9ZDRXyj7Y4xf9koS4
	qB73UrqPhxQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB834715A7;
	Tue,  4 Mar 2014 15:38:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C41D47159A;
	Tue,  4 Mar 2014 15:38:34 -0500 (EST)
In-Reply-To: <8CB399B0-6781-4702-9EC5-0D0A0CCC3450@quendi.de> (Max Horn's
	message of "Tue, 4 Mar 2014 20:16:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4E683FE-A3DC-11E3-B66F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243388>

Max Horn <max@quendi.de> writes:

>> +		buf = ident_line;
>> 		if (split_ident_line(&ident,
>> -				     buf + strlen("author "),
>> -				     line_end - (buf + strlen("author "))) ||
>> +				     buf,
>> +				     line_end - buf) ||
>> 		    !ident.date_begin || !ident.date_end)
>> 			goto fail_exit; /* malformed "author" line */
>> 		break;
>
> Why not get rid of that assignment to "buf", and use ident_line
> instead of buf below? That seems like it would be more readable,
> wouldn't it?

Yes, and also now the argument list is much shorter, you could
probably do it on two lines instead of three:

                if (split_ident_line(&ident,
                                     ident_line, line_end - ident_line) ||
                    ...


>> @@ -1193,10 +1195,9 @@ static void parse_gpg_output(struct signature_check *sigc)
>> 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> 		const char *found, *next;
>> 
>> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
>> -			/* At the very beginning of the buffer */
>> -			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
>> -		} else {
>> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
>> +		/* At the very beginning of the buffer */
>
> Do we really need that comment, and in that spot? The code seemed
> clear enough to me without it. But if you think keeping is better,
> perhaps move it to *before* the skip_prefix, and add a trailing
> "?"

Both good suggestions (I tend to prefer the removal).

Thanks.
