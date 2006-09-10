From: Paul Mackerras <paulus@samba.org>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 22:41:07 +1000
Message-ID: <17668.2019.732961.855446@cargo.ozlabs.ibm.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<20060908184215.31789.qmail@science.horizon.com>
	<9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
	<9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 14:41:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMOdL-0000KU-9Z
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 14:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWIJMlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 08:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWIJMlW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 08:41:22 -0400
Received: from ozlabs.org ([203.10.76.45]:37099 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750972AbWIJMlW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 08:41:22 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id D6D0267BA1; Sun, 10 Sep 2006 22:41:20 +1000 (EST)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26795>

Jon Smirl writes:

> gitk takes about a minute to come up on the Mozilla repo when
> everything is in cache. It  takes about twice as long when things are
> cold. It's enough of delay that I don't use the tool.

I've been doing some timing measurements with Jon's repo.  The results
are interesting.

It turns out that a lot of the initial delay is in reading all the
references.  With ~1600 heads and almost as many tags, readrefs was
taking about 30 seconds (on my 2.5GHz quad G5), largely because it was
doing two execs for each tag, a git rev-parse and a git cat-file,
which was a bit stupid.  With that fixed, it's about 5 or 6 seconds
from starting gitk to seeing a window with commits listed in it in the
hot cache case, even still using --topo-order.  Without --topo-order
it's about 2-3 seconds to seeing the window with commits listed, but
the overall process takes longer (I still need to figure out why).

In the cold cache case, it takes about 32 seconds to read all the
references, even with the fixed version of readrefs, since that's
about how long git ls-remote .git takes.  Also, if you do gitk --all
(as I often do), then gitk does a git rev-parse, which takes about 20
seconds (but then readrefs only takes 10 seconds since the heads are
in cache).

The bottom line is that I can speed up the startup for the hot-cache
case quite a lot.  The cold-cache case is going to take about 20-30
seconds whatever I do unless Linus or Junio can come up with a way to
pack the heads and tags.  I could read the refs asynchronously but
there will still be a long delay in git rev-parse if you give
arguments such as --all.

Paul.
