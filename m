From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH B v4 5/5] git config: don't allow --get-color* and 
 variable type
Date: Sun, 22 Feb 2009 09:35:01 -0800
Message-ID: <7vmycez86y.fsf@gitster.siamese.dyndns.org>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-6-git-send-email-felipe.contreras@gmail.com>
 <7vmyce2z9q.fsf@gitster.siamese.dyndns.org>
 <94a0d4530902220912r94e00d6ha7592bc397baa57c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIFt-0002zH-I3
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbZBVRfK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 12:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbZBVRfK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:35:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZBVRfI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:35:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE2E32BB06;
	Sun, 22 Feb 2009 12:35:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 807E12BB29; Sun,
 22 Feb 2009 12:35:03 -0500 (EST)
In-Reply-To: <94a0d4530902220912r94e00d6ha7592bc397baa57c@mail.gmail.com>
 (Felipe Contreras's message of "Sun, 22 Feb 2009 19:12:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25CA64AA-0107-11DE-B5A5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111029>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

>>> diff --git a/builtin-config.c b/builtin-config.c
>>> index 8045926..9930568 100644
>>> --- a/builtin-config.c
>>> +++ b/builtin-config.c
>>> @@ -359,6 +359,11 @@ int cmd_config(int argc, const char **argv, co=
nst char *unused_prefix)
>>> =C2=A0 =C2=A0 =C2=A0 if (get_colorbool_slot)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions |=3D ACTION_GET_COLORBOO=
L;
>>>
>>> + =C2=A0 =C2=A0 if ((get_color_slot || get_colorbool_slot) && types=
) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("--get-color and =
variable type are incoherent");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(buil=
tin_config_usage, builtin_config_options);
>>> + =C2=A0 =C2=A0 }
>>> +
>>
>> I do not think I suggested anything like this, so I'd decline to tak=
e
>> credit for this patch.
>>
>> Strictly speaking, "--bool --get-colorbool diff.color 1" shouldn't e=
rror
>> out, don't you think? =C2=A0And it certainly shouldn't say "--get-co=
lor".
>
> Huh? I misinterpreted:
> I see "git config --bool --get-color diff.color.whitespace" is still
> allowed, which you might want to tighten further.

"--get-color" gets, escape sequence to throw at the terminal to get the
color configured.  It does not make sense to ask for bool (or int) for
that action.

"--get-colorbool" asks if it is appropriate to use such escape sequence
(e.g. when the output is tty and config says "auto", you would get "ple=
ase
use color").  In other words, its type is always bool, so using it as
--int does not make sense but we cannot really say using it with --bool=
 is
nonsense.

The two use formats with and without is_tty are meant to be used in
scripts this way:

	# without $is_tty
	if git config --get-colorbool color.diff
        then
        	use_color=3Dtrue
	else
        	use_color=3Dfalse
	fi

        # with $is_tty
        if test -t 1
        then
        	is_tty=3D1
	else
        	is_tty=3D0
	fi
        use_color=3D$(git config --get-colorbool color.diff $is_tty)

In the latter form, output from the command is captured by $() and does
not see if the stdout of the calling script is a tty, hence the script
feeds that information to the command as an extra parameter.
