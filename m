From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] contrib: add git-jump script
Date: Fri, 21 Oct 2011 13:28:04 -0400
Message-ID: <20111021172804.GB24417@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 19:28:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHItB-0005kj-N8
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab1JUR2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 13:28:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38973
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab1JUR2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:28:07 -0400
Received: (qmail 21822 invoked by uid 107); 21 Oct 2011 17:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Oct 2011 13:28:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2011 13:28:04 -0400
Content-Disposition: inline
In-Reply-To: <20111021172239.GA22289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184071>

This is a small script for helping your editor jump to
specific points of interest. See the README for details.

Signed-off-by: Jeff King <peff@peff.net>
---
This fixes a minor bug in v1 where doing "git jump merge" would display
the usage message when there were unmerged files, but none of the files
contained conflict markers (i.e., you had already fixed them up).

 contrib/git-jump/README   |   92 +++++++++++++++++++++++++++++++++++++++++++++
 contrib/git-jump/git-jump |   69 +++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 contrib/git-jump/README
 create mode 100755 contrib/git-jump/git-jump

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
new file mode 100644
index 0000000..1cebc32
--- /dev/null
+++ b/contrib/git-jump/README
@@ -0,0 +1,92 @@
+git-jump
+========
+
+Git-jump is a script for helping you jump to "interesting" parts of your
+project in your editor. It works by outputting a set of interesting
+spots in the "quickfix" format, which editors like vim can use as a
+queue of places to visit (this feature is usually used to jump to errors
+produced by a compiler). For example, given a diff like this:
+
+------------------------------------
+diff --git a/foo.c b/foo.c
+index a655540..5a59044 100644
+--- a/foo.c
++++ b/foo.c
+@@ -1,3 +1,3 @@
+ int main(void) {
+-  printf("hello word!\n");
++  printf("hello world!\n");
+ }
+-----------------------------------
+
+git-jump will feed this to the editor:
+
+-----------------------------------
+foo.c:2: printf("hello word!\n");
+-----------------------------------
+
+Obviously this trivial case isn't that interesting; you could just open
+`foo.c` yourself. But when you have many changes scattered across a
+project, you can use the editor's support to "jump" from point to point.
+
+Git-jump can generate three types of interesting lists:
+
+  1. The beginning of any diff hunks.
+
+  2. The beginning of any merge conflict markers.
+
+  3. Any grep matches.
+
+
+Using git-jump
+--------------
+
+To use it, just drop git-jump in your PATH, and then invoke it like
+this:
+
+--------------------------------------------------
+# jump to changes not yet staged for commit
+git jump diff
+
+# jump to changes that are staged for commit; you can give
+# arbitrary diff options
+git jump diff --cached
+
+# jump to merge conflicts
+git jump merge
+
+# jump to all instances of foo_bar
+git jump grep foo_bar
+
+# same as above, but case-insensitive; you can give
+# arbitrary grep options
+git jump grep -i foo_bar
+--------------------------------------------------
+
+
+Related Programs
+----------------
+
+You can accomplish some of the same things with individual tools. For
+example, you can use `git mergetool` to start vimdiff on each unmerged
+file. `git jump merge` is for the vim-wielding luddite who just wants to
+jump straight to the conflict text with no fanfare.
+
+As of git v1.7.2, `git grep` knows the `--open-files-in-pager` option,
+which does something similar to `git jump grep`. However, it is limited
+to positioning the cursor to the correct line in only the first file,
+leaving you to locate subsequent hits in that file or other files using
+the editor or pager. By contrast, git-jump provides the editor with a
+complete list of files and line numbers for each match.
+
+
+Limitations
+-----------
+
+This scripts was written and tested with vim. Given that the quickfix
+format is the same as what gcc produces, I expect emacs users have a
+similar feature for iterating through the list, but I know nothing about
+how to activate it.
+
+The shell snippets to generate the quickfix lines will almost certainly
+choke on filenames with exotic characters (like newlines).
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
new file mode 100755
index 0000000..a33674e
--- /dev/null
+++ b/contrib/git-jump/git-jump
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+usage() {
+	cat <<\EOF
+usage: git jump <mode> [<args>]
+
+Jump to interesting elements in an editor.
+The <mode> parameter is one of:
+
+diff: elements are diff hunks. Arguments are given to diff.
+
+merge: elements are merge conflicts. Arguments are ignored.
+
+grep: elements are grep hits. Arguments are given to grep.
+EOF
+}
+
+open_editor() {
+	editor=`git var GIT_EDITOR`
+	eval "$editor -q \$1"
+}
+
+mode_diff() {
+	git diff --relative "$@" |
+	perl -ne '
+	if (m{^\+\+\+ b/(.*)}) { $file = $1; next }
+	defined($file) or next;
+	if (m/^@@ .*\+(\d+)/) { $line = $1; next }
+	defined($line) or next;
+	if (/^ /) { $line++; next }
+	if (/^[-+]\s*(.*)/) {
+		print "$file:$line: $1\n";
+		$line = undef;
+	}
+	'
+}
+
+mode_merge() {
+	git ls-files -u |
+	perl -pe 's/^.*?\t//' |
+	sort -u |
+	while IFS= read fn; do
+		grep -Hn '^<<<<<<<' "$fn"
+	done
+}
+
+# Grep -n generates nice quickfix-looking lines by itself,
+# but let's clean up extra whitespace, so they look better if the
+# editor shows them to us in the status bar.
+mode_grep() {
+	git grep -n "$@" |
+	perl -pe '
+	s/[ \t]+/ /g;
+	s/^ *//;
+	'
+}
+
+if test $# -lt 1; then
+	usage >&2
+	exit 1
+fi
+mode=$1; shift
+
+trap 'rm -f "$tmp"' 0 1 2 3 15
+tmp=`mktemp -t git-jump.XXXXXX` || exit 1
+type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+"mode_$mode" "$@" >"$tmp"
+test -s "$tmp" || exit 0
+open_editor "$tmp"
-- 
1.7.7.rc1.28.g5dd2ee
