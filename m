From: Elijah Newren <newren@gmail.com>
Subject: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Tue, 27 Jul 2010 18:13:09 -0600
Message-ID: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 02:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OduGr-0005Yu-OO
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 02:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0G1ANM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 20:13:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45590 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab0G1ANL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 20:13:11 -0400
Received: by vws3 with SMTP id 3so3876826vws.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=199vGqQrmeXxSj2XBgjfc60wPZQPCwmnYqpUPN42T/M=;
        b=vhiZFZo8FXMWQcR3RLNvSUvZfwRG+cZeMUrGfTf1BQ8kXkBDKDZw0nUxbE3uv6RyW/
         KS78HGUBhbIvOB+kHjAaQLMDPa33NJFvGJ+87CuIO2SnhjIqwnUNSLJCEJu0JEXO6un2
         AO9R3Irmig9OJmWb8GoW//P/r/43UToW1sCCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=tpcIjWfnK0IMkB/HvNoGLNDDW2CyD/EWg1gccxfvBFYa2tj5pLGE0l+MRag2MO7T9d
         TAwe2TInmn/kiSbJFjjnoo/uMzJ1/xv+S4wFy94RBxYz3SUW2sSbtiqWjWWJzJFOWk8A
         T9pZP7mscECP98gQQoRPUn5icvoQe8gczMI/w=
Received: by 10.220.84.209 with SMTP id k17mr5609069vcl.247.1280275989390; 
	Tue, 27 Jul 2010 17:13:09 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Tue, 27 Jul 2010 17:13:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152020>

Hi,

2010/7/27 Shawn O. Pearce <spearce@spearce.org>:
> I would prefer doing something more like what we do with shallow
> on the client side. =C2=A0Record in a magic file the path(s) that we
> did actually obtain. =C2=A0During fsck, rev-list, or read-tree the
> client skips over any paths that don't match that file's listing.
> Then we can keep the same commit SHA-1s, but we won't complain that
> there are objects missing.

I recently decided to take a crack at implementing sparse clones, due
to a crazy idea I had (which might not be as crazy as I thought since
you suggest something similar, though more limited).  I was going to
wait until I actually got somewhere tangible with it to post an RFC,
particularly since it may take me a while, but since it's fresh on
everyone's minds perhaps now is good anyway.

Does the following seem sane, or are there big gotchas that I'm just un=
aware of?

0) Sparse clones have "all" commit objects, but not all trees/blobs.

Note that "all" only means all that are reachable from the refs being
downloaded, of course.  I think this is widely agreed upon and has
been suggested many times on this list.

1) A user controls sparseness by passing rev-list arguments to clone.

This allows a user to control sparseness both in terms of span of
content (files/directories) and depth of history.  It can also be used
to limit to a subset of refs (cloning just one or two branches instead
of all branches and tags).  For example,
  $ git clone ssh://repo.git dst -- Documentation/
  $ git clone ssh://repo.git dst master~6..master
  $ git clone ssh://repo.git dst -3
(Note that the destination argument becomes mandatory for those doing
a sparse clone in order to disambiguate it from rev-list options.)

This method also means users don't need much training to learn how to
use sparse clones -- they just use syntax they've already learned with
log, and clone will pass this info on to upload-pack.

There is a slight question as to whether users should have to specify
"--all HEAD" with all sparse clones or whether it should be assumed
when no other refs are listed.

2) Sparse checkouts are automatically invoked with the path(s) from
   the specified rev-list arguments.

Can't checkout content that we don't have.  :-)

This has a slight downside -- it makes sparse checkouts and sparse
clones slight misfits: the syntax (.gitignore style vs. rev-list
arguments) is a bit different, and sparse checkouts can exclude
certain paths whereas my sparse clones would only be able to *include*
paths.  I don't see this as a deal-breaker, but even if others
disagree I think a more general path-exclusion mechanism for the
revision walking machinery would be really nice for reasons beyond
just this one.  I've often wanted to do something like
  git log -S'important code phrase' --EXCLUDE-PATH=3Dbig-data-dir

3) The limiting rev-list arguments passed to clone are stored.

However, relative arguments such as "-3" or "master~6" first need to
be translated into one or more exclude ranges written as "^<sha1>".

4) All revision-walking operations automatically use these limiting arg=
s.

This should be a simple code change, and would enable rev-list, log,
etc. to avoid missing blobs/trees and thus enable them to work with
sparse clones.  fsck would take a bit more work, since it doesn't use
the setup_revisions() and revision.h walking machinery, but shouldn't
be too bad (I hope).

There are also performance ramifications: There should be no
measurable performance overhead for non-sparse clones (something that
might be a problem with a different implementation that did
does-this-exist check each time it references a blob).  It should also
be a significant performance boost for those using it, as operations
will only need to deal with the subset of the repository they specify
(faster downloads, stats, logs, etc.)

5) "Densifying" a sparse clone can be done

One can fetch a new pack and replace the limiting rev-list args with
the new choice.  The sparse checkout information needs to be updated
too.

(So users probably would want to densify a sparse clone with "pull"
rather than "fetch", as manually updating sparse checkouts may be a
bit of a hassle.)

6) Cloning-from/fetching-from/pushing-to sparse clones is supported.

=46uture fetches and pushes also make use of the limiting arguments.
Receives do as well, but only to make sure the pack obtained is not
"more sparse" than what the receiving repository already has.
(uploads ignore the stored rev-list arguments, instead using the
rev-list arguments passed to it -- it will die if asked for content
not locally available to it.)

7) Operations that need unavailable data simply error out

Examples: merge, cherry-pick, rebase (and upload-pack in a sparse
clone).  However, hopefully the error messages state what extra
information needs to be downloaded so the user can appropriately
"densify" their repository.


Thanks,
Elijah
