From: Jeff King <peff@peff.net>
Subject: [PATCH] silence gcc array-bounds warning
Date: Fri, 4 Oct 2013 03:52:35 -0400
Message-ID: <20131004075234.GA26068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 09:52:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS0Bm-0002t3-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 09:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab3JDHwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Oct 2013 03:52:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:34011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728Ab3JDHwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 03:52:38 -0400
Received: (qmail 31634 invoked by uid 102); 4 Oct 2013 07:52:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 Oct 2013 02:52:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Oct 2013 03:52:35 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235703>

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
I've convinced myself that this is a gcc bug and not some weird
undefined behavior or extra analysis that gcc can do due to inlined
functions. The fact that what should be a noop makes the warning go awa=
y
makes me very suspicious.

You can also silence it by declaring ref_rev_parse_rules as:

  const char * const ref_rev_parse_rules[];

to make both the strings themselves and the pointers in the list
constant. And that may be worth doing instead, because it really is
a constant list for us. The downside is that it's a little uglier to
read, and it carries over to pointers we use to access it, like:

  const char * const *p;
  for (p =3D ref_rev_parse_rules; *p; p++)
     ...

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ad5d66c..c1cc98a 100644
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
1.8.4.1.4.gf327177
