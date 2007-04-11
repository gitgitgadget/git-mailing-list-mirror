From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Wed, 11 Apr 2007 22:36:16 +0200
Message-ID: <461D46C0.6080702@lsrfire.ath.cx>
References: <esc64d$d2u$1@sea.gmane.org>	<7virc68nc1.fsf@assigned-by-dhcp.cox.net>	<461A55FB.6070600@lsrfire.ath.cx>	<200704092137.22781.andyparkins@gmail.com>	<461B9E22.5020102@lsrfire.ath.cx> <7v8xczvr13.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nick Williams <njw@jarb.freeserve.co.uk>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 22:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbjYS-00008Z-Q7
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 22:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXDKUge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Apr 2007 16:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbXDKUge
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 16:36:34 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54919
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932129AbXDKUgd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2007 16:36:33 -0400
Received: from [10.0.1.201] (p508e4076.dip.t-dialin.net [80.142.64.118])
	by neapel230.server4you.de (Postfix) with ESMTP id 1717116007;
	Wed, 11 Apr 2007 22:36:31 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7v8xczvr13.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44253>

Junio C Hamano schrieb:
> And I think most people find it natural if you give them the whole
> tree no matter where they start from.

Well, I can't argue against that, as I don't have any numbers.  But I
can understand this expectation a bit ("archive HEAD!" -- "here is an
ear" might be confusing ;).

> You could:
>=20
> $ git archive HEAD -- t/howto
>=20
> to have a narrowed tarball, and even if you make:
>=20
> $ cd t/howto $ git archive HEAD
>=20
> to produce the whole tree, the user can still do:
>=20
> $ cd t/howto $ git archive HEAD -- .
>=20
> to get the narrowed tree if the command understands the prefix it
> receives from git_setup_directory().
>=20
> So while I understand when you say this is "another input method",
> letting people in a deep directory to abbreviate their cwd with "."
> would equally a good input method, and probably better than the
> current implementation, which leaves people without a single way to
> say "I want the whole tree" without cd'ing up.

Hmm, switching the feature's default mode around instead of cutting it
off completely might be a good idea.  Something like this?  Unlike the
current implementation, it always writes the full path from the repo
root for each file.

Ren=C3=A9


diff --git a/builtin-archive.c b/builtin-archive.c
index 7f4e409..efa8679 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -128,18 +128,6 @@ void parse_treeish_arg(const char **argv, struct a=
rchiver_args *ar_args,
 	if (tree =3D=3D NULL)
 		die("not a tree object");
=20
-	if (prefix) {
-		unsigned char tree_sha1[20];
-		unsigned int mode;
-		int err;
-
-		err =3D get_tree_entry(tree->object.sha1, prefix,
-				     tree_sha1, &mode);
-		if (err || !S_ISDIR(mode))
-			die("current working directory is untracked");
-
-		tree =3D parse_tree_indirect(tree_sha1);
-	}
 	ar_args->tree =3D tree;
 	ar_args->commit_sha1 =3D commit_sha1;
 	ar_args->time =3D archive_time;
@@ -241,6 +229,7 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
 	struct archiver ar;
 	int tree_idx;
 	const char *remote =3D NULL;
+	const char **pathspec;
=20
 	remote =3D extract_remote_arg(&argc, argv);
 	if (remote)
@@ -255,7 +244,11 @@ int cmd_archive(int argc, const char **argv, const=
 char *prefix)
=20
 	argv +=3D tree_idx;
 	parse_treeish_arg(argv, &ar.args, prefix);
-	parse_pathspec_arg(argv + 1, &ar.args);
+
+	pathspec =3D argv + 1;
+	if (*pathspec && prefix)
+		pathspec =3D get_pathspec(prefix, pathspec);
+	parse_pathspec_arg(pathspec, &ar.args);
=20
 	return ar.write_archive(&ar.args);
 }
