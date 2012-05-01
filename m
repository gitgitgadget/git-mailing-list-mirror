From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb-lib.sh: Set up PATH to use perl from /usr/bin
Date: Tue, 1 May 2012 13:08:11 -0400
Message-ID: <20120501170810.GA22444@sigill.intra.peff.net>
References: <201205011323.45190.tboegi@web.de>
 <4FA00E09.2090708@in.waw.pl>
 <7vsjfjalx6.fsf@alter.siamese.dyndns.org>
 <4FA0176B.50300@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	jnareb@gmail.com, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 01 19:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGYm-0002CY-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab2EARIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 13:08:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53470
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752492Ab2EARIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:08:15 -0400
Received: (qmail 7237 invoked by uid 107); 1 May 2012 17:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 13:08:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 13:08:11 -0400
Content-Disposition: inline
In-Reply-To: <4FA0176B.50300@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196697>

On Tue, May 01, 2012 at 07:03:39PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> But I don't see why we would use a different perl in
> git-am.sh:                      perl -ne 'BEGIN { $subject =3D 0 }
> git-am.sh:                      perl -M'POSIX qw(strftime)' -ne 'BEGI=
N { $subject =3D 0 }
> git-request-pull.sh:ref=3D$(git ls-remote "$url" | perl -e "$find_mat=
ching_ref" "$head" "$headrev")
> git-submodule.sh:       perl -e '
> test-sha1.sh:                   perl -pe 'y/\000/g/'
> test-sha1.sh:                   perl -pe 'y/\000/g/'
> and lot of files in t/. Shouldn't those be replaced too?

No. There are two ways in which we use perl:

  1. To run our complex scripts like gitweb, git-svn, etc. These requir=
e
     a reasonably modern perl version, and the user must specify it wit=
h
     PERL_PATH if it is not in /usr/bin.

  2. To run little snippets that _could_ be written in sed or awk, but
     which cause portability problems on crappy versions of those tools=
=2E
     These should run under any version of perl5.

It's OK to use 'perl' from the path for (2), because we are not asking
very much of perl in that case.

I think the patch we want is just:

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 21d11d6..ae2dc46 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -69,7 +69,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$SCRIPT_NAME" \
+	"$PERL_PATH" -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
 	perl -w -e '
 		open O, ">gitweb.headers";

no? Torsten, does that fix your problem?

-Peff
