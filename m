From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] attributes
Date: Fri, 13 Apr 2007 02:01:20 -0700
Message-ID: <7vslb4d4wv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 11:01:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcHet-00063L-5u
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbXDMJBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbXDMJBW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:01:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38069 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbXDMJBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 05:01:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413090120.SBLD1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 05:01:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mZ1L1W0021kojtg0000000; Fri, 13 Apr 2007 05:01:20 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44396>

This is a series to implement the plumbing side support for
assigning attributes to paths, and affect behaviour of git based
on them.

An attribute is a simple string.  A path either has it set, has
it unset, or unspecified.  The assignment is done via
$GIT_DIR/info/attributes file, and .gitattributes file in the
directory that contain the path, and its parent directories.
Entries in the .gitattribute file from the closest directory of
the path in question takes precedence, and entries in
$GIT_DIR/info/attributes are used as the fallback.  In a single
file, later entries override earlier ones.  These rules are
exactly the same as the existing path exclusion with
$GIT_DIR/info/exclude file and .gitignore files in directories.

Each line of these configuration files consists of a glob
pattern followed by white-space separated list of attribute
names.  Each attribute name can be prefixed with '!' to mean
"this attribute is not set for this path".  The pattern matching
rule of glob pattern is exactly the same as that of .gitignore.
A pattern that has a slash in it matches using FNM_PATHNAME
(i.e. the match is anchored to the directory the .gitattributes
file is found in), a pattern that doesn't matches just the
basename.

So, you can express:

    	*	crlf !nodiff
        *.[oa]	!crlf nodiff
	*.ps	nodiff
	t/*.ps	!nodiff

to mean:

	In general, I want all files to undergo autocrlf
	conversion, and I do not want to disable textual diff
	output for them, but files whose name match *.o or *.a
	are binaries so do not touch them with autocrlf and do
	not show textual diff for them.  Also, I do not want to
	see diffs for *.ps files because I cannot read
	PostScript, but I do want to see diffs of PostScript
	files in t/ directory.  In either case, PostScript files
	undergo autocrlf conversion.

Side note: You can think of .gitignore file to assign a single
attribute, 'ignored', to each path, although it is not
implemented that way for two reasons (historical, and
efficiency).

Side note: Unlike the .gitattributes file, the .gitignore file
format has the negation '!' at the beginning of glob, but this
is only because it only defines the implicit 'ignored' attribute
and there is no "list of attribute names" to hang '!' mark to.

The first patch only defines the basic infrastructure to assign
and check the attributes with paths.  The subsequent ones are
small examples to have them affect some operations of git.

There are some things I considered but did not implement myself
(at least not yet).  People who are interested in .gitattributes
support would want to enhance in these areas.

 * There is no support for synthetic attributes yet.  The sample
   conversion in [PATCH 2/3] makes autocrlf to be disabled by
   '!crlf', and [PATCH 3/3] makes textual diff to be disabled by
   'nodiff'.  The user should be able to set a single attribute,
   'binary', to paths and, absense of other more specific
   entries for crlf/nodiff sttributes, that should be enough to
   automatically unset crlf and set nodiff.

 * Currently convert_to_{git,work_tree} routines have only "do
   we run autocrlf or not" choice.  Ideally, there should be a
   way to build a custom pipeline of filters, depending on the
   set of attributes given to each path.

 * I've added sample hooks to the autocrlf conversion codepath
   and textual diff generation codepath.  I think it should not
   be too difficult to teach merge-recursive to notice an
   attribute that says "do not use usual file-level 3-way merge
   on this path", and use an external merge program.
