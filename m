From: Junio C Hamano <junkio@cox.net>
Subject: [RFR] gitattributes(5) documentation
Date: Thu, 19 Apr 2007 18:29:33 -0700
Message-ID: <7vslav4yv6.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	<7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	<7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 03:29:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hehwd-0002tR-8K
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 03:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbXDTB3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 21:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXDTB3f
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 21:29:35 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48607 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbXDTB3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 21:29:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420012935.TEGP1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Apr 2007 21:29:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pDVZ1W0061kojtg0000000; Thu, 19 Apr 2007 21:29:33 -0400
In-Reply-To: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 18 Apr 2007 17:04:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45052>

Here is my current draft.  I have build-infrastructure updates
to deal with a new manual section "man5/" (file formats) already
but that is boring stuff, so I am sending out only the new file
to be added for review.

We probably would want to have gitconfig(5) to describe its file
format, and include::config.txt[] in there as well.

Although I do not think it is particularly necessary, we _might_
want to also have gitdata(5) that describes the file format of
$GIT_DIR/index, loose objects, .pack, .idx, packed-refs.

-- >8 -- Documentation/gitattributes.txt -- >8 --

gitattributes(5)
================

NAME
----
gitattributes - defining attributes per path

SYNOPSIS
--------
.gitattributes


DESCRIPTION
-----------

A `gitattributes` file is a simple text file that gives
`attributes` to pathnames.

Each line in `gitattributes` file is of form:

	glob	attr1 attr2 ...

That is, a glob pattern followed by an attributes list,
separated by whitespaces.  When the glob pattern matches the
path in question, the list of attributes are given to the path.

Each attribute can be in one of these states for a given path:

Set::

	The path has the attribute with special value "true";
	this is specified by listing only the name of the
	attribute in the attribute list.

Unset::

	The path has the attribute with special value "false";
	this is specified by listing the name of the attribute
	prefixed with a dash `-` in the attribute list.

Set to a value::

	The path has the attribute with specified string value;
	this is specified by listing the name of the attribute
	followed by an equal sign `=` and its value in the
	attribute list.

Unspecified::

	No glob pattern matches the path, and nothing says if
	the path has or does not have the attribute.

When more than one glob pattern matches the path, a later line
that matches overrides an earlier line.

When deciding what attributes are assigned to a path, git
consults `.gitattributes` file in the same directory as the path
in question, and its parent directories, and then finally
`$GIT_DIR/info/attributes` file, in this order.

Sometimes you would need to override an setting of an attribute
for a path to `unspecified` state.  This can be done by listing
the name of the attribute prefixed with an exclamation point `!`.


EFFECTS
-------

Certain operations by git can be influenced by assigning
particular attributes to a path.  Currently, three operations
are attributes-aware.

Checking-out and checking-in
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The attribute `crlf` affects how the contents stored in the
repository are copied to the working tree files when commands
such as `git checkout` and `git merge` is run.  It also affects
how the contents you prepare in the working tree is stored back
in the repository when you do `git add` and `git commit`.

Set::
	A path to which the `crlf` attribute is set is converted
	to have CRLF line endings in the working tree upon
	checkout, and converted back to strip CRLF line endings
	to LF line endings upon checkin.

Unset::
	A path to which the `crlf` attribute is unset (do not
	confuse this with 'unspecified') does not go through
	line endings conversion upon checkin/checkout.

Unspecified::
	If the configuration variable `core.autocrlf` is false, no
	conversion is done for paths with `crlf` attribute
	unspecified.
+
Othewise, the contents of the path is inspected, and if it does
not look like a text file, no conversion is done.
+
If `core.autocrlf` is true, and the contents of the path does
look like a text file, line endings are converted to CRLF upon
checkout and LF upon checkin.
+
If `core.autocrlf` is set to "input", and the contents of the
path does look like a text file, line endings are converted to
LF upon checkin, but there is no conversion done upon checkout.

Any other value set to `crlf` attribute is ignored and git acts
as if the attribute is left unspecified.


Generating diff text
~~~~~~~~~~~~~~~~~~~~

The attribute `diff` affects if `git diff` generates textual
patch for the path or just says `Binary files differ`.

Set::
	A path to which the `crlf` attribute is set is treated
	as text, even when they contain funny bytes such as NUL.

Unset::
	A path to which the `crlf` attribute is unset will
	generate `Binary files differ`.

Unspecified::
	A path to which the `crlf` attribute is unspecified
	first gets its contents inspected, and if it looks like
	text, it is treated as text.  Otherwise it would
	generate `Binary files differ`.

Any other value set to `diff` attribute is ignored and git acts
as if the attribute is left unspecified.


Performing a three-way merge
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The attribute `merge` affects how three versions of a file is
merged when a file-level merge is necessary during `git merge`,
and other programs such as `git revert` and `git cherry-pick`.

Set::
	Built-in 3-way merge driver is used to merge the
	contents in a way similar to `merge` command of `RCS`
	suite.  This is suitable for ordinary text files.

Unset::
	Take the version from the current branch as the
	tentative merge result, and declare that the merge has
	conflicts.  This is suitable for binary files that does
	not have a well-defined merge semantics.

Unspecified::
	By default, this uses the same built-in 3-way merge
	driver as is the case the `merge` attribute is set.
	However, `merge.default` configuration variable can name
	different merge driver to be used for paths to which the
	`merge` attribute is unspecified.

Other string value::
	3-way merge is performed using the specified custom
	merge driver.  The built-in 3-way merge driver can be
	explicitly specified by asking for "text" driver; the
	built-in "take the current branch" driver can be
	requested by "binary".

Defining a custom merge driver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The definition of a merge driver is done in `gitconfig` not
`gitattributes` file, so strictly speaking this manual page is a
wrong place to talk about it.  However...

To define a custom merge driver `filfre`, add a section to your
`$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:

----------------------------------------------------------------
[merge "filfre"]
	name = feel-free merge driver
	driver = filfre %O %A %B
	recursive = binary
----------------------------------------------------------------

The `merge.*.name` variable gives the driver a human-readable
name.

The `merge.*.driver` variable's value is used to construct a
command to run to merge ancestor's version (`%O`), current
version (`%A`) and the other branches' version (`%B`).  These
three tokens are replaced with the names of temporary files that
hold the contents of these versions when the command line is
built.

The merge driver is expected to leave the result of the merge in
the file named with `%A` by overwriting it, and exit with zero
status if it managed to merge them cleanly, or non-zero if there
were conflicts.

The `merge.*.recursive` variable specifies what other merge
driver to use when the merge driver is called for an internal
merge between common ancestors, when there are more than one.
When left unspecified, the driver itself is used for both
internal merge and the final merge.


EXAMPLE
-------

If you have these three `gitattributes` file:

----------------------------------------------------------------
(in $GIT_DIR/info/attributes)

a*	foo !bar -baz

(in .gitattributes)
abc	foo bar baz

(in t/.gitattributes)
ab*	merge=filfre
abc	-foo -bar
*.c	frotz
----------------------------------------------------------------

the attributes given to path `t/abc` are computed as follows:

1. By examining `t/.gitattributes` (which is in the same
   diretory as the path in question), git finds that the first
   line matches.  `merge` attribute is set.  It also finds that
   the second line matches, and attributes `foo` and `bar`
   are unset.

2. Then it examines `.gitattributes` (which is in the parent
   directory), and finds that the first line matches, but
   `t/.gitattributes` file already decided how `merge`, `foo`
   and `bar` attributes should be given to this path, so it
   leaves `foo` and `bar` unset.  Attribute `baz` is set.

3. Finally it examines `$GIT_DIR/info/gitattributes`.  This file
   is used to override the in-tree settings.  The first line is
   a match, and `foo` is set, `bar` is reverted to unspecified
   state, and `baz` is unset.

As the result, the attributes assignement to `t/abc` becomes:

----------------------------------------------------------------
foo	set to true
bar	unspecified
baz	set to false
merge	set to string value "filfre"
frotz	unspecified
----------------------------------------------------------------


GIT
---
Part of the gitlink:git[7] suite
