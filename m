From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 9 Jul 2013 15:35:42 +0200
Message-ID: <20130709133542.GJ10217@login.drsnuggles.stderr.nl>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
 <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
 <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
 <20130528091812.GG25742@login.drsnuggles.stderr.nl>
 <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 15:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwY5G-00069w-50
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 15:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3GINfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 09:35:54 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:57999 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab3GINfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 09:35:53 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UwY50-000679-CS; Tue, 09 Jul 2013 15:35:43 +0200
Received: (nullmailer pid 23504 invoked by uid 1000);
	Tue, 09 Jul 2013 13:35:42 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7va9nf2fyp.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229953>

Hi Junio,

> Doing it "correctly" (in the shorter term) would involve:
>=20
>  - adding a capability on the sending side "fixed-off-by-one-depth"
>    to the protocol, and teaching the sending side to advertise the
>    capability;
>   =20
>  - teaching the requestor that got --depth=3DN from the end user to
>    pay attention to the new capability in such a way that:
>=20
>    - when talking to an old sender (i.e. without the off-by-one
>      fix), send N-1 for N greater than 1.  Punt on N=3D=3D1;
>=20
>    - when talking to a fixed sender, ask to enable the capability,
>      and send N as is (including N=3D=3D1).
>=20
>  - teaching the sending side to see if the new behaviour to fix
>    off-by-one is asked by the requestor, and stop at the correct
>    number of commits, not oversending one more.  Otherwise retain
>    the old behaviour.

While implementing the above, I noticed my fix now introduced an
off-by-one error the other way. When investigating, I found this commit=
:

	commit 682c7d2f1a2d1a5443777237450505738af2ff1a
	Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
	Date:   Fri Jan 11 16:05:47 2013 +0700

	    upload-pack: fix off-by-one depth calculation in shallow clone

	    get_shallow_commits() is used to determine the cut points at a giv=
en
	    depth (i.e. the number of commits in a chain that the user likes t=
o
	    get). However we count current depth up to the commit "commit" but=
 we
	    do the cutting at its parents (i.e. current depth + 1). This makes
	    upload-pack always return one commit more than requested. This pat=
ch
	    fixes it.

	    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
	    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Which actually seems to fix the off-by-one bug that is described in thi=
s
thread, but without going through the hoops of preserving current
behaviour for older git versions (that is, it makes behaviour dependent
on server version instead of client version).

Does this mean the discussion in this thread is meaningless, or is that
commit not intended to be the final fix?

In any case, IIUC that particular patch makes a piece of the existing
code dead, which needs to be removed.

Gr.

Matthijs
