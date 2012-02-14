From: Jeff King <peff@peff.net>
Subject: Re: diff --stat
Date: Tue, 14 Feb 2012 14:50:36 -0500
Message-ID: <20120214195036.GD12072@sigill.intra.peff.net>
References: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOOi-0003Q9-Br
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 20:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760333Ab2BNTul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 14:50:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35827
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab2BNTul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 14:50:41 -0500
Received: (qmail 10312 invoked by uid 107); 14 Feb 2012 19:57:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 14:57:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 14:50:36 -0500
Content-Disposition: inline
In-Reply-To: <7v4nuub7el.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190741>

On Mon, Feb 13, 2012 at 04:11:46PM -0800, Junio C Hamano wrote:

> Hrm, what is wrong with this picture?
> 
> $ git -c diff.color.old=red show --format='%s' --stat
> Merge branch 'jk/diff-highlight' into pu
> 
>  contrib/diff-highlight/README         |  109 ++++++++++++++++++++++++++++++--
>  contrib/diff-highlight/diff-highlight |  109 ++++++++++++++++++++++++---------
>  2 files changed, 181 insertions(+), 37 deletions(-)
> 
> They both have 109 lines changed but the end of the graph lines do not
> coincide...

I think it is rounding error. The first one is +102/-7, and the second
one is +79/-30. When we get to scale_linear, we try to scale 109 change
markers into a 33-character width. So the right scaling factor is ~.303.
So our "true" scaled widths should be:

       README, added: 30.9
     README, deleted:  2.1
    highlight, added: 23.9
  highlight, deleted:  9.1

However, we're dealing with integer numbers of characters, so we need to
round. In this case, it seems that our rounding produces (30, 2) in the
first instance and (24, 9) in the second. Which is odd.  You'd think
we'd either always round to the nearest integer, or always round down.
But we end up rounding 30.9 down and 23.9 up.  So it may be a subtle
loss-of-precision error in scale_linear.

Hmm. Looking at scale_linear, the formula is:

   return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);

I don't see how that can be accurate, since the magnitude of the "-1"
tweak will vary based on the value of "it". This code is due to
3ed74e6, but I don't quite follow the logic in the commit message.

-Peff
