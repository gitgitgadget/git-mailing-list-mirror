From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 20 Mar 2010 17:58:34 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003201724270.14365@iabervon.org>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>  <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>  <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
  <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de> <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:58:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6gt-0005Tf-CI
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab0CTV6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:58:37 -0400
Received: from iabervon.org ([66.92.72.58]:35862 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab0CTV6g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:58:36 -0400
Received: (qmail 27580 invoked by uid 1000); 20 Mar 2010 21:58:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Mar 2010 21:58:34 -0000
In-Reply-To: <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142760>

On Sun, 21 Mar 2010, Ramkumar Ramachandra wrote:

> Hi,
> 
> I just prepared another revision of my proposal- I've tried to be
> clearer about the objective, and included a timeline this time. Note
> that I've also changed the name from native-git-svn to git-remote-svn,
> as recommended by Sverre.
> 
> ======================================
> Project Proposal: git-remote-svn | Native SVN support in Git
> 
> == The Outline ==
> The objective of git-remote-svn is to allow native interaction with
> SVN repositories in Git. The motivation for writing this comes from
> the shortcomings of the current approach: git-svn.
> 1. It is essentially an arcane 5000-line Perl script that doesn't use
> git-fast-import/ git-fast-export. It converts an SVN repository to a
> Git repository by hand. This makes it virtually unmaintainable.
> 2. The UI is unnatural and complex. git-svn-* has some commands
> corresponding to git-* commands, and it can be quite difficult for the
> user to understand which one to use in different situations.
> 3. It handles the standard trunk/branches/tags layout well, but it
> doesn't know how to handle non-standard/ changing SVN layout.
> 4. There's an array of other annoyances which makes it quite
> imperfect. For example, it ignores all SVN properties except
> svn:executable.
> 
> While the last two problems can be tackled in git-svn.perl itself, a
> fresh approach is required to tackle the first two. git-remote-svn is
> a proposal for an alternative approach.
> 1. Several good SVN exporters already exist, and using them with
> git-fast-import should simplify a lot of the plumbing git-svn tackles
> by hand.
> 2. Using a remote helper to keep track of SVN remotes will simplify
> the UI greatly. The fresh UI will allow for a simple `git clone
> svn://example.com/myrepo` and multiple subsequent `git pull`
> invocations.
> 
> However, the project does not aim to be compatible with git-svn, and
> does not serve as an immediate replacement. It can be considered fully
> successful after the functionality described in all the components
> have been written. Merging the project to upstream will involve small
> changes to the Git codebase to incorporate the native UI. I
> additionally hope that this project will serve as a roadmap for other
> projects that involve natively supporting other versioning systems in
> Git.
> 
> == The Technicalities ==
> I've discussed the project with Sverre Rabbelier at length over email.
> The plan is to build component-wise. The distinct components are:
> 1. An SVN client that uses libsvn to fetch/ push revisions to a remote
> SVN repository.
> 2. An exporter for SVN repositories, which will extract all the
> relevant revision history and metadata to import into Git.
> 3. A remote helper for Git that takes the data from this SVN exporter,
> and uses git-fast-import to create corresponding commits in Git.
> 4. Another remote helper to export commit data and metadata from Git
> to import into SVN.
> 5. An importer for SVN, which will create revisions in SVN
> corresponding to commits in Git.

The structure for remote helpers should be that each foreign system has a 
single helper which git can call with instructions on what to do (both for 
foreign-to-git and for git-to-foreign operations). So 3 and 4 have to be 
functions of the same program, and it's probably best for 2 and 5 and 
maybe 1 to also be part of this program.

The structure is that git will essentially call you in a pipeline like:

 commands | you | git-fast-import

or:

 git-fast-export | you | git-fast-import

So the helper wouldn't be running git-fast-export or git-fast-import, 
unless it was a helper for using git as the foreign system.

> 6. A UI that glues all the components together.

If you use the remote-helper framework (and probably extend it as 
necessary), there shouldn't need to be a UI. The grand idea is that, 
regardless of what mechanism you use to interact with git, it would use 
the transport code from the library, which would know how to interact with 
remote helpers, and users and UI developers don't need to know about SVN 
or Perforce or any other particular system.

An extra-grand idea would be to allow helpers to be agnostic about the 
local system they're helping, so that Mercurial could use an SVN helper 
you developed for git, and git could use a Darcs helper that the Darcs 
people developed without a particular local system in mind, just to be 
interoperable.

> Due to a licensing conflict, the details of which can be found here
> [1], git-remote-svn will link to libsvn, but will NOT link to Git. It
> will simply use a thin wrapper to call compiled Git executables
> (referred to as remote helper in article).

It should be possible to avoid calling any git executables (directly or 
otherwise); git should call you with all the information you need.

> The following resources will help build the various components:
> 1. git_remote_helpers/git/git.py is a small remote helper written by
> Sverre that wraps around git-fast-import. I plan to extend this to
> wrap around git-fast-export as well.
> 2. git-svn.perl contains a two-way mapping, parts of which I plan to implement.
> 3. Thiago Macieira's svn-all-fast-export [2] has a complete SVN -> Git
> mapping. I plan to take several ideas from the branch/ tag mapper in
> repository.cpp.

If you're going to work in C, you should look at my Perforce helper. It's 
suitable for mainline inclusion, due to using a free-as-in-beer, 
made-available-without-license-terms C++ library for the Perforce side, 
but may be a better model for a C remote helper than git.py is.

	-Daniel
*This .sig left intentionally blank*
