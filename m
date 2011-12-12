From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/3] grep attributes and multithreading
Date: Mon, 12 Dec 2011 22:16:05 +0100
Message-ID: <cover.1323723759.git.trast@student.ethz.ch>
References: <4ED8F9AE.8030605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDES-0004dm-Bt
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab1LLVQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 16:16:16 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:29994 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab1LLVQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:16:13 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:09 +0100
Received: from thomas.inf.ethz.ch (129.132.208.62) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Dec
 2011 22:16:10 +0100
X-Mailer: git-send-email 1.7.8.431.g2abf2
In-Reply-To: <4ED8F9AE.8030605@lsrfire.ath.cx>
X-Originating-IP: [129.132.208.62]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186951>

I think we should finish up these three patches for the next release.
The first two are unchanged from last time; nobody seemed to have any
objections.

On the third one I'm following Ren=C3=A9's argument:

> Am 02.12.2011 14:07, schrieb Thomas Rast:
> > So disable threading entirely when not scanning the worktree, to ge=
t
> > the NO_PTHREADS performance in that case.  This obsoletes all code
> > related to grep_sha1_async.  The thread startup must be delayed unt=
il
> > after all arguments have been parsed, but this does not have a
> > measurable effect.
>=20
> This is a bit radical.  I think the underlying issue that=20
> read_sha1_file() is not thread-safe can be solved eventually and then=
=20
> we'd need to readd that code.

I already posted a bunch of POC patches, but doing the timing manually
has been getting on my nerves lately.  So I would first like to
formalize some of the performance testing, perhaps along lines already
drawn up by Michael Hagger, perhaps not.  Then we can revisit the
issue of grep performance.  But I would prefer not to block the -W fix
and two easy and confirmed speedups on that.

I dropped this part entirely:

> How about adding a parameter to control the number of threads=20
> (--threads?) instead that defaults to eight (or five) for the worktre=
e=20
> and one for the rest?  That would also make benchmarking easier.

It does make testing a lot easier, but the interface is IMHO not fit
for users and I have a feeling that the "right" for-debugging
interface will end up falling out of the performance testing work
(probably an environment variable).  The end-user option should be a
config setting, if any.


Thomas Rast (3):
  grep: load funcname patterns for -W
  grep: enable threading with -p and -W using lazy attribute lookup
  grep: disable threading in non-worktree case

 builtin/grep.c  |   34 +++++++++++++++----------
 grep.c          |   73 ++++++++++++++++++++++++++++++++++-------------=
--------
 grep.h          |    7 +++++
 t/t7810-grep.sh |   14 ++++++++++
 4 files changed, 86 insertions(+), 42 deletions(-)

--=20
1.7.8.431.g2abf2
