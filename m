From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] add post-fetch hook
Date: Sat, 24 Dec 2011 19:42:12 -0400
Message-ID: <20111224234212.GA21533@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 00:42:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RebEh-0003GK-3o
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 00:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab1LXXmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 18:42:22 -0500
Received: from wren.kitenet.net ([80.68.85.49]:34378 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab1LXXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 18:42:21 -0500
Received: from gnu.kitenet.net (dialup-4.154.1.50.Dial1.Atlanta1.Level3.net [4.154.1.50])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 76A5D1180BA
	for <git@vger.kernel.org>; Sat, 24 Dec 2011 18:42:17 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id E66E74497B; Sat, 24 Dec 2011 18:42:12 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187662>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The post-fetch hook is fed on its stdin all refs that were newly fetched.
It is not allowed to abort the fetch (or pull), but can modify what
was fetched or take other actions.

One example use of this hook is to automatically merge certain remote
branches into a local branch. Another is to update a local cache
(such as a search index) with the fetched refs. No other hook is run
near fetch time, except for post-merge, which doesn't always run after a
fetch, which is why this additional hook is useful.

Signed-off-by: Joey Hess <joey@kitenet.net>

---

The #1 point of confusion for git-annex users is the need to run
"git annex merge" after fetching. That does a union merge of newly
fetched remote git-annex branches into the local git-annex branch.
If a user does a "git pull; ... ; git push" and forgets to git annex merge
in between, their push often fails as the git-annex branches have diverged.
With this hook, that confusing step can be eliminated.

Since git annex merge could be run at any point between fetch and push,
I considered several different hooks, including this one, a pre-push hook,
and a variant of this hook that does not feed the hook any information
on stdin. I chose this one, with the information on stdin because it seems
the most generally useful, and will let me make git annex merge slightly
more optimal than it would be without the stdin.

 Documentation/githooks.txt |   12 ++++++++++
 builtin/fetch.c            |   50 ++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..96a588c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -162,6 +162,18 @@ This hook can be used to perform repository validity c=
hecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+post-fetch
+~~~~~~~~~~
+
+This hook is invoked by 'git fetch' (commonly called by 'git pull'), after
+refs have been fetched from the remote repository. It takes no arguments,
+but is fed a list of new or updated refs on its standard input. This hook
+cannot affect the outcome of 'git fetch' and is not executed, if nothing
+was fetched.
+
+This hook can make modifications to the fetched refs, or take other
+actions.
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..d813b8e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -89,6 +89,52 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_END()
 };
=20
+static const char post_fetch_hook[] =3D "post-fetch";
+struct ref *fetched_refs =3D NULL;
+void run_post_fetch_hook (void) {
+	struct ref *ref;
+	struct child_process proc;
+	const char *argv[2];
+	FILE *f;
+
+	if (! fetched_refs)
+		return;
+
+	argv[0] =3D git_path("hooks/%s", post_fetch_hook);
+	if (access(argv[0], X_OK) < 0)
+		return;
+	argv[1] =3D NULL;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv =3D argv;
+	proc.in =3D -1;
+	proc.stdout_to_stderr =3D 1;
+	if (start_command(&proc) !=3D 0)
+		return;
+
+	f =3D fdopen(proc.in, "w");
+	if (f =3D=3D NULL) {
+		close(proc.in);
+		goto cleanup;
+	}
+	for (ref =3D fetched_refs; ref; ref =3D ref->next)
+		fprintf(f, "%s\n", ref->name);
+	fclose(f);
+
+cleanup:
+	free_refs(fetched_refs);
+	fetched_refs =3D NULL;
+
+	finish_command(&proc);
+	close(proc.in);
+}
+
+void post_fetch_hook_observe (const struct ref *fetched_ref) {
+	struct ref *ref =3D copy_ref(fetched_ref);
+	ref->next =3D fetched_refs;
+	fetched_refs =3D ref;
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -233,6 +279,7 @@ static int s_update_ref(const char *action,
 	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
 		return errno =3D=3D ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	post_fetch_hook_observe(ref);
 	return 0;
 }
=20
@@ -755,6 +802,9 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 	}
=20
+	/* Run hook only after fetching all refs. */
+	run_post_fetch_hook();
+
 	return 0;
 }
=20
--=20
1.7.7.3

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvZjTckQ2SIlEuPHAQi3/BAAsOxOS5QXPtVvts3wR+yiPgtbn6ykJXn1
+jLCIo+82ocG7YXKQRjXS9tpyJKt4b8rqRqKYdjr8TLLjaZWR97CdeyAZY1xVtXA
9J1JWS/zuOJABcVVAZYFjjpUzPCq6sBUVeD+CezdOq7YMAPhzXse/2Ox0+QeOWbO
COoM7XIIz/tyULIWnvuQQ0VVRoFIXj19yp6MnrNaq5YL6NP7FJZQ2ex4J4BxSYji
0KY9FjREIUAy3USqV4LYTYVSKI0vl1YV69WX0rw9Sdk2S4Rg11yV8qugE7u51czb
JEEpRMC87qaPyK7mz54MZCeX8eMrrLorSSc0TA7a9zbqHBRfqP2zfdmEPcldUZ+w
D1uW0haKakMAiYEWAdFo4MYmNIMdW1sGqJlyM/VzoyPc59PDt6b2T4jyOYI8OZdP
accAz3aEz4s4/nMSkhKKy4iabpiQ49lUW9oqCAc4gwF5ZmopvkcfoD+FSv1IwytV
Y0/AbppyNmVY97cd1IWIy7HE1ZP2KUWPgIskBZdtlaF1+leL49/6bj/mRJ4oL9sm
1Rlc2k2WNEQ2InNioj3ZBK7niwcl1s4ty1+1XVInKWMzghVs0DPV2aqLKRb8xbSo
prZ9/nJO/wS18eB+uiUXwiZr6olp1L5lCkZx6Eewu9i3/ZYlGCma8WPmV7G/9mZE
Lzs9jBvz1TE=
=WV5w
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
