From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: warn gc will soon run, give users a chance to
 run manually
Date: Sun, 06 Nov 2011 22:04:47 -0800
Message-ID: <7vfwi031ts.fsf@alter.siamese.dyndns.org>
References: <1320489212-524-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 07:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNIKF-0002wF-Hn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 07:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab1KGGEv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 01:04:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab1KGGEu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 01:04:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C29741EF9;
	Mon,  7 Nov 2011 01:04:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fTSh+QYdoGaH3rUMiBB3JIrjh
	C8=; b=uY7ac0HLyE7RMgwOX3wzCiJuVLoqLoPj79zTzI6wHTtwyaeG23zsh0730
	gLMfmqv2lk5PGmIjcnPKhPVe/7Bk1pOdQJFLATQRSlHY4iM0pOX2ZSCxD/eeExXh
	bwgT1AaCq5vm403u/y0w7GlIrEwZ2u+aEeI0HR7PXYW4WoOuPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ScP0EZ9Vmfj7syKDKlb
	8udk9wId2f7mFmtKQ+2JLUoCJ6IzdZDU8oEy9Txxo7P6OluU9hWdCneydoxI7zLK
	XvqtHWPfzMw2PwYRil+6WHcP1RDVSXwtJ6XGBD8n4fs2f2J7r9Ds4MjykdEheUy4
	pOb/r/oKzKnAXgfPraZtgUj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B48641EF8;
	Mon,  7 Nov 2011 01:04:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F25691EF7; Mon,  7 Nov 2011
 01:04:48 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6662C4A8-0906-11E1-8001-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184954>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I hate it every single time git hangs because gc is activated.
>  Opening another terminal is an option but I would lose all terminal
>  settings I have on the current one (e.g. access to suspended vim
>  sessions).
>
>  I don't think gc_warn_* need their own config vars. Hopefully
>  hardcoded offset is good enough.

Let's think about How the user chooses a custom value for the threshold
(or accepts that the default threshold value 6600 is good enough).

In order to minimize the time the user has to endure when the eventual
auto-gc kicks in, the value needs to be small enough, and to minimize t=
he
frequency the auto-gc kicks in, the value needs to be large enough. It =
is
a balancing act between the two.

Slower users (those who do not create that many objects within a given
time period) can afford to have a small threashold and do not have to
suffer too frequent auto-gc. Busier ones would rather choose larger
threashold to avoid frequent auto-gc because they create many objects
within a given time period.

The reason why the user would want a warning is probably because the us=
er
sometimes is too busy and cannot afford the disruption of auto-gc, but =
the
busy period luckily does not last indefinitely, e.g. if a warning is gi=
ven
two days before the auto-gc actually kicks in, then within that two day=
s
there is a window of time that the user can manually run gc while fetch=
ing
a cup of coffee. For different users, the "two days" in this example wo=
uld
be different. Some people would need longer warning period. Some people
can live with shorter warning period. The number of objects before the
next auto-gc run, divided by the number of objects the user would creat=
e
on average in an hour, would give the length of the warning period.

Now, I suspect that busier users would need longer window than slower
ones, which leads me to suspect that a good default would not be a
hardcoded constant offset (e.g. once you see the new warning, the auto-=
gc
kicks in after creating 100 objects) but some ratio of the threshold
(e.g. you have 2% margin after getting a warning before the auto-gc kic=
ks
in).
