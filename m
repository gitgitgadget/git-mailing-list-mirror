From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] git-notes ui fixes regarding non-blobs notes
Date: Thu, 10 May 2012 10:29:20 -0400
Message-ID: <20120510142920.GA14711@sigill.intra.peff.net>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 16:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUMx-0003EB-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab2EJO3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 10:29:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38793
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2EJO3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:29:22 -0400
Received: (qmail 28920 invoked by uid 107); 10 May 2012 14:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 10:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 10:29:20 -0400
Content-Disposition: inline
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197572>

On Thu, May 10, 2012 at 09:04:57PM +0700, Nguyen Thai Ngoc Duy wrote:

> Thanks Jeff and Junio for all the comments. This is basically what you
> (and I) agree in v1's thread. The first patch is a new one, to avoid
> git-notes from converting everything to blobs. I don't restrict the
> "show" case either because git-notes uses "git show", which is
> capable of displaying all kinds of objects.

Nice, this is much better than the previous round.

I was surprised by the "git show" thing you mentioned, because I checked
before that "git notes add -C HEAD^{tree}; git notes show" generated
garbage. But the problem is that "-C $tree" was more broken than we
realized. It actually copied the tree contents into a blob object,
giving it a new sha1:

  $ git rev-parse HEAD^{tree}
  f799843170cdddbbdfec446e934bbccf94e0d2a7
  $ git notes add -C HEAD^{tree}
  $ git notes list HEAD
  587521811b7a5b84ed7cb48d11f9321ddcefd337

So it really was totally useless, and nobody could possibly have been
using it to store a real tree object, experimental or otherwise. But I
still like these patches better than just disallowing it, because they
allow people to experiment with the idea.

It's a little odd that we rewrite the object in the "-C" case at all; we
should never even need to open the object. I guess it is just to make
the code paths between "-c" and "-C" simpler.

-Peff
