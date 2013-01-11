From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] fetch, upload-pack: add --no-shallow for infinite depth
Date: Fri, 11 Jan 2013 10:30:04 +0700
Message-ID: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
References: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 04:30:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtVKI-0001wv-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab3AKDaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 22:30:14 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:61528 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3AKDaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:30:13 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so560111dad.10
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 19:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/Yi/AjI8pJLXuyFhuHeUPG17LcKeMTpAN61zPCFhJQQ=;
        b=MiU3nnIjVB/BKeyavAdHZDorbTaJMg0Gq3rYcpM3gXeSVfulOmwkKsA/9FYGHKsI15
         MDd/z356NLlko2EvL31vDuwG/+jttx5IU5LBwcP6F8Z5dSr7ch27FDUnUr0F2szwQeF9
         XUhRHh1OEH/0RmPHO0WlY5Pllj9hFxDAjI1q3RJoqAjfkg7vryf3C7dLXlP1YVkcAUmO
         eA9VbHCapB8226k5rf2mj/fn4pNraKZt11xdSpt7kzeEDYSE9rPsDkf6H9l4P55ABge2
         Y20CLQoi9DnvmK6nz5THf/sPyhM6aDRobyugYs0Uicq9eKb5Q3r1Nj3WoJXjmVvoE7m0
         F8JQ==
X-Received: by 10.66.88.164 with SMTP id bh4mr61962970pab.41.1357875012309;
        Thu, 10 Jan 2013 19:30:12 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id rn8sm1918824pbc.65.2013.01.10.19.30.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 19:30:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 10:30:20 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213168>

The user can do --depth=3D2147483647 (*) for infinite depth now. But
it's hard to remember. Any other numbers larger than the longest
commit chain in the repository would also do, but some guessing may
be involved. Make easy-to-remember --no-shallow an alias for
--depth=3D2147483647.

Make upload-pack recognize this special number as infinite depth. The
effect is essentially the same as before, except that upload-pack is
more efficient because it does not have to traverse to the bottom
any more. The chance of a user actually wanting exactly 2147483647
commits depth, not infinite, on a repository with a history that long,
is probably too small to consider.

(*) This is the largest positive number a 32-bit signed integer can
    contain. JGit and older C Git store depth as "int" so both are OK
    with this number. Dulwich does not support shallow clone.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt     |  4 ++++
 Documentation/git-fetch-pack.txt    |  2 ++
 Documentation/technical/shallow.txt |  3 +++
 builtin/fetch.c                     | 15 ++++++++++++++-
 commit.h                            |  3 +++
 t/t5500-fetch-pack.sh               | 16 ++++++++++++++++
 upload-pack.c                       | 13 ++++++++++---
 7 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 6e98bdf..012d1b2 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -13,6 +13,10 @@
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
=20
+--no-shallow::
+	Deepen to the roots of the repository's history (i.e. the
+	result repository is no longer shallow).
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 8c75120..b81e90d 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -84,6 +84,8 @@ be in a separate packet, and the list must end with a=
 flush packet.
=20
 --depth=3D<n>::
 	Limit fetching to ancestor-chains not longer than n.
+	'git-upload-pack' treats the special depth 2147483647 as
+	infinite even if there is an ancestor-chain that long.
=20
 --no-progress::
 	Do not show the progress.
diff --git a/Documentation/technical/shallow.txt b/Documentation/techni=
cal/shallow.txt
index 0502a54..ea2f69f 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -53,3 +53,6 @@ It also writes an appropriate $GIT_DIR/shallow.
 You can deepen a shallow repository with "git-fetch --depth 20
 repo branch", which will fetch branch from repo, but stop at depth
 20, updating $GIT_DIR/shallow.
+
+The special depth 2147483647 (or 0x7fffffff, the largest positive
+number a signed 32-bit integer can contain) means infinite depth.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b5a898..bf7b5c5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -32,7 +32,7 @@ enum {
=20
 static int all, append, dry_run, force, keep, multiple, prune, update_=
head_ok, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT;
+static int tags =3D TAGS_DEFAULT, no_shallow;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
@@ -82,6 +82,9 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	{ OPTION_SET_INT, 0, "no-shallow", &no_shallow, NULL,
+		   N_("deepen history to the bottom"),
+		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	{ OPTION_STRING, 0, "recurse-submodules-default",
@@ -970,6 +973,16 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
+	if (no_shallow) {
+		if (depth)
+			die(_("--depth and --no-shallow cannot be used together"));
+		else {
+			static char inf_depth[12];
+			sprintf(inf_depth, "%d", INFINITE_DEPTH);
+			depth =3D inf_depth;
+		}
+	}
+
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		if (recurse_submodules_default) {
 			int arg =3D parse_fetch_recurse_submodules_arg("--recurse-submodule=
s-default", recurse_submodules_default);
diff --git a/commit.h b/commit.h
index 0f469e5..fbde106 100644
--- a/commit.h
+++ b/commit.h
@@ -162,6 +162,9 @@ extern struct commit_list *get_merge_bases(struct c=
ommit *rev1, struct commit *r
 extern struct commit_list *get_merge_bases_many(struct commit *one, in=
t n, struct commit **twos, int cleanup);
 extern struct commit_list *get_octopus_merge_bases(struct commit_list =
*in);
=20
+/* largest postive number a signed 32-bit integer can contain */
+#define INFINITE_DEPTH 0x7fffffff
+
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
 extern int for_each_commit_graft(each_commit_graft_fn, void *);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6322e8a..6a6e672 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -264,6 +264,22 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
=20
+test_expect_success 'fetch --depth --no-shallow' '
+	(
+		cd shallow &&
+		test_must_fail git fetch --depth=3D1 --no-shallow
+	)
+'
+
+test_expect_success 'infinite deepening (full repo)' '
+	(
+		cd shallow &&
+		git fetch --no-shallow &&
+		git fsck --full &&
+		! test -f .git/shallow
+	)
+'
+
 test_expect_success 'clone shallow without --no-single-branch' '
 	git clone --depth 1 "file://$(pwd)/." shallow2
 '
diff --git a/upload-pack.c b/upload-pack.c
index 6142421..88f0029 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -670,10 +670,17 @@ static void receive_needs(void)
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
 	if (depth > 0) {
-		struct commit_list *result, *backup;
+		struct commit_list *result =3D NULL, *backup =3D NULL;
 		int i;
-		backup =3D result =3D get_shallow_commits(&want_obj, depth,
-			SHALLOW, NOT_SHALLOW);
+		if (depth =3D=3D INFINITE_DEPTH)
+			for (i =3D 0; i < shallows.nr; i++) {
+				struct object *object =3D shallows.objects[i].item;
+				object->flags |=3D NOT_SHALLOW;
+			}
+		else
+			backup =3D result =3D
+				get_shallow_commits(&want_obj, depth,
+						    SHALLOW, NOT_SHALLOW);
 		while (result) {
 			struct object *object =3D &result->item->object;
 			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
--=20
1.8.0.rc2.23.g1fb49df
