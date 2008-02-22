From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [Fwd: [ANNOUNCE] bzr-fastimport plugin,
	yet another Bazaar import option]
Date: Fri, 22 Feb 2008 02:32:28 -0500
Message-ID: <20080222073228.GF8410@spearce.org>
References: <47BE167A.4060005@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bazaar <bazaar@lists.canonical.com>, git@vger.kernel.org
To: Ian Clatworthy <ian.clatworthy@internode.on.net>
X-From: bazaar-bounces@lists.canonical.com Fri Feb 22 08:33:19 2008
Return-path: <bazaar-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from chlorine.canonical.com ([91.189.94.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSSPC-0004xE-0U
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 22 Feb 2008 08:33:14 +0100
Received: from localhost ([127.0.0.1] helo=chlorine.canonical.com)
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-bounces@lists.canonical.com>)
	id 1JSSOa-0001rE-DJ; Fri, 22 Feb 2008 07:32:36 +0000
Received: from corvette.plexpod.net ([64.38.20.226])
	by chlorine.canonical.com with esmtp (Exim 4.60)
	(envelope-from <spearce@spearce.org>) id 1JSSOX-0001r8-Cc
	for bazaar@lists.canonical.com; Fri, 22 Feb 2008 07:32:33 +0000
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
	helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JSSOT-0006uA-5x; Fri, 22 Feb 2008 02:32:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D49F020FBAE; Fri, 22 Feb 2008 02:32:28 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47BE167A.4060005@internode.on.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - lists.canonical.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-BeenThere: bazaar@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar discussion <bazaar.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar>
List-Post: <mailto:bazaar@lists.canonical.com>
List-Help: <mailto:bazaar-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar>,
	<mailto:bazaar-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-bounces@lists.canonical.com
Errors-To: bazaar-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74699>

Ian Clatworthy <ian.clatworthy@internode.on.net> wrote:
> FYI. I thought you'd be interested in this as it's inspired by and based
> on git-fast-import. You can download the Python source from
> https://code.launchpad.net/bzr-fastimport/. In particular, there's a
> Python parser of the stream format included that may be useful to the
> Git community or other VCS communities. The fast-import-info and
> fast-import-filter commands might also be useful to others.

This is interesting.  I'm not a Python guy, but the info and filter
commands do look like they could be useful beyond the Bazaar community.

Michael Haggerty of cvs2svn has spent a good amount of time creating
a git-fast-import backend to cvs2svn.  Given that cvs2svn is one of
the few tools that can read some of the really strange real world
CVS trees its good to be able to leverage that work for other systems
(SVN, Git, and now Bazaar).
 
> BTW, you might want to either extend the specification (a little) or fix
> git-fast-export so they match. :-) See doc/notes.txt under
> http://bazaar.launchpad.net/~bzr/bzr-fastimport/fastimport.dev/files for
> details. For example, running git-fast-export on 64-bit Hardy Heron
> produces file modes longer than permitted if the spec was strictly
> interpreted.

We may need to take a small hammer to git-fast-export and fix
its output.  Generating long mode strings like your notes suggest
is incorrect.

The fast-import format is very strict, to avoid any sort of ambiguous
behavior and implicit data corruption during import.  This is one
reason we don't use "auto format detection" for dates and instead
require that the frontend tell us what date format it is using,
and stick to only that format thoughout the stream.  Its also a
reason why we only support a limited number of date formats.

File modes in Git are very limited.  We really only want symlinks
or regular files with permissions of 644 and 755.  Everything else
is bogus.  We also now have the S_IFGITLINK mode to deal with but
fast-import does not currently support it.

> Looking forward, I'd probably like to extend the spec to support some
> Bazaar-specific features, e.g. versioning of directories without files
> inside them. If you have a preferred way of me doing this or would like
> to work on it together when that time comes, please let me know. To keep
> backwards compatibility, the first option that springs to mind is using
> specially marked comments for stuff like this, e.g.
> 
> ##bzr:: blah blah blah

Technically its valid for a Git tree to contain an empty subdirectory,
but that directory would disappear if the user tries to make a commit
on top of it due to the current limitations of the index file.

So git-fast-import could actually allow the frontend to create an
empty directory in the stream format, and record that correctly
in Git.  Its just that building on top of that may cause the
directory to disappear. :)

If we are heading in the direction of making this a common stream
format I'd like to try and work it out such that any additional
extensions aren't VCS specific, at least as much as we can avoid it.
That way exports from a source into this format can be loaded into
any VCS that recognizes it, and have little or no loss.  So yes,
I am interested in trying to work with you and anyone else who wants
to extend the format further.

> Finally, thanks for writing git-fast-import and the associated
> documentation. It's well done. If you have any thoughts on the various
> front-ends available, I'm interested in hearing them. As well as saving
> me time vs testing lots of them, your thoughts will give us things to
> keep in mind when developing bzr-fastexport soon.

I think the fast-import documentation is the longest chunk of docs
we have in git, at least as a single manpage. :-)

The git-p4 importer in the git.git contrib/ directory is probably
the most well known and most widely used frontend.  It is also an
incremental tool, and I know a number of Qt developers use it to
mirror the Qt Perforce tree into Git.

The t/t9300-fast-import.sh test script contains a number of tests
for git-fast-import.  The test cases themselves (in terms of the
stream it feeds in) may be of some use to you as it covers most of
the currently recognized stream format.
 
> -------- Original Message --------
> Subject: [ANNOUNCE] bzr-fastimport plugin, yet another Bazaar import option
> Date: Fri, 22 Feb 2008 01:23:34 +1000
> From: Ian Clatworthy <ian.clatworthy@internode.on.net>
> To: Bazaar <bazaar@lists.canonical.com>, bazaar-announce@lists.canonical.com
> 
> I'm pleased to announce bzr-fastimport, a plugin useful for loading data
> exported by a large number of foreign VCS tools. Places to start are:
> 
> * the Launchpad page - https://launchpad.net/bzr-fastimport
> * the Wiki page - http://bazaar-vcs.org/BzrFastImport.
> 
> Please note that this is not yet production quality but seems to be
> working well enough to be useful for a large number of projects.
> 
> I would *greatly* appreciate testing, feedback and improvements. In
> particular, I'm using this for migrating the OpenOffice.org repository
> (76K files and 500K revisions) into Bazaar from Subversion, so I'd
> really like some help with testing out and enhancing the existing
> Subversion front-ends.

Heh.  OOo is _huge_.  I think the best import into Git thus far is
taking up about 1.5G of disk space once fully repacked.  I don't
recall how they did the import, but coming from SVN I think they
used git-svn, which is not based on git-fast-import.

What frontend are you using to go from SVN -> fast-import?
