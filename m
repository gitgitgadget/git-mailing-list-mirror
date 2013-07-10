From: Jeff King <peff@peff.net>
Subject: [PATCH 06/10] cat-file: add --batch-check=<format>
Date: Wed, 10 Jul 2013 07:45:47 -0400
Message-ID: <20130710114546.GF21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwsqK-0001qo-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3GJLpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:45:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:47827 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620Ab3GJLpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:45:51 -0400
Received: (qmail 25426 invoked by uid 102); 10 Jul 2013 11:47:08 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:47:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:45:47 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230047>

The `cat-file --batch-check` command can be used to quickly
get information about a large number of objects. However, it
provides a fixed set of information.

This patch adds an optional <format> option to --batch-check
to allow a caller to specify which items they are interested
in, and in which order to output them. This is not very
exciting for now, since we provide the same limited set that
you could already get. However, it opens the door to adding
new format items in the future without breaking backwards
compatibility (or forcing callers to pay the cost to
calculate uninteresting items).

Since the --batch option shares code with --batch-check, it
receives the same feature, though it is less likely to be of
interest there.

The format atom names are chosen to match their counterparts
in for-each-ref. Though we do not (yet) share any code with
for-each-ref's formatter, this keeps the interface as
consistent as possible, and may help later on if the
implementations are unified.

Signed-off-by: Jeff King <peff@peff.net>
---
If the 1% slowdown in the streaming blob patch is too much, the simplest
thing would be to have this formatting apply only to --batch-check, and
let --batch follow its own simpler code path. I doubt anybody really
cares about having custom formats for --batch, as it is less about
analysis and more about getting enough information to recreate the
objects.

Also note that there is no %(contents) atom that one could use to
emulate --batch via --batch-check. I don't see much point, and it would
mean we would not want to build the formatting on strbuf_expand (because
we don't want to copy a large blob into the strbuf). We can add it later
if somebody finds an actual use.

 Documentation/git-cat-file.txt |  55 ++++++++++++++++-----
 builtin/cat-file.c             | 107 +++++++++++++++++++++++++++++++++++------
 t/t1006-cat-file.sh            |   6 +++
 3 files changed, 142 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 30d585a..dd5d6e4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -58,12 +58,16 @@ OPTIONS
 	to apply the filter to the content recorded in the index at <path>.
 
 --batch::
-	Print the SHA-1, type, size, and contents of each object provided on
-	stdin. May not be combined with any other options or arguments.
+--batch=<format>::
+	Print object information and contents for each object provided
+	on stdin.  May not be combined with any other options or arguments.
+	See the section `BATCH OUTPUT` below for details.
 
 --batch-check::
-	Print the SHA-1, type, and size of each object provided on stdin. May not
-	be combined with any other options or arguments.
+--batch-check=<format>::
+	Print object information for each object provided on stdin.  May
+	not be combined with any other options or arguments.  See the
+	section `BATCH OUTPUT` below for details.
 
 OUTPUT
 ------
@@ -78,23 +82,52 @@ each object specified on stdin:
 If <type> is specified, the raw (though uncompressed) contents of the <object>
 will be returned.
 
-If '--batch' is specified, output of the following form is printed for each
-object specified on stdin:
+BATCH OUTPUT
+------------
+
+If `--batch` or `--batch-check` is given, `cat-file` will read objects
+from stdin, one per line, and print information about them.
+
+Each line is considered as a whole object name, and is parsed as if
+given to linkgit:git-rev-parse[1].
+
+You can specify the information shown for each object by using a custom
+`<format>`. The `<format>` is copied literally to stdout for each
+object, with placeholders of the form `%(atom)` expanded, followed by a
+newline. The available atoms are:
+
+`objectname`::
+	The sha1 hash of the object.
+
+`objecttype`::
+	The type of of the object (the same as `cat-file -t` reports).
+
+`objectsize`::
+	The size, in bytes, of the object (the same as `cat-file -s`
+	reports).
+
+If no format is specified, the default format is `%(objectname)
+%(objecttype) %(objectsize)`.
+
+If `--batch` is specified, the object information is followed by the
+object contents (consisting of `%(objectsize)` bytes), followed by a
+newline.
+
+For example, `--batch` without a custom format would produce:
 
 ------------
 <sha1> SP <type> SP <size> LF
 <contents> LF
 ------------
 
-If '--batch-check' is specified, output of the following form is printed for
-each object specified on stdin:
+Whereas `--batch-check='%(objectname) %(objecttype)'` would produce:
 
 ------------
-<sha1> SP <type> SP <size> LF
+<sha1> SP <type> LF
 ------------
 
-For both '--batch' and '--batch-check', output of the following form is printed
-for each object specified on stdin that does not exist in the repository:
+If a name is specified on stdin that cannot be resolved to an object in
+the repository, then `cat-file` will ignore any custom format and print:
 
 ------------
 <object> SP missing LF
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5254fe8..b43a0c5 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -114,6 +114,66 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 	return 0;
 }
 
+struct expand_data {
+	unsigned char sha1[20];
+	enum object_type type;
+	unsigned long size;
+
+	/*
+	 * If mark_query is true, we do not expand anything, but rather
+	 * just mark the object_info with items we wish to query.
+	 */
+	int mark_query;
+
+	/*
+	 * After a mark_query run, this object_info is set up to be
+	 * passed to sha1_object_info_extended. It will point to the data
+	 * elements above, so you can retrieve the response from there.
+	 */
+	struct object_info info;
+};
+
+static int is_atom(const char *atom, const char *s, int slen)
+{
+	int alen = strlen(atom);
+	return alen == slen && !memcmp(atom, s, alen);
+}
+
+static void expand_atom(struct strbuf *sb, const char *atom, int len,
+			void *vdata)
+{
+	struct expand_data *data = vdata;
+
+	if (is_atom("objectname", atom, len)) {
+		if (!data->mark_query)
+			strbuf_addstr(sb, sha1_to_hex(data->sha1));
+	} else if (is_atom("objecttype", atom, len)) {
+		if (!data->mark_query)
+			strbuf_addstr(sb, typename(data->type));
+	} else if (is_atom("objectsize", atom, len)) {
+		if (data->mark_query)
+			data->info.sizep = &data->size;
+		else
+			strbuf_addf(sb, "%lu", data->size);
+	} else
+		die("unknown format element: %.*s", len, atom);
+}
+
+static size_t expand_format(struct strbuf *sb, const char *start, void *data)
+{
+	const char *end;
+
+	if (*start != '(')
+		return 0;
+	end = strchr(start + 1, ')');
+	if (!end)
+		die("format element '%s' does not end in ')'", start);
+
+	expand_atom(sb, start + 1, end - start - 1, data);
+
+	return end - start + 1;
+}
+
 static void print_object_or_die(int fd, const unsigned char *sha1,
 				enum object_type type, unsigned long size)
 {
@@ -142,35 +202,37 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt)
 struct batch_options {
 	int enabled;
 	int print_contents;
+	const char *format;
 };
 
-static int batch_one_object(const char *obj_name, struct batch_options *opt)
+static int batch_one_object(const char *obj_name, struct batch_options *opt,
+			    struct expand_data *data)
 {
-	unsigned char sha1[20];
-	enum object_type type = 0;
-	unsigned long size;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!obj_name)
 	   return 1;
 
-	if (get_sha1(obj_name, sha1)) {
+	if (get_sha1(obj_name, data->sha1)) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
 	}
 
-	type = sha1_object_info(sha1, &size);
-	if (type <= 0) {
+	data->type = sha1_object_info_extended(data->sha1, &data->info);
+	if (data->type <= 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
 		return 0;
 	}
 
-	printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
-	fflush(stdout);
+	strbuf_expand(&buf, opt->format, expand_format, data);
+	strbuf_addch(&buf, '\n');
+	write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
 
 	if (opt->print_contents) {
-		print_object_or_die(1, sha1, type, size);
+		print_object_or_die(1, data->sha1, data->type, data->size);
 		write_or_die(1, "\n", 1);
 	}
 	return 0;
@@ -179,9 +241,23 @@ static int batch_objects(struct batch_options *opt)
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct expand_data data;
+
+	if (!opt->format)
+		opt->format = "%(objectname) %(objecttype) %(objectsize)";
+
+	/*
+	 * Expand once with our special mark_query flag, which will prime the
+	 * object_info to be handed to sha1_object_info_extended for each
+	 * object.
+	 */
+	memset(&data, 0, sizeof(data));
+	data.mark_query = 1;
+	strbuf_expand(&buf, opt->format, expand_format, &data);
+	data.mark_query = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error = batch_one_object(buf.buf, opt);
+		int error = batch_one_object(buf.buf, opt, &data);
 		if (error)
 			return error;
 	}
@@ -216,6 +292,7 @@ static int batch_option_callback(const struct option *opt,
 
 	bo->enabled = 1;
 	bo->print_contents = !strcmp(opt->long_name, "batch");
+	bo->format = arg;
 
 	return 0;
 }
@@ -235,12 +312,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
 		OPT_SET_INT(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
-		{ OPTION_CALLBACK, 0, "batch", &batch, NULL,
+		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
-			PARSE_OPT_NOARG, batch_option_callback },
-		{ OPTION_CALLBACK, 0, "batch-check", &batch, NULL,
+			PARSE_OPT_OPTARG, batch_option_callback },
+		{ OPTION_CALLBACK, 0, "batch-check", &batch, "format",
 			N_("show info about objects fed from the standard input"),
-			PARSE_OPT_NOARG, batch_option_callback },
+			PARSE_OPT_OPTARG, batch_option_callback },
 		OPT_END()
 	};
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index c2f2503..4e911fb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -72,6 +72,12 @@ $content"
 	echo_without_newline $sha1 | git cat-file --batch-check >actual &&
 	test_cmp expect actual
     '
+
+    test_expect_success "custom --batch-check format" '
+	echo "$type $sha1" >expect &&
+	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
+	test_cmp expect actual
+    '
 }
 
 hello_content="Hello World"
-- 
1.8.3.rc3.24.gec82cb9
