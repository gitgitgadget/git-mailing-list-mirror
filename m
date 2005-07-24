From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] extending git-ls-files --exclude.
Date: Sun, 24 Jul 2005 15:49:33 -0700
Message-ID: <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Jul 25 00:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwpJA-0006Dj-1D
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 00:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGXWuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVGXWuU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 18:50:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20115 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261514AbVGXWtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 18:49:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724224932.TINT17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Jul 2005 18:49:32 -0400
To: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Yes. There were several discussions about this in the past, with no
> clear outcome, IIRC. I would prefer:
>
>   ~/.git/ignore per-user
>   /.git/ignore per-repository
>   .gitignore per-directory (cummulative with parent directories)
>
> Note that I also want to make use of some special characters in this
> file ...  to make it at least as powerful as CVS' ignore.

I'd like to extend "--exclude" and friends git-ls-files takes
the following way (strawman).  I'd appreciate your input from
the perspective of Porcelain writers, and somebody who ends up
having to use the bare Plumbing.

I'll be sending patches for actual implementation in separate messages.

------------
'git-ls-files' can use a list of "exclude patterns" when
traversing the directory tree and finding files to show when the
flags --others or --ignored are specified.

These exclude patterns come from these places:

 (1) command line flag --exclude=<pattern> specifies a single
     pattern.

 (2) command line flag --exclude-from=<file> specifies a list of
     patterns stored in a file.

 (3) command line flag --exclude-per-directory=<name> specifies
     a name of the file in each directory 'git-ls-files'
     examines, and if exists, its contents are used as an
     additional list of patterns.

An exclude pattern file used by (2) and (3) contains one pattern
per line.  A line that starts with a '#' can be used as comment
for readability.

The list of patterns that is in effect at a given time is
built and ordered in the following way:

 * --exclude=<pattern> and lines read from --exclude-from=<file>
   come at the beginning of the list of patterns, in the order
   given on the command line.  Patterns that come from the file
   specified with --exclude-from are ordered in the same order
   as they appear in the file.

 * When --exclude-per-directory=<name> is specified, upon
   entering a directory that has such a file, its contents are
   appended at the end of the current "list of patterns".  They
   are popped off when leaving the directory.

Each pattern in the pattern list specifies "a match pattern" and
optionally the fate --- either a file that matches the pattern
is considered excluded or included.  By default, this being
"exclude" mechanism, the fate is "excluded".  A filename is
examined against the patterns in the list, and the first match
determines its fate.

A pattern specified on the command line with --exclude or read
from the file specified with --exclude-from is relative to the
top of the directory tree.  A pattern read from a file specified
by --exclude-per-directory is relative to the directory that the
pattern file appears in.

An exclude pattern is of the following format:

 - an optional prefix '!' which means that the fate this pattern
   specifies is "include", not the usual "exclude"; the
   remainder of the pattern string is interpreted according to
   the following rules.

 - if it does not contain a slash '/', it is a shell glob
   pattern and used to match against the filename without
   leading directories (i.e. the same way as the current
   implementation).

 - otherwise, it is a shell glob pattern, suitable for
   consumption by fnmatch(3) with FNM_PATHNAME flag.  I.e. a
   slash in the pattern must match a slash in the pathname.
   "Documentation/*.html" matches "Documentation/git.html" but
   not "ppc/ppc.html".  As a natural exception, "/*.c" matches
   "cat-file.c" but not "mozilla-sha1/sha1.c".

An example: 

    $ cat .git/ignore
    # ignore objects and archives, anywhere in the tree.
    *.[oa]
    $ cat Documentation/.gitignore
    # ignore generated html files,
    # except foo.html which is maintained by hand
    !foo.html
    *.html
    $ git-ls-files --ignored \
        --exclude='Documentation/*.[0-9]' \
        --exclude-from=.git/ignore \
        --exclude-per-directory=.gitignore
