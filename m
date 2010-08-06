From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/12] grep: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:06:39 -0500
Message-ID: <20100806030637.GI22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:08:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDIG-0005jz-Ox
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758844Ab0HFDIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:08:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43586 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0HFDIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:08:06 -0400
Received: by gxk23 with SMTP id 23so2715868gxk.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=B3oa6qBAv3HJHOo/LOmG9/Fn75p1N03o2Xgv3+ZtmCw=;
        b=sEE80f+avAZWpx9ximq0GnFD5uls8IbksOXBzQ75mOXlKLYj/q3xH3B3p0uWSqHusf
         XUsDWOB0VPeDJryzyibmmsaJwuc7UYGDYoHDyeZH+/4GMygpbwn8lu8kKoMVYIcoezlQ
         V32W2yI+lNIG9lByMCi043zFvli3QUZpfxhHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zt8ruHvqovFG0qoyMI7HYZDrFtgyzvg85GKh20ZyFPGHnMbI+AAmSvN+0rCSCkg0YS
         fcn/4+Hn8RQ9494st5VNopVt4aiBc+Ru0Y9kRwbN3uLIXgqC6Tq73jBumZBnzn3Qf8wi
         boTZvFmEVmsMb6Qs+al6yaA/6Z0pM4Mnbe1Io=
Received: by 10.150.74.16 with SMTP id w16mr13364266yba.138.1281064085853;
        Thu, 05 Aug 2010 20:08:05 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id u41sm930879yba.10.2010.08.05.20.08.04
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:08:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152750>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

git grep already runs a repository search unconditionally,
even when the --no-index option is supplied; running such a
search earlier is not very risky.

Just like with shortlog, without this change, the
=E2=80=9C[pager] grep=E2=80=9D configuration is not respected at all.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Aside from rewriting the commit message and adding tests, this
drops the interesting

 -		/* die the same way as if we did it at the beginning */
 -		setup_git_directory();
 +		die("No git repository found");

hunk.  That change might be a good idea but it does not fit the
theme of this chapter.

 builtin/grep.c   |    6 ++----
 git.c            |    2 +-
 t/t7006-pager.sh |   13 +++++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d0a73da..cd44926 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -791,7 +791,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char **paths =3D NULL;
 	int i;
 	int dummy;
-	int nongit =3D 0, use_index =3D 1;
+	int use_index =3D 1;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -879,8 +879,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
@@ -925,7 +923,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
=20
-	if (use_index && nongit)
+	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
=20
diff --git a/git.c b/git.c
index b821058..0240179 100644
--- a/git.c
+++ b/git.c
@@ -336,7 +336,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
-		{ "grep", cmd_grep, USE_PAGER },
+		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object },
 		{ "help", cmd_help },
 		{ "index-pack", cmd_index_pack },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 084dfdb..fd7f77b 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -105,6 +105,19 @@ test_expect_success TTY 'no pager with --no-pager'=
 '
 	! test -e paginated.out
 '
=20
+test_expect_success TTY 'configuration can disable pager' '
+	rm -f paginated.out &&
+	test_might_fail git config --unset pager.grep &&
+	test_terminal git grep initial &&
+	test -e paginated.out &&
+
+	rm -f paginated.out &&
+	git config pager.grep false &&
+	test_when_finished "git config --unset pager.grep" &&
+	test_terminal git grep initial &&
+	! test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
--=20
1.7.2.1.544.ga752d.dirty
