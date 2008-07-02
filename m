From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: RFC: grafts generalised
Date: Wed, 2 Jul 2008 16:35:19 +0200
Message-ID: <20080702143519.GA8391@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 16:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3RT-000057-Gq
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbYGBOfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbYGBOfW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:35:22 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38718 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbYGBOfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 10:35:21 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 7C1675465; Wed,  2 Jul 2008 16:35:19 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87144>

I'm in the process of converting and stitching and patching vast amounts
of initially disjunct CVS and SVN repositories into larger complete
histories inside a single git repository.  Recreating history as
accurately as possible.

The problem I encounter is that any number of times I have to "edit"
history in a non-parameterable fashion, in any of the following ways:
- Change parents.
- Add merges.
- Change author, committer, commitdate, authordate.
- Change the tree (because of conversion errors in the automated
  conversion process) belonging to a single commit.
- Retrofit a patch which has to ripple through all of history until
  the present.

The only things which are easily done at the moment are:
Change parents and add merges.  This can be accomplished fairly easily
using the grafts file.
The other changes are messy at best and need to be parameterised into the
form of a shell script so that git filter-branch can have a go at it.
This parameterisation is doable for author/committer/dates in most cases
(but not pretty), but is rather (too) convoluted for ripple-through
patches.

You have to imagine that the whole tree has lots of interconnects
already (merges), and changing the tree at a point in history which has
to ripple through is a mess, because all references and interconnects
need to be rewritten as well.

I propose the following:
- Extend git fsck to do more sanity checks on the content of the grafts
  file (to make it more difficult to shoot yourself in the foot with
  that file; my feet will be grateful).
- Extend the grafts file format to support something like the following syntax:

commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28
Merge: 3b3da24960a82a479b9ad64affab50226df02abe 13b8f53e8ccec3b08eeb6515e6a10a2a
Merge: ac719ed37270558f21d89676fce97eab4469b0f1
Tree: 32fc99814b97322174dbe97ec320cf32314959e2
Author: Foo Bar (FooBar) <foo@bar>
AuthorDate: Sat Jun 6 13:50:44 1998 +0000
Commit: Foo Bar (FooBar) <foo@bar>
CommitDate: Sat Jun 7 13:50:44 1998 +0000
Logmessage: First line of logmessage override
Logmessage: Second line of logmessage override
Logmessage: Etc.
 
- Whereas not specified fields default to not altering the commit for
  those fields.
  E.g.

commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28

  Would alter just the parent, nothing else.
- Keep backward compatibility with the old format.

Obviously, the use case for this is to change the tree as needed, then
run git filter-branch to actually get things in permanently, after which
it becomes clonable.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
