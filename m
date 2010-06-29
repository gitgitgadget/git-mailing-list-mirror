From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Tue, 29 Jun 2010 10:59:15 -0700
Message-ID: <7vy6dx90uk.fsf@alter.siamese.dyndns.org>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 29 19:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTf5m-0002G2-Tn
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 19:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528Ab0F2R7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 13:59:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0F2R7Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 13:59:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DAD0C0C9A;
	Tue, 29 Jun 2010 13:59:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cLm/CtfbnYfR
	UiGNYNe3R5AVRwA=; b=uBq/Z1M0rrqDLj2LTKO98OpaYu1U0vCxGhQz0vL85GP5
	Qcwcmz1Y5v5vPwbaVGdZBN3xitDNrtiU0cIZsFLkH/S6H0n+AvmIHbvC3ekpNZLa
	a8F/yySyBZf+cGg2MshceQSvgyAITe65oE8FUs/dLTjz/iJxRqVD88l1dl1VfnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hCn5tB
	JlbQRhdND0+mMbNRplvI/fIz1n3WjgXVJ0SpX4loE1NDe24zb0l1e3EU+Mus4saP
	rZZRLzg0XRZbzLzwNbYCL1OqsRyXSZXQTo6ZWcn7UenXxlAlOZfgyvVjT7XqI7Wa
	A0kQOr1hAb/PYRlvEiOflXJa3BL+bnxdFOBr8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 562ECC0C99;
	Tue, 29 Jun 2010 13:59:20 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94AF3C0C97; Tue, 29 Jun
 2010 13:59:17 -0400 (EDT)
In-Reply-To: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue\, 29 Jun 2010 13\:38\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AC6F054-83A8-11DF-82C6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149923>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> ...  But I'm not sure I
> can rely on that when gc'ing.

Looking at the timestamp of "thisimage" would probaboly be more sensibl=
e
than "preimage" alone, _if_ "thisimage" still exists.  It is rewritten
every time this particular conflict is observed; this is not necessaril=
y
when the recorded resolution is _used_, but it may be close enough in
practice.

You probably would want to rename the helper as "last_checked_at", thou=
gh.

After rerere does its work, however, "thisimage" does not have to stay
around (the user can remove it, or we could enhance "gc" to do so).

> +		if (has_rerere_resolution(e->d_name)) {
> +			then =3D rerere_last_used_at(e->d_name);
> +			if (!then)
> +				continue;

Here you already know that you have resolution (i.e. "postimage"), but
your new function cannot stat a corresponding "thisimage", so you err
on the safer side---but that means you may keep pre/post image pairs
forever if somebody removes otherwise unused "thisimage" from a distant
past.  Perhaps we should apply cutoff_noresolve to the entry here?

One possibility is to look at the timestamp of the directory itself
instead.  Then we can safely gc otherwise-unused "thisimage" file when
rerere is not in use.  I wonder if directory m_time timestamps are usab=
le
for this purpose on non-POSIX platforms?
