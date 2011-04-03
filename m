From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-sh-i18n--envsubst: our own envsubst(1) for
 eval_gettext()
Date: Sun, 03 Apr 2011 12:05:14 -0700
Message-ID: <7voc4ncg0l.fsf@alter.siamese.dyndns.org>
References: <1301848953-31525-1-git-send-email-avarab@gmail.com>
 <1301848953-31525-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Sc5-0004fo-5P
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab1DCTFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 15:05:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab1DCTFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 15:05:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82C16416C;
	Sun,  3 Apr 2011 15:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=AoiPCapDKUnA5oY3rOcD4jYH3
	cI=; b=WUQW4cp80NtyEsfhc8FEbsI8SV6JxNUzYvzdLBNeoB6MDH3yR/+KEDwQt
	rTRuGoW9lE6s/HkXRloOLEXgrWFpWMlUkQmcM7qAmyZEIH0lo1Ja0zBrVjU63jX6
	sdlb/8O28qZ/DDh9DTAi2d7lOmpSYTNTDDhpWlEnsmZZz7gK6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=dFUIRisw0Ktf4OHBGf6
	EDJmphOmyaLBRHRV/vdyAyYEC/+I1kp789XyI5zH/E9PClQCtInPuoSQ8tsAXQRR
	9sKAaxHGvfUhmgGWF6Sh7rEqPjOfg5I7kGijAYuzDX6oTcSDwPvieY7D++084Str
	1Ykh6GAAxAGJ8+t012Z3eAxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F591416B;
	Sun,  3 Apr 2011 15:07:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C7894156; Sun,  3 Apr 2011
 15:07:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94217754-5E25-11E0-8227-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170770>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a git-sh-i18n--envsubst program which is a stripped-down version
> of the GNU envsubst(1) program that comes with GNU gettext for use in
> the eval_gettext() fallback, instead of using a clever (but broken)
> printf + eval + printf trick.
>
> In a previous incarnation of the gettext series I implemented the
> eval_gettext() fallback like this:
>
>     eval_gettext() {
>         gettext_out=3D$(gettext "$1")
>         gettext_eval=3D"printf '%s' \"$gettext_out\""
>         printf "%s" "`eval \"$gettext_eval\"`"
>     }
>
> This was clever,...

The incoming string to this function is an arbitrary string and it is
asked to interpolate variables $var in it, without any other restrictio=
n
in the string.  If we want to interpolate $var using shell eval, we hav=
e
to somehow put it in the dq context, but all other interpolation done
inside dq context would also be applied to the piece of the string by t=
he
eval, including backslashes, $(command substitution--horrors), etc., wh=
ich
we would have needed to add more quotes to selected places in the strin=
g
(read: parse and find what the shell would interpolate ourselves) to
prevent them from happening.

In hindsight, it should have been clear to all of us from day one that
shell eval based approach would have never worked.

I suspect that the use of envsubst (especially the part that gives the
string itself to envsubst) is not quite right.  What if the message wan=
ted
to say something like this?

        Look at $HOME/.gitconfig and find definition for $var variable.

where we want to show $HOME _literally_, while substituting $var for th=
e
name of the variable?  The underlying envsubst allows you to do so by
telling it which the variables are to be substituted.

	s=3D'Look at $HOME/.gitconfig and find definition of $var variable.'
	HOME=3D/home/junio
        var=3Dcore.i18n
        (
        	export HOME var ;# no need for HOME, but just an illustration
		echo "$s" | envsubst '$var'
	)

but eval_gettext interface doesn't seem to be expressive enough to do t=
his;
you would let it scan the whole "$s" and end up substituting $HOME, no?

Perhaps it is not an issue in real life; after all eval_gettext interfa=
ce
is not something you invented in 5 minutes without thinking deeply, but=
 is
what you plan to use from outside codebase that presumably has seen a w=
ide
use in the field, and it may be just that I am worried too much about a=
n
implausible corner case, but I thought I should bring it up.

Thanks.
