From: Jeff King <peff@peff.net>
Subject: Re: Syntax check via update hook?
Date: Thu, 14 May 2009 02:55:44 -0400
Message-ID: <20090514065544.GC10411@coredump.intra.peff.net>
References: <wsprejtm71.fsf@usg.edu> <20090509144711.GA3926@sigill.intra.peff.net> <wsd4aem8rh.fsf@usg.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Plaksin <happy@usg.edu>
X-From: git-owner@vger.kernel.org Thu May 14 08:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UrB-0000u5-5l
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760871AbZENGzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 02:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760788AbZENGzp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:55:45 -0400
Received: from peff.net ([208.65.91.99]:50335 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760617AbZENGzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 02:55:45 -0400
Received: (qmail 20426 invoked by uid 107); 14 May 2009 06:55:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 May 2009 02:55:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 02:55:44 -0400
Content-Disposition: inline
In-Reply-To: <wsd4aem8rh.fsf@usg.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119155>

On Tue, May 12, 2009 at 03:16:50PM -0400, Mark Plaksin wrote:

> >         $ cat <<EOF >.git/hooks/update
> >         #!/bin/sh
> >         GIT_INDEX_FILE=/path/to/tempdir/index; export GIT_INDEX_FILE
> >         cd /path/to/tempdir/tree &&
> >         mkdir -p tree &&
> >         git read-tree "$3" &&
> >         git checkout-index &&
> >         your_syntax_check
> >         EOF
> >         $ chmod +x .git/hooks/update
> 
> Thanks for helping! :)
> 
> Unfortunately we don't quite get it.  Can you flesh out your example a
> bit and explain the concepts involved?  We're relative git newbies.  We
> tried reading the man pages to the commands you use to no avail.  One
> big stumbling block seems to be how we create/set-up tempdir.  Is that
> supposed to be a pre-created git checkout, or created via git-archive,
> or .. ?

What I was trying to say earlier is that you have two choices based on
how efficient you want to make it. The simple way is to use git-archive:

  $ cat <<EOF >.git/hooks/update
  #!/bin/sh
  tempdir=`mktemp -d`
  trap 'rm -rf "$tempdir"' 0
  git archive --format=tar "$3" | tar -C "$tempdir" -xf -
  cd "$tempdir" && do_your_syntax_check || exit 1
  EOF

which will create the temp directory from scratch each time. If you have
a big tree, though, that can be quite inefficient to do on each push.

The other option is to ask git to update the temp directory with just
the changes. That was shown in my first example above: we load git's
concept of what the tree should look like (given by the commit id, which
in turn points to a tree id) into an index, which is git's mechanism for
interfacing between committed storage and the filesystem. Then we ask it
to sync what's in the filesystem with what's in the index. So it should
be much more efficient, but as you can see, less obvious (and I didn't
actually test that what I wrote works at all; it was just meant to point
you in the right direction).

However, all of that being said, if you just want:

> Also, we actually just want to check the syntax of the files that were
> changed in the commit, not the whole tree.  Will your method give us
> access to the path names of the files that changed?

That is simpler, especially if you can feed the files to your
syntax-checker over stdin. You just need to enumerate the files, and
then ask git to dump each one:

  #!/bin/sh
  git diff-tree -r "$3" |
  while read old_mode new_mode old_sha1 new_sha1 status name; do
    # skip lines showing parent commit
    test -z "$new_sha1" && continue;
    if ! git cat-file blob $new_sha1 | your_syntax_checker; then
      echo >&2 "syntax check failed: $name ($new_sha1)"
      exit 1
    fi
  done

Make sense?

-Peff
