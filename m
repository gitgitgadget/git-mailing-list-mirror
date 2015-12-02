From: Jeff King <peff@peff.net>
Subject: Re: [git-for-windows] How is detected binary files?
Date: Tue, 1 Dec 2015 19:49:21 -0500
Message-ID: <20151202004921.GC28197@sigill.intra.peff.net>
References: <487b881f-9e3e-4d22-ba1e-af3beeaccd6e@googlegroups.com>
 <alpine.DEB.1.00.1511271510520.1686@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrzej Borucki <borucki.andrzej@gmail.com>,
	git-for-windows <git-for-windows@googlegroups.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:49:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vbs-0005Vp-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 01:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbbLBAtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 19:49:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:36041 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755329AbbLBAtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 19:49:24 -0500
Received: (qmail 26479 invoked by uid 102); 2 Dec 2015 00:49:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 18:49:24 -0600
Received: (qmail 24809 invoked by uid 107); 2 Dec 2015 00:49:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Dec 2015 19:49:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Dec 2015 19:49:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1511271510520.1686@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281869>

On Fri, Nov 27, 2015 at 03:14:58PM +0100, Johannes Schindelin wrote:

> On Wed, 25 Nov 2015, Andrzej Borucki wrote:
> 
> > How git detects that file is binary? This must be safe because it not 
> > allowed to change line breaks in binary files. 
> > Binary files can contain byte 0 (zero), but:
> > - 16 bit UTF also can contain zero
> > - short binary files can not contain zero
> 
> It would probably be better to direct this question to the general Git
> mailing list (you reached the Git for Windows one, and this issue is not
> specific to Windows).
> 
> To answer your question, a NUL byte within the first 8000 bytes is indeed
> considered as an indicator for binary files.
> 
> If you use UTF-16, you will need to mark your files as such explicitly
> (Git does not handle UTF-16 internally).

I'm not sure if it is a good idea to treat UTF-16 as text. The rest of
the diff (headers, etc) will all be in ASCII, so one or the other is
going to be mojibake.

You can get readable diffs by textconv-ing them to an ASCII-superset
encoding like UTF-8. Something like:

    echo 'myfile diff=utf16' >.gitattributes
    git config diff.utf16.textconv 'iconv -f utf16 -t utf8'

but of course the resulting patches cannot be applied, and you may miss
any changes that do not make it through the encoding (e.g., using
different bytes to represent the same code point).

-Peff
