From: Jeff King <peff@peff.net>
Subject: [PATCH 08/10] cat-file: split --batch input lines on whitespace
Date: Wed, 10 Jul 2013 07:48:28 -0400
Message-ID: <20130710114828.GH21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:48:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwssw-0004Ah-8W
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab3GJLse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:48:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:47856 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab3GJLsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:48:33 -0400
Received: (qmail 25582 invoked by uid 102); 10 Jul 2013 11:49:50 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:49:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:48:28 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230049>

If we get an input line to --batch or --batch-check that
looks like "HEAD foo bar", we will currently feed the whole
thing to get_sha1(). This means that to use --batch-check
with `rev-list --objects`, one must pre-process the input,
like:

  git rev-list --objects HEAD |
  cut -d' ' -f1 |
  git cat-file --batch-check

Besides being more typing and slightly less efficient to
invoke `cut`, the result loses information: we no longer
know which path each object was found at.

This patch teaches cat-file to split input lines at the
first whitespace. Everything to the left of the whitespace
is considered an object name, and everything to the right is
made available as the %(text) atom. So you can now do:

  git rev-list --objects HEAD |
  git cat-file --batch-check='%(objectsize) %(text)'

to collect object sizes at particular paths.

Even if %(text) is not used, we always do the whitespace
split (which means you can simply eliminate the `cut`
command from the first example above).

This whitespace split is backwards compatible for any
reasonable input. Object names cannot contain spaces, so any
input with spaces would have resulted in a "missing" line.
The only input hurt is if somebody really expected input of
the form "HEAD is a fine-looking ref!" to fail; it will now
parse HEAD, and make "is a fine-looking ref!" available as
%(text).

Signed-off-by: Jeff King <peff@peff.net>
---
I have often found myself cross-referencing object sha1s with rev-list
--objects output in order to find out which paths are bloating
repository size. You can do it manually, or by post-processing the
output of cat-file with "join", but it is way more efficient to simply
not lose the information in the first place.

 Documentation/git-cat-file.txt | 10 ++++++++--
 builtin/cat-file.c             | 20 +++++++++++++++++++-
 t/t1006-cat-file.sh            |  7 +++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 06bdc43..6b0b2de 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -88,8 +88,10 @@ from stdin, one per line, and print information about them.
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
 from stdin, one per line, and print information about them.
 
-Each line is considered as a whole object name, and is parsed as if
-given to linkgit:git-rev-parse[1].
+Each line is split at the first whitespace boundary. All characters
+before that whitespace are considered as a whole object name, and are
+parsed as if given to linkgit:git-rev-parse[1]. Characters after that
+whitespace can be accessed using the `%(text)` atom (see below).
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -110,6 +112,10 @@ newline. The available atoms are:
 	The size, in bytes, that the object takes up on disk. See the
 	note about on-disk sizes in the `CAVEATS` section below.
 
+`text`::
+	The text (if any) found after the first run of whitespace on the
+	input line.
+
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 11fa8c0..36f8159 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -119,6 +119,7 @@ struct expand_data {
 	enum object_type type;
 	unsigned long size;
 	unsigned long disk_size;
+	const char *text;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -161,6 +162,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%lu", data->disk_size);
+	} else if (is_atom("text", atom, len)) {
+		if (!data->mark_query && data->text)
+			strbuf_addstr(sb, data->text);
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
@@ -263,7 +267,21 @@ static int batch_objects(struct batch_options *opt)
 	data.mark_query = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		int error = batch_one_object(buf.buf, opt, &data);
+		char *p;
+		int error;
+
+		/*
+		 * Split at first whitespace, tying off the beginning of the
+		 * string and saving the remainder (or NULL) in data.text.
+		 */
+		p = strpbrk(buf.buf, " \t");
+		if (p) {
+			while (*p && strchr(" \t", *p))
+				*p++ = '\0';
+		}
+		data.text = p;
+
+		error = batch_one_object(buf.buf, opt, &data);
 		if (error)
 			return error;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4e911fb..315da6f 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -78,6 +78,13 @@ $content"
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
+
+    test_expect_success '--batch-check with %(text)' '
+	echo "$type this is some extra content" >expect &&
+	echo "$sha1    this is some extra content" |
+		git cat-file --batch-check="%(objecttype) %(text)" >actual &&
+	test_cmp expect actual
+    '
 }
 
 hello_content="Hello World"
-- 
1.8.3.rc3.24.gec82cb9
