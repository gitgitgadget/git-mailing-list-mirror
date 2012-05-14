From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-protocol: fix first-want separator in the examples
Date: Mon, 14 May 2012 09:32:50 -0700
Message-ID: <7vmx5aiuz1.fsf@alter.siamese.dyndns.org>
References: <1336779893-23636-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon May 14 18:33:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyCn-0000qy-7P
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402Ab2ENQc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 12:32:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab2ENQc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 12:32:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E8493EB;
	Mon, 14 May 2012 12:32:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kQkS52XmEdo5
	9DOYFdzUOXAiIdM=; b=ftpW2/QRcWLV5uP5WQSN8fLQNClYJSmuzPHifEFzex1P
	OIX0UjME9aC5SWyj09usjuIuxSY8cHg1ryPA6tPDgK9GGL0BaKiSJOMcsXSfWyXo
	USFEaMPPaYtqgk6VtgKVGCjDaEkh1K6LMGI8AyqGdEEeJHUPjOG9BntLT14kFPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QnqPKA
	LTmpSzuPnniGsMOeB1rj0pkjQ9prJFPR4ki26YiY9gvS06EmV6LDrqZuJrNgDjaG
	QRfGH2/B854VooRC144sDJZ/GkOMGP43Lk5BKckazNhZgQPwhZ51sIYidFB4BKQV
	h3S+b6TgmJmObSmKAh3/MccPHeVyPuSv7Mvmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F3D093EA;
	Mon, 14 May 2012 12:32:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D179493E9; Mon, 14 May 2012
 12:32:56 -0400 (EDT)
In-Reply-To: <1336779893-23636-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 12 May 2012 01:44:53
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 762D67B4-9DE2-11E1-998B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197781>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Just after this, in the push section, it separates by NUL
> again. Running git-receive-pack locally looks like it's actually NUL
> SP, but I'm guessing that the SP comes from a printf that doesn't tak=
e
> being first into account, so I left it alone.

That leading SP was a misguided one step in the right direction ;-) to
always delimit both ends with SP, so that strstr(capabilities, " cap ")
can see if capability 'cap' is advertised.  So the protocol definition
that says "capability-list follows NUL" is correct, but capability-list
can have extra SPs on either end (or in between tokens for that matter)=
,
and what you observed has an extra SP at the beginning.

It was misguided because the capability finding code has to be able to
read output from older implementations that didn't try to be helpful to
strstr(capabilities, " cap ") style parsers; in other words, if all the
implementations advertised their capabilities that way from day one, it
would have helped, but retrofitting that does not help very much.
