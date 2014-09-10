From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Wed, 10 Sep 2014 04:13:59 -0400
Message-ID: <20140910081358.GB16413@peff.net>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:14:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRd2Y-0005kY-SL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 10:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbaIJIOF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 04:14:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:46421 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751635AbaIJIOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 04:14:01 -0400
Received: (qmail 12606 invoked by uid 102); 10 Sep 2014 08:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 03:14:01 -0500
Received: (qmail 14972 invoked by uid 107); 10 Sep 2014 08:14:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Sep 2014 04:14:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2014 04:13:59 -0400
Content-Disposition: inline
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256728>

On Sat, Sep 06, 2014 at 09:50:14AM +0200, Michael Haggerty wrote:

> Sorry for the long delay since v3. This version mostly cleans up a
> couple more places where the lockfile object was left in an
> ill-defined state. Thanks to Johannes Sixt and Torsten B=C3=B6gershau=
sen
> for their review of v3.
>=20
> I believe that this series addresses all of the comments from v1 [1],
> v2 [2], and v3 [3].

This looks pretty good to me overall.

I did coincidentally have an interesting experience with our lockfile
code earlier today, which I'd like to relate.

I was running pack-refs on a repository with a very large number of
loose refs (about 1.8 million). Needless to say, this ran very slowly
and thrashed the disk, as that's almost 7G using 4K inodes. But it did
eventually generate a packed-refs file, at which point it tried to prun=
e
the loose refs.

To do so, we have to lock each ref before removing it (to protect
against a simultaneous update). Each call to lock_ref_sha1_basic
allocates a "struct lock_file", which then gets added to the global
lock_file list. Each one contains a fixed PATH_MAX buffer (4K on this
machine). After we're done updating the ref, we leak the lock_file
struct, since there's no way to remove it from the list.

As a result, git tried to allocate 7G of RAM and got OOM-killed (the
machine had only 8G). In addition to thrashing the disk even harder,
since there was no room left for disk cache while we touched millions o=
f
loose refs. :)

Your change in this series to use a strbuf would make this a lot better=
=2E
But I still wonder how hard it would be to just remove lock_file struct=
s
from the global list when they are committed or rolled back. That would
presumably also make the "avoid transitory valid states" patch from you=
r
series a bit easier, too (you could prepare the lockfile in peace, and
then link it in fully formed, and do the opposite when removing it).

I think with your strbuf patch, this leak at least becomes reasonable.
So maybe it's not worth going further. But I'd be interested to hear
your thoughts since you've been touching the area recently.

-Peff
