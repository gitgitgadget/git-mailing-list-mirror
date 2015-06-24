From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 23:37:25 -0400
Message-ID: <20150624033725.GA19321@peff.net>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, torvalds@linux-foundation.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 05:37:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7bVF-00021i-Ka
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 05:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbbFXDh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 23:37:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753179AbbFXDh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 23:37:28 -0400
Received: (qmail 12057 invoked by uid 102); 24 Jun 2015 03:37:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 22:37:28 -0500
Received: (qmail 23529 invoked by uid 107); 24 Jun 2015 03:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Jun 2015 23:37:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2015 23:37:25 -0400
Content-Disposition: inline
In-Reply-To: <1435096643-18159-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272529>

On Tue, Jun 23, 2015 at 02:57:23PM -0700, Stefan Beller wrote:

> Linus Torvalds started a discussion[1] if we want to play rather safe
> than use defaults which make sense only for the most power users of G=
it:
>=20
> > So git is "safe" in the sense that you won't really lose any data,
> > but you may well be inconvenienced.  The "fsync each object" config
> > option is there in case you don't want that inconvenience, but it
> > should be noted that it can make for a hell of a performance impact=
=2E
>=20
> > Of course, it might well be the case that the actual default
> > might be worth turning around. Most git users probably don't
> > care about that kind of "apply two hundred patches from Andrew
> > Morton" kind of workload, although "rebase a big patch-series"
> > does end up doing basically the same thing, and might be more
> > common.=EF=BB=BF
>=20
> This patch enables fsync_object_files by default.

If you are looking for safety out of the box, I think this falls far
short, as we do not fsync all of the other files. For instance, we do
not fsync refs before they are written (nor anything else that uses the
commit_lock_file() interface to rename, such as the index).  We do
always fsync packfiles and their indices.

I had always assumed this was fine on ext4 with data=3Dordered (i.e.,
either the rename and its pointed-to content will go through, or not; s=
o
you either get your update or the old state, but not a garbage or empty
file). But it sounds from what Ted wrote in:

  http://article.gmane.org/gmane.linux.file-systems/97255

that this may not be the case. If it's not, I think we should consider
fsyncing ref writes.

-Peff
