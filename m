From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/18] Place the open() call inside the do{} struct and prevent failing close
Date: Thu, 06 Jun 2013 14:58:41 -0700
Message-ID: <7vbo7iyk8e.fsf@alter.siamese.dyndns.org>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-18-git-send-email-celestin.matte@ensimag.fr>
	<7vhahbx7r7.fsf@alter.siamese.dyndns.org>
	<51B0FF75.9070506@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, benoit.person@ensimag.fr,
	matthieu.moy@grenoble-inp.fr
To: =?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkiCn-0001IS-EA
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab3FFV6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 17:58:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab3FFV6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 17:58:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 148032587F;
	Thu,  6 Jun 2013 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=R12g7z7EqtDz
	sFHG2KesJdJkjTc=; b=xO/PpGL2xEnSvEfOlc9r/E+selIh7pKxpVr90Ok1uCJQ
	frmtEEbjiL3FvwNhy4tJ7IScrjSbx/cqtryBJTJ7Dh/kZHjOv7dulogDFrLMzIMB
	KMP61gdubFmc4MS+2bW0jFXfJhoVwLG0Y0DeVGhLL2aoTbmRIvqcvZRV8vCsUK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xEcKnd
	G1WHYmb8XdrWr4Q6H1SEzX7RrmCvL+qhMnjb+RsLBe5AYE7NnNus08KPxApR31uo
	+Z6Syb5g5NOjRucCmsjTiQrwWcvsCk8HPk+K16TFkBVr6qcsV71i0m9XV0i3WDG/
	+O5HNC1jsXdEB2PCMnvU3ZOwfkZNoem9l/TAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C54A2587E;
	Thu,  6 Jun 2013 21:58:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7001825877;
	Thu,  6 Jun 2013 21:58:43 +0000 (UTC)
In-Reply-To: <51B0FF75.9070506@ensimag.fr> (=?utf-8?Q?=22C=C3=A9lestin?=
 Matte"'s message of
	"Thu, 06 Jun 2013 23:30:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41230DBE-CEF4-11E2-9546-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226566>

C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:

> So using autodie may not be a good idea.
> But the problem is that in the current state, open() return values ar=
e
> checked, but print ones are not, although it should be.

I tried "man autodie" and tried to spot 'print' in the categories
list that shows things like ":all covers :default which in turn
covers :io which in turn covers read, seek, ..." and didn't see any.

Running the attached as

	$ perl ad.perl >&-

gave me "Hi" (i.e. no failure from print) but of course killed a
failing syswrite().

So I am not sure your "we must check print" matches well with use of
autodie, either.

-- >8 --
#!/usr/bin/perl -w

use warnings;
use autodie;

for (my $i =3D 0; $i < 256; $i++) {
	print "Did this die?\n";
}

print STDERR "Hi\n";

for (my $i =3D 0; $i < 256; $i++) {
	syswrite(1, "Did this die?\n");
}

print STDERR "Lo\n";

exit(0);
--- 8< --
