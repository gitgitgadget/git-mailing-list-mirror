From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] parse-options: make OPT_NUMBER's argh explicit
Date: Wed, 03 Jun 2009 22:22:59 +0200
Message-ID: <4A26DBA3.90604@lsrfire.ath.cx>
References: <1244015367-16998-1-git-send-email-bebarino@gmail.com> 	<4A264DFA.3090309@lsrfire.ath.cx> <780e0a6b0906031235q1438b76cyba1172556c94d1d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBwzt-0006O6-6b
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZFCUXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 16:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbZFCUXD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:23:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:50298 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbZFCUXC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:23:02 -0400
Received: from [10.0.1.101] (p57B7BC33.dip.t-dialin.net [87.183.188.51])
	by india601.server4you.de (Postfix) with ESMTPSA id 0FB862F8042;
	Wed,  3 Jun 2009 22:23:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <780e0a6b0906031235q1438b76cyba1172556c94d1d0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120637>

Stephen Boyd schrieb:
> On Wed, Jun 3, 2009 at 3:18 AM, Ren=C3=A9 Scharfe<rene.scharfe@lsrfir=
e.ath.cx> wrote:
>> By the way, can the switch be replaced by a simple check for
>> PARSE_OPT_NOARG now?
>>
>=20
> This looks possible. I think just set PARSE_OPT_NOARG as the flag of
> the appropriate OPT_* macros. I'll have to grep the tree for custom
> uses of OPTION_* though.

Yes, it's only worthwhile if there aren't too many special cases that
require explicit setting of PARSE_OPT_NOARG.

>=20
> Should that be all squashed together? Or maybe that could be a follow=
 up patch?

Your existing patch looks fine as is, I'd keep additional changes
separate.

Hmm, and how about the following in between them?

 parse-options.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b85cab2..dda36b1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -440,7 +440,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 static int usage_argh(const struct option *opts)
 {
 	const char *s;
-	int literal =3D opts->flags & PARSE_OPT_LITERAL_ARGHELP;
+	int literal =3D (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opt->ar=
gh;
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
 			s =3D literal ? "[=3D%s]" : "[=3D<%s>]";
@@ -448,7 +448,7 @@ static int usage_argh(const struct option *opts)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(stderr, s, opts->argh);
+	return fprintf(stderr, s, opt->argh ? opt->argh : "...");
 }
=20
 #define USAGE_OPTS_WIDTH 24
@@ -519,17 +519,7 @@ int usage_with_options_internal(const char * const=
 *usagestr,
 		case OPTION_FILENAME:
 			/* FALLTHROUGH */
 		case OPTION_STRING:
-			if (opts->argh)
-				pos +=3D usage_argh(opts);
-			else {
-				if (opts->flags & PARSE_OPT_OPTARG)
-					if (opts->long_name)
-						pos +=3D fprintf(stderr, "[=3D...]");
-					else
-						pos +=3D fprintf(stderr, "[...]");
-				else
-					pos +=3D fprintf(stderr, " ...");
-			}
+			pos +=3D usage_argh(opts);
 			break;
 		default: /* OPTION_{BIT,BOOLEAN,NUMBER,SET_INT,SET_PTR} */
 			break;
