From: Jeff King <peff@peff.net>
Subject: [PATCH 0/4] fix packed-refs races
Date: Mon, 6 May 2013 22:36:11 -0400
Message-ID: <20130507023610.GA22053@sigill.intra.peff.net>
References: <20130503083847.GA16542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:36:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXlL-0002Vz-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933857Ab3EGCgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:36:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:43623 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757421Ab3EGCgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:36:13 -0400
Received: (qmail 14211 invoked by uid 102); 7 May 2013 02:36:33 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:36:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:36:11 -0400
Content-Disposition: inline
In-Reply-To: <20130503083847.GA16542@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223524>

This fixes the races I brought up in the surrounding thread:

  http://thread.gmane.org/gmane.comp.version-control.git/223299

The individual races are describe in more detail in each commit, but for
reference, here is the complete reproduction recipe (which I posted
already in several parts throughout the thread, but is collected here):

  # base.sh
  # run this script forever in one terminal
  git init -q repo &&
  cd repo &&
  git commit -q --allow-empty -m one &&
  one=`git rev-parse HEAD` &&
  git commit -q --allow-empty -m two &&
  two=`git rev-parse HEAD` &&
  sha1=$one &&
  while true; do
    # this re-creates the loose ref in .git/refs/heads/master
    if test "$sha1" = "$one"; then
      sha1=$two
    else
      sha1=$one
    fi &&
    git update-ref refs/heads/master $sha1 &&

    # we can remove packed-refs safely, as we know that
    # its only value is now stale. Real git would not do
    # this, but we are simulating the case that "master"
    # simply wasn't included in the last packed-refs file.
    rm -f .git/packed-refs &&

    # and now we repack, which will create an up-to-date
    # packed-refs file, and then delete the loose ref
    git pack-refs --all --prune
  done

  # lookup.sh
  # run this script simultaneously in another terminal; when it exits,
  # git is broken (it erroneously told us that master did not exist).
  # It is fixed by applying up to patch 3/4 below.
  cd repo &&
  while true; do
    ref=`git rev-parse --verify master`
    echo "==> $ref"
    test -z "$ref" && break
  done

  # enumerate.sh
  # run this script simultaneously in another terminal (either with
  # lookup.sh running, too, or just base.sh); when it exits, we
  # for-each-ref has erroneously missed master. It is fixed by applying
  # up to patch 4/4 below.
  cd repo &&
  while true; do
    refs=`git.compile for-each-ref --format='%(refname)'`
    echo "==> $refs"
    test -z "$refs" && break
  done

I don't think is a purely hypothetical race. About once a month for the
past six months or so, I'll run across a corrupted repository on
github.com that is inexplicably missing a few objects near the tip of a
ref. This last time, I happened to catch something very odd in our ref
audit-log. The log for the repo that became corrupted showed a small
push to the tip of "master", but the objects for that push were missing
(the previous ref tip was fine). At almost the exact same time, our
alternates repo was running a "fetch --prune" from the corrupted repo.
But it didn't see the corrupted master ref; it saw that
refs/heads/master didn't exist at all, and it deleted it.

I believe that git-upload-pack hit the enumeration race above, and
showed a ref advertisement in which refs/heads/master was missing[1],
leading fetch to delete the ref. At the same time, a gc was running in
the corrupted repo which hit the same issue, and ended up pruning[2] the
newly pushed objects, which were not referenced from anywhere else.

It may seem unlikely for two programs to hit the race at the same time
(especially given the number of iterations you need to trigger the race
with the scripts above), but I think it's exacerbated when you have a
very large number of refs (because the loose enumeration takes much
longer). So I think there's a good chance this was my problem. And if
not, it is good to fix anyway. :)

  [1/4]: resolve_ref: close race condition for packed refs
  [2/4]: add a stat_validity struct
  [3/4]: get_packed_refs: reload packed-refs file when it changes
  [4/4]: for_each_ref: load all loose refs before packed refs

-Peff

[1] Usually the enumeration race would cause you to see the old value
    from the packed-refs file, not a completely missing ref (unless the
    ref was not packed at all previously, but that is almost certainly
    not the case here). But it does call into resolve_ref to actually
    read the ref, which has its own race that can cause refs to
    "disappear" (and is fixed by patch 1).

    As an aside, I think that calling resolve_ref is probably wrong. We
    know we have a fully qualified refname, because we keep track of
    which directory we are calling readdir() on. But if for whatever
    reason somebody deletes it at the exact moment between when we see
    it in readdir() and when we try to open it (not packs it, but
    actually deletes it), then we'll see it is missing and fall back to
    trying other ref-lookups. So in theory a race with a delete of
    refs/heads/foo could accidentally retrieve the value for
    refs/heads/refs/heads/foo.

    It's quite unlikely, though, and I'm not too concerned about it.

[2] Recently pushed objects should still be safe, even if they are
    unreachable. However, in our case the pruning was exacerbated by a
    gc codepath that could call "git repack -ad" (not in upstream git,
    but we do our own custom gc due to the alternates structure of our
    forks). I've also fixed that, as we should always be using "-A" to
    keep recent unreachable objects.
