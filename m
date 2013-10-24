From: Jeff King <peff@peff.net>
Subject: [PATCH] silence gcc array-bounds warning
Date: Thu, 24 Oct 2013 04:45:13 -0400
Message-ID: <20131024084513.GA582@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 10:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZGXj-00084p-KE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 10:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab3JXIpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Oct 2013 04:45:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:54643 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752517Ab3JXIpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 04:45:15 -0400
Received: (qmail 6485 invoked by uid 102); 24 Oct 2013 08:45:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 03:45:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 04:45:13 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236573>

In shorten_unambiguous_ref, we build and cache a reverse-map of the
rev-parse rules like this:

  static char **scanf_fmts;
  static int nr_rules;
  if (!nr_rules) {
	  for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
		  ... generate scanf_fmts ...
  }

where ref_rev_parse_rules is terminated with a NULL pointer.
Compiling with "gcc -O2 -Wall" does not cause any problems, but
compiling with "-O3 -Wall" generates:

  $ make CFLAGS=3D'-O3 -Wall' refs.o
  refs.c: In function =E2=80=98shorten_unambiguous_ref=E2=80=99:
  refs.c:3379:29: warning: array subscript is above array bounds [-Warr=
ay-bounds]
     for (; ref_rev_parse_rules[nr_rules]; nr_rules++)

Curiously, we can silence this by explicitly nr_rules to 0
in the beginning of the loop, even though the compiler
should be able to tell that we follow this code path only
when nr_rules is already 0.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a repost of:

  http://article.gmane.org/gmane.comp.version-control.git/235703

which contains a little more cover-letter discussion.

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3710748..0c0e963 100644
--- a/refs.c
+++ b/refs.c
@@ -3376,7 +3376,7 @@ char *shorten_unambiguous_ref(const char *refname=
, int strict)
 		size_t total_len =3D 0;
=20
 		/* the rule list is NULL terminated, count them first */
-		for (; ref_rev_parse_rules[nr_rules]; nr_rules++)
+		for (nr_rules =3D 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
 			/* no +1 because strlen("%s") < strlen("%.*s") */
 			total_len +=3D strlen(ref_rev_parse_rules[nr_rules]);
=20
--=20
1.8.4.1.898.g8bf8a41.dirty
