From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-cvsserver: break the loop after successful hit
Date: Tue, 06 Jul 2010 22:28:41 -0700
Message-ID: <7vwrt7zwqe.fsf@alter.siamese.dyndns.org>
References: <-1324832183078898154@unknownmsgid>
 <AANLkTik0pMkYDHZD9jgzn3OaGUdyeiFwAv7o3OTUmEvO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>
To: =?utf-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:28:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNBq-00006z-CM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0GGF2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 01:28:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GGF2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 01:28:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E054C2433;
	Wed,  7 Jul 2010 01:28:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=H+MxBNL74Rt4p6ito1TY711Di
	DM=; b=MJCsIcKpIuZ7Ay60OeZS0iRMdltVdxL+I6+HEETFn3zd/jFfrs2IitLFo
	JXtRfMkJ5Dl+FoXNxeg3AoTydrKckQqUcSEc1wrc59YOuFeuvAnURao1PsmGC+Z9
	ESvXJxUmK5diPMjMwHGg9vM/LRB6w+Y+e0YA5tLK1eBMJnxecQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=AA98yesMwquwU7aln7b
	JraHEjK/xXISaFo4zBQBEfNfcARbFjUuYgyTGzBNjgxB8yvzUSBMJUl/X/rwJpie
	ws7kTRVMS9G12Gbz0lFm9tL3H34DIfFMYWfQ10skfYoBKJlDGu2uQ3hGogXeROOo
	BcdBg7hbuh23ChE8D7J01d4I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C94B8C2432;
	Wed,  7 Jul 2010 01:28:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFCB2C2430; Wed,  7 Jul
 2010 01:28:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 849EF684-8988-11DF-A953-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150450>

=C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@gmail.com> writes:

> No need to check for more lines of the authentication database after =
found a
> matching one.

s/found/finding/;

But I see a bigger issue here.  Is it plausible that you might want to
allow two entries for one user, with two different passwords, in an aut=
hdb
file?  The current code allows it, but if we want to disallow it, we co=
uld
instead add your "last", like this, if you do not break the structure o=
f
the conditional statements in the original code.

	while (<$passwd>) {
		if (m{^\Q$user\E:(.*)}) {
			if (crypt($user, $password) eq $1) {
				$auth_ok =3D 1;
			}
			last;
		}
	}

Or have the "last" inside the inner "if" statement to keep that logic.

Either way I think the original nested "if" is much easier to read than
your version.
