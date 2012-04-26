From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 05:03:45 -0400
Message-ID: <20120426090345.GC22819@sigill.intra.peff.net>
References: <20120426085156.GB22819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:03:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNKcF-0004dj-89
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 11:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab2DZJDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 05:03:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45102
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab2DZJDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 05:03:48 -0400
Received: (qmail 12294 invoked by uid 107); 26 Apr 2012 09:04:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 05:04:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 05:03:45 -0400
Content-Disposition: inline
In-Reply-To: <20120426085156.GB22819@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196359>

On Thu, Apr 26, 2012 at 04:51:57AM -0400, Jeff King wrote:

> Problematic sites were found by grepping for '`.*[{\\]' and
> examined and fixed manually. The results were then verified
> by comparing the output of "html2text" on the set of
> generated html pages.

I tried comparing the raw HTML, but unfortunately the output was not
byte-for-byte identical. Using `~` in the new version puts a raw tilde
in the output, whereas using `{tilde}` in the old version inserted the
HTML character code (and ditto for the xml version from the manpages).

I also compared the rendered manpages and got similar results. They eve=
n
looked a little better, because the literal bits are bolded on the
terminal. Whereas with html2text, they are printed normally, which mean=
s
it is sometimes hard to see what is going on, even though in a real
browser the new version looks much better. However, there are many HTML
pages that do not end up as manpages, so I used the HTML version for
more complete coverage.

The diff between the old and new rendered versions is below (the first
hunk is confusingly large; it is caused by the fact that the original
version generated bogus HTML which confused html2text).

diff --git a/old/api-config.html b/new/api-config.html
index 8639ee8..e13c7dc 100644
--- a/old/api-config.html
+++ b/new/api-config.html
@@ -73,6 +73,37 @@
 To aid in parsing string values, the config API provides callbacks wit=
h a
 number of helper functions, including:
=20
+
+  git_config_int
+      Parse the string to an integer, including unit factors. Dies on =
error;
+      otherwise, returns the parsed result.
+
+  git_config_ulong
+      Identical to git_config_int, but for unsigned longs.
+
+  git_config_bool
+      Parse a string into a boolean value, respecting keywords like "t=
rue" and
+      "false". Integer values are converted into true/false values (wh=
en they
+      are non-zero or zero, respectively). Other values cause a die().=
 If
+      parsing is successful, the return value is the result.
+
+  git_config_bool_or_int
+      Same as git_config_bool, except that integers are returned as-is=
, and an
+      is_bool flag is unset.
+
+  git_config_maybe_bool
+      Same as git_config_bool, except that it returns -1 on error rath=
er than
+      dying.
+
+  git_config_string
+      Allocates and copies the value string into the dest parameter; i=
f no
+      string is given, prints an error message and returns -1.
+
+  git_config_pathname
+      Similar to git_config_string, but expands ~ or ~user into the us=
er=E2=80=99s home
+      directory when found at the beginning of the path.
+
+
 Include Directives
=20
 By default, the config parser does not respect include directives. How=
ever, a
diff --git a/old/api-parse-options.html b/new/api-parse-options.html
index 0d72807..9b75468 100644
--- a/old/api-parse-options.html
+++ b/new/api-parse-options.html
@@ -195,7 +195,7 @@
 * int_var is an integer variable,
 * str_var is a string variable (char *),
 * arg_str is the string that is shown as argument (e.g. "branch" will =
result in
-  <branch>). If set to NULL, three dots (=E2=80=A6) will be displayed.
+  <branch>). If set to NULL, three dots (...) will be displayed.
 * description is a short string to describe the effect of the option. =
It shall
   begin with a lower-case letter and a full stop (.) shall be omitted =
at the
   end.
diff --git a/old/api-strbuf.html b/new/api-strbuf.html
index 97eeacb..59f7157 100644
--- a/old/api-strbuf.html
+++ b/new/api-strbuf.html
@@ -22,7 +22,7 @@
      However, it is totally safe to modify anything in the string poin=
ted by
      the buf member, between the indices 0 and len-1 (inclusive).
   2. The buf member is a byte array that has at least len + 1 bytes al=
located.
-     The extra byte is used to store a \0, allowing the buf member to =
be a
+     The extra byte is used to store a '\0', allowing the buf member t=
o be a
      valid C-string. Every strbuf function ensure this invariant is pr=
eserved.
=20
      Note It is OK to "play" with the buffer directly if you work it t=
his way:
@@ -32,9 +32,9 @@
        strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
=20
=20
-       1. Here, the memory array starting at sb=E2=86=92buf, and of le=
ngth strbuf_avail
-          (sb) is all yours, and you can be sure that strbuf_avail(sb)=
 is at
-          least SOME_SIZE.
+       1. Here, the memory array starting at sb->buf, and of length
+          strbuf_avail(sb) is all yours, and you can be sure that strb=
uf_avail
+          (sb) is at least SOME_SIZE.
=20
           Note SOME_OTHER_SIZE must be smaller or equal to strbuf_avai=
l(sb).
=20
@@ -229,7 +229,7 @@
   strbuf_getline
       Read a line from a FILE *, overwriting the existing contents of =
the
       strbuf. The second argument specifies the line terminator charac=
ter,
-      typically \n. Reading stops after the terminator or at EOF. The
+      typically '\n'. Reading stops after the terminator or at EOF. Th=
e
       terminator is removed from the buffer before returning. Returns =
0 unless
       there was nothing left before EOF, in which case it returns EOF.
=20
diff --git a/old/api-string-list.html b/new/api-string-list.html
index d66202f..f14974b 100644
--- a/old/api-string-list.html
+++ b/new/api-string-list.html
@@ -77,7 +77,7 @@
         existing item returned.
         Since this function uses xrealloc() (which die()s if it fails)=
 if the
         list needs to grow, it is safe not to check the pointer. I.e. =
you may
-        write string_list_insert(=E2=80=A6)=E2=86=92util =3D =E2=80=A6=
;.
+        write string_list_insert(...)->util =3D ...;.
=20
     string_list_lookup
         Look up a given string in the string_list, returning the conta=
ining
diff --git a/old/api-tree-walking.html b/new/api-tree-walking.html
index 586a9e7..566dc1c 100644
--- a/old/api-tree-walking.html
+++ b/new/api-tree-walking.html
@@ -80,7 +80,7 @@
=20
   tree_entry_extract
       Decode the entry currently being visited (the one pointed to by
-      tree_desc=E2=80=99s entry member) and return the sha1 of the ent=
ry. The pathp and
+      tree_desc's entry member) and return the sha1 of the entry. The =
pathp and
       modep arguments are set to the entry=E2=80=99s pathname and mode=
 respectively.
=20
   get_tree_entry
diff --git a/old/git-clean.html b/new/git-clean.html
index 0bd14e6..c8003e7 100644
--- a/old/git-clean.html
+++ b/new/git-clean.html
@@ -21,7 +21,7 @@
 Normally, only files unknown to git are removed, but if the -x option =
is
 specified, ignored files are also removed. This can, for example, be u=
seful to
 remove all build products.
-If any optional <path>=E2=80=A6 arguments are given, only those paths =
are affected.
+If any optional <path>... arguments are given, only those paths are af=
fected.
=20
 OPTIONS
=20
diff --git a/old/git-commit.html b/new/git-commit.html
index 6e4bbf4..252c662 100644
--- a/old/git-commit.html
+++ b/new/git-commit.html
@@ -38,7 +38,7 @@
      removed from the working tree, and then perform the actual commit=
;
   5. by using the --interactive or --patch switches with the commit co=
mmand to
      decide one by one which files or hunks should be part of the comm=
it,
-     before finalizing the operation. See the `Interactive Mode` secti=
on of
+     before finalizing the operation. See the =E2=80=9CInteractive Mod=
e=E2=80=9D section of
      git-add(1) to learn how to operate these modes.
=20
 The --dry-run option can be used to obtain a summary of what is includ=
ed by any
diff --git a/old/git-config.html b/new/git-config.html
index d6dc22d..2c35841 100644
--- a/old/git-config.html
+++ b/new/git-config.html
@@ -1091,7 +1091,7 @@
       A comma separated list of --dirstat parameters specifying the de=
fault
       behavior of the --dirstat option to git-diff(1)` and friends. Th=
e
       defaults can be overridden on the command line (using --
-      dirstat=3D<param1,param2,=E2=80=A6>). The fallback defaults (whe=
n not changed by
+      dirstat=3D<param1,param2,...>). The fallback defaults (when not =
changed by
       diff.dirstat) are changes,noncumulative,3. The following paramet=
ers are
       available:
=20
diff --git a/old/git-diff-files.html b/new/git-diff-files.html
index e7ab6b9..ffb2826 100644
--- a/old/git-diff-files.html
+++ b/new/git-diff-files.html
@@ -63,7 +63,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
@@ -169,9 +169,9 @@
             Highlight changed words using only colors. Implies --color=
=2E
=20
         plain
-            Show words as [-removed-] and {added}. Makes no attempts t=
o escape
-            the delimiters if they appear in the input, so the output =
may be
-            ambiguous.
+            Show words as [-removed-] and {+added+}. Makes no attempts=
 to
+            escape the delimiters if they appear in the input, so the =
output
+            may be ambiguous.
=20
         porcelain
             Use a special line-based format intended for script consum=
ption.
diff --git a/old/git-diff-index.html b/new/git-diff-index.html
index caef350..6135834 100644
--- a/old/git-diff-index.html
+++ b/new/git-diff-index.html
@@ -64,7 +64,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
@@ -170,9 +170,9 @@
             Highlight changed words using only colors. Implies --color=
=2E
=20
         plain
-            Show words as [-removed-] and {added}. Makes no attempts t=
o escape
-            the delimiters if they appear in the input, so the output =
may be
-            ambiguous.
+            Show words as [-removed-] and {+added+}. Makes no attempts=
 to
+            escape the delimiters if they appear in the input, so the =
output
+            may be ambiguous.
=20
         porcelain
             Use a special line-based format intended for script consum=
ption.
diff --git a/old/git-diff-tree.html b/new/git-diff-tree.html
index 75baadf..99720ee 100644
--- a/old/git-diff-tree.html
+++ b/new/git-diff-tree.html
@@ -66,7 +66,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
@@ -172,9 +172,9 @@
             Highlight changed words using only colors. Implies --color=
=2E
=20
         plain
-            Show words as [-removed-] and {added}. Makes no attempts t=
o escape
-            the delimiters if they appear in the input, so the output =
may be
-            ambiguous.
+            Show words as [-removed-] and {+added+}. Makes no attempts=
 to
+            escape the delimiters if they appear in the input, so the =
output
+            may be ambiguous.
=20
         porcelain
             Use a special line-based format intended for script consum=
ption.
@@ -424,8 +424,9 @@
=20
   <path>=E2=80=A6
       If provided, the results are limited to a subset of files matchi=
ng one of
-      these prefix strings. i.e., file matches /^<pattern1>|<pattern2>=
|=E2=80=A6/ Note
-      that this parameter does not provide any wildcard or regexp feat=
ures.
+      these prefix strings. i.e., file matches /^<pattern1>|<pattern2>=
|.../
+      Note that this parameter does not provide any wildcard or regexp
+      features.
=20
   -r
       recurse into sub-trees
diff --git a/old/git-diff.html b/new/git-diff.html
index c1a933b..46d7810 100644
--- a/old/git-diff.html
+++ b/new/git-diff.html
@@ -111,7 +111,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
@@ -219,9 +219,9 @@
             Highlight changed words using only colors. Implies --color=
=2E
=20
         plain
-            Show words as [-removed-] and {added}. Makes no attempts t=
o escape
-            the delimiters if they appear in the input, so the output =
may be
-            ambiguous.
+            Show words as [-removed-] and {+added+}. Makes no attempts=
 to
+            escape the delimiters if they appear in the input, so the =
output
+            may be ambiguous.
=20
         porcelain
             Use a special line-based format intended for script consum=
ption.
diff --git a/old/git-filter-branch.html b/new/git-filter-branch.html
index e26f859..3502e5c 100644
--- a/old/git-filter-branch.html
+++ b/new/git-filter-branch.html
@@ -86,7 +86,7 @@
   --index-filter <command>
       This is the filter for rewriting the index. It is similar to the=
 tree
       filter but does not check out the tree, which makes it much fast=
er.
-      Frequently used with git rm --cached --ignore-unmatch =E2=80=A6,=
 see EXAMPLES
+      Frequently used with git rm --cached --ignore-unmatch ..., see E=
XAMPLES
       below. For hairy cases, see git-update-index(1).
=20
   --parent-filter <command>
diff --git a/old/git-format-patch.html b/new/git-format-patch.html
index 583e800..2364139 100644
--- a/old/git-format-patch.html
+++ b/new/git-format-patch.html
@@ -93,7 +93,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
diff --git a/old/git-help.html b/new/git-help.html
index aec06f2..dc33369 100644
--- a/old/git-help.html
+++ b/new/git-help.html
@@ -23,7 +23,7 @@
 If a git command is named, a manual page for that command is brought u=
p. The
 man program is used by default for this purpose, but this can be overr=
idden by
 other options or configuration variables.
-Note that git --help =E2=80=A6 is identical to git help =E2=80=A6 beca=
use the former is
+Note that git --help ... is identical to git help ... because the form=
er is
 internally converted into the latter.
=20
 OPTIONS
diff --git a/old/git-log.html b/new/git-log.html
index b6d4648..aa01e94 100644
--- a/old/git-log.html
+++ b/new/git-log.html
@@ -228,7 +228,7 @@
   --right-only
       List only commits on the respective side of a symmetric range, i=
=2Ee. only
       those which would be marked < resp. > by --left-right.
-      For example, --cherry-pick --right-only A=E2=80=A6B omits those =
commits from B
+      For example, --cherry-pick --right-only A...B omits those commit=
s from B
       which are in A or are patch-equivalent to a commit in A. In othe=
r words,
       this lists the + commits from git cherry A B. More precisely, --=
cherry-
       pick --right-only --no-merges gives the exact list.
@@ -237,7 +237,7 @@
       A synonym for --right-only --cherry-mark --no-merges; useful to =
limit the
       output to the commits on our side and mark those that have been =
applied
       to the other side of a forked history with git log --cherry
-      upstream=E2=80=A6mybranch, similar to git cherry upstream mybran=
ch.
+      upstream...mybranch, similar to git cherry upstream mybranch.
=20
   -g
=20
@@ -412,16 +412,16 @@
   --simplify-merges
       First, build a history graph in the same way that --full-history=
 with
       parent rewriting does (see above).
-      Then simplify each commit =E2=80=98C` to its replacement C=E2=80=
=99 in the final history
+      Then simplify each commit C to its replacement C' in the final h=
istory
       according to the following rules:
=20
-      * Set =E2=80=98C=E2=80=99` to C.
-      * Replace each parent =E2=80=98P` of C=E2=80=99 with its simplif=
ication =E2=80=98P=E2=80=99`. In the
-        process, drop parents that are ancestors of other parents, and=
 remove
+      * Set C' to C.
+      * Replace each parent P of C' with its simplification P'. In the=
 process,
+        drop parents that are ancestors of other parents, and remove
         duplicates.
-      * If after this parent rewriting, =E2=80=98C=E2=80=99` is a root=
 or merge commit (has
-        zero or >1 parents), a boundary commit, or !TREESAME, it remai=
ns.
-        Otherwise, it is replaced with its only parent.
+      * If after this parent rewriting, C' is a root or merge commit (=
has zero
+        or >1 parents), a boundary commit, or !TREESAME, it remains. O=
therwise,
+        it is replaced with its only parent.
=20
       The effect of this is best shown by way of comparing to --full-h=
istory
       with parent rewriting. The example turns into:
@@ -916,7 +916,7 @@
       (affects all commands generating a stat graph) or by setting
       diff.statGraphWidth=3D<width> (does not affect git format-patch)=
=2E By giving
       a third parameter <count>, you can limit the output to the first=
 <count>
-      lines, followed by =E2=80=A6 if there are more.
+      lines, followed by ... if there are more.
       These parameters can also be set individually with --stat-width=3D=
<width>,
       --stat-name-width=3D<name-width> and --stat-count=3D<count>.
=20
@@ -1023,9 +1023,9 @@
             Highlight changed words using only colors. Implies --color=
=2E
=20
         plain
-            Show words as [-removed-] and {added}. Makes no attempts t=
o escape
-            the delimiters if they appear in the input, so the output =
may be
-            ambiguous.
+            Show words as [-removed-] and {+added+}. Makes no attempts=
 to
+            escape the delimiters if they appear in the input, so the =
output
+            may be ambiguous.
=20
         porcelain
             Use a special line-based format intended for script consum=
ption.
diff --git a/old/git-merge.html b/new/git-merge.html
index bec1b50..bd7de11 100644
--- a/old/git-merge.html
+++ b/new/git-merge.html
@@ -41,7 +41,7 @@
=20
 The second syntax (<msg> HEAD <commit>=E2=80=A6) is supported for hist=
orical reasons.
 Do not use it from the command line or in new scripts. It is the same =
as git
-merge -m <msg> <commit>=E2=80=A6.
+merge -m <msg> <commit>....
 The third syntax ("git merge --abort") can only be run after the merge=
 has
 resulted in conflicts. git merge --abort will abort the merge process =
and try
 to reconstruct the pre-merge state. However, if there were uncommitted=
 changes
diff --git a/old/git-rev-list.html b/new/git-rev-list.html
index ae20275..2946ce5 100644
--- a/old/git-rev-list.html
+++ b/new/git-rev-list.html
@@ -259,7 +259,7 @@
   --right-only
       List only commits on the respective side of a symmetric range, i=
=2Ee. only
       those which would be marked < resp. > by --left-right.
-      For example, --cherry-pick --right-only A=E2=80=A6B omits those =
commits from B
+      For example, --cherry-pick --right-only A...B omits those commit=
s from B
       which are in A or are patch-equivalent to a commit in A. In othe=
r words,
       this lists the + commits from git cherry A B. More precisely, --=
cherry-
       pick --right-only --no-merges gives the exact list.
@@ -268,7 +268,7 @@
       A synonym for --right-only --cherry-mark --no-merges; useful to =
limit the
       output to the commits on our side and mark those that have been =
applied
       to the other side of a forked history with git log --cherry
-      upstream=E2=80=A6mybranch, similar to git cherry upstream mybran=
ch.
+      upstream...mybranch, similar to git cherry upstream mybranch.
=20
   -g
=20
@@ -443,16 +443,16 @@
   --simplify-merges
       First, build a history graph in the same way that --full-history=
 with
       parent rewriting does (see above).
-      Then simplify each commit =E2=80=98C` to its replacement C=E2=80=
=99 in the final history
+      Then simplify each commit C to its replacement C' in the final h=
istory
       according to the following rules:
=20
-      * Set =E2=80=98C=E2=80=99` to C.
-      * Replace each parent =E2=80=98P` of C=E2=80=99 with its simplif=
ication =E2=80=98P=E2=80=99`. In the
-        process, drop parents that are ancestors of other parents, and=
 remove
+      * Set C' to C.
+      * Replace each parent P of C' with its simplification P'. In the=
 process,
+        drop parents that are ancestors of other parents, and remove
         duplicates.
-      * If after this parent rewriting, =E2=80=98C=E2=80=99` is a root=
 or merge commit (has
-        zero or >1 parents), a boundary commit, or !TREESAME, it remai=
ns.
-        Otherwise, it is replaced with its only parent.
+      * If after this parent rewriting, C' is a root or merge commit (=
has zero
+        or >1 parents), a boundary commit, or !TREESAME, it remains. O=
therwise,
+        it is replaced with its only parent.
=20
       The effect of this is best shown by way of comparing to --full-h=
istory
       with parent rewriting. The example turns into:
diff --git a/old/git-status.html b/new/git-status.html
index 0439d84..0040808 100644
--- a/old/git-status.html
+++ b/new/git-status.html
@@ -98,7 +98,7 @@
=20
   XY PATH1 -> PATH2
=20
-where PATH1 is the path in the HEAD, and the ` -> PATH2` part is shown=
 only
+where PATH1 is the path in the HEAD, and the " -> PATH2" part is shown=
 only
 when PATH1 corresponds to a different path in the index/worktree (i.e.=
 the file
 is renamed). The XY is a two-letter status code.
 The fields (including the ->) are separated from each other by a singl=
e space.
diff --git a/old/git-update-index.html b/new/git-update-index.html
index bbf44ad..95c8b1f 100644
--- a/old/git-update-index.html
+++ b/new/git-update-index.html
@@ -233,7 +233,7 @@
 unset, use --no-assume-unchanged. To see which files have the "assume
 unchanged" bit set, use git ls-files -v (see git-ls-files(1)).
 The command looks at core.ignorestat configuration variable. When this=
 is true,
-paths updated with git update-index paths=E2=80=A6 and paths updated w=
ith other git
+paths updated with git update-index paths... and paths updated with ot=
her git
 commands that update both index and working tree (e.g. git apply --ind=
ex, git
 checkout-index -u, and git read-tree -u) are automatically marked as "=
assume
 unchanged". Note that "assume unchanged" bit is not set if git update-=
index --
diff --git a/old/git.html b/new/git.html
index 1886f0f..7f4a992 100644
--- a/old/git.html
+++ b/new/git.html
@@ -45,8 +45,8 @@
       git command is named this option will bring up the manual page f=
or that
       command.
       Other options are available to control how the manual page is di=
splayed.
-      See git-help(1) for more information, because git --help =E2=80=A6=
 is converted
-      internally into git help =E2=80=A6.
+      See git-help(1) for more information, because git --help ... is =
converted
+      internally into git help ....
=20
   -c <name>=3D<value>
       Pass a configuration parameter to the command. The value given w=
ill
diff --git a/old/gitcore-tutorial.html b/new/gitcore-tutorial.html
index 6e29915..873c0d7 100644
--- a/old/gitcore-tutorial.html
+++ b/new/gitcore-tutorial.html
@@ -139,7 +139,8 @@
   .git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238
   .git/objects/f2/4c74a2e500f5ee1332c86b94199f52b1d1d962
=20
-which correspond with the objects with names of 557db=E2=80=A6 and f24=
c7=E2=80=A6 respectively.
+which correspond with the objects with names of 557db... and f24c7...
+respectively.
 If you want to, you can use git cat-file to look at those objects, but=
 you=E2=80=99ll
 have to use the object name, not the filename of the object:
=20
@@ -240,7 +241,7 @@
   8988da15d077d4829fc51d8544c097def6644dbb
=20
 which is another incomprehensible object name. Again, if you want to, =
you can
-use git cat-file -t 8988d=E2=80=A6 to see that this time the object is=
 not a "blob"
+use git cat-file -t 8988d... to see that this time the object is not a=
 "blob"
 object, but a "tree" object (you can also use git cat-file to actually=
 output
 the raw object contents, but you=E2=80=99ll see mainly a binary mess, =
so that=E2=80=99s less
 interesting).
@@ -833,9 +834,9 @@
       Downloader from http and https URL first obtains the topmost com=
mit
       object name from the remote site by looking at the specified ref=
name
       under repo.git/refs/ directory, and then tries to obtain the com=
mit
-      object by downloading from repo.git/objects/xx/xxx=E2=80=A6 usin=
g the object name
-      of that commit object. Then it reads the commit object to find o=
ut its
-      parent commits and the associate tree object; it repeats this pr=
ocess
+      object by downloading from repo.git/objects/xx/xxx... using the =
object
+      name of that commit object. Then it reads the commit object to f=
ind out
+      its parent commits and the associate tree object; it repeats thi=
s process
       until it gets all the necessary objects. Because of this behavio=
r, they
       are sometimes also called commit walkers.
       The commit walkers are sometimes also called dumb transports, be=
cause
diff --git a/old/gitcredentials.html b/new/gitcredentials.html
index 30361db..4fca225 100644
--- a/old/gitcredentials.html
+++ b/new/gitcredentials.html
@@ -120,7 +120,7 @@
 CONFIGURATION OPTIONS
=20
 Options for a credential context can be configured either in credentia=
l.*
-(which applies to all credentials), or credential.<url>.\*, where <url=
> matches
+(which applies to all credentials), or credential.<url>.*, where <url>=
 matches
 the context as described above.
 The following options are available in either location:
=20
diff --git a/old/gitweb.conf.html b/new/gitweb.conf.html
index 1fbacdf..7457704 100644
--- a/old/gitweb.conf.html
+++ b/new/gitweb.conf.html
@@ -658,9 +658,9 @@
   forks
       If this feature is enabled, gitweb considers projects in subdire=
ctories
       of project root (basename) to be forks of existing projects. For=
 each
-      project =E2=80=98$projname.git`, projects in the $projname/ dire=
ctory and its
+      project $projname.git, projects in the $projname/ directory and =
its
       subdirectories will not be shown in the main projects list. Inst=
ead, a
-      '+=E2=80=99 mark is shown next to $projname, which links to a "f=
orks" view that
+      '+' mark is shown next to $projname, which links to a "forks" vi=
ew that
       lists all the forks (all projects in $projname/ subdirectory).
       Additionally a "forks" view for a project is linked from project=
 summary
       page.
diff --git a/old/user-manual.html b/new/user-manual.html
index cbbf1f3..ab930e8 100644
--- a/old/user-manual.html
+++ b/new/user-manual.html
@@ -3480,8 +3480,8 @@
 in cache.h), and that there are just a couple of object types (blobs, =
trees,
 commits and tags) which inherit their common structure from struct obj=
ect,
 which is their first member (and thus, you can cast e.g. (struct objec=
t
-*)commit to achieve the same as &amp;commit=E2=86=92object, i.e. get a=
t the object name
-and flags).
+*)commit to achieve the same as &amp;commit->object, i.e. get at the o=
bject
+name and flags).
 Now is a good point to take a break to let this information sink in.
 Next step: get familiar with the object naming. Read the_section_calle=
d_=E2=80=9CNaming
 commits=E2=80=9D. There are quite a few ways to name an object (and no=
t only
