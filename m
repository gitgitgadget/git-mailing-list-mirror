From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] strbuf: migrate api-strbuf.txt documentation to strbuf.h
Date: Fri, 12 Dec 2014 16:28:00 -0500
Message-ID: <20141212212800.GA27451@peff.net>
References: <20141212212726.GA26284@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:28:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXkv-0004KC-2N
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbaLLV2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:28:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:52305 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751388AbaLLV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:28:03 -0500
Received: (qmail 19902 invoked by uid 102); 12 Dec 2014 21:28:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 15:28:02 -0600
Received: (qmail 14259 invoked by uid 107); 12 Dec 2014 21:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 16:28:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 16:28:00 -0500
Content-Disposition: inline
In-Reply-To: <20141212212726.GA26284@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261375>

Some of strbuf is documented as comments above functions,
and some is separate in Documentation/technical/api-strbuf.txt.
This makes it annoying to find the appropriate documentation.
We'd rather have it all in one place, which means all in the
text document, or all in the header.

Let's choose the header as that place. Even though the
formatting is not quite as pretty, this keeps the
documentation close to the related code.  The hope is that
this makes it easier to find what you want (human-readable
comments are right next to the C declarations), and easier
for writers to keep the documentation up to date.

This is more or less a straight import of the text from
api-strbuf.txt into C comments, complete with asciidoc
formatting. The exceptions are:

 1. All comments created in this way are started with "/**"
    to indicate they are part of the API documentation. This
    may help later with extracting the text to pretty-print
    it.

 2. Function descriptions do not repeat the function name,
    as it is available in the context directly below.  So:

      `strbuf_add`::

          Add data of given length to the buffer.

    from api-strbuf.txt becomes:

      /**
       * Add data of given length to the buffer.
       */
      void strbuf_add(struct strbuf *sb, const void *, size_t);

    As a result, any block-continuation required in asciidoc
    for that list item was dropped in favor of straight
    blank-line paragraph (since it is not necessary when we
    are not in a list item).

 3. There is minor re-wording to integrate existing comments
    and api-strbuf text. In each case, I took whichever
    version was more descriptive, and eliminated any
    redundancies. In one case, for strbuf_addstr, the api
    documentation gave its inline definition; I eliminated
    this as redundant with the actual definition, which can
    be seen directly below the comment.

 4. The functions in the header file are re-ordered to match
    the ordering of the API documentation, under the
    assumption that more thought went into the grouping
    there.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-strbuf.txt | 351 -------------------------
 strbuf.h                               | 458 ++++++++++++++++++++++++++++-----
 2 files changed, 390 insertions(+), 419 deletions(-)
 delete mode 100644 Documentation/technical/api-strbuf.txt

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
deleted file mode 100644
index cca6543..0000000
--- a/Documentation/technical/api-strbuf.txt
+++ /dev/null
@@ -1,351 +0,0 @@
-strbuf API
-==========
-
-strbuf's are meant to be used with all the usual C string and memory
-APIs. Given that the length of the buffer is known, it's often better to
-use the mem* functions than a str* one (memchr vs. strchr e.g.).
-Though, one has to be careful about the fact that str* functions often
-stop on NULs and that strbufs may have embedded NULs.
-
-A strbuf is NUL terminated for convenience, but no function in the
-strbuf API actually relies on the string being free of NULs.
-
-strbufs have some invariants that are very important to keep in mind:
-
-. The `buf` member is never NULL, so it can be used in any usual C
-string operations safely. strbuf's _have_ to be initialized either by
-`strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
-+
-Do *not* assume anything on what `buf` really is (e.g. if it is
-allocated memory or not), use `strbuf_detach()` to unwrap a memory
-buffer from its strbuf shell in a safe way. That is the sole supported
-way. This will give you a malloced buffer that you can later `free()`.
-+
-However, it is totally safe to modify anything in the string pointed by
-the `buf` member, between the indices `0` and `len-1` (inclusive).
-
-. The `buf` member is a byte array that has at least `len + 1` bytes
-  allocated. The extra byte is used to store a `'\0'`, allowing the
-  `buf` member to be a valid C-string. Every strbuf function ensure this
-  invariant is preserved.
-+
-NOTE: It is OK to "play" with the buffer directly if you work it this
-      way:
-+
-----
-strbuf_grow(sb, SOME_SIZE); <1>
-strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
-----
-<1> Here, the memory array starting at `sb->buf`, and of length
-`strbuf_avail(sb)` is all yours, and you can be sure that
-`strbuf_avail(sb)` is at least `SOME_SIZE`.
-+
-NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
-+
-Doing so is safe, though if it has to be done in many places, adding the
-missing API to the strbuf module is the way to go.
-+
-WARNING: Do _not_ assume that the area that is yours is of size `alloc
-- 1` even if it's true in the current implementation. Alloc is somehow a
-"private" member that should not be messed with. Use `strbuf_avail()`
-instead.
-
-Data structures
----------------
-
-* `struct strbuf`
-
-This is the string buffer structure. The `len` member can be used to
-determine the current length of the string, and `buf` member provides
-access to the string itself.
-
-Functions
----------
-
-* Life cycle
-
-`strbuf_init`::
-
-	Initialize the structure. The second parameter can be zero or a bigger
-	number to allocate memory, in case you want to prevent further reallocs.
-
-`strbuf_release`::
-
-	Release a string buffer and the memory it used. You should not use the
-	string buffer after using this function, unless you initialize it again.
-
-`strbuf_detach`::
-
-	Detach the string from the strbuf and returns it; you now own the
-	storage the string occupies and it is your responsibility from then on
-	to release it with `free(3)` when you are done with it.
-
-`strbuf_attach`::
-
-	Attach a string to a buffer. You should specify the string to attach,
-	the current length of the string and the amount of allocated memory.
-	The amount must be larger than the string length, because the string you
-	pass is supposed to be a NUL-terminated string.  This string _must_ be
-	malloc()ed, and after attaching, the pointer cannot be relied upon
-	anymore, and neither be free()d directly.
-
-`strbuf_swap`::
-
-	Swap the contents of two string buffers.
-
-* Related to the size of the buffer
-
-`strbuf_avail`::
-
-	Determine the amount of allocated but unused memory.
-
-`strbuf_grow`::
-
-	Ensure that at least this amount of unused memory is available after
-	`len`. This is used when you know a typical size for what you will add
-	and want to avoid repetitive automatic resizing of the underlying buffer.
-	This is never a needed operation, but can be critical for performance in
-	some cases.
-
-`strbuf_setlen`::
-
-	Set the length of the buffer to a given value. This function does *not*
-	allocate new memory, so you should not perform a `strbuf_setlen()` to a
-	length that is larger than `len + strbuf_avail()`. `strbuf_setlen()` is
-	just meant as a 'please fix invariants from this strbuf I just messed
-	with'.
-
-`strbuf_reset`::
-
-	Empty the buffer by setting the size of it to zero.
-
-* Related to the contents of the buffer
-
-`strbuf_trim`::
-
-	Strip whitespace from the beginning and end of a string.
-	Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
-
-`strbuf_rtrim`::
-
-	Strip whitespace from the end of a string.
-
-`strbuf_ltrim`::
-
-	Strip whitespace from the beginning of a string.
-
-`strbuf_reencode`::
-
-	Replace the contents of the strbuf with a reencoded form.  Returns -1
-	on error, 0 on success.
-
-`strbuf_tolower`::
-
-	Lowercase each character in the buffer using `tolower`.
-
-`strbuf_cmp`::
-
-	Compare two buffers. Returns an integer less than, equal to, or greater
-	than zero if the first buffer is found, respectively, to be less than,
-	to match, or be greater than the second buffer.
-
-* Adding data to the buffer
-
-NOTE: All of the functions in this section will grow the buffer as necessary.
-If they fail for some reason other than memory shortage and the buffer hadn't
-been allocated before (i.e. the `struct strbuf` was set to `STRBUF_INIT`),
-then they will free() it.
-
-`strbuf_addch`::
-
-	Add a single character to the buffer.
-
-`strbuf_addchars`::
-
-	Add a character the specified number of times to the buffer.
-
-`strbuf_insert`::
-
-	Insert data to the given position of the buffer. The remaining contents
-	will be shifted, not overwritten.
-
-`strbuf_remove`::
-
-	Remove given amount of data from a given position of the buffer.
-
-`strbuf_splice`::
-
-	Remove the bytes between `pos..pos+len` and replace it with the given
-	data.
-
-`strbuf_add_commented_lines`::
-
-	Add a NUL-terminated string to the buffer. Each line will be prepended
-	by a comment character and a blank.
-
-`strbuf_add`::
-
-	Add data of given length to the buffer.
-
-`strbuf_addstr`::
-
-Add a NUL-terminated string to the buffer.
-+
-NOTE: This function will *always* be implemented as an inline or a macro
-that expands to:
-+
-----
-strbuf_add(..., s, strlen(s));
-----
-+
-Meaning that this is efficient to write things like:
-+
-----
-strbuf_addstr(sb, "immediate string");
-----
-
-`strbuf_addbuf`::
-
-	Copy the contents of another buffer at the end of the current one.
-
-`strbuf_adddup`::
-
-	Copy part of the buffer from a given position till a given length to the
-	end of the buffer.
-
-`strbuf_expand`::
-
-	This function can be used to expand a format string containing
-	placeholders. To that end, it parses the string and calls the specified
-	function for every percent sign found.
-+
-The callback function is given a pointer to the character after the `%`
-and a pointer to the struct strbuf.  It is expected to add the expanded
-version of the placeholder to the strbuf, e.g. to add a newline
-character if the letter `n` appears after a `%`.  The function returns
-the length of the placeholder recognized and `strbuf_expand()` skips
-over it.
-+
-The format `%%` is automatically expanded to a single `%` as a quoting
-mechanism; callers do not need to handle the `%` placeholder themselves,
-and the callback function will not be invoked for this placeholder.
-+
-All other characters (non-percent and not skipped ones) are copied
-verbatim to the strbuf.  If the callback returned zero, meaning that the
-placeholder is unknown, then the percent sign is copied, too.
-+
-In order to facilitate caching and to make it possible to give
-parameters to the callback, `strbuf_expand()` passes a context pointer,
-which can be used by the programmer of the callback as she sees fit.
-
-`strbuf_expand_dict_cb`::
-
-	Used as callback for `strbuf_expand()`, expects an array of
-	struct strbuf_expand_dict_entry as context, i.e. pairs of
-	placeholder and replacement string.  The array needs to be
-	terminated by an entry with placeholder set to NULL.
-
-`strbuf_addbuf_percentquote`::
-
-	Append the contents of one strbuf to another, quoting any
-	percent signs ("%") into double-percents ("%%") in the
-	destination. This is useful for literal data to be fed to either
-	strbuf_expand or to the *printf family of functions.
-
-`strbuf_humanise_bytes`::
-
-	Append the given byte size as a human-readable string (i.e. 12.23 KiB,
-	3.50 MiB).
-
-`strbuf_addf`::
-
-	Add a formatted string to the buffer.
-
-`strbuf_commented_addf`::
-
-	Add a formatted string prepended by a comment character and a
-	blank to the buffer.
-
-`strbuf_fread`::
-
-	Read a given size of data from a FILE* pointer to the buffer.
-+
-NOTE: The buffer is rewound if the read fails. If -1 is returned,
-`errno` must be consulted, like you would do for `read(3)`.
-`strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
-same behaviour as well.
-
-`strbuf_read`::
-
-	Read the contents of a given file descriptor. The third argument can be
-	used to give a hint about the file size, to avoid reallocs.
-
-`strbuf_read_file`::
-
-	Read the contents of a file, specified by its path. The third argument
-	can be used to give a hint about the file size, to avoid reallocs.
-
-`strbuf_readlink`::
-
-	Read the target of a symbolic link, specified by its path.  The third
-	argument can be used to give a hint about the size, to avoid reallocs.
-
-`strbuf_getline`::
-
-	Read a line from a FILE *, overwriting the existing contents
-	of the strbuf. The second argument specifies the line
-	terminator character, typically `'\n'`.
-	Reading stops after the terminator or at EOF.  The terminator
-	is removed from the buffer before returning.  Returns 0 unless
-	there was nothing left before EOF, in which case it returns `EOF`.
-
-`strbuf_getwholeline`::
-
-	Like `strbuf_getline`, but keeps the trailing terminator (if
-	any) in the buffer.
-
-`strbuf_getwholeline_fd`::
-
-	Like `strbuf_getwholeline`, but operates on a file descriptor.
-	It reads one character at a time, so it is very slow.  Do not
-	use it unless you need the correct position in the file
-	descriptor.
-
-`strbuf_getcwd`::
-
-	Set the buffer to the path of the current working directory.
-
-`strbuf_add_absolute_path`
-
-	Add a path to a buffer, converting a relative path to an
-	absolute one in the process.  Symbolic links are not
-	resolved.
-
-`stripspace`::
-
-	Strip whitespace from a buffer. The second parameter controls if
-	comments are considered contents to be removed or not.
-
-`strbuf_split_buf`::
-`strbuf_split_str`::
-`strbuf_split_max`::
-`strbuf_split`::
-
-	Split a string or strbuf into a list of strbufs at a specified
-	terminator character.  The returned substrings include the
-	terminator characters.  Some of these functions take a `max`
-	parameter, which, if positive, limits the output to that
-	number of substrings.
-
-`strbuf_list_free`::
-
-	Free a list of strbufs (for example, the return values of the
-	`strbuf_split()` functions).
-
-`launch_editor`::
-
-	Launch the user preferred editor to edit a file and fill the buffer
-	with the file's contents upon the user completing their editing. The
-	third argument can be used to set the environment which the editor is
-	run in. If the buffer is NULL the editor is launched as usual but the
-	file's contents are not read into the buffer upon completion.
diff --git a/strbuf.h b/strbuf.h
index 652b6c4..0a83f9a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,22 +1,117 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
-/* See Documentation/technical/api-strbuf.txt */
+/**
+ * strbuf's are meant to be used with all the usual C string and memory
+ * APIs. Given that the length of the buffer is known, it's often better to
+ * use the mem* functions than a str* one (memchr vs. strchr e.g.).
+ * Though, one has to be careful about the fact that str* functions often
+ * stop on NULs and that strbufs may have embedded NULs.
+ *
+ * A strbuf is NUL terminated for convenience, but no function in the
+ * strbuf API actually relies on the string being free of NULs.
+ *
+ * strbufs have some invariants that are very important to keep in mind:
+ *
+ * . The `buf` member is never NULL, so it can be used in any usual C
+ * string operations safely. strbuf's _have_ to be initialized either by
+ * `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
+ * +
+ * Do *not* assume anything on what `buf` really is (e.g. if it is
+ * allocated memory or not), use `strbuf_detach()` to unwrap a memory
+ * buffer from its strbuf shell in a safe way. That is the sole supported
+ * way. This will give you a malloced buffer that you can later `free()`.
+ * +
+ * However, it is totally safe to modify anything in the string pointed by
+ * the `buf` member, between the indices `0` and `len-1` (inclusive).
+ *
+ * . The `buf` member is a byte array that has at least `len + 1` bytes
+ *   allocated. The extra byte is used to store a `'\0'`, allowing the
+ *   `buf` member to be a valid C-string. Every strbuf function ensure this
+ *   invariant is preserved.
+ * +
+ * NOTE: It is OK to "play" with the buffer directly if you work it this
+ *       way:
+ * +
+ * ----
+ * strbuf_grow(sb, SOME_SIZE); <1>
+ * strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+ * ----
+ * <1> Here, the memory array starting at `sb->buf`, and of length
+ * `strbuf_avail(sb)` is all yours, and you can be sure that
+ * `strbuf_avail(sb)` is at least `SOME_SIZE`.
+ * +
+ * NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
+ * +
+ * Doing so is safe, though if it has to be done in many places, adding the
+ * missing API to the strbuf module is the way to go.
+ * +
+ * WARNING: Do _not_ assume that the area that is yours is of size `alloc
+ * - 1` even if it's true in the current implementation. Alloc is somehow a
+ * "private" member that should not be messed with. Use `strbuf_avail()`
+ * instead.
+ */
 
-extern char strbuf_slopbuf[];
+/*
+ * Data Structures
+ * ---------------
+ */
+
+/**
+ * This is the string buffer structure. The `len` member can be used to
+ * determine the current length of the string, and `buf` member provides
+ * access to the string itself.
+ */
 struct strbuf {
 	size_t alloc;
 	size_t len;
 	char *buf;
 };
 
+extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
 
-/*----- strbuf life cycle -----*/
+/**
+ * Functions
+ * ---------
+ */
+
+/**
+ * * Life Cycle
+ */
+
+/**
+ * Initialize the structure. The second parameter can be zero or a bigger
+ * number to allocate memory, in case you want to prevent further reallocs.
+ */
 extern void strbuf_init(struct strbuf *, size_t);
+
+/**
+ * Release a string buffer and the memory it used. You should not use the
+ * string buffer after using this function, unless you initialize it again.
+ */
 extern void strbuf_release(struct strbuf *);
+
+/**
+ * Detach the string from the strbuf and returns it; you now own the
+ * storage the string occupies and it is your responsibility from then on
+ * to release it with `free(3)` when you are done with it.
+ */
 extern char *strbuf_detach(struct strbuf *, size_t *);
+
+/**
+ * Attach a string to a buffer. You should specify the string to attach,
+ * the current length of the string and the amount of allocated memory.
+ * The amount must be larger than the string length, because the string you
+ * pass is supposed to be a NUL-terminated string.  This string _must_ be
+ * malloc()ed, and after attaching, the pointer cannot be relied upon
+ * anymore, and neither be free()d directly.
+ */
 extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
+
+/**
+ * Swap the contents of two string buffers.
+ */
 static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 {
 	struct strbuf tmp = *a;
@@ -24,14 +119,35 @@ static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 	*b = tmp;
 }
 
-/*----- strbuf size related -----*/
+
+/**
+ * * Related to the size of the buffer
+ */
+
+/**
+ * Determine the amount of allocated but unused memory.
+ */
 static inline size_t strbuf_avail(const struct strbuf *sb)
 {
 	return sb->alloc ? sb->alloc - sb->len - 1 : 0;
 }
 
+/**
+ * Ensure that at least this amount of unused memory is available after
+ * `len`. This is used when you know a typical size for what you will add
+ * and want to avoid repetitive automatic resizing of the underlying buffer.
+ * This is never a needed operation, but can be critical for performance in
+ * some cases.
+ */
 extern void strbuf_grow(struct strbuf *, size_t);
 
+/**
+ * Set the length of the buffer to a given value. This function does *not*
+ * allocate new memory, so you should not perform a `strbuf_setlen()` to a
+ * length that is larger than `len + strbuf_avail()`. `strbuf_setlen()` is
+ * just meant as a 'please fix invariants from this strbuf I just messed
+ * with'.
+ */
 static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 {
 	if (len > (sb->alloc ? sb->alloc - 1 : 0))
@@ -39,16 +155,285 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 	sb->len = len;
 	sb->buf[len] = '\0';
 }
+
+/**
+ * Empty the buffer by setting the size of it to zero.
+ */
 #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
 
-/*----- content related -----*/
+
+/**
+ * * Related to the contents of the buffer
+ */
+
+/**
+ * Strip whitespace from the beginning and end of a string.
+ * Equivalent to performing `strbuf_rtrim()` followed by `strbuf_ltrim()`.
+ */
 extern void strbuf_trim(struct strbuf *);
+
+/**
+ * Strip whitespace from the end of a string.
+ */
 extern void strbuf_rtrim(struct strbuf *);
+
+/**
+ * Strip whitespace from the beginning of a string.
+ */
 extern void strbuf_ltrim(struct strbuf *);
+
+/**
+ * Replace the contents of the strbuf with a reencoded form.  Returns -1
+ * on error, 0 on success.
+ */
 extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
+
+/**
+ * Lowercase each character in the buffer using `tolower`.
+ */
 extern void strbuf_tolower(struct strbuf *sb);
+
+/**
+ * Compare two buffers. Returns an integer less than, equal to, or greater
+ * than zero if the first buffer is found, respectively, to be less than,
+ * to match, or be greater than the second buffer.
+ */
 extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
+
+/**
+ * Adding data to the buffer
+ *
+ * NOTE: All of the functions in this section will grow the buffer as
+ * necessary.  If they fail for some reason other than memory shortage and the
+ * buffer hadn't been allocated before (i.e. the `struct strbuf` was set to
+ * `STRBUF_INIT`), then they will free() it.
+ */
+
+/**
+ * Add a single character to the buffer.
+ */
+static inline void strbuf_addch(struct strbuf *sb, int c)
+{
+	strbuf_grow(sb, 1);
+	sb->buf[sb->len++] = c;
+	sb->buf[sb->len] = '\0';
+}
+
+/**
+ * Add a character the specified number of times to the buffer.
+ */
+extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
+
+/**
+ * Insert data to the given position of the buffer. The remaining contents
+ * will be shifted, not overwritten.
+ */
+extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
+
+/**
+ * Remove given amount of data from a given position of the buffer.
+ */
+extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
+
+/**
+ * Remove the bytes between `pos..pos+len` and replace it with the given
+ * data.
+ */
+extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
+			  const void *, size_t);
+
+/**
+ * Add a NUL-terminated string to the buffer. Each line will be prepended
+ * by a comment character and a blank.
+ */
+extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
+
+
+/**
+ * Add data of given length to the buffer.
+ */
+extern void strbuf_add(struct strbuf *, const void *, size_t);
+
+/**
+ * Add a NUL-terminated string to the buffer.
+ *
+ * NOTE: This function will *always* be implemented as an inline or a macro
+ * using strlen, meaning that this is efficient to write things like:
+ *
+ * ----
+ * strbuf_addstr(sb, "immediate string");
+ * ----
+ *
+ */
+static inline void strbuf_addstr(struct strbuf *sb, const char *s)
+{
+	strbuf_add(sb, s, strlen(s));
+}
+
+/**
+ * Copy the contents of another buffer at the end of the current one.
+ */
+static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
+{
+	strbuf_grow(sb, sb2->len);
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+
+/**
+ * Copy part of the buffer from a given position till a given length to the
+ * end of the buffer.
+ */
+extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
+
+/**
+ * This function can be used to expand a format string containing
+ * placeholders. To that end, it parses the string and calls the specified
+ * function for every percent sign found.
+ *
+ * The callback function is given a pointer to the character after the `%`
+ * and a pointer to the struct strbuf.  It is expected to add the expanded
+ * version of the placeholder to the strbuf, e.g. to add a newline
+ * character if the letter `n` appears after a `%`.  The function returns
+ * the length of the placeholder recognized and `strbuf_expand()` skips
+ * over it.
+ *
+ * The format `%%` is automatically expanded to a single `%` as a quoting
+ * mechanism; callers do not need to handle the `%` placeholder themselves,
+ * and the callback function will not be invoked for this placeholder.
+ *
+ * All other characters (non-percent and not skipped ones) are copied
+ * verbatim to the strbuf.  If the callback returned zero, meaning that the
+ * placeholder is unknown, then the percent sign is copied, too.
+ *
+ * In order to facilitate caching and to make it possible to give
+ * parameters to the callback, `strbuf_expand()` passes a context pointer,
+ * which can be used by the programmer of the callback as she sees fit.
+ */
+typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
+extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+
+/**
+ * Used as callback for `strbuf_expand()`, expects an array of
+ * struct strbuf_expand_dict_entry as context, i.e. pairs of
+ * placeholder and replacement string.  The array needs to be
+ * terminated by an entry with placeholder set to NULL.
+ */
+struct strbuf_expand_dict_entry {
+	const char *placeholder;
+	const char *value;
+};
+extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+
+/**
+ * Append the contents of one strbuf to another, quoting any
+ * percent signs ("%") into double-percents ("%%") in the
+ * destination. This is useful for literal data to be fed to either
+ * strbuf_expand or to the *printf family of functions.
+ */
+extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
+
+/**
+ * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
+ * 3.50 MiB).
+ */
+extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
+
+/**
+ * Add a formatted string to the buffer.
+ */
+__attribute__((format (printf,2,3)))
+extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+
+/**
+ * Add a formatted string prepended by a comment character and a
+ * blank to the buffer.
+ */
+__attribute__((format (printf, 2, 3)))
+extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+
+__attribute__((format (printf,2,0)))
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
+
+/**
+ * Read a given size of data from a FILE* pointer to the buffer.
+ *
+ * NOTE: The buffer is rewound if the read fails. If -1 is returned,
+ * `errno` must be consulted, like you would do for `read(3)`.
+ * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
+ * same behaviour as well.
+ */
+extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+
+/**
+ * Read the contents of a given file descriptor. The third argument can be
+ * used to give a hint about the file size, to avoid reallocs.  If read fails,
+ * any partial read is undone */
+extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+
+/**
+ * Read the contents of a file, specified by its path. The third argument
+ * can be used to give a hint about the file size, to avoid reallocs.
+ */
+extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+
+/**
+ * Read the target of a symbolic link, specified by its path.  The third
+ * argument can be used to give a hint about the size, to avoid reallocs.
+ */
+extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
+
+/**
+ * Set the buffer to the path of the current working directory.
+ */
+extern int strbuf_getcwd(struct strbuf *sb);
+
+/**
+ * Read a line from a FILE *, overwriting the existing contents
+ * of the strbuf. The second argument specifies the line
+ * terminator character, typically `'\n'`.
+ * Reading stops after the terminator or at EOF.  The terminator
+ * is removed from the buffer before returning.  Returns 0 unless
+ * there was nothing left before EOF, in which case it returns `EOF`.
+ */
+extern int strbuf_getline(struct strbuf *, FILE *, int);
+
+/**
+ * Like `strbuf_getline`, but keeps the trailing terminator (if
+ * any) in the buffer.
+ */
+extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
+
+/**
+ * Like `strbuf_getwholeline`, but operates on a file descriptor.
+ * It reads one character at a time, so it is very slow.  Do not
+ * use it unless you need the correct position in the file
+ * descriptor.
+ */
+extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
+
+/**
+ * Add a path to a buffer, converting a relative path to an
+ * absolute one in the process.  Symbolic links are not
+ * resolved.
+ */
+extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+
+/**
+ * Strip whitespace from a buffer. The second parameter controls if
+ * comments are considered contents to be removed or not.
+ */
+extern void stripspace(struct strbuf *buf, int skip_comments);
+
+/**
+ * Launch the user preferred editor to edit a file and fill the buffer
+ * with the file's contents upon the user completing their editing. The
+ * third argument can be used to set the environment which the editor is
+ * run in. If the buffer is NULL the editor is launched as usual but the
+ * file's contents are not read into the buffer upon completion.
+ */
+extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
 	if (strip_suffix_mem(sb->buf, &sb->len, suffix)) {
@@ -110,52 +495,6 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  */
 extern void strbuf_list_free(struct strbuf **);
 
-/*----- add data in your buffer -----*/
-static inline void strbuf_addch(struct strbuf *sb, int c)
-{
-	strbuf_grow(sb, 1);
-	sb->buf[sb->len++] = c;
-	sb->buf[sb->len] = '\0';
-}
-
-extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
-extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
-
-/* splice pos..pos+len with given data */
-extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
-                          const void *, size_t);
-
-extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
-
-extern void strbuf_add(struct strbuf *, const void *, size_t);
-static inline void strbuf_addstr(struct strbuf *sb, const char *s)
-{
-	strbuf_add(sb, s, strlen(s));
-}
-static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
-{
-	strbuf_grow(sb, sb2->len);
-	strbuf_add(sb, sb2->buf, sb2->len);
-}
-extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
-extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
-
-typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
-struct strbuf_expand_dict_entry {
-	const char *placeholder;
-	const char *value;
-};
-extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
-
-__attribute__((format (printf,2,3)))
-extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
-__attribute__((format (printf, 2, 3)))
-extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
-__attribute__((format (printf,2,0)))
-extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
-
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
 /*
@@ -170,28 +509,11 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 		strbuf_addch(sb, '\n');
 }
 
-extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
-/* XXX: if read fails, any partial read is undone */
-extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
-extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
-extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
-extern int strbuf_getcwd(struct strbuf *sb);
-
-extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
-extern int strbuf_getline(struct strbuf *, FILE *, int);
-extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
-
-extern void stripspace(struct strbuf *buf, int skip_comments);
-extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
-
 extern int strbuf_branchname(struct strbuf *sb, const char *name);
 extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
-extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
-
-extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
 __attribute__((format (printf,1,2)))
 extern int printf_ln(const char *fmt, ...);
-- 
2.2.0.454.g7eca6b7
