From: Jim Meyering <jim@meyering.net>
Subject: detect write failure, even for stdout
Date: Mon, 22 May 2006 12:27:47 +0200
Message-ID: <87d5e6gxr0.fsf_-_@rho.meyering.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 22 12:27:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi7dg-0007RY-K8
	for gcvg-git@gmane.org; Mon, 22 May 2006 12:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWEVK1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 06:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWEVK1t
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 06:27:49 -0400
Received: from mx.meyering.net ([82.230.74.64]:15526 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1750733AbWEVK1t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 06:27:49 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BBE0C34B88; Mon, 22 May 2006 12:27:47 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <7v3bf3jl15.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 21 May 2006 11:21:58 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20497>

git doesn't always detect write failures.  A write I/O error,
(e.g., hardware I/O error or simply disk full)
doesn't provoke nonzero exit status:

    $ ./git-cat-file -t HEAD > /dev/full && echo did not detect write failure
    did not detect write failure

This is perhaps more important than the other things
I've reported, since it can lead to porcelain being unable
to detect a real failure in the plumbing.

Here are two more:

    $ ./git-ls-tree HEAD > /dev/full && echo fail
    fail
    $ ./git-show > /dev/full && echo fail
    fail

If you were using gnulib, I'd suggest simply adding this line

    atexit (close_stdout);

near the beginning of each `main'.  Then you wouldn't have to
manually track down each and every place where a write to stdout
can occur -- not to mention the maintenance burden of keeping
things correct as the code evolves.
