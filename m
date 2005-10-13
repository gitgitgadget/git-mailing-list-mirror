From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix packname hash generation.
Date: Wed, 12 Oct 2005 19:46:28 -0700
Message-ID: <7v3bn6877f.fsf@assigned-by-dhcp.cox.net>
References: <20051012173426.56fd5c1c.vsu@altlinux.ru>
	<20051012135405.CDE55E005E3@center4.mivlgu.local>
	<7vslv6b86l.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 13 04:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPt7T-0000FX-2Z
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 04:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVJMCqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 22:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVJMCqa
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 22:46:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1490 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751102AbVJMCqa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 22:46:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051013024630.FLNY9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 22:46:30 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10059>

Junio C Hamano <junkio@cox.net> writes:

> This changes the generation of hash packfiles have in their names, from
> "hash of object names as fed to us" to "hash of object names in the
> resulting pack, in the order they appear in the index file".  The new
> "git-index-pack" command is taught to output the computed hash value
> to its standard output.

In case it was not obvious, this is not a backward incompatible
change.  Your existing packs will be valid after this change.

What those 40-byte hashes were buying us was that we did not
have to worry about name clashes.  We could have said "these two
packs have the same name so they must have the same set of
objects", but there is no tool that relies on this fact.  We
could not even say "these two packs have different names so the
set of objects contained by them must be different" -- the
resulting pack name depended on the order of objects fed to
git-pack-objects, even if you fed the same set of objects.

The really core part never cared about how packfiles and their
indices are named.  The only restrictions were that they live
immediately under .git/objects/pack/, have .pack and .idx suffix
respectively, and their basename match with each other.

The commit walkers (anything that link with fetch.c) impose
another limitation that their basenames are "pack-" followed by
40-byte hexadecimal digits.  But they do not check if the name
is consistent with the set of objects in the pack (checking it
was computationally infeasible for huge packs in the previous
hashing mechanism -- you have to feed all permutations of
objects contained in the pack to SHA1 hash and see if any
produces the same hash as the pack name).  We _could_ now do
this additional check if we wanted to (the same goes to the
really core part in sha1_file.c::check_packed_git_idx()).

In short, it does not matter if your existing packs are named
using the old hashing mechanism.  They will continue to be
valid.

But if you really care about consistency, here is an easy way to
rename your existing packs to their new names the new hashing
scheme would produce.

#!/bin/sh

: ${GIT_DIR=.git}
: ${GIT_OBJECT_DIRECTORY="${GIT_DIR}/objects"}

O="$GIT_OBJECT_DIRECTORY"
P="$GIT_OBJECT_DIRECTORY/pack"
for existing in `cd "$GIT_OBJECT_DIRECTORY" &&
		 find pack -name '*.pack' -print`
do
    idx=`expr "$existing" : '\(.*\)\.pack$'`.idx &&
    test -f "$O/$idx" || {
        echo >&2 "Missing idx $idx?"
        continue
    }
    new=`git-index-pack -o tmp-idx "$O/$existing"` || {
        echo >&2 "Corrupt pack $existing?"
        continue
    }           
    # index generated for an existing pack should match.
    cmp "$O/$idx" tmp-idx || {
        echo >&2 "Corrupt idx $idx?"
        continue
    }
    if test "pack/pack-$new.pack" = "$existing"
    then
        echo >&2 "Already converted $existing."
        continue
    fi
    if test -f "$P/pack-$new.pack" || test -f "$P/pack-$new.idx"
    then
        echo >&2 "Name clash! $new"
        continue
    fi
    mv "$O/$existing" "$P/pack-$new.pack" &&
    mv "$O/$idx" "$P/pack-$new.idx" || {
        echo >&2 "Cannot move $existing to $new"
        continue
    }
    echo >&2 "Renamed $existing -> $new"
done
