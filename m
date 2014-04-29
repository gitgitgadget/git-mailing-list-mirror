From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 28 Apr 2014 23:23:47 -0400
Message-ID: <20140429032347.GB11979@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
 <20140428193502.GD25993@sigill.intra.peff.net>
 <535EB167.4030804@web.de>
 <20140428200326.GA2961@sigill.intra.peff.net>
 <535EBEDA.5070207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyeE-0003N9-FH
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbaD2DXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 23:23:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:40929 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbaD2DXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:23:49 -0400
Received: (qmail 8608 invoked by uid 102); 29 Apr 2014 03:23:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 22:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 23:23:47 -0400
Content-Disposition: inline
In-Reply-To: <535EBEDA.5070207@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247515>

On Mon, Apr 28, 2014 at 10:49:30PM +0200, Torsten B=C3=B6gershausen wro=
te:

> OK, thanks for the description.
> In theory we can make Git "composition ignoring" by changing
> index_file_exists() in name-hash.c.
> (Both names must be precomposed first and compared then)

Yeah, we could perhaps get away without storing the extra precomposed
form if we just stored the entries under their precomposed hash, and
then taught same_name to use a slower precompose-aware comparison. But =
I
also see that we do binary searches in index_name_pos (called by
index_name_is_other). I don't know if we'd have to deal with this
problem there, too.

> I don't know how much people are using Git before 1.7.12 (the
> first version supporting precomposed unicode).
>=20
> Could we simply ask them to upgrade ?

I'm not sure what you mean here. Upgrading won't help, because the
values are baked into existing history created with the old versions
forever. Any time I "git checkout v1.0" on the broken project, a modern
git will complain about the ghost untracked file.

> The next problem is that people need to agree if the repo should stor=
e
> names in pre- or decomposed form.
> (My voice is for precomposed)
> Unfortunatly the core.precomposeunicode is repo-local, so everybody
> needs to "agree globally" and "configure locally".

Yeah, that was sort of my "point 1" from the patch. I'm a bit worried
that it creates problems for people on other systems, though. Linux
people do not need to care about precomposed/decomposed at all, and any
attempt we make to automatically handle it is going to run afoul of
non-utf8 encodings. Not to mention that it does not solve the "git
checkout v1.0" problem above.

> Side note:
> I which we had this config variable travelling with the repo, like .g=
itattributes does
> for text dealing with CRLF-LF.

Yeah, I guess if we wanted to enforce it everywhere, you would have to
use .gitattributes since we cannot safely turn on such a feature by
default.

> I don't know how many reports you have, reading all this it feels as =
if the effected users
> could "normalize" their repos and run "git config core.precomposeunic=
ode true", followed
> by "git config --global core.precomposeunicode true".
> Does that sound like a possible way forward ?

I have just a handful of reports. Maybe 3-4? I didn't dig them all up
today, as it would be a non-trivial effort. But I have no idea how good
a sampling that is.

-Peff
