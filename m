From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: [PATCH] read-tree: deprecate syntax without tree-ish args
Date: Fri, 10 Sep 2010 15:28:59 +0200
Message-ID: <20100910152859.778636d4@jk.gs>
References: <20100910120604.50aa1e94@jk.gs>
	<4C8A168F.1030502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 10 15:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou3fF-0005WS-Pp
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 15:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0IJN3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 09:29:07 -0400
Received: from zoidberg.org ([88.198.6.61]:48310 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901Ab0IJN3G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 09:29:06 -0400
Received: from jk.gs (xdsl-89-0-15-194.netcologne.de [::ffff:89.0.15.194])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Fri, 10 Sep 2010 15:29:03 +0200
  id 0023C094.4C8A329F.00001EC1
In-Reply-To: <4C8A168F.1030502@viscovery.net>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155927>

Currently, read-tree can be run without tree-ish arguments, in which
case it will empty the index. Since this behavior is undocumented and
perhaps a bit too invasive to be the "default" action for read-tree,
deprecate it in favor of a new --empty option that does the same thing.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---
On Fri, 10 Sep 2010 13:29:19 +0200, Johannes Sixt wrote:

> See
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/135280/focus=3D=
135407
>=20
> and the discussion that ensued; perhaps intersting is
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/135280/focus=3D=
135462
>=20
> (where Junio suggest to make this a warning for now).

Thanks for the pointer. I don't really agree that undocumented
behaviour (that has never even been sighted in the wild, no less) needs
to be protected quite this much, but then again I would be much less
visibly responsible for the consequences than Junio, wouldn't I? :)

This patch effectively combines Sverre's and Junio's suggestions from
the old discussion; it deprecates the current behavior with a warning
message and also introduces --empty as a replacement. [Cc'ing both]

The alternative would be to simply match up the documentation with the
way read-tree currently works. I prefer my approach due to the
reasoning in the commit message.

 Documentation/git-read-tree.txt |    6 +++++-
 builtin/read-tree.c             |   10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 2e78da4..e88e9c2 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>]
 		[-u [--exclude-per-directory=3D<gitignore>] | -i]]
 		[--index-output=3D<file>] [--no-sparse-checkout]
-		<tree-ish1> [<tree-ish2> [<tree-ish3>]]
+		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
=20
=20
 DESCRIPTION
@@ -114,6 +114,10 @@ OPTIONS
 	Disable sparse checkout support even if `core.sparseCheckout`
 	is true.
=20
+--empty::
+	Instead of reading tree object(s) into the index, just empty
+	it.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
=20
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9ad1e66..eb1e3e7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -16,6 +16,7 @@
 #include "resolve-undo.h"
=20
 static int nr_trees;
+static int read_empty;
 static struct tree *trees[MAX_UNPACK_TREES];
=20
 static int list_tree(unsigned char *sha1)
@@ -32,7 +33,7 @@ static int list_tree(unsigned char *sha1)
 }
=20
 static const char * const read_tree_usage[] =3D {
-	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-spar=
se-checkout] [--index-output=3D<file>] <tree-ish1> [<tree-ish2> [<tree-=
ish3>]]",
+	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>] [-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-spar=
se-checkout] [--index-output=3D<file>] (--empty | <tree-ish1> [<tree-is=
h2> [<tree-ish3>]])",
 	NULL
 };
=20
@@ -106,6 +107,8 @@ int cmd_read_tree(int argc, const char **argv, cons=
t char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "index-output", NULL, "FILE",
 		  "write resulting index to <FILE>",
 		  PARSE_OPT_NONEG, index_output_cb },
+		OPT_SET_INT(0, "empty", &read_empty,
+			    "only empty the index", 1),
 		OPT__VERBOSE(&opts.verbose_update),
 		OPT_GROUP("Merging"),
 		OPT_SET_INT('m', NULL, &opts.merge,
@@ -166,6 +169,11 @@ int cmd_read_tree(int argc, const char **argv, con=
st char *unused_prefix)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
+	if (nr_trees =3D=3D 0 && !read_empty)
+		warning("read-tree: emptying the index with no arguments is deprecat=
ed; use --empty");
+	else if (nr_trees > 0 && read_empty)
+		die("passing trees as arguments contradicts --empty");
+
 	if (1 < opts.index_only + opts.update)
 		die("-u and -i at the same time makes no sense");
 	if ((opts.update||opts.index_only) && !opts.merge)
--=20
1.7.2.3.392.g02377.dirty
