From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] revision: convert to using diff_tree_sha1()
Date: Wed, 5 Feb 2014 12:25:11 -0500
Message-ID: <20140205172511.GA7268@sigill.intra.peff.net>
References: <cover.1391619218.git.kirr@mns.spb.ru>
 <975fbde9bdd2c5aad7376e398ca8001b9a41d2d6.1391619218.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:25:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6Dx-00068m-3b
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbaBERZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:25:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:45105 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753053AbaBERZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:25:14 -0500
Received: (qmail 6152 invoked by uid 102); 5 Feb 2014 17:25:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:25:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:25:11 -0500
Content-Disposition: inline
In-Reply-To: <975fbde9bdd2c5aad7376e398ca8001b9a41d2d6.1391619218.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241613>

On Wed, Feb 05, 2014 at 08:57:12PM +0400, Kirill Smelkov wrote:

> Since diff_tree_sha1() can now accept empty trees via NULL sha1, we
> could just call it without manually reading trees into tree_desc and
> duplicating code.
> 
> Besides, that
> 
> 	if (!tree)
> 		return 0;
> 
> looked suspect - we were saying an invalid tree != empty tree, but maybe it is
> better to just say the tree is invalid here, which is what diff_tree_sha1()
> does for such case.

I think that is sensible. The assertion that "invalid != empty" is
probably sane, because we handle the empty tree as internal magic. But I
do not see any reason we should be hitting this code path regularly with
an invalid tree, short of repository corruption, so in practice I don't
think it matters.

This does introduce a die() where there was not one previously, and that
can make things harder to diagnose/debug in a corrupted repository. But
it looks like this is limited to the history-simplification code, and I
suspect that it is not commonly used in the case of corruption.

So I think the patch looks fine.

-Peff
