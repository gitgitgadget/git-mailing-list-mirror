From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Documentation/technical: document quoting API
Date: Mon, 3 Jan 2011 00:35:34 -0600
Message-ID: <20110103063534.GA3661@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 07:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZe1K-0007a2-C5
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 07:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab1ACGfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 01:35:45 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47742 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1ACGfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 01:35:45 -0500
Received: by ywl5 with SMTP id 5so5173417ywl.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 22:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=AcggBZHNQdU1n4jzlBYyhd+bZvCA3aQqKIev4r0JJTA=;
        b=Vog67c1aCj2d41YM7Hxp5v06lqB2b2CTNGnJ997eyae6arFDV9shiJcE0OFPzA9Bk7
         OwodakX8Mh0dcy7d56z2Fd/LPsWT4TF2k3XDQz5FFIIORrs9bHCJ5RZZ3dHZx9M3uvxS
         zZVYcw3qHlKj6lPvvMklZu09WYYNXjwJmW7YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Y389n8DIh5XvzfuIqaPVmj2VX+R97O6A/ty3fg07Gm3GJlZOwHVQxM20JO42QmpVSI
         A9X5PavYzra1lBWmkmSU4nMx5mb4pmGDzuN+4/hSHgehtun87y9KGNpe5EJ/GHvF0exo
         W/pZxjJTjjEI0wiWPiyzJMzFzyFeYGbWp1eXY=
Received: by 10.236.102.179 with SMTP id d39mr30290253yhg.48.1294036544310;
        Sun, 02 Jan 2011 22:35:44 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id 3sm12066318yhl.0.2011.01.02.22.35.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 22:35:43 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164443>

Briefly explain the zoo of quoting functions.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is just a starting point, I fear.  Not even compile-tested.
Problems:

 - not very brief
 - not a great overview

But I was happy to have the chance to read through the available
functions.

Suggestions and other improvements welcome.

 Documentation/technical/api-quote.txt |  124 ++++++++++++++++++++++++++++++---
 quote.h                               |   14 ++--
 2 files changed, 121 insertions(+), 17 deletions(-)
 rewrite Documentation/technical/api-quote.txt (84%)

diff --git a/Documentation/technical/api-quote.txt b/Documentation/technical/api-quote.txt
dissimilarity index 84%
index e8a1bce..18da370 100644
--- a/Documentation/technical/api-quote.txt
+++ b/Documentation/technical/api-quote.txt
@@ -1,10 +1,114 @@
-quote API
-=========
-
-Talk about <quote.h>, things like
-
-* sq_quote and unquote
-* c_style quote and unquote
-* quoting for foreign languages
-
-(JC)
+quote API
+=========
+
+The quoting API can be used to replace unusual characters for
+shell safety or for output readability and parseability.
+It also can be used to perform the inverse operation and recover
+the unusual characters again.
+
+C-style quoting
+---------------
+
+`quote_c_style` quotes a string in a manner that might be familiar
+to C programmers.  This can be used to quote newlines and tabs in
+filenames for patches, for example.
+
+. if sb and fp are both NULL, it returns the number of bytes needed
+  to hold the quoted version of "name", counting the double quotes
+  around it but not terminating NUL.  If "name" does not need quoting,
+  it returns 0.
+
+. otherwise, it emits the quoted version of "name" to a stream,
+  strbuf, or both.  Output will have enclosing double quotes
+  suppressed if requested with the "no_dq" parameter.
+
+`quote_two_c_style`::
+	Quote two paths (prefix + path) in C-style and concatenate them.
+	One should use this instead of calling `quote_c_style` twice
+	to avoid unsightly quotation marks in the middle.
+
+`unquote_c_style`::
+	This unwraps what quote_c_style() produces in place,
+	but returns -1 and doesn't touch if the input does not start with
+	a double-quote or otherwise differs from what quote_c_style
+	would have produced.  Though note that this function will
+	allocate memory in the strbuf, so calling `strbuf_release`
+	is mandatory regardless of the result `unquote_c_style` returns.
++
+Updates the endp pointer to point at one past the ending double quote
+if given.
+
+`write_name_quoted`::
+	`write_name_quoted` is like `quote_c_style` but takes a
+	different set of arguments.
+	Instead of asking for quotes or not, you pass a "terminator".
+	If it's \0 then we assume you don't want to escape, else C
+	escaping is performed. In any case, the terminator is also
+	appended to the stream.
+
+`write_name_quotedpfx`::
+	`write_name_quotedpfx` works like `write_name_quoted` but takes
+	prefix/prefix_len arguments.  The first "prefix_len" characters
+	of "prefix" will be prepended when emiting "name".
+
+`write_name_quoted_relative`::
+	This is a sort of converse to `write_name_quotedpfx`.
+	The path "name" is made relative to the directory described by
+	prefix and prefix_len by stripping away path components and
+	prepending `../` when necessary before quoting.
+
+Quoting for the shell
+---------------------
+
+`sq_quote` copies its argument quoted for the shell safety.
+Any single quote is replaced with '\'', any exclamation point
+is replaced with '\!', and the whole thing is enclosed in a
+single-quote pair.
+
+For example, if you are passing the result to `system()` as an
+argument:
+--------------
+sprintf(cmd, "foobar %s %s", sq_quote(arg0), sq_quote(arg1))
+--------------
+would be appropriate.  If the `system()` is going to call 'ssh' to
+run the command on the other side:
+--------------
+sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
+sprintf(rcmd, "ssh %s %s", sq_quote(host), sq_quote(cmd));
+--------------
+Note that the above examples leak memory!  Remember to free result from
+`sq_quote()` in a real application.
+
+`sq_quote_print`::
+	Writes to a stream instead of a new buffer.
+
+`sq_quote_buf`::
+	Appends to a strbuf instead of allocating a new buffer.
+
+`sq_quote_argv`::
+	Appends a list of command-line-ready arguments to "dst",
+	each preceded by a space character.  This function is
+	available for scripted use as 'git rev-parse --sq-quote'.
+
+`sq_dequote`::
+	This unwraps what sq_quote() produces in place, but returns
+	NULL if the input does not look like what sq_quote would have
+	produced.
+
+`sq_dequote_to_argv`::
+	Like the above, but unwrap many arguments in the same string
+	separated by space. "*argv", "*nr", and "*alloc" should be a
+	pointer to a malloc-ed array (or NULL), its current number of
+	valid elements, and the number of allocated elements, for
+	example as managed with ALLOC_GROW.  The result is appended
+	after the valid part of *argv.
+
+Quoting for other languages
+---------------------------
+
+`perl_quote_print`::
+`python_quote_print`::
+`tcl_quote_print`::
+	Quote as a string literal for evaluation in the specified
+	language.  This is used by 'git for-each-ref' to output
+	various aspects of objects for use by language bindings.
diff --git a/quote.h b/quote.h
index 38003bf..cec40b0 100644
--- a/quote.h
+++ b/quote.h
@@ -23,9 +23,8 @@
  * Note that the above examples leak memory!  Remember to free result from
  * sq_quote() in a real application.
  *
- * sq_quote_buf() writes to an existing buffer of specified size; it
- * will return the number of characters that would have been written
- * excluding the final null regardless of the buffer size.
+ * sq_quote_buf() writes to the end of a strbuf instead of
+ * allocating a new buffer.
  */
 
 extern void sq_quote_print(FILE *stream, const char *src);
@@ -40,10 +39,11 @@ extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
 extern char *sq_dequote(char *);
 
 /*
- * Same as the above, but can be used to unwrap many arguments in the
- * same string separated by space. "next" is changed to point to the
- * next argument that should be passed as first parameter. When there
- * is no more argument to be dequoted, "next" is updated to point to NULL.
+ * Similar to the above, but unwraps many arguments in the
+ * same string separated by space. "*argv" is expanded to hold
+ * the dequoted arguments in positions (*argv)[*nr], *argv[*nr+1], etc
+ * and *nr and *alloc updated to hold the new number of entries
+ * and allocated size of the array.
  */
 extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
-- 
1.7.4.rc0.580.g89dc.dirty
