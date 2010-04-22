From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 15:44:53 +0300
Message-ID: <20100422124453.GA30328@LK-Perkele-V2.elisa-laajakaista.fi>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
 <7vwrw0573t.fsf@alter.siamese.dyndns.org>
 <20100422094153.GA504@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 14:46:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4vo0-0007T5-FV
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 14:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab0DVMqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 08:46:42 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:50308 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab0DVMql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 08:46:41 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 79990C82DE;
	Thu, 22 Apr 2010 15:46:39 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A033A273598; Thu, 22 Apr 2010 15:46:39 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 3DCC61C6389;
	Thu, 22 Apr 2010 15:46:33 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100422094153.GA504@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145527>

On Thu, Apr 22, 2010 at 04:42:16AM -0500, Jonathan Nieder wrote:
>=20
> Thanks for the clarification.  As I see it, these are two different
> classes of problem:
>=20
> 1. The git daemon is very quiet, usually for good reason, as you
>    mentioned [1] [2].
>=20
> 2. The git daemon and protocol helpers do not always send the datum =E2=
=80=9Ca
>    controlled fatal error occured=E2=80=9D by writing some message (a=
ny
>    message) to side band 3.
>=20
> Fixing the daemon=E2=80=99s share in both might require setting up a =
side band
> very early.  If an RFC patch appears setting up the side band (or an
> explanation for why that=E2=80=99s not possible), I would be happy to=
 start
> work building from there.

There are few subcases of daemon-level errors:

1A) Invalid request

No feedback is needed. These are protocol violations and well-behaved
clients don't send these.

1B) Request for invalid repository

These should have one error. That error can be sent using ERR response
(already supported).

1C) Request for disabled service

These too can be reported via ERR. One has to be careful not to create
information leak using these.

1D) Catastrophic network error

One can't do anything about these.

1E) Relay error

Really shouldn't happen. Due to service state being unknown at time
of things going wrong, one can't do much about these (what if
relay error occurs in middle of packet? pad packet with zeroes?)


So, pretty much the only daemon-level errors with feedback required
would be one for invalid repository and disabled service. How about:

"foo/example: unreadable or anonymous fetching not allowed."
"foo/example: unreadable or anonymous pushing not allowed."
"foo/example: unreadable or anonymous snapshotting not allowed."
"fooserv: requested service unknown."

And all of these can be sent over ERR. I don't see need for using
sidebands.

> That has been the big obstacle for me experimenting with it, more tha=
n
> the information disclosure.  But this is easy to say.  The doing is
> more important.

-Ilari
