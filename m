From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 07:40:47 -0700
Message-ID: <20090406144047.GE23604@spearce.org>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com> <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Klas Lindberg <klas.lindberg@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqq1w-0008E8-3n
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbZDFOku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZDFOkt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:40:49 -0400
Received: from george.spearce.org ([209.20.77.23]:36351 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbZDFOkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:40:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4E15038211; Mon,  6 Apr 2009 14:40:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115838>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 6 Apr 2009, Klas Lindberg wrote:
> 
> > Is there a way to fetch based on SHA id's instead of named references?
> 
> No, out of security concerns;  imagine you included some proprietary 
> source code by mistake, and undo the damage by forcing a push with a 
> branch that does not have the incriminating code.  Usually you do not 
> control the garbage-collection on the server, yet you still do not want 
> other people to fetch "by SHA-1".
> 
> BTW this is really a strong reason not to use HTTP push in such 
> environments.

Err, you mean http:// and rsync:// fetch, don't you?  Because if
you rely on being able to unpublish a ref you have to use only the
native git://, where direct access is otherwise forbidden.

Anyway.

The fetch-pack/upload-pack protocol uses SHA1s in the want commands,
so in theory at the protocol level you can say "git fetch URL SHA1"
and convey your request to the remote peer.

The problem is, upload-pack won't perform a reachability analysis
to determine if a wanted SHA1 is reachable from a current ref.
Instead it requires that the wanted SHA1 is *exactly* referenced
by at least one ref.

I had previously proposed adding a merge base test if SHA1 parses
as a commit, but IIRC Junio rejected the idea, saying it was too
costly to perform on the server.

The thing is, he's right.

There's no reason to perform the reachability test on the server
when you can move it onto the client, and that's exactly what
git-submodule is doing.  It fetches everything, and then assumes
its reachable post fetch.  Since the client has fetched everything,
the client has the object if its reachable by the server.

If the object is no longer reachable by the server's refs (think
branch rebased) then the object is actually in danger of being GC'd
off of the server's object store.  So you already are going to be
playing with fire, even if we added a server side config to permit
fetching of unreachable data.  A future "git gc" on that server
repository could suddenly wipe out that data entirely.


Klas, one suggestion might be to make a "refs/heads/world" ref which
has a threaded chain of merges of every commit you ever recorded
in the supermodule, and then you can assume post fetch that the
world is reachable.

E.g. every time you want to record a commit in the manifest file,
also shove it into the world:

  C=...commit.to.save... &
  W=$(git rev-parse refs/heads/world) &&
  git update-ref refs/heads/world \
    $(echo Save $C, save the world | git commit-tree $W -p $W -p $C) \
    $W &&
  git push URL refs/heads/world

One way we get away with this sort of thing in repo is, we only
put SHA1s in our manifest that are published in branches that
won't ever rewind or delete.  Hence, its a moot point.

-- 
Shawn.
