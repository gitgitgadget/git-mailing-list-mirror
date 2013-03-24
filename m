From: Jeff King <peff@peff.net>
Subject: propagating repo corruption across clone
Date: Sun, 24 Mar 2013 14:31:33 -0400
Message-ID: <20130324183133.GA11200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 19:32:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJpi9-0006H9-Cr
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 19:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab3CXSbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 14:31:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab3CXSbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 14:31:36 -0400
Received: (qmail 17909 invoked by uid 107); 24 Mar 2013 18:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Mar 2013 14:33:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2013 14:31:33 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218964>

I saw this post-mortem on recent disk corruption seen on git.kde.org:

  http://jefferai.org/2013/03/24/too-perfect-a-mirror/

The interesting bit to me is that object corruption propagated across a
clone (and oddly, that --mirror made complaints about corruption go
away). I did a little testing and found some curious results (this ended
up long; skip to the bottom for my conclusions).

Here's a fairly straight-forward corruption recipe:

-- >8 --
obj_to_file() {
  echo ".git/objects/$(echo $1 | sed 's,..,&/,')"
}

# corrupt a single byte inside the object
corrupt_object() {
  fn=$(obj_to_file "$1") &&
  chmod +w "$fn" &&
  printf '\0' | dd of="$fn" bs=1 conv=notrunc seek=10
}

git init repo &&
cd repo &&
echo content >file &&
git add file &&
git commit -m one &&
corrupt_object $(git rev-parse HEAD:file)
-- 8< --

report git clone . fast-local
report git clone --no-local . no-local
report git -c transfer.unpackLimit=1 clone --no-local . index-pack
report git -c fetch.fsckObjects=1 clone --no-local . fsck

and here is how clone reacts in a few situations:

  $ git clone --bare . local-bare && echo WORKED
  Cloning into bare repository 'local-bare'...
  done.
  WORKED

We don't notice the problem during the transport phase, which is to be
expected; we're using the fast "just hardlink it" code path. So that's
OK.

  $ git clone . local-tree && echo WORKED
  Cloning into 'local-tree'...
  done.
  error: inflate: data stream error (invalid distance too far back)
  error: unable to unpack d95f3ad14dee633a758d2e331151e950dd13e4ed header
  WORKED

We _do_ see a problem during the checkout phase, but we don't propagate
a checkout failure to the exit code from clone.  That is bad in general,
and should probably be fixed. Though it would never find corruption of
older objects in the history, anyway, so checkout should not be relied
on for robustness.

  $ git clone --no-local . non-local && echo WORKED
  Cloning into 'non-local'...
  remote: Counting objects: 3, done.
  remote: error: inflate: data stream error (invalid distance too far back)
  remote: error: unable to unpack d95f3ad14dee633a758d2e331151e950dd13e4ed header
  remote: error: inflate: data stream error (invalid distance too far back)
  remote: fatal: loose object d95f3ad14dee633a758d2e331151e950dd13e4ed (stored in ./objects/d9/5f3ad14dee633a758d2e331151e950dd13e4ed) is corrupt
  error: git upload-pack: git-pack-objects died with error.
  fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
  remote: aborting due to possible repository corruption on the remote side.
  fatal: early EOF
  fatal: index-pack failed

Here we detect the error. It's noticed by pack-objects on the remote
side as it tries to put the bogus object into a pack. But what if we
already have a pack that's been corrupted, and pack-objects is just
pushing out entries without doing any recompression?

Let's change our corrupt_object to:

  corrupt_object() {
    git repack -ad &&
    pack=`echo .git/objects/pack/*.pack` &&
    chmod +w "$pack" &&
    printf '\0' | dd of="$pack" bs=1 conv=notrunc seek=175
  }

and try again:

  $ git clone --no-local . non-local && echo WORKED
  Cloning into 'non-local'...
  remote: Counting objects: 3, done.
  remote: Total 3 (delta 0), reused 3 (delta 0)
  error: inflate: data stream error (invalid distance too far back)
  fatal: pack has bad object at offset 169: inflate returned -3
  fatal: index-pack failed

Great, we still notice the problem in unpack-objects on the receiving
end. But what if there's a more subtle corruption, where filesystem
corruption points the directory entry for one object at the inode of
another. Like:

  corrupt_object() {
    corrupt=$(echo corrupted | git hash-object -w --stdin) &&
    mv -f $(obj_to_file $corrupt) $(obj_to_file $1)
  }

This is going to be more subtle, because the object in the packfile is
self-consistent but the object graph as a whole is broken.

  $ git clone --no-local . non-local && echo WORKED
  Cloning into 'non-local'...
  remote: Counting objects: 3, done.
  remote: Total 3 (delta 0), reused 0 (delta 0)
  Receiving objects: 100% (3/3), done.
  error: unable to find d95f3ad14dee633a758d2e331151e950dd13e4ed
  WORKED

Like the --local cases earlier, we notice the missing object during the
checkout phase, but do not correctly propagate the error.

We do not notice the sha1 mis-match on the sending side (which we could,
if we checked the sha1 as we were sending). We do not notice the broken
object graph during the receive process either. I would have expected
check_everything_connected to handle this, but we don't actually call it
during clone! If you do this:

  $ git init non-local && cd non-local && git fetch ..
  remote: Counting objects: 3, done.
  remote: Total 3 (delta 0), reused 3 (delta 0)
  Unpacking objects: 100% (3/3), done.
  fatal: missing blob object 'd95f3ad14dee633a758d2e331151e950dd13e4ed'
  error: .. did not send all necessary objects

we do notice.

And one final check:

  $ git -c transfer.fsckobjects=1 clone --no-local . fsck
  Cloning into 'fsck'...
  remote: Counting objects: 3, done.
  remote: Total 3 (delta 0), reused 3 (delta 0)
  Receiving objects: 100% (3/3), done.
  error: unable to find d95f3ad14dee633a758d2e331151e950dd13e4ed
  fatal: object of unexpected type
  fatal: index-pack failed

Fscking the incoming objects does work, but of course it comes at a cost
in the normal case (for linux-2.6, I measured an increase in CPU time
with "index-pack --strict" from ~2.5 minutes to ~4 minutes). And I think
it is probably overkill for finding corruption; index-pack already
recognizes bit corruption inside an object, and
check_everything_connected can detect object graph problems much more
cheaply.

One thing I didn't check is bit corruption inside a packed object that
still correctly zlib inflates. check_everything_connected will end up
reading all of the commits and trees (to walk them), but not the blobs.
And I don't think that we explicitly re-sha1 every incoming object (only
if we detect a possible collision). So it may be that
transfer.fsckObjects would save us there (it also introduces new
problems if there are ignorable warnings in the objects you receive,
like zero-padded trees).

So I think at the very least we should:

  1. Make sure clone propagates errors from checkout to the final exit
     code.

  2. Teach clone to run check_everything_connected.

I don't have details on the KDE corruption, or why it wasn't detected
(if it was one of the cases I mentioned above, or a more subtle issue).

-Peff
