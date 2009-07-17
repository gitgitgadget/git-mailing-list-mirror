From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] pull: support rebased upstream + fetch + pull 
 --rebase
Date: Fri, 17 Jul 2009 01:25:08 -0700
Message-ID: <7vr5wf67iz.fsf@alter.siamese.dyndns.org>
References: <adf1fd3d0907152329v7f49999u42b0d0fc4d39f5e9@mail.gmail.com>
 <1247731921-2290-1-git-send-email-santi@agolina.net>
 <alpine.DEB.1.00.0907161035060.3155@pacific.mpi-cbg.de>
 <7vhbxc8inp.fsf@alter.siamese.dyndns.org>
 <adf1fd3d0907161618o61ee4b58of25659f8c36420f7@mail.gmail.com>
 <adf1fd3d0907170051u7268d8f6kba7f2e529381d275@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRikw-0001BW-UK
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934226AbZGQIZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2009 04:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934219AbZGQIZR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:25:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934179AbZGQIZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:25:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C630565B6;
	Fri, 17 Jul 2009 04:25:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 38C6A65B2; Fri,
 17 Jul 2009 04:25:10 -0400 (EDT)
In-Reply-To: <adf1fd3d0907170051u7268d8f6kba7f2e529381d275@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 17 Jul 2009 09\:51\:38
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A4DC2CE-72AB-11DE-B1C7-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123447>

Santi B=C3=A9jar <santi@agolina.net> writes:

> 2009/7/17 Santi B=C3=A9jar <santi@agolina.net>:
>> 2009/7/16 Junio C Hamano <gitster@pobox.com>:
>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>
>>>> How about
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 oldremoteref=3D"$(git rev-list --boundary HEA=
D --not \
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $(git rev-list -g $remoteref | sed 's/$/^@/') |
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -e '/^[^-]/d'=
 -e q)"
>>>>
>>>> Explanation: the "git rev-list -g $remoteref" lists the previous c=
ommits
>>>> the remote ref pointed to, and the ^@ appended to them means all t=
heir
>>>> parents. =C2=A0Now, the outer rev-list says to take everything in =
HEAD but
>>>> _not_ in those parents, showing the boundary commits. =C2=A0The "s=
ed" call
>>>> lists the first such boundary commit (which must, by construction,=
 be one
>>>> of the commits shown by the first rev-list).
>>>
>>> Hmm, I am not sure about that "(which must..." part.
>
> Unfortunatly you are right with the "(which must..." part. Even
> without the ^@. Normally gives the right answer, but it is not
> sure that the first commit boundary is the correct one. For
> example:
>
>          o--C
>         /
>  A--x--y--B--o--z
>      \      /
>       o----o
>
> A, B, C are upstream@{n}
>
> It involves a merge with a branch forked before the fork commit
> for the current branch, and it will not work neither with git
> pull --rebase. We could say that it is not supported, but
> nevertheless it gives the wrong answer.
>
> The right answer is B, but:
> $ git rev-list --boundary z --not C B A
> z
> o
> o
> o
> -x
> -B

Now a short question.  Does your original loop give a correct answer in
this case?
