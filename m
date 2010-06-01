From: Jeff King <peff@peff.net>
Subject: Re: Best way to apply textconv to a working tree file
Date: Tue, 1 Jun 2010 15:50:36 -0400
Message-ID: <20100601195036.GA18220@sigill.intra.peff.net>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
 <vpqd3walot1.fsf@bauges.imag.fr>
 <20100601171359.GD9702@sigill.intra.peff.net>
 <vpqtypmaceb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: clement.poulain@ensimag.imag.fr, git@vger.kernel.org,
	diane.gasselin@ensimag.imag.fr, axel.bonnet@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 01 21:50:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJXU7-0005HA-0M
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 21:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab0FATul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 15:50:41 -0400
Received: from peff.net ([208.65.91.99]:34163 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab0FATuk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 15:50:40 -0400
Received: (qmail 2333 invoked by uid 107); 1 Jun 2010 19:50:46 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Jun 2010 15:50:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jun 2010 15:50:36 -0400
Content-Disposition: inline
In-Reply-To: <vpqtypmaceb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148155>

On Tue, Jun 01, 2010 at 07:30:36PM +0200, Matthieu Moy wrote:

> > It would be nice if there was some way in the get_sha1* functions to
> > save some context, like tree context and filename. This would be helpful
> > for something like "git show HEAD:foo.txt", which probably should be
> > respecting autocrlf and smudge/clean filters.
> 
> Yup. The code to do the parsing is already there, it "just" needs to
> be made available through a clean API.

I was thinking of something like the patch below, which applies
clean/smudge filters to the output of "cat-file -p".

It keeps a global context for the last sha1 looked up. Probably
get_sha1_with_mode should be folded into get_sha1_with_context, as mode
is really just another case of this exact sort of mid-lookup context.
And then we don't get a proliferation of "get_sha1_with_*" functions,
which doesn't scale.  I'll leave that as an exercise for your students.
:)

You could get fancier, including things like which ref we ended up
looking at to get to the object. I seem to recall running into a
situation where I wanted to know "foo" when looking up "foo^", but I
don't remember where now.  I think it makes sense to keep it simple for
now, and people could add more context elements as needed.

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a933eaa..4d1e634 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -87,6 +87,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	void *buf;
 	unsigned long size;
 
+	object_resolve_context_init(&the_resolve_context);
 	if (get_sha1(obj_name, sha1))
 		die("Not a valid object name %s", obj_name);
 
@@ -129,6 +130,18 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 			pprint_tag(sha1, buf, size);
 			return 0;
 		}
+		if (type == OBJ_BLOB) {
+			struct strbuf out = STRBUF_INIT;
+
+			if (!the_resolve_context.path[0])
+				break;
+			if (convert_to_working_tree(the_resolve_context.path,
+						buf, size, &out) < 0)
+				die("unable to prepare blob for printing");
+			free(buf);
+			size = out.len;
+			buf = strbuf_detach(&out, NULL);
+		}
 
 		/* otherwise just spit out the data */
 		break;
diff --git a/cache.h b/cache.h
index c966023..c030083 100644
--- a/cache.h
+++ b/cache.h
@@ -730,6 +730,13 @@ static inline unsigned int hexval(unsigned char c)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
 
+struct object_resolve_context {
+	unsigned char tree[20];
+	char path[PATH_MAX];
+};
+extern struct object_resolve_context the_resolve_context;
+void object_resolve_context_init(struct object_resolve_context *orc);
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
diff --git a/sha1_name.c b/sha1_name.c
index bf92417..cc049bf 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,13 @@
 #include "refs.h"
 #include "remote.h"
 
+struct object_resolve_context the_resolve_context;
+
+void object_resolve_context_init(struct object_resolve_context *orc)
+{
+	memset(orc, 0, sizeof(*orc));
+}
+
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
 	struct alternate_object_database *alt;
@@ -1104,6 +1111,10 @@ int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 							   tree_sha1, object_name);
 				free(object_name);
 			}
+			hashcpy(the_resolve_context.tree, tree_sha1);
+			strncpy(the_resolve_context.path, filename,
+				sizeof(the_resolve_context.path));
+			the_resolve_context.path[sizeof(the_resolve_context.path)] = '\0';
 			return ret;
 		} else {
 			if (!gently)
