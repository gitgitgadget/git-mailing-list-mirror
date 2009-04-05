From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 12:17:03 -0700
Message-ID: <20090405191703.GJ23521@spearce.org>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXra-00066L-A6
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbZDETRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755379AbZDETRH
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:17:07 -0400
Received: from george.spearce.org ([209.20.77.23]:33957 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbZDETRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:17:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EA85738211; Sun,  5 Apr 2009 19:17:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090405190213.GA12929@vidovic>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115682>

Nicolas Sebrecht <nicolas.s-dev@laposte.net> wrote:
> On Sun, Apr 05, 2009 at 12:04:12AM -0700, Robin H. Johnson wrote:
> >          The GSoC 2009 ideas contain a potential project for caching the
> > generated packs, which, while having value in itself, could be partially
> > avoided by sending suitable pre-built packs (if they exist) without any
> > repacking.
> 
> Right. It could be an option to wait and see if the GSoC gives
> something.

Another option is to use rsync:// for initial clones.
 
Tell new developers that their initial command sequence to
(efficiently) get the base tree is:

  git clone rsync://git.gentoo.org/tree.git
  cd tree
  git config remote.origin.url git://git.gentoo.org/tree.git

rsync should be more efficient at dragging 1.6GiB over the network,
as its only streaming the files.  But it may fall over if the server
has a lot of loose objects; many more small files to create.

One way around that would be to use two repositories on the server;
a historical repository that is fully packed and contains the full
history, and a bleeding edge repository that users would normally
work against:

  git clone rsync://git.gentoo.org/fully-packed-tree.git tree
  cd tree
  git config remote.origin.url git://git.gentoo.org/tree.git
  git pull

Then every so often (e.g. once a Gentoo release cycle, so once
a year) pull the bleeding edge repository into the fully packed
repository.  That will introduce a single new pack file, so the
fully packed repository grows at a rate of 2 inodes/year, and is
still very efficient to rsync on initial clones.


That caching GSoC project may help, but didn't I see earlier in
this thread that you have >4.8 million objects in your repository?
Any proposals on that project would still have Git malloc()'ing
data per object; its ~80 bytes per object needed so that's a data
segment of 384+ MiB, per concurrent clone client.

-- 
Shawn.
