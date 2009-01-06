From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: JGit vs. Git
Date: Tue, 6 Jan 2009 10:45:23 -0800
Message-ID: <20090106184523.GA24578@spearce.org>
References: <a55cfe9d0901052249v1461c70cp1d89e184cfc05eb9@mail.gmail.com> <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vagmi Mudumbai <vagmi.mudumbai@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKGx0-0002wO-Dg
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 19:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbZAFSp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 13:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZAFSp1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 13:45:27 -0500
Received: from george.spearce.org ([209.20.77.23]:41073 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbZAFSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 13:45:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 97D8238210; Tue,  6 Jan 2009 18:45:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a55cfe9d0901052250k2be203dfvb0b437a523f2cecc@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104704>

Vagmi Mudumbai <vagmi.mudumbai@gmail.com> wrote:
> 1) Is JGit a drop in replacement of Git? In sense, if I were to pack
> in an SCM with my app, Can I pack jgit instead of C Git?

As Robin said, its not a full drop-in replacement.  That said, its
getting there.  We're now only really missing patch application,
diff generation, merge support, and submodule support.  Most of
the JGit core can handle submodules by skipping over them during
object traversal, but the part that talks to the filesystem to do
a checkout doesn't recognize them.

JGit is mostly a library, not a command line replacement.  But it
does have commands like "jgit init", "jgit clone", "jgit fetch",
"jgit push", even some server side tools like "jgit daemon",
"jgit receive-pack" and "jgit upload-pack".

To be honest I don't think anyone actually uses the command line
pgm stuff to work with Git.  Anyone using JGit is actually running
it embedded in some type of application like an IDE plugin or a
server like Gerrit.
 
> 2) I noticed that there are no 'add' and 'commit' commands (at least
> from the source) in the org.spearce.git.pgm project. I am looking at
> the repo.or.cz/egit.git repo. I had a brief look at the
> lib/GitIndex.java and lib/Repository.java. GitIndex has the add
> methods to add files/entries to the index. I am still stumped on how
> commits can be done with JGit. Any help is hugely appreciated.

As Robin said, look at the unit tests.  Basically you want to use
the Commit class to populate out the data fields, then pass it off to
an ObjectWriter instance to store it into the tree.  Finally you'll
need to use a RefUpdate (obtained from Repository's updateRef method)
to store the new ObjectId of that Commit into a ref like HEAD.

Unfortunately we have two commit representations in JGit.  If you
are trying to read data from a Repository the RevCommit (obtained
from a RevWalk) is orders of magnitude faster than the Commit class.

> I am working on Windows with msysGit behind a HTTP Proxy. (Life cant
> get worse, I guess.) . I planned on using grit via JRuby but grit uses
> fork which is not available on funny platforms like windows. And JRuby
> guys do not have any plan on supporting fork even on platforms on
> which for is supported. If JGit is a pure Java based implementation of
> Git with more or less the same functionality, then my work becomes a
> lot easier.

I plan on writing patch apply sometime this quarter I think.  I have
most of what I need to rip a patch apart and inspect it prior to
application, now I just need to line it up onto the base object
and issue the output version.

Diff might also come in the next few months.  Dscho has a nice
prototype working, but there's still some work to be done on it.

-- 
Shawn.
