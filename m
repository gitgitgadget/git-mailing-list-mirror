From: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>
Subject: [PATCH 1/2] builtin/symbolic-ref.c: add option to fall back to normal ref
Date: Mon, 27 Feb 2012 23:08:56 +0100
Message-ID: <1330380536-9647-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 23:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28kv-0000Na-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 23:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab2B0WJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 17:09:09 -0500
Received: from zoidberg.org ([88.198.6.61]:38727 "EHLO heapsort.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab2B0WJI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 17:09:08 -0500
Received: from perceptron.heapsort.bogus (xdsl-89-0-11-50.netcologne.de [::ffff:89.0.11.50])
  (AUTH: PLAIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu with esmtp; Mon, 27 Feb 2012 23:09:04 +0100
  id 00400F65.4F4BFF01.000033F1
X-Mailer: git-send-email 1.7.9.2.302.g3724c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191682>

=46requently, people want to determine the current value of HEAD in
scripts. However, there is no tool that can always output it, since "gi=
t
symbolic-ref" will fail if HEAD isn't currently a symref, and other
tools (e.g. "git rev-parse --symbolic-full-name") will also fail in
one of HEAD's possible modes.

To resolve this situation, add the new -f option to symbolic-ref that
falls back to outputting the value of HEAD as a normal ref if necessary=
=2E

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-symbolic-ref.txt |    7 ++++++-
 builtin/symbolic-ref.c             |   16 ++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-sym=
bolic-ref.txt
index a45d4c4..a05819b 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -8,7 +8,7 @@ git-symbolic-ref - Read and modify symbolic refs
 SYNOPSIS
 --------
 [verse]
-'git symbolic-ref' [-q] [-m <reason>] <name> [<ref>]
+'git symbolic-ref' [-q] [-f] [-m <reason>] <name> [<ref>]
=20
 DESCRIPTION
 -----------
@@ -33,6 +33,11 @@ OPTIONS
 	symbolic ref but a detached HEAD; instead exit with
 	non-zero status silently.
=20
+-f::
+	When showing the current value of <name>, do not fail if it is
+	not a symbolic ref; instead output the SHA1 value referenced by
+	<name>.
+
 -m::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 2ef5962..2e0a86f 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -8,6 +8,8 @@ static const char * const git_symbolic_ref_usage[] =3D =
{
 	NULL
 };
=20
+static int fallback_regular_ref;
+
 static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
@@ -17,10 +19,18 @@ static void check_symref(const char *HEAD, int quie=
t)
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
 	else if (!(flag & REF_ISSYMREF)) {
-		if (!quiet)
+		if (fallback_regular_ref) {
+			char sha1[20];
+			if (!get_sha1(HEAD, sha1))
+				puts(sha1_to_hex(sha1));
+			else
+				die("failed to resolve ref %s", HEAD);
+			return;
+		} else if (!quiet) {
 			die("ref %s is not a symbolic ref", HEAD);
-		else
+		} else {
 			exit(1);
+		}
 	}
 	puts(refs_heads_master);
 }
@@ -32,6 +42,8 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 	struct option options[] =3D {
 		OPT__QUIET(&quiet,
 			"suppress error message for non-symbolic (detached) refs"),
+		OPT_BOOLEAN('f', NULL, &fallback_regular_ref,
+					"fall back to showing as a regular ref"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
--=20
1.7.9.2.302.g3724c.dirty


=46rom 1fffb746a65aac88d3af9bae785b1cfa58cbf31c Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Jan=3D20Kr=3DC3=3DBCger?=3D <jk@jk.gs>
Date: Mon, 27 Feb 2012 22:40:13 +0100
Subject: [PATCH 2/2] builtin/symbolic-ref.c: add option to output short=
ened
 ref
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

In scripts meant to generate user-consumable output, it can be helpful
to resolve a symbolic ref and output the result in a shortened form,
such as for use in shell prompts. Add a new -s option to allow this.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
 Documentation/git-symbolic-ref.txt |    6 +++++-
 builtin/symbolic-ref.c             |    5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-sym=
bolic-ref.txt
index a05819b..7f108ce 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -8,7 +8,7 @@ git-symbolic-ref - Read and modify symbolic refs
 SYNOPSIS
 --------
 [verse]
-'git symbolic-ref' [-q] [-f] [-m <reason>] <name> [<ref>]
+'git symbolic-ref' [-q] [-f] [-s] [-m <reason>] <name> [<ref>]
=20
 DESCRIPTION
 -----------
@@ -38,6 +38,10 @@ OPTIONS
 	not a symbolic ref; instead output the SHA1 value referenced by
 	<name>.
=20
+-s::
+	When showing the value of <name> as a symbolic ref, try to shorten th=
e
+	value, e.g. from `refs/heads/master` to `master`.
+
 -m::
 	Update the reflog for <name> with <reason>.  This is valid only
 	when creating or updating a symbolic ref.
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 2e0a86f..df8da11 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -9,6 +9,7 @@ static const char * const git_symbolic_ref_usage[] =3D =
{
 };
=20
 static int fallback_regular_ref;
+static int shorten;
=20
 static void check_symref(const char *HEAD, int quiet)
 {
@@ -32,6 +33,9 @@ static void check_symref(const char *HEAD, int quiet)
 			exit(1);
 		}
 	}
+	if (shorten)
+		refs_heads_master =3D shorten_unambiguous_ref(
+			refs_heads_master, 0);
 	puts(refs_heads_master);
 }
=20
@@ -44,6 +48,7 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 			"suppress error message for non-symbolic (detached) refs"),
 		OPT_BOOLEAN('f', NULL, &fallback_regular_ref,
 					"fall back to showing as a regular ref"),
+		OPT_BOOLEAN('s', NULL, &shorten, "shorten ref output"),
 		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
 		OPT_END(),
 	};
--=20
1.7.9.2.302.g3724c.dirty
