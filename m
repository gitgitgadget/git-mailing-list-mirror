From: Jeff King <peff@peff.net>
Subject: Re: Storing additional information in commit headers
Date: Wed, 3 Aug 2011 21:39:56 -0600
Message-ID: <20110804033955.GA4534@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
 <20110802082810.GC29887@fishbowl.rw.madduck.net>
 <20110802185154.GA2499@sigill.intra.peff.net>
 <20110802190645.GB17322@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 05:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoomz-0002a1-3m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 05:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab1HDDkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 23:40:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60276
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab1HDDj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 23:39:58 -0400
Received: (qmail 13850 invoked by uid 107); 4 Aug 2011 03:40:32 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 23:40:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 21:39:56 -0600
Content-Disposition: inline
In-Reply-To: <20110802190645.GB17322@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178665>

On Tue, Aug 02, 2011 at 09:06:45PM +0200, martin f krafft wrote:

> It just seems to me that per-ref storage is a lot further away than
> per-commit storage, and I'd really like to move forward with TopGit=E2=
=80=A6

I don't think it's that hard. For example:

  # our mapping for all refs, and the history of that mapping, will be
  # stored under this ref
  MAP=3Drefs/topgit/metadata

  refmap_set() {
    (
      # start with a pristine index based on the current map
      GIT_INDEX_FILE=3D"$(git rev-parse --git-dir)/tg-meta-index"
      export GIT_INDEX_FILE
      if git rev-parse -q --verify $MAP >/dev/null; then
        git read-tree $MAP
      fi

      # and then put our new ref and metadata in
      blob=3D`git hash-object --stdin -w`
      git update-index --add --cacheinfo 100644 $blob $1
      tree=3D`git write-tree`
      parent=3D$(git rev-parse -q --verify $MAP)
      commit=3D`echo 'updated map' | git commit-tree $tree ${parent:+-p=
 $parent}`
      git update-ref $MAP $commit $old
    )
  }

  refmap_get() {
    git cat-file blob $MAP:$1
  }

  # and some examples of use
  echo some metadata | refmap_set refs/heads/foo
  refmap_get refs/heads/foo |
    sed 's/meta/changed &/' |
    refmap_set refs/heads/foo

It's a little more clunky than notes, of course, but it's not too bad t=
o
put into a script. The tricky part is how to handle fetching and mergin=
g
the metadata ref from other people. But that's not really different fro=
m
notes. In either case, you're probably going to want to make a custom
merge program for combining the meta-information.

-Peff
