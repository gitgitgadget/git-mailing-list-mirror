From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] diff: squelch empty diffs even more
Date: Wed, 15 Aug 2007 00:41:00 +0200
Message-ID: <46C22F7C.1000502@lsrfire.ath.cx>
References: <46C21A25.2040304@lsrfire.ath.cx> <7v643hbyao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 00:41:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL54g-0001IR-K7
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXHNWlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXHNWlN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 18:41:13 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:44247
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbXHNWlM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 18:41:12 -0400
Received: from [10.0.1.201] (p508ED78A.dip.t-dialin.net [80.142.215.138])
	by neapel230.server4you.de (Postfix) with ESMTP id E84C98B008;
	Wed, 15 Aug 2007 00:41:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v643hbyao.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55861>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> When we compare two non-tracked files or explicitly specify
>> --no-index then the suggestion to run git-status is not helpful.
>=20
> That observation is correct but how does skip_stat_unmatch count
> up in such a case?  Shouldn't diffcore_skip_stat_unmatch()
> function be taught about such a "fake" filepair that did not
> come from git, and ignore the stat differences?

Hmm.  Like this?

The patch adds a new diff_options bitfield member, no_index, that
is used instead of the special value of -2 of the rev_info field
max_count to indicate that the index is not to be used.  This makes
it possible to pass that flag down to diffcore_skip_stat_unmatch(),
which only has one diff_options parameter.

This could even become a cleanup if we removed all assignments of
max_count to a value of -2 (viz. replacement of a magic value with
a self-documenting field name) but I didn't dare to do that so late
in the rc game..

The no_index bit, if set, then tells diffcore_skip_stat_unmatch()
to not account for any skipped stat-mismatches, which avoids the
suggestion to run git-status.

Ren=C3=A9
---

 diff-lib.c |    8 ++++++--
 diff.c     |    3 ++-
 diff.h     |    1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 92c0e39..f5568c3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -189,6 +189,7 @@ static int handle_diff_files_args(struct rev_info *=
revs,
 				!strcmp(argv[1], "--no-index")) {
 			revs->max_count =3D -2;
 			revs->diffopt.exit_with_status =3D 1;
+			revs->diffopt.no_index =3D 1;
 		}
 		else if (!strcmp(argv[1], "-q"))
 			*silent =3D 1;
@@ -204,8 +205,10 @@ static int handle_diff_files_args(struct rev_info =
*revs,
 		 */
 		read_cache();
 		if (!is_in_index(revs->diffopt.paths[0]) ||
-					!is_in_index(revs->diffopt.paths[1]))
+					!is_in_index(revs->diffopt.paths[1])) {
 			revs->max_count =3D -2;
+			revs->diffopt.no_index =3D 1;
+		}
 	}
=20
 	/*
@@ -293,6 +296,7 @@ int setup_diff_no_index(struct rev_info *revs,
 	else
 		revs->diffopt.paths =3D argv + argc - 2;
 	revs->diffopt.nr_paths =3D 2;
+	revs->diffopt.no_index =3D 1;
 	revs->max_count =3D -2;
 	return 0;
 }
@@ -304,7 +308,7 @@ int run_diff_files_cmd(struct rev_info *revs, int a=
rgc, const char **argv)
 	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
 		return -1;
=20
-	if (revs->max_count =3D=3D -2) {
+	if (revs->diffopt.no_index) {
 		if (revs->diffopt.nr_paths !=3D 2)
 			return error("need two files/directories with --no-index");
 		if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
diff --git a/diff.c b/diff.c
index f884de7..97cc5bc 100644
--- a/diff.c
+++ b/diff.c
@@ -3185,7 +3185,8 @@ static void diffcore_skip_stat_unmatch(struct dif=
f_options *diffopt)
 			 * to determine how many paths were dirty only
 			 * due to stat info mismatch.
 			 */
-			diffopt->skip_stat_unmatch++;
+			if (!diffopt->no_index)
+				diffopt->skip_stat_unmatch++;
 			diff_free_filepair(p);
 		}
 	}
diff --git a/diff.h b/diff.h
index de21f8e..4546aad 100644
--- a/diff.h
+++ b/diff.h
@@ -60,6 +60,7 @@ struct diff_options {
 		 color_diff_words:1,
 		 has_changes:1,
 		 quiet:1,
+		 no_index:1,
 		 allow_external:1,
 		 exit_with_status:1;
 	int context;
