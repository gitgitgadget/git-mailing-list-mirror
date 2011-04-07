From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] magic pathspec: add tentative ":/path/from/top/level"
 pathspec support
Date: Wed,  6 Apr 2011 18:16:33 -0700
Message-ID: <1302138996-10006-2-git-send-email-gitster@pobox.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 03:16:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dq4-0006il-AA
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab1DGBQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:16:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab1DGBQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:16:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D11A4C1A
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oSzH
	pkSksg+VxzHe5t0+g0wlfRM=; b=ZGesRBCRnmU4ROVyZljJL/ml915IuQn4ia6s
	pchMLpZYmr40iviSJWoW5iqJnnX/5+nSyoWvPcBt19kBg7O70K541xK40HMFZceL
	WavwmWOJTf0V41FyEM4I/ixsKO8eYh0zh3iLhaqB9Bi3ZBZVUJV6aKPnHPHO5/xa
	oGHFLSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=v3ULEk
	G4+Bq83zFDp9y6m2V2jrh3e6Q/oAz9J/ks5rDJHS93VzidnrziqvSZD7SEwdUKMD
	FyAyPdDENkbF1xsIGYdda9xdZGZ9CynKhLsp7wobOp6chIV8+E7XTQO7gMe3t+Iv
	rEauJkxxvVcF2ZbXFhV6cJTI+UVurRA+GKDlE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A7314C19
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E5CC24C18 for
 <git@vger.kernel.org>; Wed,  6 Apr 2011 21:18:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1
In-Reply-To: <1302138996-10006-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F60BAC5A-60B4-11E0-9E73-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171035>

Support ":/" magic string that can be prefixed to a pathspec element to
say "this names the path from the top-level of the working tree", when
you are in the subdirectory.

For example, you should be able to say:

    $ edit Makefile ;# top-level
    $ cd Documentation
    $ edit git.txt ;# in the subdirectory

and then do one of three things, still inside the subdirectory:

    $ git add -u .  ;# add only Documentation/git.txt
    $ git add -u :/ ;# add everything, including paths outside Documentation
    $ git add -u    ;# whatever the default setting is.

To truly support magic pathspec, the API needs to be restructured so that
get_pathspec() and init_pathspec() are unified into one call.  Currently,
the former just prefixes the user supplied pathspec with the current
subdirectory path, and the latter takes the output from the former and
pre-parses them into a bit richer structure for easier handling.  They
should become a single API function that takes the current subdirectory
path and the remainder of argv[] (after parsing --options and revision
arguments from the command line) and returns an array of parsed pathspec
elements, and "magic" should become attributes of struct pathspec_item.

This patch implements only "top" magic because it is the only kind of
magic that can be hacked into the system without such a refactoring.
Other types of magic that are envisioned (e.g. "icase") needs to be able
to express more than what a simple string can encode and needs to wait.

The syntax for magic pathspec prefix is designed to be extensible yet
simple to type to invoke a simple magic like "from the top".  The parser
for the magic prefix is hooked into get_pathspec() function in this patch,
and it needs to be moved when we refactor the API.

But we have to start from somewhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.txt |   31 +++++++++++-
 setup.c                            |   98 +++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 33716a3..e51d7e6 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -277,7 +277,8 @@ This commit is referred to as a "merge commit", or sometimes just a
        Pattern used to specify paths.
 +
 Pathspecs are used on the command line of "git ls-files", "git
-ls-tree", "git grep", "git checkout", and many other commands to
+ls-tree", "git add", "git grep", "git diff", "git checkout",
+and many other commands to
 limit the scope of operations to some subset of the tree or
 worktree.  See the documentation of each command for whether
 paths are relative to the current directory or toplevel.  The
@@ -296,6 +297,34 @@ For example, Documentation/*.jpg will match all .jpg files
 in the Documentation subtree,
 including Documentation/chapter_1/figure_1.jpg.
 
++
+A pathspec that begins with a colon `:` has special meaning.  In the
+short form, the leading colon `:` is followed by zero or more "magic
+signature" letters (which optionally is terminated by another colon `:`),
+and the remainder is the pattern to match against the path. The optional
+colon that terminates the "magic signature" can be omitted if the pattern
+begins with a character that cannot be a "magic signature" and is not a
+colon.
++
+In the long form, the leading colon `:` is followed by a open
+parenthesis `(`, a comma-separated list of zero or more "magic words",
+and a close parentheses `)`, and the remainder is the pattern to match
+against the path.
++
+The "magic signature" consists of an ASCII symbol that is not
+alphanumeric.
++
+--
+top `/`;;
+	The magic word `top` (mnemonic: `/`) makes the pattern match
+	from the root of the working tree, even when you are running
+	the command from inside a subdirectory.
+--
++
+Currently only the slash `/` is recognized as the "magic signature",
+but it is envisioned that we will support more types of magic in later
+versions of git.
+
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) list
 	of the logical predecessor(s) in the line of development, i.e. its
diff --git a/setup.c b/setup.c
index 03cd84f..820ed05 100644
--- a/setup.c
+++ b/setup.c
@@ -126,6 +126,101 @@ void verify_non_filename(const char *prefix, const char *arg)
 	    "Use '--' to separate filenames from revisions", arg);
 }
 
+/*
+ * Magic pathspec
+ *
+ * NEEDSWORK: These need to be moved to dir.h or even to a new
+ * pathspec.h when we restructure get_pathspec() users to use the
+ * "struct pathspec" interface.
+ *
+ * Possible future magic semantics include stuff like:
+ *
+ *	{ PATHSPEC_NOGLOB, '!', "noglob" },
+ *	{ PATHSPEC_ICASE, '\0', "icase" },
+ *	{ PATHSPEC_RECURSIVE, '*', "recursive" },
+ *	{ PATHSPEC_REGEXP, '\0', "regexp" },
+ *
+ */
+#define PATHSPEC_FROMTOP    (1<<0)
+
+struct pathspec_magic {
+	unsigned bit;
+	char mnemonic; /* this cannot be ':'! */
+	const char *name;
+} pathspec_magic[] = {
+	{ PATHSPEC_FROMTOP, '/', "top" },
+};
+
+/*
+ * Take an element of a pathspec and check for magic signatures.
+ * Append the result to the prefix.
+ *
+ * For now, we only parse the syntax and throw out anything other than
+ * "top" magic.
+ *
+ * NEEDSWORK: This needs to be rewritten when we start migrating
+ * get_pathspec() users to use the "struct pathspec" interface.  For
+ * example, a pathspec element may be marked as case-insensitive, but
+ * the prefix part must always match literally, and a single stupid
+ * string cannot express such a case.
+ */
+const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
+{
+	unsigned magic = 0;
+	const char *copyfrom = elt;
+	int i;
+
+	if (elt[0] != ':') {
+		; /* nothing to do */
+	} else if (elt[1] == '(') {
+		/* longhand */
+		const char *nextat;
+		for (copyfrom = elt + 2;
+		     *copyfrom && *copyfrom != ')';
+		     copyfrom = nextat) {
+			size_t len = strcspn(copyfrom, ",)");
+			if (copyfrom[len] == ')')
+				nextat = copyfrom + len;
+			else
+				nextat = copyfrom + len + 1;
+			if (!len)
+				continue;
+			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (strlen(pathspec_magic[i].name) == len &&
+				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
+					magic |= pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <= i)
+				die("Invalid pathspec magic '%.*s' in '%s'",
+				    (int) len, copyfrom, elt);
+		}
+		if (*copyfrom == ')')
+			copyfrom++;
+	} else {
+		/* shorthand */
+		for (copyfrom = elt + 1;
+		     *copyfrom && *copyfrom != ':';
+		     copyfrom++) {
+			char ch = *copyfrom;
+			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
+				if (pathspec_magic[i].mnemonic == ch) {
+					magic |= pathspec_magic[i].bit;
+					break;
+				}
+			if (ARRAY_SIZE(pathspec_magic) <= i)
+				break;
+		}
+		if (*copyfrom == ':')
+			copyfrom++;
+	}
+
+	if (magic & PATHSPEC_FROMTOP)
+		return xstrdup(copyfrom);
+	else
+		return prefix_path(prefix, prefixlen, copyfrom);
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
@@ -147,8 +242,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
-		const char *p = prefix_path(prefix, prefixlen, *src);
-		*(dst++) = p;
+		*(dst++) = prefix_pathspec(prefix, prefixlen, *src);
 		src++;
 	}
 	*dst = NULL;
-- 
1.7.5.rc1
