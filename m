From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3.5 02/12] send-email: No longer repeatedly test if 
 $smtp_server is a command
Date: Sun, 19 Apr 2009 21:21:11 -0700
Message-ID: <7viql0lzuw.fsf@gitster.siamese.dyndns.org>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <7veivop0dx.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904191937x55f94dc3sb6fbda27f380b105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 06:23:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvl2f-0004Ip-23
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 06:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbZDTEVY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 00:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbZDTEVX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 00:21:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZDTEVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 00:21:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A793D106E3;
	Mon, 20 Apr 2009 00:21:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E3207106E0; Mon,
 20 Apr 2009 00:21:17 -0400 (EDT)
In-Reply-To: <b4087cc50904191937x55f94dc3sb6fbda27f380b105@mail.gmail.com>
 (Michael Witten's message of "Sun, 19 Apr 2009 21:37:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B35A276A-2D62-11DE-8EBA-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116933>

Michael Witten <mfwitten@gmail.com> writes:

> On Sun, Apr 19, 2009 at 20:41, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> This is a minor change, but it's cleaner, and it sets up the
>>> $smtp_server initialization code for future improvements.
>>> ...
>>> -if (!defined $smtp_server) {
>>> +if (defined $smtp_server) {
>>> +
>>> + =C2=A0 =C2=A0 $smtp_server_is_a_command =3D ($smtp_server =3D~ m{=
^/});
>>> +
>>> +} else { # use a default:
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 foreach (qw( /usr/sbin/sendmail /usr/lib/sendm=
ail )) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (-x $_) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $smtp_server =3D $_;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 $smtp_server_is_a_command =3D 1;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 last;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> =C2=A0 =C2=A0 =C2=A0 }
>>> - =C2=A0 =C2=A0 $smtp_server ||=3D 'localhost'; # could be 127.0.0.=
1, too... *shrug*
>>> +
>>> + =C2=A0 =C2=A0 $smtp_server =3D 'localhost'; # 127.0.0.1 is not co=
mpatible with IPv6
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unless $smtp_server_is_=
a_command;
> ...
>> I think a genuine improvement would be something like:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!defined $smtp_server) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$smtp_server =
=3D 'localhost';
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> You don't care to search for a possible sendmail?

That's something you already did before setting smtp_server
unconditionally to localhost, right?  You do (in the above):

	if (user gave $smtp_server) {
        	use it, notice and note if it is a command;
	} else {
                if (standard binary avaiable) {
                	use it, note it is a command;
		}
                # otherwise it still is undef
	}
	if (!defined $smtp_server) {
        	set it to localhost;
	}

But I would probably write it this way:

	if (user didn't give us $smtp_server) {
                if (standard binary avaiable) {
                	use it, note it is a command;
		} else {
                	use localhost;
		}
	}
	if ($smtp_server looks like a command) {
        	$smtp_server_is_a_command =3D true;
	}
