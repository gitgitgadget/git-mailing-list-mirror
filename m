From: Jeff King <peff@peff.net>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Tue, 19 May 2015 19:39:25 -0400
Message-ID: <20150519233925.GA22748@peff.net>
References: <20150519132958.GA21130@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Wed May 20 01:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yur6j-0003eP-G4
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 01:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbbESXj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 19:39:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:32934 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751619AbbESXj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 19:39:28 -0400
Received: (qmail 24191 invoked by uid 102); 19 May 2015 23:39:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:39:28 -0500
Received: (qmail 18807 invoked by uid 107); 19 May 2015 23:39:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 19:39:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 19:39:25 -0400
Content-Disposition: inline
In-Reply-To: <20150519132958.GA21130@frolo.macqel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269432>

On Tue, May 19, 2015 at 03:29:58PM +0200, Philippe De Muyter wrote:

> Trying to understand, I have eventually done "git log" on my branch and
> on v3.15 with the following commands :
> 
> git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
> git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
> 
> I compare then the two histories with
> 
> diff -u /tmp/3.15.commits /tmp/mybranch.commits
> 
> and I get (excerpt) :
> 
> --- /tmp/3.15.commits      2015-05-19 13:19:59.665205514 +0200
> +++ /tmp/mybranch.commits     2015-05-19 13:19:52.452081328 +0200
> @@ -1,3780 +1,84 @@
> -commit 1860e379875dfe7271c649058aeddffe5afd9d0d (tag: v3.15)
> -commit ...
> ...
> -commit fad01e866afdbe01a1f3ec06a39c3a8b9e197014 (tag: v3.15-rc8)
> ...
> ...
> -commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5 (tag: v3.15-rc1)
> ...
> -commit 57673c2b0baa900dddae3b9eb3d7748ebf550eb3
> +commit a1fb433346cb5733945b5fc243f7334744bae4fd (HEAD, macq_boards-3.14.0)
> +commit ...
> ...
> +commit 2be7b20bbb337e0031e0f0d39c9a4845b6bbf3b8

It looks like v3.15 is ahead of your branch. And I _think_ your question
is: since they both contain v3.14, shouldn't they also contain all of
the ancestors of v3.14?

The answer is yes. But from your output here:

>  commit 455c6fdbd219161bd09b1165f11699d6d73de11c (tag: v3.14)	==== identical commit
> -commit c32fc9c803f8ed90a7548810de48ca33a3020168		==== commit missing in my branch
>  commit fedc1ed0f11be666de066b0c78443254736a942e		==== more identical commits

I think what you are saying is: c32fc9c803 comes after v3.14, so it
should be an ancestor, right?

And the answer is no. Git's traversal order does not necessarily reflect
the true topology if you have multiple lines of development. And in this
case, they do not have a direct ancestry relationship (i.e., they are on
separate branches, and neither is an ancestor of the other).

-Peff
