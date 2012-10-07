From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow generating a non-default set of documentation
Date: Sun, 7 Oct 2012 17:48:56 -0400
Message-ID: <20121007214855.GB1743@sigill.intra.peff.net>
References: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:49:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKyij-0000Dx-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975Ab2JGVs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 17:48:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43990 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab2JGVs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 17:48:58 -0400
Received: (qmail 18348 invoked by uid 107); 7 Oct 2012 21:49:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 17:49:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 17:48:56 -0400
Content-Disposition: inline
In-Reply-To: <7vzk3yow3f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207201>

On Sun, Oct 07, 2012 at 01:39:32PM -0700, Junio C Hamano wrote:

> By default, "make doc" generates the manpages and htmldocs in the
> Documentation directory, but you may want to change this depending
> on the target environment, e.g. to include 'pdf'.  Introduce a new
> Makefile variable DEFAULT_DOC_TARGET to allow customizing this.

Makes sense (we have DEFAULT_TEST_TARGET for similar reasons).

> The primary motivation is to let us check documentation patches with
> 
>     $ DEFAULT_DOC_TARGET=git-push.1 make doc

Wouldn't it be just as easy to say:

  $ make -C Documentation git-push.1

?

> but it is not so far-fetched to imagine that Windows users may want to
> omit manpages with
> 
>     $ DEFAULT_DOC_TARGET=html make doc

That use case makes a lot more sense to me (or more likely setting it in
config.mak).

>  Makefile | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

No change to Documentation/Makefile? So this will work:

  $ echo DEFAULT_DOC_TARGET=html >config.mak
  $ make doc

but this will not:

  $ cd Documentation
  $ make

Why not do it like this:

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 267dfe1..ca10313 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -152,7 +152,8 @@ endif
 endif
 endif
 
-all: html man
+DEFAULT_DOC_TARGET ?= html man
+all: $(DEFAULT_DOC_TARGET)
 
 html: $(DOC_HTML)
 

which covers both cases? That is also how we handle DEFAULT_TEST_TARGET.

-Peff
