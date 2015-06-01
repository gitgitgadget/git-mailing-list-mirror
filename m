From: Jeff King <peff@peff.net>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 04:14:50 -0400
Message-ID: <20150601081450.GA32634@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git list <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 10:15:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzKsE-0004XL-D8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 10:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbbFAIO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 04:14:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:38624 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753064AbbFAIOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 04:14:54 -0400
Received: (qmail 10433 invoked by uid 102); 1 Jun 2015 08:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 03:14:53 -0500
Received: (qmail 27066 invoked by uid 107); 1 Jun 2015 08:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 04:14:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 04:14:50 -0400
Content-Disposition: inline
In-Reply-To: <556C0BAD.80106@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270380>

On Mon, Jun 01, 2015 at 09:37:17AM +0200, Stefan N=C3=A4we wrote:

> One of my repos started giving an error on 'git gc' recently:
>=20
>  $ git gc
>  error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85
>  Counting objects: 3052, done.
>  Delta compression using up to 4 threads.
>  Compressing objects: 100% (531/531), done.
>  Writing objects: 100% (3052/3052), done.
>  Total 3052 (delta 2504), reused 3052 (delta 2504)
>  error: Could not read 7713c3b1e9ea2dd9126244697389e4000bb39d85

The only error string that matches that is the one in parse_commit(),
when we fail to read the object. It happens twice here because
`git gc` runs several subcommands; you can see which ones are generatin=
g
the error if you run with GIT_TRACE=3D1.

I am surprised that it doesn't cause the commands to abort, though. If
we are traversing the object graph to repack, for example, we would wan=
t
to abort if we are missing a reachable object (i.e., the repository is
corrupt).

> I tried:
>=20
>  $ git cat-file -t 7713c3b1e9ea2dd9126244
>  fatal: Not a valid object name 7713c3b1e9ea2dd9126244

Not surprising, if we don't have the object. What is curious is why git
wants to look it up in the first place. I.e., who is referencing it?

Either:

  1. It is an object that we are OK to be missing (e.g., the
     UNINTERESTING side of a traversal), and the error should be
     suppressed.

  2. Your repository really is corrupted, and this is a case where we
     need to be paying attention to the return value of parse_commit bu=
t
     are not.

I'd love to see:

  - the output of "GIT_TRACE=3D1 git gc" (to see which subcommand is
    causing the error)

  - the output of "git fsck" (which should hopefully confirm whether or
    not there is a real problem)

  - any mentions of the sha1 in the refs or reflogs. Something like:

      sha1=3D7713c3b1e9ea2dd9126244697389e4000bb39d85
      cd .git
      grep $sha1 $(find packed-refs refs logs -type f)

  - If that doesn't turn up any hits, then presumably it's an object
    referencing the sha1. We can dig into the objects (all of them, not
    just reachable ones), like:

      {
        # loose objects
        (cd .git/objects && find ?? -type f | tr -d /)
        # packed objects
        for i in .git/objects/pack/*.idx; do
          git show-index <$i
        done | cut -d' ' -f2
      } |
      # omit blobs; they are expensive to access and cannot have
      # reachability pointers
      git cat-file --batch-check=3D'%(objecttype) %(objectname)' |
      grep -v ^blob |
      cut -d' ' -f2 |
      # now get all of the contents, and look for our object; this is
      # going to be slow, since it's one process per object; but we
      # can't use --batch because we need to pretty-print the trees
      xargs -n1 git cat-file -p |
      less +/$sha1

I would have guessed this was maybe caused by trying to traverse
unreachable recent objects for reachability. It fits case 1 (it is OK
for us to be missing these objects, but we might accidentally complain)=
,
and it would probably happen twice during a gc (once for the repack, an=
d
once for `git prune`).

But that code should not be present in older versions of msysgit, as it
came in v2.2.0 (and I assume "older msysgit is v1.9.5). And if that is
the problem, it would follow a copy of the repo, but not a clone (thoug=
h
I guess if your clone was on the local filesystem, we blindly hardlink
the objects, so it might follow there).

-Peff
