From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for
 doing  custom path transformations
Date: Fri, 13 Mar 2009 23:58:58 -0700
Message-ID: <7vvdqcd1zh.fsf@gitster.siamese.dyndns.org>
References: <49B7DFA1.4030409@viscovery.net>
 <1236852820-12980-1-git-send-email-johan@johansorensen.com>
 <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
 <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johan =?utf-8?Q?S=C3=B8rensen?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 08:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiNrV-0002aR-NH
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 08:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971AbZCNG7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 02:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZCNG7K
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 02:59:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZCNG7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 02:59:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 46BB555B0;
	Sat, 14 Mar 2009 02:59:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8A00655AA; Sat,
 14 Mar 2009 02:59:00 -0400 (EDT)
In-Reply-To: <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
 (Johan =?utf-8?Q?S=C3=B8rensen's?= message of "Thu, 12 Mar 2009 20:06:25
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9C01D6A4-1065-11DE-9B91-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113239>

Johan S=C3=B8rensen <johan@johansorensen.com> writes:

>> More importantly, you might want to point out the security concerns =
of
>> running a script with the full permissions of git-daemon. =C2=A0(AFA=
ICT from
>> your patch you are not dropping any privileges at any point.)
>
> Do you really think this is needed? It doesn't seem like running the
> hook scripts does anything more than trusting the script author and
> permissions of the hook scripts (?). I see the path-filter script
> exactly the same way, with the exception of having to double-check th=
e
> user supplied path the script receives.

If I am not misreading the patch (I only skimmed it), the script is wha=
t
is given to the git-daemon process from its command line, so it is unde=
r
total control of the site owner.  It is much much much less problematic
than the security worry of allowing random hook scripts to be installed=
 in
the repositories hosted at a hosting site.  I think Dscho is being a bi=
t
too paranoid in this particular case.

However, being paranoid is a good thing when we talk about instructions=
 we
give to the end users.  The site owner who uses this facility needs to =
be
aware that the script is run as the same user that runs git-daemon, and
that more than one instances of the script can be run at the same time.
The script writer needs to be careful about using the same scratchpad
location for the temporary files the script uses and not letting multip=
le
instances of scripts stomping on each other's toes.  These things need =
to
be documented.

Do you run git-daemon from inetd, or standalone, by the way?  I am
wondering how well it would scale if you spawn an external "filter path=
"
script (by the way, "filter path" sounds as if it checks and conditiona=
lly
denies access to, or something like that, which is not what you are usi=
ng
it for.  It is more about rewriting paths, a la mod_rewrite, and I thin=
k
the option is misnamed) every time you get a request.
