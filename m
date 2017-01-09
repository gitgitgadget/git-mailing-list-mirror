Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D78331FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760095AbdAIMNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 07:13:21 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:34408 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759229AbdAIMM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 07:12:28 -0500
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v09CCQOK020552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2017 12:12:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v09CCPIO028056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jan 2017 12:12:26 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v09CCNl2012522;
        Mon, 9 Jan 2017 12:12:24 GMT
Received: from localhost (/10.175.238.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jan 2017 04:12:22 -0800
Date:   Mon, 9 Jan 2017 13:17:24 +0100
From:   Quentin Casasnovas <quentin.casasnovas@oracle.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Refreshing index timestamps without reading content
Message-ID: <20170109121724.GC7000@chrystal.oracle.com>
References: <20170105112359.GN8116@chrystal.oracle.com>
 <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: multipart/mixed; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 07:02:45PM +0700, Duy Nguyen wrote:
> On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
> <quentin.casasnovas@oracle.com> wrote:
>=20
> > If not, I am willing to implement a --assume-content-unchanged to the g=
it
> > update-index if you guys don't see something fundamentally wrong with t=
his
> > approach.
>=20
> If you do that, I think you should go with either of the following options
>=20
> - Extend git-update-index --index-info to take stat info as well (or
> maybe make a new option instead). Then you can feed stat info directly
> to git without a use-case-specific "assume-content-unchanged".
>=20
> - Add "git update-index --touch" that does what "touch" does. In this
> case, it blindly updates stat info to latest. But like touch, we can
> also specify  mtime from command line if we need to. It's a bit less
> generic than the above option, but easier to use.
>=20
> Caveat: The options I'm proposing can be rejected. So maybe wait a bit
> to see how people feel and perhaps send an RFC patch, again to gauge
> the reception.


Hey Duy,

Thanks for your answer.

I've played with this a bit last week and added an extra command, which I
called --refresh-stat, which works like your suggested --index.  It works
very well with my use case and improves the performances very significantly
on some of our use cases.

It is attached to this e-mail to gather comments, as you suggest, and is
really not meant to be reviewed for inclusion yet as it lacks test cases,
documentation changes, etc.  It is just a convenient way to show what I
need and receive comments.

The logic is simple enugh and will just skip calling ie_modified() when
refreshing the index.

Cheers,
Q

--S1BNGpv0yoYahz37
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-git-update-index-add-refresh-stat-option.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 461b4f75056fc476db6bbdf8bc3ff6e91a8ad08d Mon Sep 17 00:00:00 2001
=46rom: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Date: Sat, 7 Jan 2017 09:26:29 +0100
Subject: [PATCH] git-update-index: add --refresh-stat option.

git-update-index --refresh, contrary to what the documentation says, not
only will refresh the stat information but will also update the sha1 of the
objects in the working tree if the stat information is found to be
out-of-date.

We add a --refresh-stat option, which like --refresh will update the stat
information, but will assume that any file in the working tree that is
present in the index matches the index - hence prevents unecessarily
reading the files in the working tree.  It is different from
--assume-unchanged or --skip-worktree in that the new stat information is
recorded in the index, hence subsequent git update-index --refresh will not
read the files if their mtime hasn't changed.

This sounds like a very dangerous option to give to the user, since it
could potentially cause changed files to be missed, but can be needed when
we are sure the working tree files have not changed and are matching the
index.

Signed-off-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
---
 builtin/update-index.c | 10 ++++++++++
 cache.h                |  3 +++
 read-cache.c           |  7 +++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f3f07e7f1cb2..1215b6a09687 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -777,6 +777,12 @@ static int really_refresh_callback(const struct option=
 *opt,
 	return refresh(opt->value, REFRESH_REALLY);
 }
=20
+static int refresh_stat_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	return refresh(opt->value, REFRESH_STAT_ONLY);
+}
+
 static int chmod_callback(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -934,6 +940,10 @@ int cmd_update_index(int argc, const char **argv, cons=
t char *prefix)
 			N_("refresh stat information"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			refresh_callback},
+		{OPTION_CALLBACK, 0, "refresh-stat", &refresh_args, NULL,
+			N_("refresh only stat information (assume content has not changed)"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			refresh_stat_callback},
 		{OPTION_CALLBACK, 0, "really-refresh", &refresh_args, NULL,
 			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
diff --git a/cache.h b/cache.h
index a50a61a19787..57d0f9fffbe5 100644
--- a/cache.h
+++ b/cache.h
@@ -611,6 +611,8 @@ extern void *read_blob_data_from_index(struct index_sta=
te *, const char *, unsig
 #define CE_MATCH_IGNORE_MISSING		0x08
 /* enable stat refresh */
 #define CE_MATCH_REFRESH		0x10
+/* only stat refresh, assume content hasn't changed */
+#define CE_MATCH_REFRESH_STAT_ONLY	0x20
 extern int ie_match_stat(const struct index_state *, const struct cache_en=
try *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, const struct cache_entr=
y *, struct stat *, unsigned int);
=20
@@ -643,6 +645,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce=
, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs up=
date" */
+#define REFRESH_STAT_ONLY	0x0040	/* do not check content but update stat */
 extern int refresh_index(struct index_state *, unsigned int flags, const s=
truct pathspec *pathspec, char *seen, const char *header_msg);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsig=
ned int);
=20
diff --git a/read-cache.c b/read-cache.c
index db5d91064266..e9334094c6f0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1101,6 +1101,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 	int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
 	int ignore_skip_worktree =3D options & CE_MATCH_IGNORE_SKIP_WORKTREE;
 	int ignore_missing =3D options & CE_MATCH_IGNORE_MISSING;
+	int assume_content_unchanged =3D options & CE_MATCH_REFRESH_STAT_ONLY;
=20
 	if (!refresh || ce_uptodate(ce))
 		return ce;
@@ -1161,7 +1162,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 		}
 	}
=20
-	if (ie_modified(istate, ce, &st, options)) {
+	if (!assume_content_unchanged && ie_modified(istate, ce, &st, options)) {
 		if (err)
 			*err =3D EINVAL;
 		return NULL;
@@ -1206,11 +1207,13 @@ int refresh_index(struct index_state *istate, unsig=
ned int flags,
 	int quiet =3D (flags & REFRESH_QUIET) !=3D 0;
 	int not_new =3D (flags & REFRESH_IGNORE_MISSING) !=3D 0;
 	int ignore_submodules =3D (flags & REFRESH_IGNORE_SUBMODULES) !=3D 0;
+	int refresh_stat_only =3D (flags & REFRESH_STAT_ONLY) !=3D 0;
 	int first =3D 1;
 	int in_porcelain =3D (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options =3D (CE_MATCH_REFRESH |
 				(really ? CE_MATCH_IGNORE_VALID : 0) |
-				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
+				(not_new ? CE_MATCH_IGNORE_MISSING : 0) |
+				(refresh_stat_only ? CE_MATCH_REFRESH_STAT_ONLY : 0));
 	const char *modified_fmt;
 	const char *deleted_fmt;
 	const char *typechange_fmt;
--=20
2.11.0


--S1BNGpv0yoYahz37--

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYc39UAAoJEB5Tt01po9cNLogP/3ScNVNp3RpKU+6+Ye9wAl1H
lMWfxk2Dg1gdMsIeCyT4r+5o51CkTrd3KsFbn8VKAmZ4jGxrtiOu6hLYpiHdx2oH
ltpUBcd/D0utF71YMsl3QWKzCuhXniDjfDMUT+w/odo+D6LHtUWBdRnCg75P97cP
mpJQqTjDUgwYjrAzbFYl93gAUvnj8iRa40U+BgHeku/dnIy6yzrZ/vYDnwkFmMPk
nRqWhzLSqpfhpQOvVgkLvIC7dsq20ICJwEKL/DiQbhxFsdVrbf8sK037qV9hP0g1
jnp76xbkVs8sSQ2LB/fIXA0PhNzlTzbqVNH306Oq2iLTjyq259aX8T3jcTOI8gwo
8qrvyVV7+snya/2DVYdwegFZVm+f4Hq2q8z80cGf2ZRB+3b0AQhlhtriLoGAO39N
7LTWAFaPQ0T5x50NKG+wobX4dN9d1xhjdPdf1enNSC0bFb/fQ4FHqVxWBfOU8eNO
Oyuw8ORqUcK5ByMXErQvhualYnM5UIrVwhcox1g7II4miIIrf1S9D4cd3nZyVP8e
FhbnWnT+3Y2bU2sdLQAvi/wPulve+8RVVA64/xCZk7Ca23Y+rQMlnzSpw0U4EWR8
Wy+vtFHvWOKw6loW5nG33q5lkv48XfG1VTyWn1QoNOLp3bsY5v7+N8c3bYiMD0Am
a6Xg7ZuYmWKSBvYX/AmL
=Fh13
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
