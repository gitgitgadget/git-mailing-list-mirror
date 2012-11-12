From: Jeff King <peff@peff.net>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Mon, 12 Nov 2012 16:34:28 -0500
Message-ID: <20121112213428.GK4623@sigill.intra.peff.net>
References: <20121111232820.284510@gmx.net>
 <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net>
 <20121112202701.GE4623@sigill.intra.peff.net>
 <7vmwymh83r.fsf@alter.siamese.dyndns.org>
 <CANQwDwdRTeaVS5cMic5gv9SP1A8Z1vruOsZBFfMDQDTZHBAtvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <n1xim.email@gmail.com>,
	glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY1ee-0000Ix-6v
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 22:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab2KLVef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2012 16:34:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45057 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab2KLVed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 16:34:33 -0500
Received: (qmail 14325 invoked by uid 107); 12 Nov 2012 21:35:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 16:35:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 16:34:28 -0500
Content-Disposition: inline
In-Reply-To: <CANQwDwdRTeaVS5cMic5gv9SP1A8Z1vruOsZBFfMDQDTZHBAtvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209528>

On Mon, Nov 12, 2012 at 10:13:27PM +0100, Jakub Nar=C4=99bski wrote:

> > Yeah, that looks correct, given the way how the other variables
> > emitted with the same "print" like $descr and $owner are formed.
>=20
> It looks like good solution to me too.
>=20
> Nb. the problems with feed are mainly because it is generated
> by hand even more than HTML (which uses CGI.pm).

Yeah, I noticed that. Here it is in patch form with a test. It would be
nice if people interested in gitweb would add more entries to the XSS
test below (I put in the one that fails, along with an obvious variatio=
n
that is actually OK).

I didn't look carefully through the rest of gitweb for more XSS
instances. From a glance, it looks like we mostly use the safe CGI
methods, but probably it could use a full audit (which again, I would b=
e
happy if people who care more about gitweb would do).

-- >8 --
Subject: [PATCH] gitweb: escape html in rss title

The title of an RSS feed is generated from many components,
including the filename provided as a query parameter, but we
failed to quote it.  Besides showing the wrong output, this
is a vector for XSS attacks.

Signed-off-by: Jeff King <peff@peff.net>
---
 gitweb/gitweb.perl                        |  1 +
 t/t9502-gitweb-standalone-parse-output.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..a51a8ba 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8055,6 +8055,7 @@ sub git_feed {
 		$feed_type =3D 'history';
 	}
 	$title .=3D " $feed_type";
+	$title =3D esc_html($title);
 	my $descr =3D git_get_project_description($project);
 	if (defined $descr) {
 		$descr =3D esc_html($descr);
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb=
-standalone-parse-output.sh
index 731e64c..3a8e7d3 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -185,5 +185,20 @@ test_expect_success 'forks: project_index lists al=
l projects (incl. forks)' '
 	test_cmp expected actual
 '
=20
+xss() {
+	echo >&2 "Checking $1..." &&
+	gitweb_run "$1" &&
+	if grep "$TAG" gitweb.body; then
+		echo >&2 "xss: $TAG should have been quoted in output"
+		return 1
+	fi
+	return 0
+}
+
+test_expect_success 'xss checks' '
+	TAG=3D"<magic-xss-tag>" &&
+	xss "a=3Drss&p=3D$TAG" &&
+	xss "a=3Drss&p=3Dfoo.git&f=3D$TAG"
+'
=20
 test_done
--=20
1.8.0.207.gdf2154c
