From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 04:59:07 -0700
Message-ID: <20130802115906.GA9183@sigill.intra.peff.net>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
 <20130802105402.GA25697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joeyh@debian.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 13:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5E0w-0004MF-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 13:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab3HBL7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 07:59:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:37374 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3HBL7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 07:59:09 -0400
Received: (qmail 3763 invoked by uid 102); 2 Aug 2013 11:59:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Aug 2013 06:59:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Aug 2013 04:59:07 -0700
Content-Disposition: inline
In-Reply-To: <20130802105402.GA25697@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231522>

On Fri, Aug 02, 2013 at 03:54:02AM -0700, Jeff King wrote:

> We need to revert that commit before the release. It can either be
> replaced with:
> 
>   1. A "--split" (or similar) option to use the behavior only when
>      desired.
> 
>   2. Enabling splitting only when %(rest) is used in the output format.

Of the two, I think the latter is more sensible; the former is
unnecessarily placing the burden on the user to match "--split" with
their use of "%(rest)". The second is pointless without the first.

A patch to implement (2) is below.

By the way, Joey, I am not sure how safe "git cat-file --batch-check" is
for arbitrary filenames. In particular, I don't know how it would react
to a filename with an embedded newline (and I do not think it will undo
quoting). Certainly that does not excuse this regression; even if what
you are doing is not 100% reliable, it is good enough in sane situations
and we should not be breaking it. But you may want to double-check the
behavior of your scripts in such a case, and we may need to add a "-z"
to support it reliably.

The "rev-list --objects" output may contain such paths, of course, but
they will be quoted, and "%(rest)" does not care (it is not trying to
interpret the paths, but will reliably relay the quoted bits to the
output).

-- >8 --
Subject: [PATCH] cat-file: only split on whitespace when %(rest) is used

Commit c334b87 recently taught `cat-file --batch-check` to
split input lines on whitespace, and stash everything after
the first token into the %(rest) output format element. That
commit claims:

   Object names cannot contain spaces, so any input with
   spaces would have resulted in a "missing" line.

But that is not correct. Refs, object sha1s, and various
peeling suffixes cannot contain spaces, but some object
names can. In particular:

  1. Tree paths like "[<tree>]:path with whitespace"

  2. Reflog specifications like "@{2 days ago}"

  3. Commit searches like "rev^{/grep me}" or ":/grep me"

To remain backwards compatible, we cannot split on
whitespace by default. This patch teaches cat-file to only
do the splitting when "%(rest)" is used by the output
format. Since that element did not exist at all until
c334b87, old scripts cannot be affected.

The existence of object names with spaces does mean that you
cannot reliably do:

  echo ":path with space and other data" |
  git cat-file --batch-check="%(objectname) %(rest)"

as it would split the path and feed only ":path" to
get_sha1. But that command is nonsensical. If you wanted to
see "and other data" in "%(rest)", git cannot possibly know
where the filename ends and the "rest" begins.

It might be more robust to have something like "-z" to
separate the input elements. But this patch is still a
reasonable step before having that.  It makes the easy cases
easy; people who do not care about %(rest) do not have to
consider it, and the %(rest) code handles the spaces and
newlines of "rev-list --objects" correctly.

Hard cases remain hard but possible (if you might get
whitespace in your input, you do not get to use %(rest) and
must split and join the output yourself using more flexible
tools). And most importantly, it does not preclude us from
having different splitting rules later if a "-z" (or
similar) option is added.  So we can make the hard
cases easier later, if we choose to.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 16 ++++++++--------
 builtin/cat-file.c             | 31 +++++++++++++++++++++----------
 t/t1006-cat-file.sh            |  8 ++++++++
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 3ddec0b..21cffe2 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -86,12 +86,9 @@ If `--batch` or `--batch-check` is given, `cat-file` will read objects
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them.
-
-Each line is split at the first whitespace boundary. All characters
-before that whitespace are considered as a whole object name, and are
-parsed as if given to linkgit:git-rev-parse[1]. Characters after that
-whitespace can be accessed using the `%(rest)` atom (see below).
+from stdin, one per line, and print information about them. By default,
+the whole line is considered as an object, as if it were fed to
+linkgit:git-rev-parse[1].
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -113,8 +110,11 @@ newline. The available atoms are:
 	note about on-disk sizes in the `CAVEATS` section below.
 
 `rest`::
-	The text (if any) found after the first run of whitespace on the
-	input line (i.e., the "rest" of the line).
+	If this atom is used in the output string, input lines are split
+	at the first whitespace boundary. All characters before that
+	whitespace are considered to be the object name; characters
+	after that first run of whitespace (i.e., the "rest" of the
+	line) are output in place of the `%(rest)` atom.
 
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 163ce6c..07b4818 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -128,6 +128,13 @@ struct expand_data {
 	int mark_query;
 
 	/*
+	 * Whether to split the input on whitespace before feeding it to
+	 * get_sha1; this is decided during the mark_query phase based on
+	 * whether we have a %(rest) token in our format.
+	 */
+	int split_on_whitespace;
+
+	/*
 	 * After a mark_query run, this object_info is set up to be
 	 * passed to sha1_object_info_extended. It will point to the data
 	 * elements above, so you can retrieve the response from there.
@@ -165,7 +172,9 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 		else
 			strbuf_addf(sb, "%lu", data->disk_size);
 	} else if (is_atom("rest", atom, len)) {
-		if (!data->mark_query && data->rest)
+		if (data->mark_query)
+			data->split_on_whitespace = 1;
+		else if (data->rest)
 			strbuf_addstr(sb, data->rest);
 	} else
 		die("unknown format element: %.*s", len, atom);
@@ -280,16 +289,18 @@ static int batch_objects(struct batch_options *opt)
 		char *p;
 		int error;
 
-		/*
-		 * Split at first whitespace, tying off the beginning of the
-		 * string and saving the remainder (or NULL) in data.rest.
-		 */
-		p = strpbrk(buf.buf, " \t");
-		if (p) {
-			while (*p && strchr(" \t", *p))
-				*p++ = '\0';
+		if (data.split_on_whitespace) {
+			/*
+			 * Split at first whitespace, tying off the beginning of the
+			 * string and saving the remainder (or NULL) in data.rest.
+			 */
+			p = strpbrk(buf.buf, " \t");
+			if (p) {
+				while (*p && strchr(" \t", *p))
+					*p++ = '\0';
+			}
+			data.rest = p;
 		}
-		data.rest = p;
 
 		error = batch_one_object(buf.buf, opt, &data);
 		if (error)
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d499d02..a420742 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -98,6 +98,14 @@ run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
 
 run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
 
+test_expect_success '--batch-check without %(rest) considers whole line' '
+	echo "$hello_sha1 blob $hello_size" >expect &&
+	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
+	test_when_finished "git update-index --remove \"white space\"" &&
+	echo ":white space" | git cat-file --batch-check >actual &&
+	test_cmp expect actual
+'
+
 tree_sha1=$(git write-tree)
 tree_size=33
 tree_pretty_content="100644 blob $hello_sha1	hello"
-- 
1.8.4.rc0.3.g042a762
