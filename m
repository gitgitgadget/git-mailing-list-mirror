From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] prune: show progress while marking reachable objects
Date: Wed, 9 Nov 2011 11:26:42 +0700
Message-ID: <20111109042642.GA11222@duynguyen-vnpc.dek-tpc.internal>
References: <1320494408-6373-1-git-send-email-pclouds@gmail.com>
 <20111108053149.GA29643@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 09 05:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNzkY-00058a-17
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 05:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab1KIE0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 23:26:53 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:52464 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1KIE0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 23:26:52 -0500
Received: by pzk2 with SMTP id 2so629003pzk.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 20:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mVGI9TC7SeTiZlONS871i+7YH7tZidKawiNBLBKEv6M=;
        b=ONQSJZceJsMFpKoed0PYyOj5ud3LNeG8aMZ4amgvGDU0Ik5E+CSpUpm+V5uyNJQam2
         0bJqAnCwzENMW8xRYVraZdpSFE2y/ZBtRF/zNVVY9LI+sj/jYsxnIKjACdz+ya5CAvYi
         JLPe7DbfjvANPmmkIzpGEsSpMW/yUDPqLmgus=
Received: by 10.68.17.7 with SMTP id k7mr2210762pbd.20.1320812812215;
        Tue, 08 Nov 2011 20:26:52 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id a4sm9661411pbl.11.2011.11.08.20.26.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Nov 2011 20:26:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Nov 2011 11:26:42 +0700
Content-Disposition: inline
In-Reply-To: <20111108053149.GA29643@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185145>

On Tue, Nov 08, 2011 at 12:31:49AM -0500, Jeff King wrote:
> On Sat, Nov 05, 2011 at 07:00:08PM +0700, Nguyen Thai Ngoc Duy wrote:
>=20
> > prune already shows progress meter while pruning. The marking part =
may
> > take a few seconds or more, depending on repository size. Show
> > progress meter during this time too.
>=20
> Thanks, this is a nice start. It's missing a few things IMHO:
>=20
>   1. It actually counts commits, not all objects. I'm tempted to say
>      this doesn't matter, as any eye candy is helpful. Except that th=
e
>      most common use of prune is as part of "git gc", in which case
>      pack-objects will have just done the "counting objects" phase an=
d
>      come up with some number. If we count all objects, then our end
>      number is the same (modulo any .keep packs, but at least it's
>      probably in the same order of magnitude). That gives the user a
>      better sense of completion time.
>=20
>   2. Prune should learn --progress/--no-progress, isatty(2), etc. And
>      git-gc should pass --no-progress when it's told to be quiet.

  3. Show progress meter while pruning packed objects. It does not
     seem to take long enough time to show the meter. Anyway the code
     is there we should enable it.

-- 8< --
Subject: [PATCH] prune: show progress meter while pruning packed object=
s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin.h              |    4 ++++
 builtin/prune-packed.c |   13 +++++--------
 builtin/prune.c        |   13 +++++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..0a5b511 100644
--- a/builtin.h
+++ b/builtin.h
@@ -13,6 +13,10 @@ extern const char git_version_string[];
 extern const char git_usage_string[];
 extern const char git_more_info_string[];
=20
+#define PRUNE_DRY_RUN  01
+#define PRUNE_PROGRESS 02
+#define PRUNE_VERBOSE  04
+
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 int merge_title, int shortlog_len);
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f9463de..d9f6d1d 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -8,9 +8,6 @@ static const char * const prune_packed_usage[] =3D {
 	NULL
 };
=20
-#define DRY_RUN 01
-#define VERBOSE 02
-
 static struct progress *progress;
=20
 static void prune_dir(int i, DIR *dir, char *pathname, int len, int op=
ts)
@@ -29,7 +26,7 @@ static void prune_dir(int i, DIR *dir, char *pathname=
, int len, int opts)
 		if (!has_sha1_pack(sha1))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
-		if (opts & DRY_RUN)
+		if (opts & PRUNE_DRY_RUN)
 			printf("rm -f %s\n", pathname);
 		else
 			unlink_or_warn(pathname);
@@ -46,7 +43,7 @@ void prune_packed_objects(int opts)
 	const char *dir =3D get_object_directory();
 	int len =3D strlen(dir);
=20
-	if (opts =3D=3D VERBOSE)
+	if (opts & PRUNE_PROGRESS)
 		progress =3D start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
=20
@@ -71,10 +68,10 @@ void prune_packed_objects(int opts)
=20
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int opts =3D isatty(2) ? VERBOSE : 0;
+	int opts =3D isatty(2) ? PRUNE_PROGRESS : 0;
 	const struct option prune_packed_options[] =3D {
-		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
-		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
+		OPT_BIT('n', "dry-run", &opts, "dry run", PRUNE_DRY_RUN),
+		OPT_NEGBIT('q', "quiet", &opts, "be quiet", PRUNE_PROGRESS),
 		OPT_END()
 	};
=20
diff --git a/builtin/prune.c b/builtin/prune.c
index 58d7cb8..4cdbac0 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -127,9 +127,10 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress =3D NULL;
+	int prune_opts =3D 0;
 	const struct option options[] =3D {
-		OPT__DRY_RUN(&show_only, "do not remove, show only"),
-		OPT__VERBOSE(&verbose, "report pruned objects"),
+		OPT_BIT('n', "dry-run", &prune_opts, "do not remove, show only", PRU=
NE_DRY_RUN),
+		OPT_BIT('v', "verbose", &prune_opts, "report pruned objects", PRUNE_=
VERBOSE),
 		OPT_BOOL(0, "progress", &show_progress, "show progress"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
@@ -143,6 +144,8 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	init_revisions(&revs, prefix);
=20
 	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0);
+	show_only =3D prune_opts & PRUNE_DRY_RUN;
+	verbose =3D prune_opts & PRUNE_VERBOSE;
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name =3D *argv++;
@@ -159,14 +162,16 @@ int cmd_prune(int argc, const char **argv, const =
char *prefix)
=20
 	if (show_progress =3D=3D -1)
 		show_progress =3D isatty(2);
-	if (show_progress)
+	if (show_progress) {
+		prune_opts |=3D PRUNE_PROGRESS;
 		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+	}
=20
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
 	prune_object_dir(get_object_directory());
=20
-	prune_packed_objects(show_only);
+	prune_packed_objects(prune_opts);
 	remove_temporary_files(get_object_directory());
 	s =3D xstrdup(mkpath("%s/pack", get_object_directory()));
 	remove_temporary_files(s);
--=20
1.7.3.1.256.g2539c.dirty

-- 8< --
