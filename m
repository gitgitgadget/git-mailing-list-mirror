From: Jeff King <peff@peff.net>
Subject: [PATCHv3 0/19] pkt-line cleanups and fixes
Date: Wed, 20 Feb 2013 14:51:47 -0500
Message-ID: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 20:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FiC-0006L3-9C
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 20:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934674Ab3BTTvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 14:51:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54538 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934361Ab3BTTvt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 14:51:49 -0500
Received: (qmail 17433 invoked by uid 107); 20 Feb 2013 19:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 14:53:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 14:51:47 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216714>

Here's another round of my pkt-line fixes. The more I dug, the more
interesting corners I found. :)

There are really several potentially independent topics rolled together
here. There are dependencies between some of them, so I tried to float
the most independent and non-controversial bits to the beginning. We may
want those as a separate topic to merge sooner, and have the rest as a
topic build on top.

Overall, the diffstat shows a reduction in lines (and I even added a few
dozen lines of comments), which is nice. The intent was to fix some bugs
and corner cases, but I found a lot of cleanup opportunities in the
middle.

 builtin/archive.c          |  17 ++--
 builtin/fetch-pack.c       |  11 +-
 builtin/receive-pack.c     |  10 +-
 builtin/send-pack.c        |   4 +-
 builtin/upload-archive.c   |  45 +++------
 cache.h                    |   4 +-
 connect.c                  |  13 +--
 daemon.c                   |   4 +-
 fetch-pack.c               |  18 ++--
 http-backend.c             |   8 +-
 http.c                     |   1 +
 pkt-line.c                 | 126 ++++++++++-------------
 pkt-line.h                 |  72 +++++++++++++-
 remote-curl.c              | 188 ++++++++++++++++-------------------
 send-pack.c                |  22 ++--
 sideband.c                 |  11 +-
 sideband.h                 |   3 -
 t/t5503-tagfollow.sh       |  38 ++++---
 t/t5700-clone-reference.sh |  10 +-
 transport.c                |   6 +-
 upload-pack.c              |  40 +++-----
 write_or_die.c             |  19 ++--
 22 files changed, 321 insertions(+), 349 deletions(-)

The patches are:

  [01/19]: upload-pack: use get_sha1_hex to parse "shallow" lines

    New in this round; fixes a potential interoperability problem.

  [02/19]: upload-pack: do not add duplicate objects to shallow list

    New. Fixes a potential memory-consumption denial-of-service.

  [03/19]: upload-pack: remove packet debugging harness

    New. Optional cleanup, but later patches textually depend on it.

  [04/19]: fetch-pack: fix out-of-bounds buffer offset in get_ack

    New. Fixes a potential interoperability problem.

  [05/19]: send-pack: prefer prefixcmp over memcmp in receive_status

    New. Optional cleanup.

  [06/19]: upload-archive: do not copy repo name
  [07/19]: upload-archive: use argv_array to store client arguments

    New. Optional cleanup.

  [08/19]: write_or_die: raise SIGPIPE when we get EPIPE
  [09/19]: pkt-line: move a misplaced comment
  [10/19]: pkt-line: drop safe_write function

    The latter two were in the last round; but it's 08/19 that makes
    doing 10/19 safe. I think it's also a sane thing to be doing in
    general for existing callers of write_or_die.

    These can really be pulled into a separate topic if we want, as
    there isn't even a lot of textual dependency.

  [11/19]: pkt-line: provide a generic reading function with options

    This is an alternative to the proliferation of different reading
    functions that round 2 had. I think it ends up cleaner.  It also
    addresses Jonathan's function-signature concerns.

  [12/19]: pkt-line: teach packet_read_line to chomp newlines

    New. A convenience cleanup that drops a lot of lines. Technically
    optional, but later patches depend heavily on it (textually, and for
    splitting line-readers from binary-readers).

  [13/19]: pkt-line: move LARGE_PACKET_MAX definition from sideband
  [14/19]: pkt-line: provide a LARGE_PACKET_MAX static buffer

    New. Another cleanup that makes packet_read_line callers a bit
    simpler, and bumps the packet size limits throughout git, as we
    discussed.

  [15/19]: pkt-line: share buffer/descriptor reading implementation
  [16/19]: teach get_remote_heads to read from a memory buffer
  [17/19]: remote-curl: pass buffer straight to get_remote_heads

    These are more or less ported from v2's patches 6-8, except that the
    earlier pkt-line changes make the first one way more pleasant.

  [18/19]: remote-curl: move ref-parsing code up in file
  [19/19]: remote-curl: always parse incoming refs

    ...and the yak is shaved. More or less a straight rebase of their v2
    counterparts, and the thing that actually started me on this topic.

I know it's a big series, but I tried hard to break it down into
bite-sized chunks. Thanks for your reviewing patience.

-Peff
