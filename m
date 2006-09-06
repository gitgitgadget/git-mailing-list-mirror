From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Wed, 06 Sep 2006 20:05:18 +0200
Message-ID: <44FF0DDE.7030700@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx> <7vwt8mx8lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 20:05:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL1mH-0004sh-J9
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 20:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWIFSFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWIFSFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 14:05:25 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49024
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751357AbWIFSFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 14:05:23 -0400
Received: from [10.0.1.3] (p508E760A.dip.t-dialin.net [80.142.118.10])
	by neapel230.server4you.de (Postfix) with ESMTP id 2C4191B030;
	Wed,  6 Sep 2006 20:05:21 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt8mx8lb.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26545>

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Currently git-archive-tree -f tar is slower than git-tar-tree.  This=
 is
>> because it is welded to the side of the existing code to minimize pa=
tch
>> size, and I also suspect read_tree_recursive() to be quite a bit slo=
wer
>> than builtin-tar-tree.c::traverse_tree().
>=20
> Yes, I suspect "struct object" and friends are very inefficient
> to use for things like this.  "struct tree_desc" based traverser
> is much preferred.

Turns out the reason for git-archive-tree -f tar being 10% slower than
git-tar-tree was a stupid memory leak in write_tar_entry(). *blush*
It caused lots of brk() calls (i.e. system calls).

In order to simplify measurement, I commented out the body of
write_entry(), which both git-archive-tree and git-tar-tree are calling
to write their output.  The rest left is basically two pure tree
traversers, git-archive-tree using read_tree_recursive() and git-tar-tr=
ee
using its struct tree_desc based traverse_tree().

I then let the two chew away on the kernel repository.  And as
kcachegrind impressively shows, all we do with our trees and objects is
dwarfed by inflate().  In both cases more than 96.6% of the cost lies
within libz.  That's not too surprising, because archivers need to
decompress _all_ objects, not only trees.

So for git-archive we can pretty much chose which traverser to use base=
d
on convenience.

As a second experiment I wrote a struct tree_desc based traverser plus =
a
matching read_tree_recursive() compatibility wrapper (included below fo=
r
reference, not for inclusion) and compared the performance of
'git-ls-tree -r -t' on the kernel repository with and without it.  The
result is that the relative cost of all functions from tree.c combined
decreased from 0.93% to 0.66%.  Ugh.

So while a struct tree_desc based traverser can be significantly faster
than read_tree_recursive(), as soon as you actually start to do somethi=
ng
to the trees that difference pales to insignificance.

Ren=E9



diff --git a/tree.c b/tree.c
index ea386e5..977a4aa 100644
--- a/tree.c
+++ b/tree.c
@@ -4,6 +4,7 @@ #include "blob.h"
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
+#include "strbuf.h"
 #include <stdlib.h>
=20
 const char *tree_type =3D "tree";
@@ -227,3 +228,99 @@ struct tree *parse_tree_indirect(const u
 			parse_object(obj->sha1);
 	} while (1);
 }
+
+static int do_read_tree_recursive_light(struct tree_desc *desc,
+                                        struct strbuf *base,
+                                        const char **match, read_tree_=
fn_t fn)
+{
+	struct name_entry entry;
+	int err =3D 0;
+	int baselen =3D base->len;
+
+	while (tree_entry(desc, &entry)) {
+		if (!match_tree_entry(base->buf, base->len, entry.path, entry.mode, =
match))
+			continue;
+
+		err =3D fn(entry.sha1, base->buf, base->len, entry.path, entry.mode,=
 0);
+		switch (err) {
+		case 0:
+			continue;
+		case READ_TREE_RECURSIVE:
+			break;
+		default:
+			return -1;
+		}
+
+		if (S_ISDIR(entry.mode)) {
+			struct tree_desc subtree;
+			char type[20];
+			void *buf;
+			int newbaselen;
+
+			buf =3D read_sha1_file(entry.sha1, type, &subtree.size);
+			if (!buf)
+				return error("cannot read %s",
+				             sha1_to_hex(entry.sha1));
+			if (strcmp(type, tree_type)) {
+				free(buf);
+				return error("Object %s not a tree",
+				             sha1_to_hex(entry.sha1));
+			}
+			subtree.buf =3D buf;
+
+			newbaselen =3D baselen + entry.pathlen + 1;
+			if (newbaselen > base->alloc) {
+				base->buf =3D xrealloc(base->buf, newbaselen);
+				base->alloc =3D newbaselen;
+			}
+			memcpy(base->buf + baselen, entry.path, entry.pathlen);
+			base->buf[baselen + entry.pathlen] =3D '/';
+			base->len =3D newbaselen;
+
+			err =3D do_read_tree_recursive_light(&subtree,
+			                                   base,
+			                                   match, fn);
+			base->len =3D baselen;
+			free(buf);
+			if (err)
+				break;
+		}
+	}
+
+	return err;
+}
+
+int read_tree_recursive_light(struct tree *tree,
+                              const char *base, int baselen, int stage=
,
+                              const char **match, read_tree_fn_t fn)
+{
+	unsigned char *sha1 =3D tree->object.sha1;
+	struct tree_desc desc;
+	char type[20];
+	void *buf;
+	int err;
+	struct strbuf sb;
+
+	sb.buf =3D xmalloc(PATH_MAX);
+	sb.alloc =3D PATH_MAX;
+	sb.len =3D 0;
+	if (baselen > sb.alloc) {
+		sb.buf =3D xrealloc(sb.buf, baselen);
+		sb.alloc =3D baselen;
+	}
+	memcpy(sb.buf, base, baselen);
+	sb.len =3D baselen;
+
+	desc.buf =3D buf =3D read_sha1_file(sha1, type, &desc.size);
+	if (!buf)
+		return error("Could not read %s", sha1_to_hex(sha1));
+	if (strcmp(type, tree_type)) {
+		free(buf);
+		return error("Object %s not a tree", sha1_to_hex(sha1));
+	}
+
+	err =3D do_read_tree_recursive_light(&desc, &sb, match, fn);
+	free(buf);
+
+	return err;
+}
diff --git a/tree.h b/tree.h
index dd25c53..2294bc2 100644
--- a/tree.h
+++ b/tree.h
@@ -30,4 +30,8 @@ extern int read_tree_recursive(struct tr
=20
 extern int read_tree(struct tree *tree, int stage, const char **paths)=
;
=20
+extern int read_tree_recursive_light(struct tree *tree,
+                                     const char *base, int baselen, in=
t stage,
+                                     const char **match, read_tree_fn_=
t fn);
+
 #endif /* TREE_H */
