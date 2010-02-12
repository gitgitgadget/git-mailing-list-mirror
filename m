From: Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
Subject: Re: Bug#569505: git-core: 'git add' corrupts repository if the
	working directory is modified as it runs
Date: Thu, 11 Feb 2010 20:23:14 -0500
Message-ID: <20100212012314.GC24809@gibbs.hungrycats.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100212002741.GB9883@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, 569505-forwarded@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 02:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfkOS-0006Ks-5p
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 02:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0BLBaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 20:30:21 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:48166 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752885Ab0BLBaU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 20:30:20 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 20:30:20 EST
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
X-Envelope-Mail-From: zblaxell@gibbs.hungrycats.org
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 582E5770130;
	Thu, 11 Feb 2010 20:23:14 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@gibbs.hungrycats.org>)
	id 1NfkFW-00029h-9p; Thu, 11 Feb 2010 20:23:14 -0500
Content-Disposition: inline
In-Reply-To: <20100212002741.GB9883@progeny.tock>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139653>

On Thu, Feb 11, 2010 at 06:27:41PM -0600, Jonathan Nieder wrote:
> Zygo Blaxell reported through http://bugs.debian.org/569505 that ???git
> update-index??? has some issues when the files it is adding change under
> its feet:
> 
> My thoughts:
> 
>  - Low-hanging fruit: it should be possible for update-index to check
>    the stat information to see if the file has changed between when it
>    first opens it and when it finishes.

I don't think this is a good idea.  stat() is very coarse-grained, and
provides accuracy of only a second on a lot of file systems where git
working directories might be found.  If you run the test script on an
ext3 filesystem on a modern machine the stat() data won't change at all
even though the file contents change completely many times.

What would be a good idea is to make sure that the code that copies a
file into the index and calculates its hash does both in a single pass
over the same input data.  That might require replacing a simple mmap()
of the input file with a read-hash-copy loop.
