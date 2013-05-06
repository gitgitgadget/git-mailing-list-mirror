From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 12:20:08 -0400
Message-ID: <20130506162008.GB7992@sigill.intra.peff.net>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
 <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
 <20130506123111.GB3809@sigill.intra.peff.net>
 <7v7gjctabm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 18:20:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZO9C-0004cR-4g
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 18:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab3EFQUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 12:20:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:39505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab3EFQUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 12:20:11 -0400
Received: (qmail 13748 invoked by uid 102); 6 May 2013 16:20:31 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 11:20:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 12:20:08 -0400
Content-Disposition: inline
In-Reply-To: <7v7gjctabm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223467>

On Mon, May 06, 2013 at 08:08:45AM -0700, Junio C Hamano wrote:

> > I'm also not sure why your claim "we don't care about blobs" is true,
> > because naively we would want future runs of fast-export to avoid having
> > to write out the whole blob content when mentioning the blob again.
> 
> The existing documentation is fairly clear that marks for objects
> other than commits are not exported, and the import-marks codepath
> discards anything but commits, so there is no mechanism for the
> existing fast-export users to leave blob marks in the marks file for
> later runs of fast-export to take advantage of.  The second
> invocation cannot refer to such a blob in the first place.

OK. If the argument is "we do not write them, so do not bother reading
them back in", I think that is reasonable. It could hurt anybody trying
to run "fast-export" against a marks file created by somebody else, but
that is also the same case that is being helped here (since otherwise,
we would not be seeing blob entries at all).

I do not offhand know enough about the internals of import/export-style
remote-helpers to say whether the "hurt" case even exists, let alone how
common it is.

> By discarding marks on blobs, we may be robbing some optimization
> possibilities, and by discarding marks on tags, we may be robbing
> some features, from users of fast-export; we might want to add an
> option "--use-object-marks={blob,commit,tag}" or something to both
> fast-export and fast-import, so that the former can optionally write
> marks for non-commits out, and the latter can omit non commit marks
> if the user do not need them. But that is a separate issue.

Yeah, that would allow the old behavior (and more) if anybody is hurt by
this. It is nice if the order of implementation is "more features, then
flip the default" because it provides an immediate escape hatch for
anybody who is hurt by the change in default. But again, I do not know
enough to say whether such hurt cases even exist.

-Peff
