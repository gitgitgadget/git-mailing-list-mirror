From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 2 Aug 2011 12:13:57 -0600
Message-ID: <20110802181357.GA1861@sigill.intra.peff.net>
References: <20110728170222.GB15931@sigill.intra.peff.net>
 <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
 <20110801174603.GB10302@sigill.intra.peff.net>
 <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com>
 <20110801182516.GC10302@sigill.intra.peff.net>
 <4E371109.7050500@lsrfire.ath.cx>
 <4E3718B4.6090803@kdbg.org>
 <4E37202B.80208@lsrfire.ath.cx>
 <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:14:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoJTl-00080g-12
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab1HBSOE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 14:14:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47822
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257Ab1HBSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 14:14:03 -0400
Received: (qmail 31719 invoked by uid 107); 2 Aug 2011 18:14:35 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Aug 2011 14:14:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Aug 2011 12:13:57 -0600
Content-Disposition: inline
In-Reply-To: <4E3829DC.8070802@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178494>

On Tue, Aug 02, 2011 at 06:46:20PM +0200, Ren=C3=A9 Scharfe wrote:

> The output of gzip is not simply always mangled, though (taken from m=
y
> earlier email, all three are working):
>=20
> 	$ git archive v1.7.6 | gzip -cn | md5sum
> 	a0ca1c873a533a5fcd41d248fb325a5b *-
>=20
> 	$ git archive --format=3Dtar.gz v1.7.6 | md5sum
> 	a0ca1c873a533a5fcd41d248fb325a5b *-
>=20
> 	$ git archive v1.7.6 | gzip -cn >a.tgz && md5sum <a.tgz
> 	a0ca1c873a533a5fcd41d248fb325a5b *-
>=20
> It's only broken if we call it from git archive:
>=20
> 	$ git archive --format=3Dtar.gz v1.7.6 >a.tgz && md5sum <a.tgz
> 	30886283af1aed05ae6a36fc5aeda077 *-
>=20
> 	$ git archive -o a.tgz v1.7.6 && md5sum <a.tgz
> 	30886283af1aed05ae6a36fc5aeda077 *-
>=20
> But not if we stuff the result into a pipe instead of a file:
>=20
> 	$ git archive --format=3Dtar.gz v1.7.6 | cat >a.tgz && md5sum <a.tgz
> 	a0ca1c873a533a5fcd41d248fb325a5b *-
>=20
> It _is_ confusing.

Hmm. So it's not _just_ the pipe vs file thing. What's different about
calling it from the shell, versus the way we call it from git-archive?

IOW, the pipe trick you mentioned is one way to fix it; but it may be
more elegant to do whatever it is the shell is doing to get those
results (unless the shell is secretly putting a "cat" into the pipeline
:) ).

-Peff
