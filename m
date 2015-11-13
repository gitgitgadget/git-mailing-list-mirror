From: Jeff King <peff@peff.net>
Subject: Re: Fw: [git-users] git fsck error - duplicate file entries -
 different then existing stackoverflow scenarios
Date: Fri, 13 Nov 2015 00:33:10 -0500
Message-ID: <20151113053310.GC29708@sigill.intra.peff.net>
References: <20151112140210.ef05a31c401dd49992e9674e@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Wind Over Water <wndovrwtr@gmail.com>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Fri Nov 13 06:33:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx6z7-0004H3-TH
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbbKMFdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:33:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:56926 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbbKMFdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:33:13 -0500
Received: (qmail 14144 invoked by uid 102); 13 Nov 2015 05:33:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:33:13 -0600
Received: (qmail 21432 invoked by uid 107); 13 Nov 2015 05:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:33:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20151112140210.ef05a31c401dd49992e9674e@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281236>

On Thu, Nov 12, 2015 at 02:02:10PM +0300, Konstantin Khomoutov wrote:

> A user recently asked an interesting question on the git-users list.
> I think it warrants attentions of a specialists more hard-core than
> we're there over at git-users.
> 
> So I'd like to solicit help if those knowledgeable, if possible.

Thanks. Curating user questions and forwarding the hard ones here is
appreciated.

> I have a repo that is giving a 'git fsck --full' error that seems to be 
> different from the existing questions and answers on stackoverflow on
> this topic.  For example, in our fsck error it is not obvious which
> file is actually duplicated and how/where.  And there is no commit sha
> involved - apparently only blob and tree sha's.  But then finding good
> documentation on this is challenging.

Yes, fsck does not traverse the graph in order. So it sees a problem
with a particular tree, but cannot know where that tree is within the
whole project tree, or which commits reference it. In fact, an arbitrary
number of commits might reference it.

The most useful thing is sometimes to ask which commit introduced the
tree (which can _also_ have multiple answers, but usually just one). You
can do that by walking the history, like this:

  tree=df79068051fa8702eae7e91635cca7eee1339002
  git log --all --format=raw --raw -t --no-abbrev | less +/$tree

That will visit each commit. The options are:

  - we visit commits reachable from all branches and tags (--all)

  - we include the sha1 of the root tree (due to --format=raw)

  - adding --raw shows the raw diff, which includes the sha1 of each
    file touched by the commit

  - using "-t" includes the raw diff for trees, rather than just blobs

  - using "--no-abbrev" gives full 40-hex sha1s

And then "less +/$tree" will open the pager and immediately jump to the
first instance of the sha1 in question.

But of course that doesn't tell you how to fix it. It might tell you how
the bogus object came about (and it is a bogus object; a bug-free git
implementation should _never_ produce a tree with duplicate entries.
AFAIK we have never had such a bug in Git itself, but I have
occasionally come across problematic entries that I suspect were created
with very old versions of JGit).

> error in tree df79068051fa8702eae7e91635cca7eee1339002: contains
> duplicate file entries
> [...]
> $ git ls-tree df79068051fa8702eae7e91635cca7eee1339002
> 
> 100644 blob 14d6d1a6a2f4a7db4e410583c2893d24cb587766 build.gradle
> 
> 120000 blob cd70e37500a35663957cf60f011f81703be5d032 msrc
> 
> 040000 tree 658c892e15fbe0d3ea6b8490d9d54c5f2e658fc9 msrc
> 
> 100644 blob f623819c94a08252298220871ac0ba1118372e59 pom.xml
> 
> 100644 blob 9223cc2fddb138f691312c1ea2656b9dc17612d2 settings.gradle
> 
> 040000 tree c3bac1d92722bdee9588a27747b164baa275201f src

Looks like "msrc" is your duplicate entry (even though the sha1s of the
sub-entries are different, the tree cannot have two entries with the
same name). You can use the "log" trick above to find the full path to it.

The fact that one is a symlink (mode 120000) and one is a tree means
that whatever git implementation created this presumably has a bug
related to symlinks.

The only way to fix it is to rewrite the history mentioning the tree
(because once the tree is fixed, it will get a new sha1, and then any
commit referencing it will get a new sha1, and commits built on that,
and so forth).

You can use "git filter-branch" to do so. There is a sample command
here:

  http://stackoverflow.com/questions/32577974/duplicate-file-error-while-pushing-mirror-into-git-repository/

that just rewrites each tree via a round-trip to the index (so it's not
clear which of the duplicate entries it will discard). You could also
write a more clever index-filter snippet to use git-update-index to
insert the entry you want.

-Peff
