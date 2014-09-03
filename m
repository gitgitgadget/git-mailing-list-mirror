From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short option name
Date: Wed, 03 Sep 2014 14:05:31 -0700
Message-ID: <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
	<54077A3E.20703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 03 23:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPHkJ-00082p-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 23:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbaICVFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 17:05:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62445 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaICVFd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 17:05:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3304F378DC;
	Wed,  3 Sep 2014 17:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E1f4F/FHI5n4
	opl6jqXsrcGw2/Q=; b=KwePoOHjH4jbsgUh054jNEWbyk6bvlneco4P3vzQFnz6
	Lbok3zGM1pM3Nb9/1hCdDo8xDJoI2PApFuUohWS/TJvIxh006yL4k2kSMWIzATI1
	2C2a+NLBBDg+dnMs6uHHlvxI5OMM3lRF+1FzlliCpZdGZjI8JufaW/aEQece9Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YXpfa8
	dm2s+VR5C5I5EwJtwTn9dG7wtTVgEasxKTAqZHuGpkPiBHTGJZbeosOn2emiNq/H
	0Rois+MVwJBXoPHwD1d0tOfWGZZqmEahqoPpU5jKI7YHp0XMcou9PiOnHSANpsxy
	OnmbXV8WWcyZQux9JfbD6RIj+6LTXGNSr6F4M=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 299C3378D9;
	Wed,  3 Sep 2014 17:05:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A0BDF378D8;
	Wed,  3 Sep 2014 17:05:32 -0400 (EDT)
In-Reply-To: <54077A3E.20703@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 03 Sep
	2014 22:29:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AD052BA-33AE-11E4-99BE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256413>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Compact and useful, I like it.
>
> You might want to squash in something like this, though.  Without it
> t1502 fails because -b is defined twice there.

Thanks.  I like it to see that the check automatically propagates
even to scripts ;-)

It bugged me enough that we didn't identify which short option
letter we were complaining about and that opts->short_name is
defined as an "int", which may cause us to overstep char[128],
I ended up doing it this way instead, though.  It no longer is so
compact, even though it may still have the same usefulness.

We might want to tighten the type of the short_name member to
unsigned char, but I didn't go that far yet, at least in this step.

-- >8 --
Subject: [PATCH] parse-options: detect attempt to add a duplicate short=
 option name

It is easy to overlook an already assigned single-letter option name
and try to use it for a new one.  Help the developer to catch it
before such a mistake escapes the lab.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c               | 15 +++++++++++++++
 t/t1502-rev-parse-parseopt.sh |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index b536896..70227e9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -345,12 +345,27 @@ static void check_typos(const char *arg, const st=
ruct option *options)
 static void parse_options_check(const struct option *opts)
 {
 	int err =3D 0;
+	char short_opts[128];
+
+	memset(short_opts, '\0', sizeof(short_opts));
=20
 	for (; opts->type !=3D OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
 			err |=3D optbug(opts, "uses incompatible flags "
 					"LASTARG_DEFAULT and OPTARG");
+		if (opts->short_name) {
+			struct strbuf errmsg =3D STRBUF_INIT;
+			if (opts->short_name < ' ' || 0x7F <=3D opts->short_name)
+				strbuf_addf(&errmsg, "invalid short name (0x%02x)",
+					    opts->short_name);
+			else if (short_opts[opts->short_name]++)
+				strbuf_addf(&errmsg, "short name %c already used",
+					    opts->short_name);
+			if (errmsg.len)
+				err |=3D optbug(opts, errmsg.buf);
+			strbuf_release(&errmsg);
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
2.1.0-394-g3e31896
