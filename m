From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] git-grep: Bail out when -P is used with -F or -E
Date: Mon, 09 May 2011 18:48:36 -0700
Message-ID: <7vfwonmikr.fsf@alter.siamese.dyndns.org>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1304977928-7142-7-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 03:48:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJc4J-0007Tx-4K
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 03:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab1EJBsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 21:48:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab1EJBsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2011 21:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4D805B49;
	Mon,  9 May 2011 21:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ocdgoS3KxHcx
	C47jlg/dETdvqgg=; b=ncqlmveKAnvki55EaNDtrY9NeFznpMxJaoTJ9SDpnIA1
	gno3llrt9AAzOP9VXiPeFG2M+MfGuCYw2y3VMdaD3bz9FKQRR3og/2ymOWigxr7Y
	26VtEhZrOK87oJxHB5Y9WuMtfK3LiLS0/2m6jnk7Itg3+e1xqCj0xHxquqGnv5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BtXS5L
	vbbmyNp0+bjrm/ytDwDXnBb3ts2FCnFEpWmTvRcaMEaw9Qt/T4AJv8OVZVOSFX+5
	O0BkIdH7drXpXAE1Ubr1RhJrcaUn2e/F6wTpQZRWgQ6tAzPmhVN4r13xaYxgATKI
	kzFS6CwGd+56+RIlHhZPw4WKaDHSzuETCFnF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 872FF5B48;
	Mon,  9 May 2011 21:50:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 907335B44; Mon,  9 May 2011
 21:50:43 -0400 (EDT)
In-Reply-To: <1304977928-7142-7-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Mon, 9 May 2011
 23:52:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF54F170-7AA7-11E0-AE46-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173297>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> This also makes it bail out when grep.extendedRegexp is enabled.

That is a no-starter.  "git grep -P foo" from the command line should j=
ust
ignore the configured default.  It is not entirely your fault, as I thi=
nk
you inherited the bug from the existing code that lets grep.extendedReg=
exp
interact with the "--fixed" option from the command line.

> But `git grep -G -P pattern` and `git grep -E -G -P pattern` still wo=
rk
> because -G and -E set opts.regflags during parse_options() and there =
is
> no way to detect `-G` or `-E -G`.

How about following the usual pattern of letting the last one win?

Perhaps like this?  This is not even compile tested, but should apply
cleanly on top of, and can be squashed into, your 6/6.  You of course
would need to rewrite the commit log message and documentation, if you
said only one of these can be used.

We would need some tests for "grep -P", no?  Please throw in the "last =
one
wins" and "command line defeats configuration" when you add one.

Also I deliberately said "--ignore-case and -P are not compatible (yet)=
";
shouldn't you be able to do ignore case fairly easily, I wonder?  Isn't=
 it
just the matter of wrapping each one with "(?i:" and ")" pair, or anyth=
ing
more involved necessary?

 builtin/grep.c |   58 +++++++++++++++++++++++++++++++++++++++++++-----=
-------
 1 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8e422b3..37f2331 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -753,6 +753,15 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 	int i;
 	int dummy;
 	int use_index =3D 1;
+	enum {
+		pattern_type_unspecified =3D 0,
+		pattern_type_bre,
+		pattern_type_ere,
+		pattern_type_fixed,
+		pattern_type_pcre,
+	};
+	int pattern_type =3D pattern_type_unspecified;
+
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -774,15 +783,18 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 			"descend at most <depth> levels", PARSE_OPT_NONEG,
 			NULL, 1 },
 		OPT_GROUP(""),
-		OPT_BIT('E', "extended-regexp", &opt.regflags,
-			"use extended POSIX regular expressions", REG_EXTENDED),
-		OPT_NEGBIT('G', "basic-regexp", &opt.regflags,
-			"use basic POSIX regular expressions (default)",
-			REG_EXTENDED),
-		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
-			"interpret patterns as fixed strings"),
-		OPT_BOOLEAN('P', "perl-regexp", &opt.pcre,
-				"use Perl-compatible regular expressions"),
+		OPT_SET_INT('E', "extended-regexp", &pattern_type,
+			    "use extended POSIX regular expressions",
+			    pattern_type_ere),
+		OPT_SET_INT('G', "basic-regexp", &pattern_type,
+			    "use basic POSIX regular expressions (default)",
+			    pattern_type_bre),
+		OPT_SET_INT('F', "fixed-strings", &pattern_type,
+			    "interpret patterns as fixed strings",
+			    pattern_type_fixed),
+		OPT_SET_INT('P', "perl-regexp", &pattern_type,
+			    "use Perl-compatible regular expressions",
+			    pattern_type_pcre),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
@@ -888,6 +900,28 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
+	switch (pattern_type) {
+	case pattern_type_fixed:
+		opt.fixed =3D 1;
+		opt.pcre =3D 0;
+		break;
+	case pattern_type_bre:
+		opt.fixed =3D 0;
+		opt.pcre =3D 0;
+		opt.regflags &=3D ~REG_EXTENDED;
+		break;
+	case pattern_type_ere:
+		opt.fixed =3D 0;
+		opt.pcre =3D 0;
+		opt.regflags |=3D REG_EXTENDED;
+		break;
+	case pattern_type_pcre:
+		opt.fixed =3D 0;
+		opt.pcre =3D 1;
+		break;
+	default:
+		break; /* nothing */
+	}
=20
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
@@ -925,12 +959,10 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
=20
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-	if (opt.regflags !=3D REG_NEWLINE && opt.pcre)
-		die(_("cannot mix --extended-regexp and --perl-regexp"));
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |=3D REG_ICASE;
-	if ((opt.regflags !=3D REG_NEWLINE || opt.pcre) && opt.fixed)
-		die(_("cannot mix --fixed-strings and regexp"));
+	if (opt.pcre && opt.ignore_case)
+		die(_("--ignore-case and -P are not compatible (yet)"));
=20
 #ifndef NO_PTHREADS
 	if (online_cpus() =3D=3D 1 || !grep_threads_ok(&opt))
