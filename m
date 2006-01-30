From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] shallow clone
Date: Sun, 29 Jan 2006 23:18:50 -0800
Message-ID: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 30 08:19:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3TKL-0001si-L2
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 08:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWA3HSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 02:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWA3HSx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 02:18:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6385 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932111AbWA3HSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 02:18:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130071626.DDPN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 02:16:26 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15265>

Shallow History Cloning
=======================

One good thing about git repository is that each clone is a
freestanding and complete entity, and you can keep developing in
it offline, without talking to the outside world, knowing that
you can sync with them later when online.

It is also a bad thing.  It gives people working on projects
with long development history stored in CVS a heart attack when
we tell them that their clones need to store the whole history.

There was a suggestion by Linus to allow a partial clone using a
syntax like this:

	$ git clone --since=v2.6.14 git://.../linux-2.6/ master

Here is an outline of what changes are needed to the current
core to do this.


Strategy
--------

We have `info/grafts` mechanism to fake parent information for
commit objects.  Using this facility, we could roughly do:

. Download the full tree for v2.6.14 commit and store its
  objects locally.

. Set up `info/grafts` to lie to the local git that Linux kernel
  history began at v2.6.14 version.

. Run `git fetch git://.../linux-2.6 master`, with a local ref
  pointing at v2.6.14 commit, to pretend that we have everything
  up to v2.6.14 to `upload-pack` running on the other end.

. Update the `origin` branch with the master commit object name
  we just fetched from Linus.

There are some issues.

. In the fetch above to obtain everything after v2.6.14, and
  future runs of `git fetch origin`, if a blob that is in the
  commit being fetched happens to match what used to be in a
  commit that is older than v2.6.14 (e.g. a patch was reverted),
  `upload-pack` running on the other end is free to omit sending
  it, because we are telling it that we are up to date with
  respect to v2.6.14.  Although I think the current `rev-list
  --objects` implementation does not always do such a revert
  optimization if the revert is to a blob in a revision that is
  sufficiently old, it is free to optimize more aggressively in
  the future.

. Later when the user decides to fetch older history, the
  operation can become a bit cumbersome.

I think the latter one is cumbersome but is doable -- we could
do the equivalent of:

	$ git clone --since=v2.6.13 origin v2.6.14

place all the objects obtained by such a clone/fetch operation
and remember that now we have history beginning at v2.6.13.  So
let's worry about that later.

For the first issue, we need to have the other end cooperate
while fetching from it.  If the other end also thinks the
development started at v2.6.14, even if we tell that we have the
history up to v2.6.14 (or a commit we obtained since then),
there is no way for `upload-pack` running there to optimize too
agressively and assume we have a blob that appeared in v2.6.13.
More simply, we do not have to tell them we have anything -- if
the other end thinks the epoch is at v2.6.14, only commits that
comes later will be sent to us.


Design
------

First, to bootstrap the process, we would need to add a way to
obtain all objects associated with a commit.  We could do a new
program, or we could implement this as a protocol extension to
`upload-pack`.  My current inclination is the latter.

When talking with `upload-pack` that supports this extension,
the downloader can give one commit object name and get a pack
that contains all the objects in the tree associated with that
commit, plus the commit object itself.  This is a rough
equivalent of running the commit walker with the `-t` flag.

Another functionality we would need is to tell `upload-pack` to
use `info/grafts` of downloader's choice.  With this, after
fetching the objects for v2.6.14 commit, the downloader can set
up its own grafts file to cauterize the development history at
v2.6.14, and tell the `upload-pack` to pretend the kernel
history starts at that commit, while sending the tip of Linus'
development track to us.

Using the extended protocol (let's call it 'shallow' extension),
a clone to create a repository that has only recent kernel
history since v2.6.14 goes like this:

The first client is to fetch the v2.6.14 itself.

[NOTE]
Most likely this is not directly run by the user but is run as
the first command invoked by the shallow clone script.

1. The `fetch-pack` command acquires a new option, `--single`:

	$ git-fetch-pack --single git://.../linux-2.6/ v2.6.14

   This talks with `upload-pack` on the kernel.org server via
   `git-daemon`.

2. `upload-pack` tells the fetcher what commits it has,
   what their refs are, and what protocol extensions it
   supports, as usual.

3. If it does not see `shallow` extension supported, there is no
   way to get a single tree, so things fail here.  Otherwise, it
   sends `single X{40}\0` request, instead of the usual `want`
   line.  The object name sent here is the desired commit.

4. `upload-pack` notices this is a single commit request, and
   sends an ACK if it can satisfy the request (or a NAK if it
   can't, e.g. it does not have the asked commit).  Instead of
   doing the usual `get_common_commits` followed by
   `create_pack_file`, it does:

	$ git rev-list -n1 --objects $commit | git pack-object

   and sends the result out.

5. The fetcher checks the ACK and receives the objects.

After the above exchange, we have downloaded v2.6.14 commit and
its objects but not its history.  `git-fetch-pack` would output
the tag object name for `v2.6.14` and we would stash it away in
`$GIT_DIR/FETCH_HEAD` as usual.  Then we set up `info/grafts`
with this:

	$ git rev-parse FETCH_HEAD^{commit} >"$GIT_DIR/info/grafts"

This cauterizes the history on our end.

The second phase of the shallow clone is to fetch the history
since v2.6.14 to the tip.

1. The `fetch-pack` command is run as usual.  Most likely the
   command line run by the shallow clone script would be:

	$ git fetch-pack git://.../linux-2.6/ master

   Notice there is nothing magical about it.  It is just the
   business as usual.

2. `upload-pack` does its usual greeting to the downloader.

3. We notice `shallow` extension again, and first send out
   `graft X{40}\0` request.  The syntax of graft request would
   be `graft ` followed by one or more commit object names on a
   line separated with SP.  After sending out all the needed
   graft requests (in this example there is only one, to
   cauterize the history at v2.6.14), it does the usual `want
   X{40}\0multi_ack` and a flush.

4. `upload-pack` notices graft requests, reinitializes its graft
   information with what it receives from the other end, and
   then records `want`.

5. After the above steps, the usual `upload-pack` vs
   `fetch-pack` exchange continues and objects needed to
   complete the Linus' tip of development trail for somebody who
   has v2.6.14 are sent in a pack.  The difference from the
   usual operation is that `upload-pack` during this run thinks
   v2.6.14 commit does not have any parent.

The exact sequence from the second part of the initial "shallow
clone" can be used for further updates.

There is a small issue about the actual implementation.  In the
above description I pretended that `upload-pack` can be told to
use phony grafts information, but in the current implementation
the program that needs to use phony grafts information is
`rev-list` spawned from it.  We _could_ point GIT_GRAFT_FILE
environment variable point at a temporary file while we do so,
but I'd like to avoid using a temporary file if possible, given
that `upload-pack` is run from `git-daemon`.  Maybe we could
give --read-graft-from-stdin flag to `rev-list` for this
purpose.


Anybody want to try?
