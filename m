From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] tag: allow --sort with -n
Date: Wed, 25 Jun 2014 19:35:06 -0400
Message-ID: <20140625233505.GA23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:35:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzwih-0007ZX-8w
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbaFYXfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:35:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:51214 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752761AbaFYXfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:35:08 -0400
Received: (qmail 4783 invoked by uid 102); 25 Jun 2014 23:35:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:35:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:35:06 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252473>

When we are listing tags, we print each one as it is
processed by for_each_ref. We can't do that with --sort, of
course, as we need to see the whole list to sort. For the
--sort code path, we store each tag in a string_list, and
then print them all at the end.

This interacts badly with "-n", which needs not only the
name of the tag, but also the object itself. We simply
punted on handling this, and disallowed the combination.

This patch remedies that by storing the sha1 of each object
in the "util" field of the string list. We can then factor
out the printing to a helper function and call that function
either when we first see each tag, or after we have sorted.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c  | 42 +++++++++++++++++++++++++-----------------
 cache.h        |  7 +++++++
 t/t7004-tag.sh | 18 ++++++++++++++++++
 3 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index c6e8a71..2adfc3d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -213,6 +213,18 @@ free_return:
 	free(buf);
 }
 
+static void print_tag(const char *refname, const unsigned char *sha1,
+		      int lines)
+{
+		if (!lines)
+			printf("%s\n", refname);
+		else {
+			printf("%-15s ", refname);
+			show_tag_lines(sha1, lines);
+			putchar('\n');
+		}
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
@@ -232,16 +244,10 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		if (points_at.nr && !match_points_at(refname, sha1))
 			return 0;
 
-		if (!filter->lines) {
-			if (filter->sort)
-				string_list_append(&filter->tags, refname);
-			else
-				printf("%s\n", refname);
-			return 0;
-		}
-		printf("%-15s ", refname);
-		show_tag_lines(sha1, filter->lines);
-		putchar('\n');
+		if (filter->sort)
+			string_list_append(&filter->tags, refname)->util = hashdup(sha1);
+		else
+			print_tag(refname, sha1, filter->lines);
 	}
 
 	return 0;
@@ -273,12 +279,16 @@ static int list_tags(const char **patterns, int lines,
 			qsort(filter.tags.items, filter.tags.nr,
 			      sizeof(struct string_list_item), sort_by_version);
 		if (sort & REVERSE_SORT)
-			for (i = filter.tags.nr - 1; i >= 0; i--)
-				printf("%s\n", filter.tags.items[i].string);
+			for (i = filter.tags.nr - 1; i >= 0; i--) {
+				struct string_list_item *it = &filter.tags.items[i];
+				print_tag(it->string, it->util, lines);
+			}
 		else
-			for (i = 0; i < filter.tags.nr; i++)
-				printf("%s\n", filter.tags.items[i].string);
-		string_list_clear(&filter.tags, 0);
+			for (i = 0; i < filter.tags.nr; i++) {
+				struct string_list_item *it = &filter.tags.items[i];
+				print_tag(it->string, it->util, lines);
+			}
+		string_list_clear(&filter.tags, 1);
 	}
 	return 0;
 }
@@ -634,8 +644,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (lines != -1 && sort)
-			die(_("--sort and -n are incompatible"));
 		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, sort);
 		if (column_active(colopts))
 			stop_column_filter();
diff --git a/cache.h b/cache.h
index df65231..74bf163 100644
--- a/cache.h
+++ b/cache.h
@@ -738,6 +738,13 @@ static inline void hashclr(unsigned char *hash)
 	memset(hash, 0, 20);
 }
 
+static inline unsigned char *hashdup(const unsigned char *hash)
+{
+	unsigned char *ret = xmalloc(20);
+	hashcpy(ret, hash);
+	return ret;
+}
+
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e4ab0f5..279b932 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,6 +1423,24 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'sorting works with -n' '
+	cat >msg <<-\EOF &&
+	multiline
+	tag
+	message
+	EOF
+	git tag -F msg foo-long &&
+	git tag -l --sort=-refname -n2 "foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.6          Merge branch '\''master'\'' into stable
+	foo1.3          Merge branch '\''master'\'' into stable
+	foo1.10         Merge branch '\''master'\'' into stable
+	foo-long        multiline
+	    tag
+	EOF
+	test_cmp expect actual
+'
+
 run_with_limited_stack () {
 	(ulimit -s 64 && "$@")
 }
-- 
2.0.0.566.gfe3e6b2
