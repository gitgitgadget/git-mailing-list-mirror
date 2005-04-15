From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 04:11:05 -0700
Message-ID: <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 13:08:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMOg1-0007BP-6d
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 13:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVDOLLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVDOLLV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 07:11:21 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44195 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261804AbVDOLLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 07:11:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415111106.EXMN9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 07:11:06 -0400
To: Christopher Li <git@chrisli.org>,
	Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050415062807.GA29841@64m.dyndns.org> (Christopher Li's
 message of "Fri, 15 Apr 2005 02:28:07 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "CL" == Christopher Li <git@chrisli.org> writes:

CL> Then do you emit the entry for it's parents directory?

In GIT object model, directory modes do not matter.  It is not
designed to record directories, and running "update-cache --add
foo" when foo is a directory fails.

The data model of GIT is that it associates file datablob to a
string called "pathname" that happen to contain slashes in them.
It is kinda wierd.  When you externalize it with checkout-cache,
these slashes are mapped to hierarchical UNIX filesystem paths,
relative to whereever you happened to run checkout-cache.  The
hierarchical "tree" representation in the GIT database was
started as just a space optimization thing.

CL> e.g. /foo/bar get created. foo doesn't exists. You have
CL> to create foo first. You don't have mode information for
CL> foo yet.

And you will never have that information, since it is not
recorded anywhere.  If I say you should have foo/bar (by the
way, no leading slashes are placed in the dircache either), and
if it so happens that you do not have foo yet, you'd better
create one without waiting to be told, because I will never tell
you to just create a directory.

By the way, Linus, while I was studying how the new hierarchical
trees are written out, I think I have found one small funny (I
would not call this a *bug*) there.  Here is an excerpt from
write-tree (around ll. 56; I am basing on pasky-0.4 so your line
numbers may have some offsets):

        sha1 = ce->sha1;
        mode = ntohl(ce->st_mode);

        /* Do we have _further_ subdirectories? */
        filename = pathname + baselen;
        dirname = strchr(filename, '/');
        if (dirname) {
                int subdir_written;

                subdir_written = write_tree(cachep + nr, maxentries - nr, pathname, dirname-pathname+1, subdir_sha1);
                nr += subdir_written;

                /* Now we need to write out the directory entry into this tree.. */
                mode |= S_IFDIR;
                pathlen = dirname - pathname;

                /* ..but the directory entry doesn't count towards the total count */
                nr--;
                sha1 = subdir_sha1;
        }

This code is going through a flat list of cache entries sorted
by pathnames.  The list is flat in the sense that the pathnames
are like "foo/bar" i.e. with slashes inside.  The if() statement
there, upon seeing "foo/bar", slurps all the entries in foo/
subhierarchy and writes into a separate tree, recursively, to
"represent" foo/.

Notice what mode the "tree" object gets in this case?  File mode
for foo/bar (or whatever happens to be sorted the first among
the stuff in dircache from foo/ directory) ORed with S_IFDIR.  I
think this is nonsense, and we should just store constant
S_IFDIR.

Another option, probably better from the SCM purist's POV, would
be to start recording directories in dircaches, so that people
can actually keep track of directory modes.  Does it matter? ---
I would say not.  GIT does not have to be tar or cpio.  

