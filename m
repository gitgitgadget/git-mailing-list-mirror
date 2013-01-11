From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/3] fetch: add --unshallow for turning shallow repo into complete one
Date: Fri, 11 Jan 2013 16:05:46 +0700
Message-ID: <1357895148-30909-1-git-send-email-pclouds@gmail.com>
References: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Jan 11 10:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtaYy-0000ZI-NH
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 10:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385Ab3AKJFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 04:05:46 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41650 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3AKJFn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 04:05:43 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so907565pac.15
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AKsUpYHZyhqfw1ZKnPnFvdrd0CAc6lETNPxLU+tQHGo=;
        b=ehadPySvmkvJDpA+qq3j7om+jp6yGkosPlvy8jrHc0loWJsvemS80yynLXe/gKIexR
         gVKbSsUYz70W4KhtPrrYKidEfiiZb3SH+cBmvPXrEJbfnOTG9CeqltcBtjOmfBZF2i1B
         WvT1iJZNFWLKyrWyxKjddxB0YAh/EkfAnkYJR8RCfK8j8L95K0u3iffSvBA+HKF+w7tB
         ClMqWF3Ojy8Bq7kb/NlDFk/yH2qm2cFZP2dO8hBGpNNR5x2W5fZhBOPc5qdaQGpNNT8V
         RZ8DejUOsdwCsTGJdRQXJu+K2/L664EGrFbnciz4kiS4aiFkO9sIsjpSItMIvijSJthU
         1CUQ==
X-Received: by 10.66.79.134 with SMTP id j6mr183515108pax.11.1357895143242;
        Fri, 11 Jan 2013 01:05:43 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id ou3sm2448656pbb.46.2013.01.11.01.05.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 01:05:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 16:05:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357875005-21956-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213186>

The user can do --depth=3D2147483647 (*) for restoring complete repo
now. But it's hard to remember. Any other numbers larger than the
longest commit chain in the repository would also do, but some
guessing may be involved. Make easy-to-remember --unshallow an alias
for --depth=3D2147483647.

Make upload-pack recognize this special number as infinite depth. The
effect is essentially the same as before, except that upload-pack is
more efficient because it does not have to traverse to the bottom
anymore.

The chance of a user actually wanting exactly 2147483647 commits
depth, not infinite, on a repository with a history that long, is
probably too small to consider. The client can learn to add or
subtract one commit to avoid the special treatment when that actually
happens.

(*) This is the largest positive number a 32-bit signed integer can
    contain. JGit and older C Git store depth as "int" so both are OK
    with this number. Dulwich does not support shallow clone.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Fri, Jan 11, 2013 at 10:55 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
 > I think "no shallow" makes sense in a much more important way than
 > "infinite depth", and this patch is a good idea for a reason
 > entirely different from the justification your log message makes ;-)
 > [snip]
 > Calling the option "--no-shallow" (or even better, "--unshallow",
 > meaning "make it a repository that is no longer shallow") makes it
 > crystal clear that the option is about wiping away the shallowness.
 > Of course, the result has to contain an untruncted history, but that
 > is a mere side effect and an implementation detail from the end
 > user's point of view.

 Very well said. --unshallow it is.

 Documentation/fetch-options.txt     |  4 ++++
 Documentation/git-fetch-pack.txt    |  2 ++
 Documentation/technical/shallow.txt |  3 +++
 builtin/fetch.c                     | 17 ++++++++++++++++-
 commit.h                            |  3 +++
 t/t5500-fetch-pack.sh               | 20 ++++++++++++++++++++
 upload-pack.c                       | 13 ++++++++++---
 7 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 6e98bdf..8a0449c 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -13,6 +13,10 @@
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
=20
+--unshallow::
+	Convert a shallow repository to a complete one, removing all
+	the limitations imposed by shallow repositories.
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
index 4b5a898..2b15ced 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -32,7 +32,7 @@ enum {
=20
 static int all, append, dry_run, force, keep, multiple, prune, update_=
head_ok, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT;
+static int tags =3D TAGS_DEFAULT, unshallow;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
@@ -82,6 +82,9 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
+		   N_("convert to a complete repository"),
+		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	{ OPTION_STRING, 0, "recurse-submodules-default",
@@ -970,6 +973,18 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
=20
+	if (unshallow) {
+		if (depth)
+			die(_("--depth and --unshallow cannot be used together"));
+		else if (!is_repository_shallow())
+			die(_("--unshallow on a complete repository does not make sense"));
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
index 6322e8a..426027e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -264,6 +264,26 @@ test_expect_success 'clone shallow object count' '
 	grep "^count: 52" count.shallow
 '
=20
+test_expect_success 'fetch --no-shallow on full repo' '
+	test_must_fail git fetch --noshallow
+'
+
+test_expect_success 'fetch --depth --no-shallow' '
+	(
+		cd shallow &&
+		test_must_fail git fetch --depth=3D1 --noshallow
+	)
+'
+
+test_expect_success 'turn shallow to complete repository' '
+	(
+		cd shallow &&
+		git fetch --unshallow &&
+		! test -f .git/shallow &&
+		git fsck --full
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
