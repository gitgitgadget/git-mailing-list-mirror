From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Strbuf documentation: document most functions
Date: Tue,  3 Jun 2008 00:59:51 +0200
Message-ID: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3J1B-0001uP-SH
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbYFBW7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYFBW7t
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:59:49 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56013 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbYFBW7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:59:45 -0400
Received: from vmobile.example.net (dsl5401C7C1.pool.t-online.hu [84.1.199.193])
	by yugo.frugalware.org (Postfix) with ESMTP id E52E01DDC5B;
	Tue,  3 Jun 2008 00:59:42 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5ABCE18E2A7; Tue,  3 Jun 2008 00:59:51 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83590>

All functions in strbuf.h are documented, except strbuf_expand() and
launch_editor().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Actually this is a bit of request for help, I haven't figured out what
strbuf_expand() does, and I don't know the second argument of
launch_editor() is good for, but I *think* I'm familiar with the rest of
the functions, so here is an attempt to document them.

 Documentation/technical/api-strbuf.txt |  173 +++++++++++++++++++++++++++++++-
 1 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index a52e4f3..3879e0e 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -1,6 +1,175 @@
 strbuf API
 ==========
 
-Talk about <strbuf.h>
+strbuf's can be use in many ways: as a byte array, or to store arbitrary
+long, overflow safe strings.
 
-(Pierre, JC)
+strbufs has some invariants that are very important to keep in mind:
+
+. The `->buf` member is always malloc-ed, hence strbuf's can be used to
+  build complex strings/buffers whose final size isn't easily known.
++
+It is *not* legal to copy the `->buf` pointer away. `strbuf_detach()` is
+the operation that detachs a buffer from its shell while keeping the
+shell valid wrt its invariants.
+
+. The `->buf` member is a byte array that has at least `->len + 1` bytes
+  allocated. The extra byte is used to store a `'\0'`, allowing the
+  `->buf` member to be a valid C-string. Every strbuf function ensure this
+  invariant is preserved.
++
+NOTE: It is OK to "play" with the buffer directly if you work it that
+      way:
++
+----
+strbuf_grow(sb, SOME_SIZE);
+   ... Here, the memory array starting at sb->buf, and of length
+   ... strbuf_avail(sb) is all yours, and you are sure that
+   ... strbuf_avail(sb) is at least SOME_SIZE.
+strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+----
++
+Of course, SOME_OTHER_SIZE must be smaller or equal to strbuf_avail(sb).
++
+Doing so is safe, though if it has to be done in many places, adding the
+missing API to the strbuf module is the way to go.
++
+WARNING: Do _not_ assume that the area that is yours is of size `->alloc
+- 1` even if it's true in the current implementation. Alloc is somehow a
+"private" member that should not be messed with.
+
+Data structures
+---------------
+
+* `struct strbuf`
+
+This is string buffer structure. The `->len` variable can be used to
+determine the current length of the string, and `->buf` provides access
+to the string itself.
+
+Functions
+---------
+
+* Life cycle
+
+`strbuf_init`::
+
+	Initializes the structure. The second parameter can be zero or a bigger
+	number to allocate memory, in case you want to prevent further reallocs.
+
+`strbuf_release`::
+
+	Releases a string buffer and the memory it used. You should not use the
+	string buffer after using this function, unless you initialize it again.
+
+`strbuf_detach`::
+
+	Detaches the string from the string buffer. The function returns a
+	pointer to the old string and empties the buffer.
+
+`strbuf_attach`::
+
+	Attaches a string to a buffer. You should specify the string to attach,
+	the current length of the string and the amount of allocated memory.
+
+`strbuf_swap`::
+
+	Swaps the contents of two string buffers.
+
+* Related to the size of the buffer
+
+`strbuf_avail`::
+
+	Determines the amount of allocated but not used memory.
+
+`strbuf_grow`::
+
+	Allocated extra memory for the buffer.
+
+`strbuf_setlen`::
+
+	Sets the length of the buffer to a given value.
+
+`strbuf_reset`::
+
+	Empties the buffer by setting the size of it to zero.
+
+* Related to the contents of the buffer
+
+`strbuf_rtrim`::
+
+	Strip whitespace from the end of a string.
+
+`strbuf_cmp`::
+
+	Compares two buffers. Returns an integer less than, equal to, or greater
+	than zero if the first buffer is found, respectively, to be less than,
+	to match, or be greater than the second buffer.
+
+* Adding data to the buffer
+
+`strbuf_addch`::
+
+Adds a single character.
+
+`strbuf_insert`::
+
+	Insert data to the given position of the buffer. The remaining contents
+	will be shifted, not overwritten.
+
+`strbuf_remove`::
+
+	Remove given amount of data from a given position of the buffer.
+
+`strbuf_splice`::
+
+	Splice pos..pos+len with given data.
+
+`strbuf_add`::
+
+	Add data of given length to the buffer.
+
+`strbuf_addstr`::
+
+	Add a NULL-terminated string to the buffer.
+
+`strbuf_addbuf`::
+
+	Add an other buffer to the current one.
+
+`strbuf_adddup`::
+
+	Copy part of the buffer from a given position till a given length to the
+	end of the buffer.
+
+`strbuf_expand`::
+
+`strbuf_addf`::
+
+	Add a formatted string to the buffer.
+
+`strbuf_fread`::
+
+	Read a given size of data from a FILE* pointer to the buffer.
+
+`strbuf_read`::
+
+	Read the contents of a given file descriptor. The third argument can be
+	used to give a hint about the file, to avoid reallocs.
+
+`strbuf_read_file`::
+
+	Read the contents of a file, specified by its path. The third argument
+	can be used to give a hint about the file, to avoid reallocs.
+
+`strbuf_getline`::
+
+	Read a line from a FILE* pointer. The second argument specifies the line
+	terminator character, like `'\n'`.
+
+`stripspace`::
+
+	Strips whitespace from a buffer. The second parameter controls if
+	comments are considered contents to be removed or not.
+
+`launch_editor`::
-- 
1.5.6.rc0.dirty
