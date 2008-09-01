From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Mon, 1 Sep 2008 03:06:12 +0200
Message-ID: <20080901010612.GC16514@genesis.frugalware.org>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org> <20080819125429.GD17582@genesis.frugalware.org> <7vabf83j9u.fsf@gitster.siamese.dyndns.org> <20080819205917.GJ23800@genesis.frugalware.org> <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ahZICQ7iXVM/oLYH"
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 03:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZxt2-0005Sk-IB
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYIABGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 21:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYIABGP
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:06:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45382 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbYIABGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 21:06:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EC7271B251A;
	Mon,  1 Sep 2008 03:06:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8E5E34465E;
	Mon,  1 Sep 2008 03:06:12 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6E012119003C; Mon,  1 Sep 2008 03:06:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3al0zmv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94518>


--ahZICQ7iXVM/oLYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2008 at 03:00:27PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> and the call chain would become:
> (...)
>     cmd_revert(), cmd_am(), cmd_checkout(), cmd_stash(), ...
>     -> merge_trees()

I tried to let cmd_revert() use merge_trees() only and not
merge_recursive_generic(), but something is fishy with it.

t3501-revert-cherry-pick passes fine, but t3404-rebase-interactive fail,
becase once we have a conflict, git diff --name-status says 'M' for the
given file and not 'U', which is obviously wrong.

I'm sending both patches: the one that works properly using
merge_recursive_generic() - and which one passes the testsuite here, and
the one that is elegant as it uses merge_trees(), but actually not
complete, at least regarding not adding the unmerged entries to the
index.

So, first here is my failed attempt to use merge_trees() inside
builtin-revert:

diff --git a/builtin-revert.c b/builtin-revert.c
index 3667705..3071518 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
+#include "merge-recursive.h"
=20
 /*
  * This implements the builtins revert and cherry-pick.
@@ -201,36 +202,6 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
=20
-static int merge_recursive(const char *base_sha1,
-		const char *head_sha1, const char *head_name,
-		const char *next_sha1, const char *next_name)
-{
-	char buffer[256];
-	const char *argv[6];
-	int i =3D 0;
-
-	sprintf(buffer, "GITHEAD_%s", head_sha1);
-	setenv(buffer, head_name, 1);
-	sprintf(buffer, "GITHEAD_%s", next_sha1);
-	setenv(buffer, next_name, 1);
-
-	/*
-	 * This three way merge is an interesting one.  We are at
-	 * $head, and would want to apply the change between $commit
-	 * and $prev on top of us (when reverting), or the change between
-	 * $prev and $commit on top of us (when cherry-picking or replaying).
-	 */
-	argv[i++] =3D "merge-recursive";
-	if (base_sha1)
-		argv[i++] =3D base_sha1;
-	argv[i++] =3D "--";
-	argv[i++] =3D head_sha1;
-	argv[i++] =3D next_sha1;
-	argv[i++] =3D NULL;
-
-	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
-}
-
 static char *help_msg(const unsigned char *sha1)
 {
 	static char helpbuf[1024];
@@ -271,6 +242,8 @@ static int revert_or_cherry_pick(int argc, const char *=
*argv)
 	char *oneline, *reencoded_message =3D NULL;
 	const char *message, *encoding;
 	const char *defmsg =3D xstrdup(git_path("MERGE_MSG"));
+	struct merge_options o;
+	struct tree *result;
=20
 	git_config(git_default_config, NULL);
 	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
@@ -374,13 +347,16 @@ static int revert_or_cherry_pick(int argc, const char=
 **argv)
 		}
 	}
=20
-	if (merge_recursive(base =3D=3D NULL ?
-				NULL : sha1_to_hex(base->object.sha1),
-				sha1_to_hex(head), "HEAD",
-				sha1_to_hex(next->object.sha1), oneline) ||
-			write_cache_as_tree(head, 0, NULL)) {
+	read_cache();
+	init_merge_options(&o);
+	o.branch1 =3D "HEAD";
+	o.branch2 =3D oneline;
+	parse_commit(next);
+	parse_commit(base);
+	if (!merge_trees(&o, lookup_commit_reference_gently(head, 0)->tree,
+				next->tree, base->tree, &result) ||
+		write_cache_as_tree(head, 0, NULL)) {
 		add_to_msg("\nConflicts:\n\n");
-		read_cache();
 		for (i =3D 0; i < active_nr;) {
 			struct cache_entry *ce =3D active_cache[i++];
 			if (ce_stage(ce)) {

--ahZICQ7iXVM/oLYH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki7QAQACgkQe81tAgORUJbMcwCeIGEu0YK9a73WN6JURE7x7xZL
eZoAn1+28sq0mEKIWS6vGYm5vH+KAQzY
=alwW
-----END PGP SIGNATURE-----

--ahZICQ7iXVM/oLYH--
