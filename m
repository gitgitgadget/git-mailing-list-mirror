From: Jeff King <peff@peff.net>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Fri, 22 Feb 2013 17:46:55 -0500
Message-ID: <20130222224655.GB21579@sigill.intra.peff.net>
References: <kg8ri2$vjb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91Ol-000802-Az
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758090Ab3BVWq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 17:46:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57578 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757867Ab3BVWq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:46:57 -0500
Received: (qmail 9313 invoked by uid 107); 22 Feb 2013 22:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 17:48:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 17:46:55 -0500
Content-Disposition: inline
In-Reply-To: <kg8ri2$vjb$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216873>

On Sat, Feb 23, 2013 at 12:30:28AM +0200, Mantas Mikul=C4=97nas wrote:

> When messing around with various repositories, I noticed that git 1.8
> (currently using 1.8.2.rc0.22.gb3600c3) has problems parsing tag obje=
cts
> that have invalid timestamps.
>=20
> Times in tag objects appear to be kept as Unix timestamps, but I didn=
't
> realize this at first, and ran something roughly equivalent to:
>   git cat-file -p $tagname | git hash-object -w -t tag --stdin
> creating a tag object the "tagger" line containing formatted time
> instead of a Unix timestamp.

Thanks, that makes it easy to replicate. It looks like it is not just
tags, but rather the pp_user_info function does not realize that
split_ident may return NULL for the date field if it is unparseable.
Something like this stops the crash and just gives a bogus date:

diff --git a/pretty.c b/pretty.c
index eae57ad..9688857 100644
--- a/pretty.c
+++ b/pretty.c
@@ -428,8 +428,16 @@ void pp_user_info(const struct pretty_print_contex=
t *pp,
 	strbuf_add(&name, namebuf, namelen);
=20
 	namelen =3D name.len + mail.len + 3; /* ' ' + '<' + '>' */
-	time =3D strtoul(ident.date_begin, &date, 10);
-	tz =3D strtol(date, NULL, 10);
+
+	if (ident.date_begin) {
+		time =3D strtoul(ident.date_begin, &date, 10);
+		tz =3D strtol(date, NULL, 10);
+	}
+	else {
+		/* ident line had malformed date */
+		time =3D 0;
+		tz =3D 0;
+	}
=20
 	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");

I guess we should probably issue a warning, too. Also disappointingly,
git-fsck does not seem to detect this breakage at all.

> Git doesn't handle the resulting tag objects nicely at all. For examp=
le,
> running `git cat-file -p` on the new object outputs a really odd
> timestamp "Thu Jun Thu Jan 1 00:16:09 1970 +0016" (I'm guessing it
> parses the year as Unix time), and `git show` outright crashes
> (backtrace included below.)

If "cat-file -p" is not using the usual pretty-print routines, it
probably should. I'll take a look.

-Peff
