From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 8/9] replace: check mergetags when using --graft
Date: Sat, 19 Jul 2014 17:01:14 +0200
Message-ID: <20140719150116.9564.55503.chriscool@tuxfamily.org>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Wm0-00087f-1x
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbaGSPlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:52 -0400
Received: from [194.158.98.14] ([194.158.98.14]:33809 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755322AbaGSPls (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:48 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1C8EA65;
	Sat, 19 Jul 2014 17:41:27 +0200 (CEST)
X-git-sha1: 38b34a5246f31815373516bbf9ff49f4eed4e6fe 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253889>

When using --graft, with a mergetag in the original
commit, we should check that the commit pointed to by
the mergetag is still a parent of then new commit we
create, otherwise the mergetag could be misleading.

If the commit pointed to by the mergetag is no more
a parent of the new commit, we could remove the
mergetag, but in this case there is a good chance
that the title or other elements of the commit might
also be misleading. So let's just error out and
suggest to use --edit instead on the commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 52f73ce..d29026f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -13,6 +13,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "tag.h"
 
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
@@ -325,6 +326,50 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 	strbuf_release(&new_parents);
 }
 
+struct check_mergetag_data {
+	int argc;
+	const char **argv;
+};
+
+static void check_one_mergetag(struct commit *commit,
+			       struct commit_extra_header *extra,
+			       void *data)
+{
+	struct check_mergetag_data *mergetag_data = (struct check_mergetag_data *)data;
+	const char *ref = mergetag_data->argv[0];
+	unsigned char tag_sha1[20];
+	struct tag *tag;
+	int i;
+
+	hash_sha1_file(extra->value, extra->len, typename(OBJ_TAG), tag_sha1);
+	tag = lookup_tag(tag_sha1);
+	if (!tag)
+		die(_("bad mergetag in commit '%s'"), ref);
+	if (parse_tag_buffer(tag, extra->value, extra->len))
+		die(_("malformed mergetag in commit '%s'"), ref);
+
+	/* iterate over new parents */
+	for (i = 1; i < mergetag_data->argc; i++) {
+		unsigned char sha1[20];
+		if (get_sha1(mergetag_data->argv[i], sha1) < 0)
+			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
+		if (!hashcmp(tag->tagged->sha1, sha1))
+			return; /* found */
+	}
+
+	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
+	      "use --edit instead of --graft"), ref, sha1_to_hex(tag_sha1));
+}
+
+static void check_mergetags(struct commit *commit, int argc, const char **argv)
+{
+	struct check_mergetag_data mergetag_data;
+
+	mergetag_data.argc = argc;
+	mergetag_data.argv = argv;
+	for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
+}
+
 static int create_graft(int argc, const char **argv, int force)
 {
 	unsigned char old[20], new[20];
@@ -349,6 +394,8 @@ static int create_graft(int argc, const char **argv, int force)
 		warning(_("the signature will be removed in the replacement commit!"));
 	}
 
+	check_mergetags(commit, argc, argv);
+
 	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
 		die(_("could not write replacement commit for: '%s'"), old_ref);
 
-- 
2.0.0.421.g786a89d.dirty
