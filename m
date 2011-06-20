From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] plug a few coverity-spotted leaks
Date: Mon, 20 Jun 2011 09:40:06 +0200
Message-ID: <87mxhd6je1.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 09:40:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYZ5p-00015p-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1FTHkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:40:15 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:52157 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144Ab1FTHkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:40:14 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 3D7389400DE
	for <git@vger.kernel.org>; Mon, 20 Jun 2011 09:40:07 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id DE9C36023D; Mon, 20 Jun 2011 09:40:06 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176055>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin/cat-file.c     |    2 ++
 builtin/diff.c         |    1 +
 builtin/update-index.c |    4 +++-
 remote-curl.c          |   10 ++++++----
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94632db..07bd984 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -187,6 +187,8 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	if (type <= 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
+		if (print_contents == BATCH)
+			free(contents);
 		return 0;
 	}

diff --git a/builtin/diff.c b/builtin/diff.c
index 14bd14f..69cd5ee 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -182,6 +182,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
+	free(parent);
 	return 0;
 }

diff --git a/builtin/update-index.c b/builtin/update-index.c
index f14bc90..a6a23fa 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -100,8 +100,10 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);

 	if (index_path(ce->sha1, path, st,
-		       info_only ? 0 : HASH_WRITE_OBJECT))
+		       info_only ? 0 : HASH_WRITE_OBJECT)) {
+		free(ce);
 		return -1;
+	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
diff --git a/remote-curl.c b/remote-curl.c
index 17d8a9b..b5be25c 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -811,19 +811,21 @@ static void parse_push(struct strbuf *buf)

 		strbuf_reset(buf);
 		if (strbuf_getline(buf, stdin, '\n') == EOF)
-			return;
+			goto free_specs;
 		if (!*buf->buf)
 			break;
 	} while (1);

 	if (push(nr_spec, specs))
 		exit(128); /* error already reported */
-	for (i = 0; i < nr_spec; i++)
-		free(specs[i]);
-	free(specs);

 	printf("\n");
 	fflush(stdout);
+
+ free_specs:
+	for (i = 0; i < nr_spec; i++)
+		free(specs[i]);
+	free(specs);
 }

 int main(int argc, const char **argv)
--
1.7.6.rc2.4.g36bfb.dirty
