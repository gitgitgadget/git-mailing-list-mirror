From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: performance on repack
Date: Sun, 12 Aug 2007 12:33:38 +0200
Message-ID: <20070812103338.GA7763@auto.tuwien.ac.at>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 13:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKBFd-0005WM-SD
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 13:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229AbXHLLEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 07:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbXHLLEk
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 07:04:40 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56771 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbXHLLEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 07:04:39 -0400
X-Greylist: delayed 1859 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Aug 2007 07:04:39 EDT
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 2CB7F6870AA4;
	Sun, 12 Aug 2007 12:33:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIzPPYcihcNW; Sun, 12 Aug 2007 12:33:38 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A1204686BF9D; Sun, 12 Aug 2007 12:33:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55674>

On Sat, Aug 11, 2007 at 05:12:24PM -0400, Jon Smirl wrote:
> If anyone is bored and looking for something to do, making the delta
> code in git repack multithreaded would help. Yesterday I did a big
> repack that took 20 minutes and it only used one of my four cores. It
> was compute bound the entire time.

=46irst, how much time is used by the write and how much by the deltify
phase?

If the writing phase uses too much time and you have enough free
memory, you can try to raise the config variable pack.deltacachelimit
(default 1000). It will save an additional delta operation for all
object, whose delta is smaller than pack.deltacachelimit by caching
the delta.

Have you considered the impact on memory usage, if there are large
blobs in the repository?

While repacking, git keeps $window_size (default: 10) objects unpacked
in memory. For all (except one), it additionally stores the delta
index, which has about the same size as the object.

So the worst case memory usage is "sizeof(biggest object)*(2*$window_si=
ze - 1)".
If you have blobs >=3D100 MB, you need some GB of memory.

Partitioning the problem is not trivial:

* To get not worse packing resultes, we must first sort all objects by
  type, path, size. Then we can split split the list (for each task
  one part), which we can deltify individually.

  The problems are:

  - We need more memory, as each tasks keeps its own window of
    $window_size objects (+ delta indexes) in memory.

  - The list must be split in parts, which require the same amount of
    time. This is difficult, as it depends on the size of the objects a=
s
    well as how they are stored (delta chain length).

* On the other hand, we could run all try_delta operations for one obje=
ct
  parallel. This way, we would need not very much more memory, but
  require more synchronisation (and more complex code).

mfg Martin K=F6gler
