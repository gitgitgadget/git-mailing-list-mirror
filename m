From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] sha1_name.c: signal if @{-N} was a true branch
 nameor a detached head
Date: Thu, 9 May 2013 08:46:07 +0200
Message-ID: <20130509064607.GA11985@sigill.intra.peff.net>
References: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 08:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaKcK-0002fS-48
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 08:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab3EIGqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 02:46:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:35954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab3EIGqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 02:46:11 -0400
Received: (qmail 3044 invoked by uid 102); 9 May 2013 06:46:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 May 2013 01:46:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2013 08:46:07 +0200
Content-Disposition: inline
In-Reply-To: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223712>

On Wed, May 08, 2013 at 02:12:29PM -0700, Junio C Hamano wrote:

> The original API read "checkout: moving from (.*) to ..." from the
> reflog of the HEAD, and returned the substring between "from" and
> "to", but there was no way, if the substring was a 40-hex string, to
> tell if we were on a detached HEAD at that commit object, or on a
> branch whose name happened to be the 40-hex string.
> 
> At this point, we cannot afford to change the format recorded in the
> reflog, so introduce a heuristics to see if the 40-hex matches the
> object name of the commit we are switching out of.  This will
> unfortunately mishandle this case:
> 
> 	HEX=$(git rev-parse master)
> 	git checkout -b $HEX master
> 	git checkout master

I do not think I've ever seen a 40-hex branch name in practice, but I
would think a branch named after the commit tip would be a reasonably
common reason to have one, and would trigger this case.

Since the point of marking the detached HEAD is to turn off things like
"@{-1}@{u}", we would want to be generous and err on the side of
assuming it is a branch if it _might_ be one. IOW, shouldn't we treat
the above sequence as a branch, and therefore mishandle:

  git checkout $HEX^0 master
  git checkout master

by erroneously assuming that we moved to the branch $HEX?

-Peff
