From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: filter out invalid remote configurations
Date: Tue, 27 Aug 2013 07:50:33 -0700
Message-ID: <xmqqr4dffarq.fsf@gitster.dls.corp.google.com>
References: <1377608796-13732-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKbQ-0006du-Vu
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab3H0Ouh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 10:50:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab3H0Oug convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 10:50:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1BE3C8D8;
	Tue, 27 Aug 2013 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PbhkP/eexcMJ
	ytN0IuwIxyNHEIs=; b=k9TsOC8ZyXDKdCcSe9HedHpfYO2GUxpMWuIDGRhomqAJ
	7KTVqwQ913j2C9ep9EJs6fvQ/0UJSIAWmRvHzf7IlXfd4njKZlyb2qa6313+j/KU
	M3LNrU1ydzZJuLGL514iaYuA7qF0u1v2YrtSOow9EEHPzcy5AEF82DlRMUddXUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZzO3BA
	JK9c7Rx/yY/Ldk7KQHO+LHLG4V8U0yk2Z4I/AyqFU1p0KEvGhsCN88io39XExQCp
	/JVd4wjTXv14liB1C78ifqiOUvY7wnb7jmdqE+j5HVdlPVL7KODJyaZacX9btYIh
	DaXicmp3sbv7pdBr1a7wGNrxIshIpJitQe1JM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F41C33C8D7;
	Tue, 27 Aug 2013 14:50:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47E1A3C8D2;
	Tue, 27 Aug 2013 14:50:35 +0000 (UTC)
In-Reply-To: <1377608796-13732-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Tue, 27 Aug 2013 15:06:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07AB9618-0F28-11E3-AC96-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233094>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> In remote's configuration callback, anything that looks like
> 'remote.<name>.*' creates a remote '<name>'. This remote may not end
> up having any configuration for a remote, but it's still in the list,
> so 'git remote' shows it, which means something like
>
>     [remote "bogus"]
>         hocus =3D pocus
>
> will show a remote 'bogus' in the listing, even though it won't work
> as a remote name for either git-fetch or git-push.

Isn't this something the user may want to be aware of, though?
Hiding these would rob a chance for such an entry to be noticed from
the user---is it a good change?

> Filter out the remotes that we created which have no urls in order to
> work around such configuration entries.
