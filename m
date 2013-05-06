From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 08:31:11 -0400
Message-ID: <20130506123111.GB3809@sigill.intra.peff.net>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
 <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 14:31:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZKZf-0001x1-6T
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 14:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab3EFMbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 08:31:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:37952 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab3EFMbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 08:31:13 -0400
Received: (qmail 32595 invoked by uid 102); 6 May 2013 12:31:33 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 07:31:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 08:31:11 -0400
Content-Disposition: inline
In-Reply-To: <1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223445>

On Sun, May 05, 2013 at 05:38:53PM -0500, Felipe Contreras wrote:

> We don't care about blobs, or any object other than commits, but in
> order to find the type of object, we are parsing the whole thing, which
> is slow, specially in big repositories with lots of big files.

I did a double-take on reading this subject line and first paragraph,
thinking "surely fast-export needs to actually output blobs?".

Reading the patch, I see that this is only about not bothering to load
blob marks from --import-marks. It might be nice to mention that in the
commit message, which is otherwise quite confusing.

I'm also not sure why your claim "we don't care about blobs" is true,
because naively we would want future runs of fast-export to avoid having
to write out the whole blob content when mentioning the blob again. I
think one argument could be "if we write a mark for blob X, we will also
have written a mark for commit Y which contains it; on subsequent runs,
we will just show the mark for Y in the first place, and not even care
about showing X (as a part of Y) either way. We would only refer to the
mark for X if it appears as part of a different commit, but that is a
rare case not worth worrying about."

Does that match your reasoning?

> Before this, loading the objects of a fresh emacs import, with 260598
> blobs took 14 minutes, after this patch, it takes 3 seconds.

Presumably most of that speed improvement comes from not parsing the
blob objects. I wonder if you could get similar speedups by applying the
"do not bother parsing" rule from your patch 3. You would still incur
some cost to create a "struct blob", but it may or may not be
measurable.  That would mean we get the "case not worth worrying about"
from above for free. I doubt it would make that big a difference,
though, given the rarity of it. So I am OK with it either way.

-Peff
