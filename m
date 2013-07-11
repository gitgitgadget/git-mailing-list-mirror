From: Jeff King <peff@peff.net>
Subject: [PATCHv3 08/10] cat-file: split --batch input lines on whitespace
Date: Thu, 11 Jul 2013 16:45:59 -0400
Message-ID: <20130711204559.GA11399@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
 <20130710114828.GH21963@sigill.intra.peff.net>
 <CALkWK0mGMZPWowZ0ULNuGKD8w2Q=kN0nEGaOkuWoYKmzD5zGrw@mail.gmail.com>
 <20130711113653.GD6015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 22:46:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxNke-0006KZ-IW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 22:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab3GKUqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 16:46:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:60946 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613Ab3GKUqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 16:46:02 -0400
Received: (qmail 21913 invoked by uid 102); 11 Jul 2013 20:47:19 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Jul 2013 15:47:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jul 2013 16:45:59 -0400
Content-Disposition: inline
In-Reply-To: <20130711113653.GD6015@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230128>

On Thu, Jul 11, 2013 at 07:36:53AM -0400, Jeff King wrote:

> On Wed, Jul 10, 2013 at 08:59:51PM +0530, Ramkumar Ramachandra wrote:
> 
> > Jeff King wrote:
> > >   git rev-list --objects HEAD |
> > >   git cat-file --batch-check='%(objectsize) %(text)'
> > 
> > If anything, I would have expected %(rest), not %(text).  This atom is
> > specific to commands that accept input via stdin (i.e. not log, f-e-r,
> > branch, or anything else I can think of).
> 
> I considered %(rest) as well. I don't have a strong preference.

Here is the patch re-rolled with s/text/rest/.

Junio, that makes this and 10/10 the only "v3" updates. Let me know if
it would be simpler to just resend the whole series.

-- >8 --
Subject: [PATCH] cat-file: split --batch input lines on whitespace

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
made available as the %(reset) atom. So you can now do:

  git rev-list --objects HEAD |
  git cat-file --batch-check='%(objectsize) %(rest)'

to collect object sizes at particular paths.

Even if %(rest) is not used, we always do the whitespace
split (which means you can simply eliminate the `cut`
command from the first example above).

This whitespace split is backwards compatible for any
reasonable input. Object names cannot contain spaces, so any
input with spaces would have resulted in a "missing" line.
The only input hurt is if somebody really expected input of
the form "HEAD is a fine-looking ref!" to fail; it will now
parse HEAD, and make "is a fine-looking ref!" available as
%(rest).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 10 ++++++++--
 builtin/cat-file.c             | 20 +++++++++++++++++++-
 t/t1006-cat-file.sh            |  7 +++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 06bdc43..68691d4 100644
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
+whitespace can be accessed using the `%(rest)` atom (see below).
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -110,6 +112,10 @@ newline. The available atoms are:
 	The size, in bytes, that the object takes up on disk. See the
 	note about on-disk sizes in the `CAVEATS` section below.
 
+`rest`::
+	The text (if any) found after the first run of whitespace on the
+	input line (i.e., the "rest" of the line).
+
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 11fa8c0..0e64b41 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -119,6 +119,7 @@ struct expand_data {
 	enum object_type type;
 	unsigned long size;
 	unsigned long disk_size;
+	const char *rest;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -161,6 +162,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%lu", data->disk_size);
+	} else if (is_atom("rest", atom, len)) {
+		if (!data->mark_query && data->rest)
+			strbuf_addstr(sb, data->rest);
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
+		 * string and saving the remainder (or NULL) in data.rest.
+		 */
+		p = strpbrk(buf.buf, " \t");
+		if (p) {
+			while (*p && strchr(" \t", *p))
+				*p++ = '\0';
+		}
+		data.rest = p;
+
+		error = batch_one_object(buf.buf, opt, &data);
 		if (error)
 			return error;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4e911fb..d499d02 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -78,6 +78,13 @@ $content"
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
+
+    test_expect_success '--batch-check with %(rest)' '
+	echo "$type this is some extra content" >expect &&
+	echo "$sha1    this is some extra content" |
+		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
+	test_cmp expect actual
+    '
 }
 
 hello_content="Hello World"
-- 
1.8.3.rc3.24.gec82cb9
