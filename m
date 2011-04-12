From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive: tar.umask ignored
Date: Tue, 12 Apr 2011 22:02:35 +0200
Message-ID: <4DA4AFDB.7040606@lsrfire.ath.cx>
References: <BANLkTimTs+Qh9fNs6pLcZidYy-YjXNR2iw@mail.gmail.com> <4DA497B7.706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Apr 12 22:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9jo2-0007jX-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 22:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253Ab1DLUDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 16:03:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:46224 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab1DLUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 16:03:00 -0400
Received: from [192.168.2.103] (p4FFDBE81.dip.t-dialin.net [79.253.190.129])
	by india601.server4you.de (Postfix) with ESMTPSA id 697E02F806F;
	Tue, 12 Apr 2011 22:02:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4DA497B7.706@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171416>

Am 12.04.2011 20:19, schrieb Ren=E9 Scharfe:
> Would a new --umask command line option alone (that overrides any con=
fig=20
> setting) be sufficient for your use case?

Something like this (docs and tests missing)?

I'm not so sure about PARSE_OPT_OPTARG.  E.g. this is confusing and eve=
n
becomes slightly dangerous if you have a branch named 022 with a file
named HEAD (the =3D is required):

	$ git archive --umask 022 HEAD
	fatal: Not a valid object name

Also I'm and not sure what --no-umask should do.  In this patch it is
equivalent to --umask=3D0; perhaps it should rather make archive use th=
e
configured tar.umask value, i.e. neutralize any previous --umask
option.
---
 archive-tar.c |    5 ++++-
 archive.c     |   34 +++++++++++++++++++++++++++++++++-
 archive.h     |    1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cee06ce..1a29f3c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -238,7 +238,10 @@ int write_tar_archive(struct archiver_args *args)
 {
 	int err =3D 0;
=20
-	git_config(git_tar_config, NULL);
+	if (args->umask =3D=3D -1)
+		git_config(git_tar_config, NULL);
+	else
+		tar_umask =3D args->umask;
=20
 	if (args->commit_sha1)
 		err =3D write_global_extended_header(args);
diff --git a/archive.c b/archive.c
index 1944ed4..2ec5391 100644
--- a/archive.c
+++ b/archive.c
@@ -15,13 +15,14 @@ static char const * const archive_usage[] =3D {
 };
=20
 #define USES_ZLIB_COMPRESSION 1
+#define USES_UMASK 2
=20
 static const struct archiver {
 	const char *name;
 	write_archive_fn_t write_archive;
 	unsigned int flags;
 } archivers[] =3D {
-	{ "tar", write_tar_archive },
+	{ "tar", write_tar_archive, USES_UMASK },
 	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
 };
=20
@@ -285,6 +286,30 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time =3D archive_time;
 }
=20
+static int umask_callback(const struct option *opt, const char *arg, i=
nt unset)
+{
+	int *target =3D opt->value;
+	int value;
+	const char *endp;
+
+	if (unset) {
+		*target =3D 0;
+		return 0;
+	}
+	if (arg) {
+		value =3D strtol(arg, (char **)&endp, 0);
+		if (*endp || value < 0) {
+			return error("option `%s' %s", "umask",
+				     "expects a non-negative numerical value");
+		}
+	} else {
+		value =3D umask(0);
+		umask(value);
+	}
+	*target =3D value;
+	return 0;
+}
+
 #define OPT__COMPR(s, v, h, p) \
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
@@ -305,6 +330,7 @@ static int parse_archive_args(int argc, const char =
**argv,
 	int i;
 	int list =3D 0;
 	int worktree_attributes =3D 0;
+	int umask =3D -1;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
@@ -325,6 +351,9 @@ static int parse_archive_args(int argc, const char =
**argv,
 		OPT__COMPR_HIDDEN('7', &compression_level, 7),
 		OPT__COMPR_HIDDEN('8', &compression_level, 8),
 		OPT__COMPR('9', &compression_level, "compress better", 9),
+		{ OPTION_CALLBACK, 0, "umask", &umask, "umask",
+			"apply user's umask or <umask> to archived files",
+			PARSE_OPT_OPTARG, umask_callback },
 		OPT_GROUP(""),
 		OPT_BOOLEAN('l', "list", &list,
 			"list supported archive formats"),
@@ -370,10 +399,13 @@ static int parse_archive_args(int argc, const cha=
r **argv,
 					format, compression_level);
 		}
 	}
+	if (umask !=3D -1 && !((*ar)->flags & USES_UMASK))
+		die("Argument not supported for format '%s': --umask", format);
 	args->verbose =3D verbose;
 	args->base =3D base;
 	args->baselen =3D strlen(base);
 	args->worktree_attributes =3D worktree_attributes;
+	args->umask =3D umask;
=20
 	return argc;
 }
diff --git a/archive.h b/archive.h
index 038ac35..083675c 100644
--- a/archive.h
+++ b/archive.h
@@ -12,6 +12,7 @@ struct archiver_args {
 	unsigned int verbose : 1;
 	unsigned int worktree_attributes : 1;
 	int compression_level;
+	int umask;
 };
=20
 typedef int (*write_archive_fn_t)(struct archiver_args *);
--=20
1.7.4
