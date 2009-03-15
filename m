From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
Date: Sun, 15 Mar 2009 06:30:52 -0500
Message-ID: <1237116652-24716-1-git-send-email-chris_johnsen@pobox.com>
References: <1237085349-14824-1-git-send-email-chris_johnsen@pobox.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 15 12:32:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LioaG-000874-ED
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 12:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbZCOLbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 07:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbZCOLbS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 07:31:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbZCOLbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 07:31:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E55C6788;
	Sun, 15 Mar 2009 07:31:11 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.203.162.168]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 7BBD46784; Sun, 15 Mar 2009 07:31:06 -0400 (EDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237085349-14824-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: C8F9A8B8-1154-11DE-8A2E-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113280>

On 2009 Mar 14, at 21:49, Chris Johnsen wrote:
> On 2009 Mar 14, at 15:56, Jeff King wrote:
> > On Sat, Mar 14, 2009 at 04:34:34PM -0400, Jeff King wrote:
> > > The question is how it _should_ be rendered. Monospace isn't really
> > > useful for terminals. Maybe simply putting quotation marks around it
> > > would cover all situations (I'm worried it will look funny for
> > > single-word instances).
> >
> > And here's a patch that does that; skimming through the output it
> > doesn't look too bad. What do you guys think?
> >
> > ---
>
> The presentation seems OK to me. I thought of two issues:
>
> 1) literals that contain a double quote
>
> 	$ git grep '`[^`]*"[^`]`' | cat
> 	config.txt:You can have `[section]` if you have `[section "subsection"]`, but you
>
>    There might be a better regexp to find these, I did not think
>    about it too long. The above "hit" seems like a reasonable

Of course the above regexp fails miserably since there are many
other instances of `..."...` in the documentation. I eventually
ended up using this one:

	git grep -e "\`.*['\"]" -e "['\"].*\`" master -- Documentation

It catches a lot more than just "`...`" and `"..."`, but I tried
to plow through it all. I turns out that there are lots of
instances of double quotes inside or just outside backticks in
the documentation.

I edited out all the ones that did not seem to be meaningful. But
there are still many places where there is a meaningful double
quote inside a literal section. So, I think the workaround of
wrapping double quotes around manpage-destined literal sections
may not work well.

A patch to remove much of the extra quoting/emphasis
around/inside literal sections follows, but it will likely
negatively affect the manpages unless we can find a different way
to render the literal sections in manpages. It seems likely that
this patch should just be "parked" in the list archives until
someone can work out a way to emphasize the literal sections for
manpages.

The '`...`' style used in parts of config.txt yields underlined
text in my terminal-based view of the manpage. If underlining (or
whatever other formatting) could be applied to manpage-destined
literal text, that might work out better. I have not yet searched
for a way to make that happen through XSL. It might be as simple
as taking Peff's approach and using \fI and \fR instead of double
quotes (codes taken from other text that shows up as underlined
on my system; also the more I look into the asciidoc/docbook
stuff, the less I think anything involving more than one version
can be "simple").

-- >8 --
Subject: [PATCH] Documentation: remove extra quoting/emphasis around literal texts

If literal text (asciidoc `...`) can be rendered in a differently from
normal text for each output format (man, HTML), then we do not need
extra quotes or other wrapping around inline literal text segments.

config.txt

  Change '`...`' to `...`. In asciidoc, the single quotes provide
  emphasis, literal text should be distintive enough.

  Change "`...`" to `...`. These double quotes do not work if present
  in the described config value, so drop them.

git-checkout.txt

  Change "`...`" to `...` or `"..."`. All instances are command line
  argument examples. One "`-`" becomes `-`. Two others are involve
  curly braces, so move the double quotes inside the literal region to
  indicate that they might need to be quoted on the command line of
  certain shells (tcsh).

git-merge.txt

  Change "`...`" to `...`. All instances are used to describe merge
  conflict markers. The quotes should are not important.

git-rev-parse.txt

  Change "`...`" to `...`. All instances are around command line
  arguments where no in-shell quoting should be necessary.

gitcli.txt

  Change `"..."` to `...`. All instances are around command line
  examples or single command arguments. They do not semanticly belong
  inside the literal text, and they are not needed outside it.

glossary-content.txt
user-manual.txt

  Change "`...`" to `...`. All instances were around command lines.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
---
 Documentation/config.txt           |   24 ++++++++++++------------
 Documentation/git-checkout.txt     |    4 ++--
 Documentation/git-merge.txt        |    6 +++---
 Documentation/git-rev-parse.txt    |    8 ++++----
 Documentation/gitcli.txt           |   24 ++++++++++++------------
 Documentation/glossary-content.txt |    2 +-
 Documentation/user-manual.txt      |    6 +++---
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 14f861a..11f37d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -25,7 +25,7 @@ blank lines are ignored.
 The file consists of sections and variables.  A section begins with
 the name of the section in square brackets and continues until the next
 section begins.  Section names are not case sensitive.  Only alphanumeric
-characters, '`-`' and '`.`' are allowed in section names.  Each variable
+characters, `-` and `.` are allowed in section names.  Each variable
 must belong to some section, which means that there must be section
 header before first setting of a variable.
 
@@ -39,7 +39,7 @@ in the section header, like in example below:
 --------
 
 Subsection names can contain any characters except newline (doublequote
-'`"`' and backslash have to be escaped as '`\"`' and '`\\`',
+`"` and backslash have to be escaped as `\"` and `\\`,
 respectively) and are case sensitive.  Section header cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
@@ -53,7 +53,7 @@ All the other lines are recognized as setting variables, in the form
 'name = value'.  If there is no equal sign on the line, the entire line
 is taken as 'name' and the variable is recognized as boolean "true".
 The variable names are case-insensitive and only alphanumeric
-characters and '`-`' are allowed.  There can be more than one value
+characters and `-` are allowed.  There can be more than one value
 for a given variable; we say then that variable is multivalued.
 
 Leading and trailing whitespace in a variable value is discarded.
@@ -69,15 +69,15 @@ String values may be entirely or partially enclosed in double quotes.
 You need to enclose variable value in double quotes if you want to
 preserve leading or trailing whitespace, or if variable value contains
 beginning of comment characters (if it contains '#' or ';').
-Double quote '`"`' and backslash '`\`' characters in variable value must
-be escaped: use '`\"`' for '`"`' and '`\\`' for '`\`'.
+Double quote `"` and backslash `\` characters in variable value must
+be escaped: use `\"` for `"` and `\\` for `\`.
 
-The following escape sequences (beside '`\"`' and '`\\`') are recognized:
-'`\n`' for newline character (NL), '`\t`' for horizontal tabulation (HT, TAB)
-and '`\b`' for backspace (BS).  No other char escape sequence, nor octal
+The following escape sequences (beside `\"` and `\\`) are recognized:
+`\n` for newline character (NL), `\t` for horizontal tabulation (HT, TAB)
+and `\b` for backspace (BS).  No other char escape sequence, nor octal
 char sequences are valid.
 
-Variable value ending in a '`\`' is continued on the next line in the
+Variable value ending in a `\` is continued on the next line in the
 customary UNIX fashion.
 
 Some variables may require special value format.
@@ -382,9 +382,9 @@ core.pager::
 	to override git's default settings this way, you need
 	to be explicit.  For example, to disable the S option
 	in a backward compatible manner, set `core.pager`
-	to "`less -+$LESS -FRX`".  This will be passed to the
+	to `less -+$LESS -FRX`.  This will be passed to the
 	shell by git, which will translate the final command to
-	"`LESS=FRSX less -+FRSX -FRX`".
+	`LESS=FRSX less -+FRSX -FRX`.
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
@@ -1161,7 +1161,7 @@ pager.<cmd>::
 	particular git subcommand when writing to a tty.  If
 	`\--paginate` or `\--no-pager` is specified on the command line,
 	it takes precedence over this option.  To disable pagination for
-	all commands, set `core.pager` or 'GIT_PAGER' to "`cat`".
+	all commands, set `core.pager` or `GIT_PAGER` to `cat`.
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 125d8f3..1a6c19e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -133,9 +133,9 @@ the conflicted merge in the specified paths.
 When this parameter names a non-branch (but still a valid commit object),
 your HEAD becomes 'detached'.
 +
-As a special case, the "`@\{-N\}`" syntax for the N-th last branch
+As a special case, the `"@\{-N\}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
-"`-`" which is synonymous with "`@\{-1\}`".
+`-` which is synonymous with `"@\{-1\}"`.
 
 
 Detached HEAD
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index f7be584..cc0d30f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -146,7 +146,7 @@ And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area where a pair of conflicting changes happened is marked with markers
-"`<<<<<<<`", "`=======`", and "`>>>>>>>`".  The part before the "`=======`"
+`<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `=======`
 is typically your side, and the part afterwards is typically their side.
 
 The default format does not show what the original said in the conflicting
@@ -173,8 +173,8 @@ Git makes conflict resolution easy.
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the "`<<<<<<<`", "`=======`", and "`>>>>>>>`" markers, it uses
-another "`|||||||`" marker that is followed by the original text.  You can
+In addition to the `<<<<<<<`, `=======`, and `>>>>>>>` markers, it uses
+another `|||||||` marker that is followed by the original text.  You can
 tell that the original just stated a fact, and your side simply gave in to
 that statement and gave up, while the other side tried to have a more
 positive attitude.  You can sometimes come up with a better resolution by
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 3ccef2f..5ed2bc8 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -299,18 +299,18 @@ previous section means the set of commits reachable from that
 commit, following the commit ancestry chain.
 
 To exclude commits reachable from a commit, a prefix `{caret}`
-notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
+notation is used.  E.g. `{caret}r1 r2` means commits reachable
 from `r2` but exclude the ones reachable from `r1`.
 
 This set operation appears so often that there is a shorthand
 for it.  When you have two commits `r1` and `r2` (named according
 to the syntax explained in SPECIFYING REVISIONS above), you can ask
 for commits that are reachable from r2 excluding those that are reachable
-from r1 by "`{caret}r1 r2`" and it can be written as "`r1..r2`".
+from r1 by `{caret}r1 r2` and it can be written as `r1..r2`.
 
-A similar notation "`r1\...r2`" is called symmetric difference
+A similar notation `r1\...r2` is called symmetric difference
 of `r1` and `r2` and is defined as
-"`r1 r2 --not $(git merge-base --all r1 r2)`".
+`r1 r2 --not $(git merge-base --all r1 r2)`.
 It is the set of commits that are reachable from either one of
 `r1` or `r2` but not from both.
 
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 29e5929..be39ed7 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -46,20 +46,20 @@ Here are the rules regarding the "flags" that you should follow when you are
 scripting git:
 
  * it's preferred to use the non dashed form of git commands, which means that
-   you should prefer `"git foo"` to `"git-foo"`.
+   you should prefer `git foo` to `git-foo`.
 
- * splitting short options to separate words (prefer `"git foo -a -b"`
-   to `"git foo -ab"`, the latter may not even work).
+ * splitting short options to separate words (prefer `git foo -a -b`
+   to `git foo -ab`, the latter may not even work).
 
  * when a command line option takes an argument, use the 'sticked' form.  In
-   other words, write `"git foo -oArg"` instead of `"git foo -o Arg"` for short
-   options, and `"git foo --long-opt=Arg"` instead of `"git foo --long-opt Arg"`
+   other words, write `git foo -oArg` instead of `git foo -o Arg` for short
+   options, and `git foo --long-opt=Arg` instead of `git foo --long-opt Arg`
    for long options.  An option that takes optional option-argument must be
    written in the 'sticked' form.
 
  * when you give a revision parameter to a command, make sure the parameter is
    not ambiguous with a name of a file in the work tree.  E.g. do not write
-   `"git log -1 HEAD"` but write `"git log -1 HEAD --"`; the former will not work
+   `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
    if you happen to have a file called `HEAD` in the work tree.
 
 
@@ -99,17 +99,17 @@ usage: git-describe [options] <committish>*
 
 Negating options
 ~~~~~~~~~~~~~~~~
-Options with long option names can be negated by prefixing `"--no-"`. For
-example, `"git branch"` has the option `"--track"` which is 'on' by default. You
-can use `"--no-track"` to override that behaviour. The same goes for `"--color"`
-and `"--no-color"`.
+Options with long option names can be negated by prefixing `--no-`. For
+example, `git branch` has the option `--track` which is 'on' by default. You
+can use `--no-track` to override that behaviour. The same goes for `--color`
+and `--no-color`.
 
 
 Aggregating short options
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 Commands that support the enhanced option parser allow you to aggregate short
-options. This means that you can for example use `"git rm -rf"` or
-`"git clean -fdx"`.
+options. This means that you can for example use `git rm -rf` or
+`git clean -fdx`.
 
 
 Separating argument from the option
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 9afca75..4fc1cf1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -262,7 +262,7 @@ This commit is referred to as a "merge commit", or sometimes just a
 	'origin' is used for that purpose. New upstream updates
 	will be fetched into remote <<def_tracking_branch,tracking branches>> named
 	origin/name-of-upstream-branch, which you can see using
-	"`git branch -r`".
+	`git branch -r`.
 
 [[def_pack]]pack::
 	A set of objects which have been compressed into one file (to save space
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 96af897..e33b29b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1136,10 +1136,10 @@ Ignoring files
 A project will often generate files that you do 'not' want to track with git.
 This typically includes files generated by a build process or temporary
 backup files made by your editor. Of course, 'not' tracking files with git
-is just a matter of 'not' calling "`git-add`" on them. But it quickly becomes
+is just a matter of 'not' calling `git-add` on them. But it quickly becomes
 annoying to have these untracked files lying around; e.g. they make
-"`git add .`" practically useless, and they keep showing up in the output of
-"`git status`".
+`git add .` practically useless, and they keep showing up in the output of
+`git status`.
 
 You can tell git to ignore certain files by creating a file called .gitignore
 in the top level of your working directory, with contents such as:
-- 
1.6.2
