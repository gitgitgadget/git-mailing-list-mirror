Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0532018A
	for <e@80x24.org>; Thu, 23 Jun 2016 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcFWXPT (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 19:15:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:59415 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcFWXPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 19:15:18 -0400
Received: (qmail 11986 invoked by uid 102); 23 Jun 2016 23:15:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:15:18 -0400
Received: (qmail 15859 invoked by uid 107); 23 Jun 2016 23:15:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 19:15:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 19:15:13 -0400
Date:	Thu, 23 Jun 2016 19:15:13 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH v3] friendlier handling of overflows in archive-tar
Message-ID: <20160623231512.GA27683@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
 <20160621161604.GA17638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160621161604.GA17638@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a replacement for the jk/big-and-future-archive-tar topic. It's
sufficiently rewritten that I won't bother with an interdiff, but rather
just describe the changes below. Thanks to René for talking through some
of the issues, and to Robin for suggesting the double-compression trick
for the tests.

The important changes here are:

  - the "size" fix is more localized to write_tar_entry(). This results
    in shorter code, and means that if one were to somehow write an
    extended header larger than 8GB, we would notice and die(), rather
    than just writing a "0" (though such a thing should not be
    possible).

  - the mtime is now written only in a single global header, rather than
    once per file. I checked POSIX and this is explicitly allowed, and
    of course I also checked that it works against GNU tar.

  - there are now tests! I tried hard to make them portable and
    efficient. See the first patch for details.

  - the final patch is just a cleanup I noticed in the area; it could be
    done independently, but I floated it to the end in case it's
    controversial.

The patches are:

  [1/4]: t5000: test tar files that overflow ustar headers
  [2/4]: archive-tar: write extended headers for file sizes >= 8GB
  [3/4]: archive-tar: write extended headers for far-future mtime
  [4/4]: archive-tar: drop return value

-Peff
