From: Jeff King <peff@peff.net>
Subject: Re: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 22:51:07 -0400
Message-ID: <20090421025107.GD14479@coredump.intra.peff.net>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com> <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk> <20090421024433.GC14479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:53:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw66Y-0001ah-H7
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbZDUCvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZDUCvN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:51:13 -0400
Received: from peff.net ([208.65.91.99]:39638 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbZDUCvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:51:12 -0400
Received: (qmail 6123 invoked by uid 107); 21 Apr 2009 02:51:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 22:51:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 22:51:07 -0400
Content-Disposition: inline
In-Reply-To: <20090421024433.GC14479@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117079>

On Mon, Apr 20, 2009 at 10:44:33PM -0400, Jeff King wrote:

> This is _exactly_ what git's rename detection is designed to do. Yes, it
> seems horribly confusing in this toy example, but that is because it is
> a toy example: both 'date' and 'LICENSE' are empty files. But with real
> files, if a source file has actual content but is deleted, there is a
> new filename with the identical or near-identical content, and the patch
> applies to the new content without conflicts, then applying it there is
> probably exactly what you want.

Looking back over the blog post, it seems that the original question was
not about a toy example, but what looks like some boilerplate that
involved empty files.

Maybe git should refuse to detect exact renames between empty files.
That is easy enough to special-case, and would help people who have
these sorts of boilerplate hierarchies. It would mean that we fail to
automatically resolve something like:

  $ touch foo && git add foo && git commit -m boilerplate
  $ git branch other
  $ echo content >foo && git commit -m 'fill in boilerplate'
  $ git checkout other
  $ git mv foo bar && git commit -m reorganize
  $ git merge master

But the failure case is actually quite reasonable. We just mark it as a
conflict, which is of course trivial for the user to resolve because the
ancestor, by definition, had nothing in it.

-Peff
