From: Junio C Hamano <gitster@pobox.com>
Subject: Subject: [PATCH] git-merge-pack
Date: Thu, 06 Sep 2007 16:12:56 -0700
Message-ID: <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 01:13:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITQXA-0001y6-1j
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 01:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbXIFXNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 19:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXIFXNH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 19:13:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:33021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932502AbXIFXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 19:13:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F96312DE52;
	Thu,  6 Sep 2007 19:13:19 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 6 Sep 2007 19:15:58 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57943>

This is a beginning of "git-merge-pack" that combines smaller
packs into one.  Currently it does not actually create a new
pack, but pretends that it is a (dumb) "git-rev-list --objects"
that lists the objects in the affected packs.  You have to pipe
its output to "git-pack-objects".

The command reads names of pack-*.pack files from the standard
input, outputs the objects' names in the order they are stored
in the original packs (i.e. the offset order).  This sorting is
done in order to emulate the traversal order the original
"git-rev-list --objects" that was used to create the existing
pack listed the objects.

While this approach would give the resulting packfile very
similar locality of access as the original, it does not give the
"name" component you would see in "git-rev-list --objects"
output.  This information is used as the clustering cue while
computing delta, and the lack of it means you can get horrible
delta selection.  You do _not_ want to run the downstream
"git-pack-objects" without the optimization/heuristics to reuse
delta.  IOW, do not run it with --no-reuse-delta.

To consolidate all packs that are smaller than a megabytes into
one, you would use it in its current form like this:

    $ old=$(find .git/objects/pack -type f -name '*.pack' -size 1M)
    $ new=$(echo "$old" | git merge-pack | git pack-objects pack)
    $ for p in $old; do rm -f $p ${p%.pack}.idx; done
    $ for s in pack idx; do mv pack-$new.$s .git/objects/pack/; done

An obvious next steps that can be done in parallel by interested
parties would be:

 (1) come up with a way to give "name" aka "clustering cue" (I
     think this is very hard);

 (2) run the above four command sequence internally without
     having to resort to shell wrapper (easy).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Linus Torvalds <torvalds@linux-foundation.org> writes:

  > IOW, if you get lots of small incrmental packs, after a while you really 
  > *do* need to do "git gc" to get the real pack generated.

  'auto' should do a lessor impact repack than the usual one.
  Especially we do not want to lose objects that do not look like
  they are reachable from this reopsitory, to help people with
  alternate object stores, aka "repo.or.cz style _forked_
  repositories".  However, a full repack with "-a -d" discards
  unreferenced objects that are only in packs.

  We need a middle ground between "pack and prune-pack only loose
  ones" and "full repack.

  Here is one.

 Makefile             |    1 +
 builtin-merge-pack.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h            |    1 +
 git.c                |    1 +
 4 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 builtin-merge-pack.c

diff --git a/Makefile b/Makefile
index dace211..cdff756 100644
--- a/Makefile
+++ b/Makefile
@@ -343,6 +343,7 @@ BUILTIN_OBJS = \
 	builtin-mailsplit.o \
 	builtin-merge-base.o \
 	builtin-merge-file.o \
+	builtin-merge-pack.o \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
diff --git a/builtin-merge-pack.c b/builtin-merge-pack.c
new file mode 100644
index 0000000..c98da80
--- /dev/null
+++ b/builtin-merge-pack.c
@@ -0,0 +1,87 @@
+#include "builtin.h"
+#include "cache.h"
+#include "pack.h"
+
+struct in_pack_object {
+	off_t offset;
+	const unsigned char *sha1;
+};
+
+static uint32_t get_packed_object_list(struct packed_git *p, struct in_pack_object *list, uint32_t loc)
+{
+	uint32_t n;
+
+	for (n = 0; n < p->num_objects; n++) {
+		list[loc].sha1 = nth_packed_object_sha1(p, n);
+		list[loc].offset = find_pack_entry_one(list[loc].sha1, p);
+		loc++;
+	}
+	return loc;
+}
+
+static int ofscmp(const void *a_, const void *b_)
+{
+	struct in_pack_object *a = (struct in_pack_object *)a_;
+	struct in_pack_object *b = (struct in_pack_object *)b_;
+	if (a->offset < b->offset)
+		return -1;
+	else if (a->offset > b->offset)
+		return 1;
+	else
+		return hashcmp(a->sha1, b->sha1);
+}
+
+int cmd_merge_pack(int ac, const char **av, const char *prefix)
+{
+	char filename[PATH_MAX];
+	struct packed_git **pack = NULL;
+	int pack_nr = 0;
+	int pack_alloc = 0;
+	uint32_t max_objs, cnt;
+	struct in_pack_object *objs;
+	int i;
+
+	while (fgets(filename, sizeof(filename), stdin) != NULL) {
+		int len = strlen(filename);
+		struct packed_git *p;
+
+		while (0 < len) {
+			if (filename[len-1] != '\n' &&
+			    filename[len-1] != '\r')
+				break;
+			filename[--len] = '\0';
+		}
+		if (strcmp(filename + len - 5, ".pack"))
+			goto error;
+
+		/* add-packed-git wants the name of .idx file */
+		strcpy(filename + len - 5, ".idx");
+		len--;
+		p = add_packed_git(filename, len, 1);
+		if (!p)
+			goto error;
+		if (open_pack_index(p))
+			goto error;
+
+		if (pack_alloc <= pack_nr) {
+			pack_alloc = alloc_nr(pack_nr);
+			pack = xrealloc(pack, pack_alloc * sizeof(*pack));
+		}
+		pack[pack_nr++] = p;
+		continue;
+	error:
+		die("Cannot add a pack .idx file: %s", filename);
+	}
+
+	max_objs = 0;
+	for (i = 0; i < pack_nr; i++)
+		max_objs += pack[i]->num_objects;
+	objs = xmalloc(sizeof(*objs) * max_objs);
+	cnt = 0;
+	for (i = 0; i < pack_nr; i++)
+		cnt = get_packed_object_list(pack[i], objs, cnt);
+	qsort(objs, cnt, sizeof(*objs), ofscmp);
+	for (cnt = 0; cnt < max_objs; cnt++)
+		printf("%s\n", sha1_to_hex(objs[cnt].sha1));
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index bb72000..aff28ca 100644
--- a/builtin.h
+++ b/builtin.h
@@ -49,6 +49,7 @@ extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
 extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
+extern int cmd_merge_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index fd3d83c..69e86bc 100644
--- a/git.c
+++ b/git.c
@@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file },
+		{ "merge-pack", cmd_merge_pack },
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
-- 
1.5.3.1.860.g2cce2
