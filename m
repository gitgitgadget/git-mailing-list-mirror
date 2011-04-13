From: "George Spelvin" <linux@horizon.com>
Subject: Re: is hosting a read-mostly git repo on a distributed file system practical?
Date: 12 Apr 2011 23:47:15 -0400
Message-ID: <20110413034715.15553.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com, spearce@spearce.org
To: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 13 05:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9r3B-0006sU-EC
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 05:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab1DMDrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 23:47:17 -0400
Received: from science.horizon.com ([71.41.210.146]:29483 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756834Ab1DMDrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 23:47:16 -0400
Received: (qmail 15554 invoked by uid 1000); 12 Apr 2011 23:47:15 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171431>

> All clients, including the client that occasionally updates the
> read-mostly repo would be mounting the DFS as a local file system. My
> environment is one where DFS is easy, but establishing a shared server
> is more complicated (ie. bureaucratic).

> I guess I am prepared to put up with a slow initial clone (my developer
> pool will be relatively stable and pulling from a peer via git: or ssh:
> will usually be acceptable for this occasional need).

> What I am most interested in is the incremental performance. Can my
> integrator, who occasionally updates the shared repo, avoid automatically
> repacking it (and hence taking the whole of repo latency hit) and can
> my developers who are pulling the updates do so reliably without a whole
> of repo scan?

I think the answers are yes, but I have to make a vouple of things clear:
* You can *definitely* control repack behaviour.  .keep files are the
  simplest way to prevent repacking.
* Are you talking about hosting only a "bare" repository, or one with
  the unpacked source tree as well?  If you try to run git commands on
  a large network-mounted source tree, things can get more than a bit
  sluggish; git recursively stats the whole tree fairly frequently.
  (There are ways to precent that, notably core.ignoreStat, but they
  make it less friendly.)
* You can clone from a repository mounted on the file system just as
  easily as you can from a network server.  So there's no need to set
  up a server if you find it onconvenient.
* Normally, the developers will clone from the integrator's repository
  before doing anything, so the source tree, and any changes they make,
  will be local.
* A local clone will try to hard link to the object directory.  I think
  it will copy them if it fails, or you can force that with "git clone
  --no-hardlinks".  For a more space-saving version, try "git clone
  -s", which will make a sort of soft link to the upstream repository.
  It's a git concept, so repacking upstream won't do any harm, but you
  Must Not delete objects from the upstream repository or you'll create
  dangling references in the downstream.
* If using the objects on the DFS mount turns out to be slow, you can
  just do the initial clone with --no-hardlinks.  Then the developers'
  day-to-day work is all local.

Indeed, you could easily do everything via DFS.  Give everyone a personal
"public" repo to push to, which is read-only to everyone else, and let
the integrator pull from those.

> I understand that avoiding repacking for an extended period brings its
> own problems, so I guess I could live with a local repack followed by
> an rsync transfer to re-initial the shared remote, if this was
> warranted.

Normally, you do a generational garbage collection thing.  You repack the
current work frequently (which is fast to do, and to share, because
it's small), and the larger, slower, older packs less frequently.

Anyway, I hope this helps!
