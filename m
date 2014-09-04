From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short option name
Date: Thu, 04 Sep 2014 11:07:11 -0700
Message-ID: <xmqqtx4ntg33.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
	<54077A3E.20703@web.de> <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
	<54078C2C.5020503@web.de>
	<xmqqbnqwwds2.fsf@gitster.dls.corp.google.com>
	<540802F5.1070708@web.de>
	<xmqqegvruwmz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 20:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPbRK-0000ig-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbaIDSHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Sep 2014 14:07:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63533 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbaIDSHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 14:07:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7315038164;
	Thu,  4 Sep 2014 14:07:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gbEtCOKYLg5u
	Dcvb2dkldHFgPqM=; b=KTKRnLy8PSn5ZKNaTkCNYC20Z8f7F/moUnDiIqS/lpTv
	IwG0CbJSdpzdo2gFXpgXo0S8w9SmJMt0JyFqZg54D2NjYzNivqODvoY5gu8ItEiL
	lsEANof4IwzAsNN59IpRRXfwzOh2RNGG+11rhfUH/vCqjmIwfnwuGLFA/3HpKJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AC1Mfp
	NddEJYjtN4BYlxcYWzrzPh5FF8Qnflj3rQ8Pw5zuqiBLWj3RfhMq+wKe5xgfgjix
	qMg9IFtYrZ8KMjGJKPPp7P0IqQgZcZqHoIaJOnxbLl20VpU1H0CaxkOdc/iko2Sz
	x7tZEYFAztIo4cpAAgC2JPC2J8GGwsZD6A+OQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 677F538163;
	Thu,  4 Sep 2014 14:07:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D278F38162;
	Thu,  4 Sep 2014 14:07:13 -0400 (EDT)
In-Reply-To: <xmqqegvruwmz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 04 Sep 2014 10:24:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C46D98E-345E-11E4-AF4E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256456>

It is easy to overlook an already assigned single-letter option name
and try to use it for a new one.  Help the developer to catch it
before such a mistake escapes the lab.

This retroactively forbids any short option name (which is defined
to be of type "int") outside the ASCII printable range.  We might
want to do one of two things:

 - tighten the type of short_name member to 'char', and further
   update optbug() to protect it against doing "'%c'" on a funny
   value, e.g. negative or above 127.

 - drop the check (even the "duplicate" check) for an option whose
   short_name is either negative or above 255, to allow clever folks
   to take advantage of the fact that such a short_name cannot be
   parsed from the command line and the member can be used to store
   some extra information.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
  >
  >>> Not quite, as an opt with long name is reported with the long nam=
e
  >>> only, which is not very nice when the problem we are reporting is
  >>> about its short variant.
  >>
  >> Perhaps something like the patch below helps, here and in general?
  >
  > Excellent.  Not just this particular case, but we would show both
  > when both are available.
  >
  > Thanks; will reroll.

 parse-options.c               | 14 +++++++++++++-
 t/t1502-rev-parse-parseopt.sh |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b536896..34a15aa 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -14,8 +14,12 @@ static int parse_options_usage(struct parse_opt_ctx_=
t *ctx,
=20
 int optbug(const struct option *opt, const char *reason)
 {
-	if (opt->long_name)
+	if (opt->long_name) {
+		if (opt->short_name)
+			return error("BUG: switch '%c' (--%s) %s",
+				     opt->short_name, opt->long_name, reason);
 		return error("BUG: option '%s' %s", opt->long_name, reason);
+	}
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
=20
@@ -345,12 +349,20 @@ static void check_typos(const char *arg, const st=
ruct option *options)
 static void parse_options_check(const struct option *opts)
 {
 	int err =3D 0;
+	char short_opts[128];
=20
+	memset(short_opts, '\0', sizeof(short_opts));
 	for (; opts->type !=3D OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
 			err |=3D optbug(opts, "uses incompatible flags "
 					"LASTARG_DEFAULT and OPTARG");
+		if (opts->short_name) {
+			if (0x7F <=3D opts->short_name)
+				err |=3D optbug(opts, "invalid short name");
+			else if (short_opts[opts->short_name]++)
+				err |=3D optbug(opts, "short name already used");
+		}
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt=
=2Esh
index 922423e..ebe7c3b 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -19,7 +19,7 @@ sed -e 's/^|//' >expect <<\END_EXPECT
 |    -d, --data[=3D...]      short and long option with an optional ar=
gument
 |
 |Argument hints
-|    -b <arg>              short option required argument
+|    -B <arg>              short option required argument
 |    --bar2 <arg>          long option required argument
 |    -e, --fuz <with-space>
 |                          short and long option required argument
@@ -51,7 +51,7 @@ sed -e 's/^|//' >optionspec <<\EOF
 |d,data?   short and long option with an optional argument
 |
 | Argument hints
-|b=3Darg     short option required argument
+|B=3Darg     short option required argument
 |bar2=3Darg  long option required argument
 |e,fuz=3Dwith-space  short and long option required argument
 |s?some    short option optional argument
--=20
2.1.0-396-ga35a9df
