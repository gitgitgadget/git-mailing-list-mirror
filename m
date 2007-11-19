From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH/RFC] parse-options: allow to define hidden synonym options
Date: Mon, 19 Nov 2007 10:22:07 +0100
Message-ID: <20071119092207.GB9028@artemis.corp>
References: <7v4pfircka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="i9LlY+UWpKt15+FH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 10:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu2pw-0001fr-9X
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 10:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbXKSJWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 04:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXKSJWL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 04:22:11 -0500
Received: from pan.madism.org ([88.191.52.104]:49230 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbXKSJWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 04:22:10 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A764F29BC8;
	Mon, 19 Nov 2007 10:22:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E8EBD2E3C; Mon, 19 Nov 2007 10:22:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4pfircka.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65417>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On lun, nov 19, 2007 at 06:09:41 +0000, Junio C Hamano wrote:
> By setting the help member to NULL, you can implement an option
> that is not shown in the "git-cmd -h" help output.  This is
> useful to support backward compatible synonyms without
> cluttering the help text.

  Sorry I'm not very present those days, but oh well...

  The idea looks nice, though if we are doing this, I'd like to see it
fix other problems at the same time. We sometimes have "internal"
commands switches and other cases of alias.

  I wonder if it wouldn't be better that we have some kind of --help-all
switch that would show them _all_ and a way (through another flag ?) to
hide those additional options by default.

  And defining an alias would then be:

  { OPTION_SOME_TYPE, 0, "alias-name", &some_value, "some-arg",
    "backward compatibility alias for \"foo\"", PARSE_OPT_HIDE, ... }

or:

  { OPTION_SOME_TYPE, 0, "plumbing-dark-think", &some_value, "some-arg",
    "internal plumbing switch used in", PARSE_OPT_HIDE, ... }


  I personnaly don't like that parse-opt sees more options than what it
says it sees, else with your patch, if the user gives ambiguous
abbreviated long switches, he'll get "--w is ambiguous, could be
`--whith` or `--wibble`" whereas he never knew that --with existed in
the first place.

  That gives something more along the lines of :

=46rom 860a5bf335e44dd2bbe5f30620c99d174b697f69 Mon Sep 17 00:00:00 2001
=46rom: Pierre Habouzit <madcoder@debian.org>
Date: Mon, 19 Nov 2007 10:21:44 +0100
Subject: [PATCH] parse-options: Allow to hide options from the default usag=
e.

This is useful for backward-compatibility aliases, or very advanced command
line switches introduced for internal git usages and have no real use for a
user.

parse-options still shows them if the user asks for --help-all.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   17 +++++++++++++++--
 parse-options.h |    3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d3e608a..807e443 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -216,6 +216,9 @@ is_abbreviated:
 	return error("unknown option `%s'", arg);
 }
=20
+static NORETURN void usage_with_options_internal(const char * const *,
+                                                 const struct option *, in=
t);
+
 int parse_options(int argc, const char **argv, const struct option *option=
s,
                   const char * const usagestr[], int flags)
 {
@@ -249,6 +252,8 @@ int parse_options(int argc, const char **argv, const st=
ruct option *options,
 			break;
 		}
=20
+		if (!strcmp(arg + 2, "help-all"))
+			usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
 		if (parse_long_opt(&args, arg + 2, options))
@@ -263,8 +268,8 @@ int parse_options(int argc, const char **argv, const st=
ruct option *options,
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
=20
-void usage_with_options(const char * const *usagestr,
-                        const struct option *opts)
+void usage_with_options_internal(const char * const *usagestr,
+                                 const struct option *opts, int full)
 {
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
@@ -285,6 +290,8 @@ void usage_with_options(const char * const *usagestr,
 				fprintf(stderr, "%s\n", opts->help);
 			continue;
 		}
+		if (!full & (opts->flags & PARSE_OPT_HIDDEN))
+			continue;
=20
 		pos =3D fprintf(stderr, "    ");
 		if (opts->short_name)
@@ -335,6 +342,12 @@ void usage_with_options(const char * const *usagestr,
 	exit(129);
 }
=20
+void usage_with_options(const char * const *usagestr,
+                        const struct option *opts)
+{
+	usage_with_options_internal(usagestr, opts, 0);
+}
+
 /*----- some often used options -----*/
 #include "cache.h"
=20
diff --git a/parse-options.h b/parse-options.h
index a8760ac..102ac31 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -24,6 +24,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_OPTARG  =3D 1,
 	PARSE_OPT_NOARG   =3D 2,
 	PARSE_OPT_NONEG   =3D 4,
+	PARSE_OPT_HIDDEN  =3D 8,
 };
=20
 struct option;
@@ -57,6 +58,8 @@ typedef int parse_opt_cb(const struct option *, const cha=
r *arg, int unset);
  *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEA=
Ns)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBAC=
Ks
  *   PARSE_OPT_NONEG: says that this option cannot be negated
+ *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed =
in
+ *                    the long one.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK.
--=20
1.5.3.5.1795.g5421e-dirty


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHQVW/vGr7W6HudhwRAlepAJ0Se8nGt1YwGmBqU2TCSGRCjhjByACgiOz6
BJK3dztOaaZ8Q/3/s921yOc=
=b2JY
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
