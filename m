From: Jeff King <peff@peff.net>
Subject: Re: How do I resolve conflict after popping stash without adding the
 file to index?
Date: Tue, 21 Apr 2015 17:29:23 -0400
Message-ID: <20150421212922.GC13230@peff.net>
References: <5535697E.2030204@yandex.ru>
 <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
 <553583C0.6090404@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Gutov <dgutov@yandex.ru>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkfjW-0005r7-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871AbbDUV30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:29:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:48300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932319AbbDUV3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:29:25 -0400
Received: (qmail 5398 invoked by uid 102); 21 Apr 2015 21:29:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 16:29:25 -0500
Received: (qmail 4908 invoked by uid 107); 21 Apr 2015 21:29:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Apr 2015 17:29:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2015 17:29:23 -0400
Content-Disposition: inline
In-Reply-To: <553583C0.6090404@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267556>

On Tue, Apr 21, 2015 at 01:54:56AM +0300, Dmitry Gutov wrote:

> I'm not really sure what "higher stage entries" are, but this scenario seems
> to be a counter-example:
> 
> git init
> echo "aaaaa" > test
> git add test
> git commit -m "first"
> echo "aaa" > test
> git stash save
> echo "bbbbb" > test
> git add test
> git stash pop
> 
> Either that, or 'git stash pop' was a destructive operation, and ate the
> staged changes.

Hmm, interestingly, if you do _not_ stage the changes (i.e., drop the
final "git add" there), you get:

  $ git stash pop
  error: Your local changes to the following files would be overwritten by merge:
	test
  Please, commit your changes or stash them before you can merge.
  Aborting

which makes sense. Writing conflict markers into the file would leave
you in a situation where it is hard to recover the "bbbbb" content.

But we seem to skip that safety valve when the content has been staged,
which seems questionable to me (technically we are slightly better off
than the protected case because "bbbbb" was written to a git blob
object, so you can recover it.  But it may be difficult to find the
correct blob in the object database).

-Peff
