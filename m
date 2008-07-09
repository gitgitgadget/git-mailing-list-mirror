From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git push to amazon s3 [was: [GSoC] What is status of Git's
	Google Summer of Code 2008 projects?]
Date: Wed, 9 Jul 2008 03:22:22 +0000
Message-ID: <20080709032222.GA18520@spearce.org>
References: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nick Hengeveld <nickh@reactrix.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 05:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQK6-00043z-ND
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 05:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbYGIDWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYGIDWX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:22:23 -0400
Received: from george.spearce.org ([209.20.77.23]:35806 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYGIDWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:22:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D8D538195; Wed,  9 Jul 2008 03:22:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87833>

Tarmigan <tarmigan+git@gmail.com> wrote:
> (trimmed cc list to folks who've touched http-push.c)
> On Mon, Jul 7, 2008 at 9:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Using Marek's pack generation code I added support for push over
> > the dumb sftp:// and amazon-s3:// protocols, with the latter also
> > supporting transparent client side encryption.
> 
> Can you describe the s3 support that you added?  Did you do any
> locking when you pushed?  The objects and packs seem likely to be
> naturally OK, but I was worried about refs/ and especially
> objects/info/packs and info/refs (fetch over http works currently out
> of the box with publicly accessable s3 repos).

It behaves like http push does in C git in that it is pretty
transparent to the end-user:

  # Create a bucket using other S3 tools.
  # I used jets3t's cockpit tool to creat "gitney".

  # Create a configuration file for jgit's S3 client:
  #
  $ touch ~/.jgit_s3_public
  $ chmod 600 ~/.jgit_s3_public
  $ cat >>~/.jgit_s3_public
  accesskey: AWSAccessKeyId
  secretkey: AWSSecretAccessKey
  acl: public
  EOF

  # Configure the remote and push
  #
  $ git remote add s3 amazon-s3://.jgit_s3_public@gitney/projects/egit.git/
  $ jgit push s3 refs/heads/master
  $ jgit push --tags s3

  # Future incremental updates are just as easy
  #
  $ jgit push s3 refs/heads/master

  (or)
  $ git config remote.s3.push refs/heads/master
  $ jgit push s3

This is now cloneable[*1*]:

  $ git clone http://gitney.s3.amazonaws.com/projects/egit.git

Pushes are incremental, rather than the approach you outlined, as
that causes a full re-upload of the repository.  Consequently there
is relatively little bandwidth usage during subsequent pushes.

A jgit amazon-s3 URL is organized as:

  amazon-s3://$config@$bucket/$prefix

where:

  $config = path to configuration in $GIT_DIR/$config or $HOME/$config
  $bucket = name of the Amazon S3 bucket holding the objects
  $prefix = prefix to apply to all objects, implicitly ends in "/"


Amazon S3 atomically replaces a file, but offers no locking support.
Our crude remote VFS abstraction offers two types of file write
operations:

  - Atomic write for small (in-memory) files <~1M
  - Stream write for large (e.g. pack) files >~1M

In the S3 implementation both operations are basically the same
code, since even large streams are atomic updates.  But in sftp://
our remote VFS writes to a "$path.lock" for the atomic case and
renames to "$path".  This is not the same as a real lock, but it
avoids readers from seeing an in-progress update.

We are very carefully to order the update operations to try and
avoid any sorts of race conditions:

  - Delete loose refs which are being deleted.
  - Upload new pack:
    - If same pack already exists:
      - (atomic) Remove it from objects/info/packs
      - Delete .idx
      - Delete .pack
    - Upload new .pack
    - Upload new .idx
    - (atomic) Add to front of objects/info/packs.
  - (atomic) Create/update loose refs.
  - (atomic) Update (if necessary) packed-refs.
  - (atomic) Update info/refs.

Since we are pushing over a dumb transport we assume readers
are pulling over the same dumb transport and thus rely upon the
objects/info/packs and info/refs files to obtain the listing of
what is available.  This isn't true though for jgit's sftp://
and amazon-s3:// protocols as both support navigation of the
objects/packs and refs/{heads,tags} tree directly.

Locking on S3 is difficult.  Multi-object writes may not sync
across the S3 cluster immediately.  This means you can write to A,
then to B, then read A and see the old content still there, then
seconds later read A again and see the new content suddenly arrive.
It all depends upon when the replicas update and which replica
the load-balancer sends you into during the request.  So despite
our attempts to order writes to S3 it is still possible for an S3
write to appear "late" and for a client to see a ref in info/refs
for which the corresponding pack is not listed in object/info/packs.

However, this is the same mirroring problem that kernel.org has for
its git trees.  I believe they are moved out to the public mirrors
by dumb rsync and not some sort of smart git-aware transport.
As rsync is free to order the writes out of order kernel.org has
the same issue.  ;-)

Actually I suspect the S3 replica update occurs more quickly than
the kernel.org mirrors update, so the window under which a client
can see out-of-order writes is likely smaller.


*1* You need a bug fix in jgit to correctly initialize HEAD during
    push to a new, non-existant repository stored on S3.  The patch
    is going to be posted later this evening, its still in my tree.

-- 
Shawn.
