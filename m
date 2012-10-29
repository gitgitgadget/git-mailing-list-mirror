From: Jeff King <peff@peff.net>
Subject: Re: crash on git diff-tree -Ganything <tree> for new files with
 textconv filter
Date: Mon, 29 Oct 2012 02:05:24 -0400
Message-ID: <20121029060524.GB4457@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
 <508D8DF7.7040007@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 07:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSiTl-00073f-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 07:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab2J2GF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 02:05:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41813 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab2J2GF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 02:05:28 -0400
Received: (qmail 15675 invoked by uid 107); 29 Oct 2012 06:06:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 02:06:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 02:05:24 -0400
Content-Disposition: inline
In-Reply-To: <508D8DF7.7040007@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208589>

On Sun, Oct 28, 2012 at 08:56:39PM +0100, Peter Oberndorfer wrote:

> > The patch below should fix it. I added tests, but please try your
> > real-world test case on it to double-check.
> 
> I tested your patch, but now it crashes for another reason :-)

Well, that's progress, right? :)

> i have a file with exactly 12288(0x3000) bytes in the repository.
> When the file is loaded, the data is placed luckily so the data end
> falls at a page boundary.
> Later diff_grep() calls regexec() which calls strlen() on the loaded buffer
> and ends up reading beyond the actual data into the next page
> which is not allocated and causes a pagefault.
> Or it could possibly (randomly) match the regex on data that is not
> actually part of a file...

Yuck. For the most part, we treat blob content (and generally most
object content) as a sized buffer. However, there are some spots which,
either through laziness or because a code interface expects a string, we
pass the value as a string. This works because the object-reading code
puts an extra NUL at the end of our buffer to handle just such an
instance. So we might prematurely end if the object contains embedded
NULs, but we would never read past the end.

The code to read the output of a textconv filter does not do this
explicitly. I would think it would get it for free by virtue of reading
into a strbuf, though. I'll try to investigate.

-Peff
