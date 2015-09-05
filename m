From: Rudy Matela <rudy@matela.com.br>
Subject: [PATCH] tag: support mixing --sort=<spec> and -n
Date: Sat, 5 Sep 2015 18:52:02 +0100
Message-ID: <20150905175202.GC7050@zero.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYHda-0003Vg-GP
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 19:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbbIERwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 13:52:09 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37955 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbIERwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 13:52:06 -0400
Received: by wiclk2 with SMTP id lk2so45813542wic.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=fyjnVh0cVP7ySCA9A1pYhakB6OKwTd7u46J6AD/RI+w=;
        b=0RGML88kfYkEClll9SHTsorJcXz0ogujCvIJUqgNG6c5p47eif57Ip2NKIWe4iB7EO
         3aFMVPLyeXjcR4n7ZQqUM4MIkj6Afi8FAx773KkqLnpelP0bIWbyXvxJPs0ovYikh7rM
         Ra/O4WA0afpbaaLNIoZKn0nGlSb61zmwPghKfdObA8kDtZmXB7SLdorBCXcYGzIHEJfE
         4rj9q9C90jLzd2SAXMfascORsxGS6psPduMgtjXvdsoDhQhu6Q3cF+q0UtBN1yXqZF9l
         5AUYmXbpERofOIkHQwbUirScF0uRURhQ55FxxzF75OAnH4r1YEpIjH/uOn8oPpCjhKBH
         bEAA==
X-Received: by 10.194.93.3 with SMTP id cq3mr19250963wjb.20.1441475524880;
        Sat, 05 Sep 2015 10:52:04 -0700 (PDT)
Received: from zero.home (host86-191-157-159.range86-191.btcentralplus.com. [86.191.157.159])
        by smtp.gmail.com with ESMTPSA id k12sm11027333wjw.4.2015.09.05.10.52.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2015 10:52:04 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277392>


Allow -n and --sort=version:refname to be used together
instead of failing with:

  fatal: --sort and -n are incompatible

Signed-off-by: Rudy Matela <rudy@matela.com.br>
---
 builtin/tag.c | 64 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index cccca99..cdcb373 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -176,13 +176,19 @@ static enum contains_result contains(struct commit *candidate,
 	return contains_test(candidate, want);
 }
 
-static void show_tag_lines(const struct object_id *oid, int lines)
+static char *get_tag_lines(const struct object_id *oid, int lines)
 {
 	int i;
 	unsigned long size;
 	enum object_type type;
 	char *buf, *sp, *eol;
 	size_t len;
+	struct strbuf sb;
+
+	if (!lines)
+		return NULL;
+
+	strbuf_init(&sb,0);
 
 	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
@@ -203,20 +209,21 @@ static void show_tag_lines(const struct object_id *oid, int lines)
 		size = parse_signature(buf, size);
 	for (i = 0, sp += 2; i < lines && sp < buf + size; i++) {
 		if (i)
-			printf("\n    ");
+			strbuf_addstr(&sb,"\n    ");
 		eol = memchr(sp, '\n', size - (sp - buf));
 		len = eol ? eol - sp : size - (sp - buf);
-		fwrite(sp, len, 1, stdout);
+		strbuf_add(&sb, sp, len);
 		if (!eol)
 			break;
 		sp = eol + 1;
 	}
 free_return:
 	free(buf);
+	return strbuf_detach(&sb, NULL);
 }
 
-static int show_reference(const char *refname, const struct object_id *oid,
-			  int flag, void *cb_data)
+static int get_reference_and_tag_lines(const char *refname, const struct object_id *oid,
+				       int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
 
@@ -234,16 +241,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
 		if (points_at.nr && !match_points_at(refname, oid->hash))
 			return 0;
 
-		if (!filter->lines) {
-			if (filter->sort)
-				string_list_append(&filter->tags, refname);
-			else
-				printf("%s\n", refname);
-			return 0;
-		}
-		printf("%-15s ", refname);
-		show_tag_lines(oid, filter->lines);
-		putchar('\n');
+		string_list_append(&filter->tags, refname)->util =
+			get_tag_lines(oid, filter->lines);
 	}
 
 	return 0;
@@ -260,6 +259,7 @@ static int list_tags(const char **patterns, int lines,
 		     struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;
+	int i;
 
 	filter.patterns = patterns;
 	filter.lines = lines;
@@ -268,20 +268,28 @@ static int list_tags(const char **patterns, int lines,
 	memset(&filter.tags, 0, sizeof(filter.tags));
 	filter.tags.strdup_strings = 1;
 
-	for_each_tag_ref(show_reference, (void *)&filter);
-	if (sort) {
-		int i;
-		if ((sort & SORT_MASK) == VERCMP_SORT)
-			qsort(filter.tags.items, filter.tags.nr,
-			      sizeof(struct string_list_item), sort_by_version);
-		if (sort & REVERSE_SORT)
-			for (i = filter.tags.nr - 1; i >= 0; i--)
+	for_each_tag_ref(get_reference_and_tag_lines, (void *)&filter);
+	if ((sort & SORT_MASK) == VERCMP_SORT)
+		qsort(filter.tags.items, filter.tags.nr,
+		      sizeof(struct string_list_item), sort_by_version);
+	if (sort & REVERSE_SORT)
+		for (i = filter.tags.nr - 1; i >= 0; i--)
+			if (lines)
+				printf("%-15s %s\n",
+					filter.tags.items[i].string,
+					(char*)filter.tags.items[i].util);
+			else
 				printf("%s\n", filter.tags.items[i].string);
-		else
-			for (i = 0; i < filter.tags.nr; i++)
+	else
+		for (i = 0; i < filter.tags.nr; i++)
+			if (lines)
+				printf("%-15s %s\n",
+					filter.tags.items[i].string,
+					(char*)filter.tags.items[i].util);
+			else
 				printf("%s\n", filter.tags.items[i].string);
-		string_list_clear(&filter.tags, 0);
-	}
+	string_list_clear(&filter.tags, 1);
+
 	return 0;
 }
 
@@ -665,8 +673,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			copts.padding = 2;
 			run_column_filter(colopts, &copts);
 		}
-		if (lines != -1 && tag_sort)
-			die(_("--sort and -n are incompatible"));
 		ret = list_tags(argv, lines == -1 ? 0 : lines, with_commit, tag_sort);
 		if (column_active(colopts))
 			stop_column_filter();
-- 
2.5.0
