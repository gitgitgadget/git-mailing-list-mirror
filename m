From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Sat, 21 May 2011 18:00:27 -0700
Message-ID: <7v1uzrzh04.fsf@alter.siamese.dyndns.org>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
 <1305961127-26540-5-git-send-email-gitster@pobox.com>
 <4DD82931.6000101@lsrfire.ath.cx> <4DD837EE.3010608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun May 22 03:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNx2D-0005ut-S7
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 03:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038Ab1EVBAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 21:00:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab1EVBAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 21:00:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 026B35CAC;
	Sat, 21 May 2011 21:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nYbQn2iwVJ8F
	Wur6JbHmXNWWir8=; b=n3Bx3kJcAOX6MQncOl4uCQjSoWT1Din0D4i+F5NB0MH2
	R2hpPFF7RZxt1PTYkflF7Iy96iKVnMDmRSHTIakb70W757Flo30eEEEql6ba+kov
	TeaoMF3kxHBTuZ09nInyItwhVd5e/S73bJ4DDI1EkR9S1ifN1bnVVaIW6GGfDv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FaTJWC
	h1+bqgXjkFTP/t2FTweNCwygQv6f/nsLIfeCb4NGseaGJG3sJ5aQTYF05EwN9O+C
	Z2J+TONn7vV9QblkH/BNU9KPsTJu4XbbCAj9JapSAbZj4mL4vPR92Ovh/qkkfrkb
	6VDCAZm9HyzzIDPrMw3j5akAWIn24xNaOt1Rs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D22155CAB;
	Sat, 21 May 2011 21:02:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F3EBE5CA5; Sat, 21 May 2011
 21:02:35 -0400 (EDT)
In-Reply-To: <4DD837EE.3010608@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 22 May 2011 00:08:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 301E1D4C-840F-11E0-8337-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174179>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 21.05.2011 23:05, schrieb Ren=C3=A9 Scharfe:
>>> +		if (ident->state < sizeof(head) &&
>>=20
>> 		// minus one because otherwise we'd compare the
>> 		// terminating NUL as well even though we're not
>> 		// actually looking for a NUL
>> 		if (ident->state < sizeof(head) - 1 &&
>
> Possibly, but that doesn't matter, as the right number of characters =
is
> remembered and the second test below is not passed if we sailed past =
the
> NUL.  Sorry for the noise.

Thanks for a careful reading.

In the second re-roll, I'll split the cascade and ident into two patche=
s
(ident comes first, with a fake cascade that returns NULL to indicate
there is no cascading supported when two "real" filters are given). Als=
o I
do not need two buffers in the cascade. The input to cascade can be fed
directly to the input of cascade->one to fill the cascade's buffer, and=
 we
can feed cascade->two with what is in the cascade's buffer to directly
drain to the output of the cascade.

But that won't happen today.
