From: Jeff King <peff@peff.net>
Subject: Re: How to efficiently blame an entire repo?
Date: Fri, 30 Apr 2010 17:21:03 -0400
Message-ID: <20100430212103.GB14039@coredump.intra.peff.net>
References: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 23:21:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7xeB-0002nB-68
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 23:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759653Ab0D3VVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 17:21:08 -0400
Received: from peff.net ([208.65.91.99]:46597 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759648Ab0D3VVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 17:21:06 -0400
Received: (qmail 16706 invoked by uid 107); 30 Apr 2010 21:21:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Apr 2010 17:21:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Apr 2010 17:21:03 -0400
Content-Disposition: inline
In-Reply-To: <r2l76718491004291612qbe0834ela89f0606e5f477e2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146063>

On Thu, Apr 29, 2010 at 07:12:27PM -0400, Jay Soffian wrote:

> Let's say you've got a repo with ~ 40K files and 35K commits.
> Well-packed .git is about 800MB.
> 
> You want to find out how many lines of code a particular group of
> individuals has contributed to HEAD.
> 
> The naive solution is to run git blame on all 40K files grep'ing for
> the just the authors you want.

With the exception of your "blame only those files that you know your
authors have touched" optimization, I think you pretty much have to do
this. Anything else will just be reimplementing blame. You can't throw
away most content prematurely, because it may end up blaming to your
authors of interest eventually.

I think this is also what Junio ended up doing when presenting at
GitTogether '08:

  http://userweb.kernel.org/~junio/200810-Chron.pdf

In theory you might be able to do multi-file blame faster.  I would be
curious to see the performance difference between:

  $ git blame file1 file2 ;# not actually implemented

and

  $ for i in file1 file2; do git blame $i; done

Much of the work is O(content), but there is some overlap in walking the
history and generating diffs.

-Peff
