From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Sun, 18 Jan 2009 14:43:28 -0500
Message-ID: <20090118194328.GA31180@coredump.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdZq-0002vc-Q1
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZARTnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755431AbZARTnc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:43:32 -0500
Received: from peff.net ([208.65.91.99]:45385 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383AbZARTnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:43:31 -0500
Received: (qmail 23066 invoked by uid 107); 18 Jan 2009 19:43:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 14:43:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 14:43:28 -0500
Content-Disposition: inline
In-Reply-To: <20090118173753.GB17434@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106269>

On Sun, Jan 18, 2009 at 12:37:53PM -0500, Jeff King wrote:

> On Sun, Jan 18, 2009 at 06:13:21PM +0100, Ren=C3=A9 Scharfe wrote:
> > Another step would be for --pretty=3Dformat to respect the color co=
nfig,
> > i.e. it shouldn't print any colour codes if colouring is turned off=
 or
> > if set to auto while writing to file or pipe.
>=20
> That makes sense to me. In theory, we could offer an "always use this
> color" and a "conditionally use this color" substitution. But I don't
> really see why anyone would want the "always use this color" one (the=
y
> could just say --color, then).

Here is a patch that seems to work. It predicates pretty format colors
on diff colors, which is the same way the yellow commit header works in
log-tree. I don't know if it makes more sense to introduce yet another
color config option.

And I say "seems to work" because I remember there being some trickery
with color flags sometimes not getting set properly. However, since thi=
s
is the same flag as the yellow commit header, and called around the sam=
e
time, I think it should be fine.

One final note: if you are writing "generic" format strings, you
probably don't want to say "yellow". You want to say "whatever the user
has configured for color.diff.commit". I don't know if %C should be
overloaded for that or not (i.e., %C(commit) would be a valid color).

-- >8 --
respect color settings for --pretty=3Dformat colors

Previously, we would unconditionally print any colors the
user put into the --pretty=3Dformat specifier, regardless of
the setting of color configuration. This is not a problem if
the user writes a custom string each time git-log is
invoked. However, it makes use in scripts unnecessarily
complex, since they would have to change the format string
based on user preferences (and whether output is going to a
tty).

This patch will ignore any colors in --pretty=3Dformat if diff
colors are not turned on (they will still be parsed and
treated as placeholders, but no color will be output). This
matches the color.diff.commit colorization, which depends on
diff coloring even though it is not technically part of a
diff.
---
 pretty.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index b1b8620..fe606c5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -563,20 +563,25 @@ static size_t format_commit_item(struct strbuf *s=
b, const char *placeholder,
 			color_parse_mem(placeholder + 2,
 					end - (placeholder + 2),
 					"--pretty format", color);
-			strbuf_addstr(sb, color);
+			if (diff_use_color_default)
+				strbuf_addstr(sb, color);
 			return end - placeholder + 1;
 		}
 		if (!prefixcmp(placeholder + 1, "red")) {
-			strbuf_addstr(sb, "\033[31m");
+			if (diff_use_color_default)
+				strbuf_addstr(sb, "\033[31m");
 			return 4;
 		} else if (!prefixcmp(placeholder + 1, "green")) {
-			strbuf_addstr(sb, "\033[32m");
+			if (diff_use_color_default)
+				strbuf_addstr(sb, "\033[32m");
 			return 6;
 		} else if (!prefixcmp(placeholder + 1, "blue")) {
-			strbuf_addstr(sb, "\033[34m");
+			if (diff_use_color_default)
+				strbuf_addstr(sb, "\033[34m");
 			return 5;
 		} else if (!prefixcmp(placeholder + 1, "reset")) {
-			strbuf_addstr(sb, "\033[m");
+			if (diff_use_color_default)
+				strbuf_addstr(sb, "\033[m");
 			return 6;
 		} else
 			return 0;
--=20
1.6.1.151.g5a7da.dirty
