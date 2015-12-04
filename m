From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP
Date: Fri, 04 Dec 2015 10:40:07 -0800
Message-ID: <xmqqtwnyrraw.fsf@gitster.mtv.corp.google.com>
References: <564AFF32.1030406@web.de> <564B00BD.7010709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 19:40:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4vHq-0002aK-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 19:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbLDSkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2015 13:40:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbbLDSkL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2015 13:40:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD1AC2FE0C;
	Fri,  4 Dec 2015 13:40:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LSaoSdu3LAyF
	NeQjMFtR5/uxUGY=; b=Ar4oGgXO1O7vmlkPLOoPq7gaDj6UyrMFbXyMD4EzW1zd
	ZaEqnZ7SWcRHTj0gS+z4rzir74OT52svhUvLWbj+X8CDDuHJKgrWYN3BcFx3m0Xh
	fUQcAshWlCIaIfHTFFkFhvDXEcvGHaq0RwKlhW4Re9RXUw0PTB1jXnB53pjZXgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NJoXzd
	QorHUy8y5Ks8nxSkeNrzVjcbOS1DhJ4lCFmQRS7cmy4JyGcqXknOCFZTADi+Sox+
	Nx2zncjz47Z31RU29YRM6b0AeEQZ8g9fKCLy3RgkPL460hqwPXQ0Br48RsLl5fGt
	wmH0xRwF8G7u8agx/6aOl3DCW0FFQzMxTd1rs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4FAE2FE0B;
	Fri,  4 Dec 2015 13:40:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39EA02FE0A;
	Fri,  4 Dec 2015 13:40:09 -0500 (EST)
In-Reply-To: <564B00BD.7010709@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 17
	Nov 2015 11:26:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7207D88E-9AB6-11E5-8EF1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281994>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The flag PARSE_OPT_NO_INTERNAL_HELP is set to allow overriding the
> option -h, except when it's the only one given.
> This is the default behavior now,...

OK, so in the old world order, "-h" used to trigger the internal
help even before consulting parse_short_opt() to see if there is a
handler supplied by the caller, and NO_INTERNAL_HELP was invented as
a kludge to to disable this behaviour.  The existing two users
(dealt with 4/5 and 5/5) both used this mechanism to let their own
handler kick in, but they had to make "-h" without anything else on
the command line behave just like the internal one, while handling
"-h" with something else on the command line do a custom thing.

In the new world order, internal "-h" handler is called only after
seeing that parse_short_opt() decides there is no handler for "-h"
as a fallback.

	Side note.  Not really.  Among the three uses of
	intenal_help in parse_options_step(), the first one ("lone
	-h asks for help") is used before we ask parse_short_opt().

I wonder if we can/want to further tweak this in a follow-up
series.  If that is done, I think NO_INTERNAL_HELP can go away, as
its only effect would be to make us say "unknown option" when "-h"
alone was given from the command line for an options[] array that
does not have a handler for "-h".
