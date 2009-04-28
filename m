From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to
	follow and maintain
Date: Tue, 28 Apr 2009 08:28:22 -0700
Message-ID: <20090428152822.GP23604@spearce.org>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:29:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypF3-0002KG-QU
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbZD1P2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756614AbZD1P2X
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:28:23 -0400
Received: from george.spearce.org ([209.20.77.23]:38241 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbZD1P2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:28:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 66A1038221; Tue, 28 Apr 2009 15:28:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1240885572-1755-2-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117791>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> 
> This rewrite generalizes most of the cache logic into a new class,
...
>  I'm tossing this out there for tonight.  Please don't apply until
>  I give a final yay or nay.
...
>  I'm going to burn this in tonight for about 12 hours by pounding
>  a whole bunch of clients against it.

Yay.

This patch looks solid to me.  

I ran it overnight for 12 hours on a test rig.  4-way Intel(R)
Xeon(R) CPU 5148 @ 2.33GHz with 32 GiB physical memory.  The git://
server process was launched with:

  java -Xmx8192m -classpath jgit \
    org.spearce.jgit.pgm.Main daemon
    --port 8853 --export-all base

Note that is the default WindowCacheConfig.

I ran 8 concurrent clone clients on two 2-way systems, 4 clients
per host.  The clone clients randomly selected between three
repositories on each clone attempt:

  linux-2.6 fork (322M on disk)
  repo.git       (1.6M on disk)
  gerrit.git     (9.3M on disk)

I used C git `git clone --bare ...` for the clients to try and
speed up the client side of the test.

In 12 hours the clients successfully completed a total of 2,456
clones, and appear to have been averaging 10,999 KiB/s at peak on
one test host and 4,969 KiB/s on the other.  So JGit was pushing
somewhere around 63,872 KiB/s.  I'm not sure what the network can
really do here; the test clients are in my office and the server
is in a data center somewhere in the same state.

At peak (when all clients picked the linux-2.6 fork roughly around
the same time) I saw the server JVM approaching 380% CPU utilization.
Not too bad giving that the WindowCacheConfig's default settings are
woefully inadequate for 8 concurrent PackWriters on linux-2.6.

Unfortunately, this quad is largest SMP box I have available.
I'm sure we're wasting CPU spinning through cache entries under load.
I still need to do throughput testing, and that may lead to some
tuning changes.  But the code is cleaner and didn't fall over,
so I say we move ahead and apply this rewrite.

-- 
Shawn.
