From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/6] refs.c: enable large transactions
Date: Mon, 26 Jan 2015 19:17:07 -0800
Message-ID: <xmqqd260nc98.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-7-git-send-email-sbeller@google.com>
	<xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYbCBHVhL+FvKu-yKMinxGCMwGfqG96rSp+0-7frgO2wQ@mail.gmail.com>
	<xmqqtwzhnhbl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 04:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFweS-0001Xv-1R
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 04:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbbA0DRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 22:17:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751453AbbA0DRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 22:17:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5C743338B;
	Mon, 26 Jan 2015 22:17:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vRmGVoGcnXk9wKLCVdclb3fjIlA=; b=Ejxce5
	YTqPF/R0whpPwRJlYGllS+JU3SUdGnugRo1QgRCyMY2h4BkyagO5KP8NrhhLmG/j
	Cm50+lvTPdflXKrO30GeXz70Z0Dk9ej26nIfOJ+3MC+VOGVnE5YICmrI0MdiOr/Q
	poJoi+svQJd25E9nGd4y001MmWwsC+hQiQR1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoXctuC0TgXhpywfw2TjaBaTAEYfxATt
	vuKWjJuEosdcHmmKW4EqEtRQyX0TKM0ZA/qEGFTzWHr12talSYbLZtTmdykxdMB8
	7Q/zau4Tjx1qR2vqKqmXblAuknxr8fwwUxAU+2491X/jhYfppv0Rin+xbulADIyC
	1E7pKPmOq3s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1F083338A;
	Mon, 26 Jan 2015 22:17:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C1E333389;
	Mon, 26 Jan 2015 22:17:09 -0500 (EST)
In-Reply-To: <CAGZ79kbQiVQJyZC8mKaSUnOpY6YJc0TYdX=msuZDXLd7DxmTmQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 26 Jan 2015 11:30:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA6F5456-A5D2-11E4-A957-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263056>

Stefan Beller <sbeller@google.com> writes:

> I do not see the problem in the code itself, but rather in understanding
> the code. I will send a follow up patch which makes it easier to follow
> by removing the early exit with no problem away.


Taken as a whole the code may function correctly but the division of
roles of individual functions seems screwed up.  write_ref_sha1()
sometimes unlocks, and sometimes leaves the unlocking to the caller,
and the caller cannot even tell if it is expected to do the unlocking
for it from the return value because both cases return 0 (success).

I am not sure if it is sensible to call that "correct but hard to
understand".  I'd rather see us admit that its behaviour is screwey
and needs fixing for better code health longer term.
