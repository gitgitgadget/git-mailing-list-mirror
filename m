From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] add '%d' pretty format specifier to show decoration
Date: Thu, 04 Sep 2008 00:06:18 +0200
Message-ID: <48BF0A5A.2040502@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb0Vm-0004Lo-DD
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbYICWGc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYICWGc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 18:06:32 -0400
Received: from india601.server4you.de ([85.25.151.105]:60138 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYICWGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 18:06:31 -0400
Received: from [10.0.1.200] (p57B7B77A.dip.t-dialin.net [87.183.183.122])
	by india601.server4you.de (Postfix) with ESMTPSA id 48DBA2F8045;
	Thu,  4 Sep 2008 00:06:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vsksh9c9m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94863>

Junio C Hamano schrieb:
> If the concensus is that we do the simpler variant _now_ and leave
> extending it for later, I think it is Ok to pick any one reasonable
> default/simple format, and including the parentheses (with leading SP=
)
> would be one reasonable default, certainly more reasonable than not
> including the parentheses at all.

Yes, but can we please use the existing parser and not add another one
just to find out if some initialization is needed?  Also,
format_commit_message() is called from git archive.  In order to keep
all the placeholders working on each call site, it's better to control
everything from there.

The patch below does that by using a static variable to remember if the
decorations have already been loaded.  That's not too unreasonable, I
think, because we currently have no way of unloading them.

The patch should be split up and contains no documentation updates.  It

  - moves add_name_decoration() and add_ref_decoration() to log-tree.c,
    next to the variable name_decoration they are working with,

  - exports add_ref_decoration(),

  - adds load_ref_decorations(), which loads all refs as decorations,
    unless they have already been loaded,

  - adds the placeholder %d, with parentheses and leading space (or
    empty if no decoration is present).

Thanks,
Ren=C3=A9


 builtin-log.c |   25 -------------------------
 log-tree.c    |   36 ++++++++++++++++++++++++++++++++++++
 log-tree.h    |    3 +++
 pretty.c      |   25 +++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1d3c5cb..ba1ef8d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -25,31 +25,6 @@ static int default_show_root =3D 1;
 static const char *fmt_patch_subject_prefix =3D "PATCH";
 static const char *fmt_pretty;
=20
-static void add_name_decoration(const char *prefix, const char *name, =
struct object *obj)
-{
-	int plen =3D strlen(prefix);
-	int nlen =3D strlen(name);
-	struct name_decoration *res =3D xmalloc(sizeof(struct name_decoration=
) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
-	res->next =3D add_decoration(&name_decoration, obj, res);
-}
-
-static int add_ref_decoration(const char *refname, const unsigned char=
 *sha1, int flags, void *cb_data)
-{
-	struct object *obj =3D parse_object(sha1);
-	if (!obj)
-		return 0;
-	add_name_decoration("", refname, obj);
-	while (obj->type =3D=3D OBJ_TAG) {
-		obj =3D ((struct tag *)obj)->tagged;
-		if (!obj)
-			break;
-		add_name_decoration("tag: ", refname, obj);
-	}
-	return 0;
-}
-
 static void cmd_log_init(int argc, const char **argv, const char *pref=
ix,
 		      struct rev_info *rev)
 {
diff --git a/log-tree.c b/log-tree.c
index 30cd5bb..083d08a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1,12 +1,48 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "tag.h"
 #include "graph.h"
 #include "log-tree.h"
 #include "reflog-walk.h"
+#include "refs.h"
=20
 struct decoration name_decoration =3D { "object names" };
=20
+static void add_name_decoration(const char *prefix, const char *name, =
struct object *obj)
+{
+	int plen =3D strlen(prefix);
+	int nlen =3D strlen(name);
+	struct name_decoration *res =3D xmalloc(sizeof(struct name_decoration=
) + plen + nlen);
+	memcpy(res->name, prefix, plen);
+	memcpy(res->name + plen, name, nlen + 1);
+	res->next =3D add_decoration(&name_decoration, obj, res);
+}
+
+int add_ref_decoration(const char *refname, const unsigned char *sha1,=
 int flags, void *cb_data)
+{
+	struct object *obj =3D parse_object(sha1);
+	if (!obj)
+		return 0;
+	add_name_decoration("", refname, obj);
+	while (obj->type =3D=3D OBJ_TAG) {
+		obj =3D ((struct tag *)obj)->tagged;
+		if (!obj)
+			break;
+		add_name_decoration("tag: ", refname, obj);
+	}
+	return 0;
+}
+
+void load_ref_decorations(void)
+{
+	static int loaded;
+	if (!loaded) {
+		loaded =3D 1;
+		for_each_ref(add_ref_decoration, NULL);
+	}
+}
+
 static void show_parents(struct commit *commit, int abbrev)
 {
 	struct commit_list *p;
diff --git a/log-tree.h b/log-tree.h
index 59ba4c4..beeb86e 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -18,4 +18,7 @@ void log_write_email_headers(struct rev_info *opt, co=
nst char *name,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p);
=20
+int add_ref_decoration(const char *refname, const unsigned char *sha1,=
 int flags, void *cb_data);
+void load_ref_decorations(void);
+
 #endif
diff --git a/pretty.c b/pretty.c
index a29c290..4a31e31 100644
--- a/pretty.c
+++ b/pretty.c
@@ -5,6 +5,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "log-tree.h"
=20
 static char *user_format;
=20
@@ -423,6 +424,7 @@ struct format_commit_context {
 	struct chunk abbrev_commit_hash;
 	struct chunk abbrev_tree_hash;
 	struct chunk abbrev_parent_hashes;
+	struct chunk decoration;
 };
=20
 static int add_again(struct strbuf *sb, struct chunk *chunk)
@@ -481,6 +483,23 @@ static void parse_commit_header(struct format_comm=
it_context *context)
 	context->commit_header_parsed =3D 1;
 }
=20
+static void format_decoration(struct strbuf *sb, const struct commit *=
commit)
+{
+	struct name_decoration *d;
+	const char *prefix =3D " (";
+
+	load_ref_decorations();
+	d =3D lookup_decoration(&name_decoration, &commit->object);
+	while (d) {
+		strbuf_addstr(sb, prefix);
+		prefix =3D ", ";
+		strbuf_addstr(sb, d->name);
+		d =3D d->next;
+	}
+	if (prefix[0] =3D=3D ',')
+		strbuf_addch(sb, ')');
+}
+
 static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
                                void *context)
 {
@@ -520,6 +539,12 @@ static size_t format_commit_item(struct strbuf *sb=
, const char *placeholder,
 			return 3;
 		} else
 			return 0;
+	case 'd':
+		if (add_again(sb, &c->decoration))
+			return 1;
+		format_decoration(sb, commit);
+		c->decoration.len =3D sb->len - c->decoration.off;
+		return 1;
 	}
=20
 	/* these depend on the commit */
