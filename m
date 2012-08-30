From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 23:51:27 -0400
Message-ID: <20120830035127.GB32268@sigill.intra.peff.net>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vnE-0007zl-04
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab2H3Dvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2H3Dvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:51:33 -0400
Received: (qmail 5174 invoked by uid 107); 30 Aug 2012 03:51:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 23:51:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 23:51:27 -0400
Content-Disposition: inline
In-Reply-To: <1346275044-10171-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204513>

On Wed, Aug 29, 2012 at 02:17:24PM -0700, Junio C Hamano wrote:

> Instead of naming a rev after a tip that is topologically closest,
> use the tip that is the oldest one among those which contain the
> rev.

When you wrote "oldest" here, I thought that meant you would do a
comparison on the taggerdate. But reading the implementation, you really
mean "topologically oldest".

I wonder, though, if the former would be sufficient for most people. Or
even just sorting based on the tag name. For example, taking Greg's
original example:

  $ commit=0136db586c028f71e7cc21cc183064ff0d5919
  $ oldest_tag=`git tag --contains $commit | sort -V | head -1`
  $ git name-rev --refs="refs/tags/$oldest_tag" $commit
  0136db586c028f71e7cc21cc183064ff0d5919 tags/v3.5~335^2~81^2~76

Of course "sort -V" is not portable, and it actually places -rc tags
after release tags (note that we found v3.5 here, not v3.5-rc1). But
that is an implementation detail that could be solved (either by a
better comparison function, or by just using taggerdate instead).

In some ways it is not as elegant (clock skew in your tag dates would be
relevant), but it is simple and performs well without needing to manage
a cache.

-Peff
