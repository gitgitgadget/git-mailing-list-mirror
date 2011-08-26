From: Jeff King <peff@peff.net>
Subject: Re: Looking up objects that point to other objects
Date: Fri, 26 Aug 2011 16:10:55 -0400
Message-ID: <20110826201055.GA9223@sigill.intra.peff.net>
References: <CACBZZX6sydEmuwj_C-KNocjra=6ynud5KFoezPd_Rr3bN4wh2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 22:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx2k2-0000c3-RW
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 22:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab1HZUK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Aug 2011 16:10:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57062
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874Ab1HZUK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 16:10:57 -0400
Received: (qmail 30873 invoked by uid 107); 26 Aug 2011 20:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Aug 2011 16:11:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Aug 2011 16:10:55 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6sydEmuwj_C-KNocjra=6ynud5KFoezPd_Rr3bN4wh2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180194>

On Fri, Aug 26, 2011 at 09:01:22PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Here's a couple of tasks that require brute-force with the Git object
> format that I've wanted to do at some point.
>=20
>  * Associate a blob with trees
>=20
>    Given a blob sha1 find trees that reference it.
>=20
>  * Associate trees with commits / other trees.
>=20
>    Given a tree find which commit points to that tree, or a parent
>    tree N levels up the stack that a commit points to.

I've more frequently wanted to find the entrance and exit points of a
particular blob in history, and used something like:

  git log --all --no-abbrev -c --raw --format=3D'commit %H' |
  perl -le '
    my @blobs =3D map { qr/$_/ } @ARGV;
    while(<STDIN>) {
      if (/^commit (.*)/) {
        $commit =3D $1;
      }
      else {
        foreach my $re (@blobs) {
          next unless /$re/;
          print $commit;
          last;
        }
      }
    }
  ' $blobs

which is fairly efficient. It's brute-force, but at least it all happen=
s
in O(1) processes. It can find blobs in git.git in about a minute or so
on my machine.

I don't think there's a way to ask for all of the trees in a commit in =
a
single process. It wouldn't be hard to write in C, of course, but it's
not something the current tools support. However, you can use the above
script to narrow the range of commits that you know contain a blob, and
then individually run ls-tree each one. It's better at least than runni=
ng
ls-tree on every commit in the repo.

Anything that iterates over commits is going to end up seeing the same
trees again and again. I think you could probably do better by thinking
of it like a directed graph problem. Nodes are sha1s, and edges are any
references of interest:

  1. For a commit, make an edge from the commit to its tree.

  2. For a tree, make an edge from the tree to each of its entries.

And then the problem is reduced to "find all commit nodes that have a
path to $blob". Which you can do by breadth-first search from the
commits (or backwards from the blob).

-Peff
