From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach cvsexportcommit to add new files
Date: Fri, 06 Jan 2006 14:37:39 -0800
Message-ID: <7virsxrnik.fsf@assigned-by-dhcp.cox.net>
References: <20060106205441.GA32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Dg-0007b1-FY
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWAFWht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWAFWhs
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:48 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12729 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964866AbWAFWhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223555.IUSF17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:55 -0500
To: Yann Dirson <ydirson@altern.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14216>

Yann Dirson <ydirson@altern.org> writes:

> Teach cvsexportcommit to add new files
> "cvs add" support was already there, but the "unknown" status
> returned when querying a file not yet known to cvs caused the
> script to abort prematurely.

Thanks.  I'll take the patch as is, but I noticed that the
cvsexportcommit still has some room for polishing.

 * The command is to be run from CVS working copy (as desribed
   in the documentation) and seems to assume that the parent
   commit is checked out at least for the paths involved between
   the commit and the parent (not clearly documented).

 * I wonder if it is safe with filenames with embedded SP?

 * This undef @files seem premature; later you will say
   cleanupcvs(@files) won't you?

> $opt_v && print "The commit affects:\n ";
> $opt_v && print join ("\n ", @afiles,@mfiles,@dfiles) . "\n\n";
> undef @files; # don't need it anymore
> ...
> ### NOTE: if you are planning to die() past this point
> ###       you MUST call cleanupcvs(@files) before die()

 * I think this grep '^Binary' is unsafe; different versions of
   gnu diff say just "Files differ".

> print "'Patching' binary files\n";
> 
> my @bfiles = `git-diff-tree -p $parent $commit | grep '^Binary'`;

 * ls-tree can take $parent (a commit which is by definition a
   treeish) happily here, so rev-parse is not needed.

>     my $tree = `git-rev-parse $parent^{tree} `;
>     chomp $tree;
>     my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
>     chomp $blob;

 * another way would be git-hash-object (without -w) the working
   tree file (which you already know matches the $parent
   version) and compare the hash with $blob without extracting
   it with cat-file.

>     `git-cat-file blob $blob > $tmpdir/blob`;
>     `cmp -q $f $tmpdir/blob`;

I am getting an impression that _if_ we care about applying
fuzzy patch like this, giving fuzz feature to git-apply would
help this program somewhat, but at the same time I do not think
of a good reason to even accept nonexact patch when synching two
SCM histories.
