From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Wed, 9 May 2007 09:49:58 -0400
Message-ID: <20070509134958.GA21489@thunk.org>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net> <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu> <alpine.LFD.0.99.0705081136050.24220@xanadu.home> <20070508163044.GA15796@thunk.org> <Pine.LNX.4.64.0705081848330.4167@racer.site> <20070508180947.GB15796@thunk.org> <alpine.LFD.0.99.0705081439140.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 15:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlmYg-0003Lc-UP
	for gcvg-git@gmane.org; Wed, 09 May 2007 15:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXEINuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbXEINuU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 09:50:20 -0400
Received: from thunk.org ([69.25.196.29]:48646 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbXEINuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 09:50:19 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HlmfH-0001RY-I6; Wed, 09 May 2007 09:57:11 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HlmYI-000085-IS; Wed, 09 May 2007 09:49:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99.0705081439140.24220@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46716>

On Tue, May 08, 2007 at 02:46:35PM -0400, Nicolas Pitre wrote:
> The window size has absolutely no effect on the runtime pack access, 
> except maybe for the increased number of deltas.  It is really a pack 
> time cost.  The delta depth is the opposite: it has no effect on the 
> packing time, but it has the potential to slow down runtime access.  But 
> the delta base cache is apparently working really well to mitigate that 
> cost, as long as it is big enough of course.

Exactly, and the numbers bear out with the theory.  Junio's already
applied the change to up the default to 50, but for the record, here
are the results using a kernel git repository, with times for doing a
git-gc (with the --no-reuse-delta, although I like the suggestion to
change it to just be "--hard", or maybe "--agressive"), and with a git
pickaxe and a git-log with pathname restrictions.  It essentially
confirms that the delta base cache is doing the job just fine, up to
even a depth of 100.  However, there isn't much difference in pack
size between a depth of 50 and 100.

Increasing the window size from 10 to 30 increases the pack run time
by roughly 40%, and saves an extra 5% or so on the pack size.
Increasing the window beyond 30 has ever-smaller diminishing returns,
while the time to repack gets bigger and bigger.

The timing information is real/user/system/minor pagefaults, and as
before, the results are done using a hot cache.  Apologies in advance
for the long lines in the benchmark results.  These results were
generated using a relatively recent, post-2.6.21 kernel git tree on a
Thinkpad T60p laptop with a 2GHz T2500 Intel Core Duo processor.

Regards,

             git-gc                      pack size   git-log -S'object'    git-log include/scsi drivers/scsi
w=10,d=10   5:08.70/293.20/5.56/1027802  162316k  5:31.12/322.20/4.14/153298  0:01.80/1.72/0.03/19077
w=10,d=30   4:14.79/245.46/2.57/398754   149636k  5:41.56/331.21/4.86/517220  0:01.83/1.74/0.05/17880
w=10,d=50   4:31.89/257.16/3.50/576538   146608k  5:51.58/336.63/5.07/259643  0:01.88/1.80/0.04/17658
w=10,d=100  4:35.93/262.77/4.08/715195   144152k  5:58.23/341.26/6.22/624510  0:01.89/1.80/0.04/17571

w=30,d=10   7:23.06/424.08/6.35/1222640  153752k  5:32.85/323.96/2.13/213150  0:01.73/1.64/0.06/18429
w=30,d=30   6:15.76/364.27/3.53/407546   141200k  5:42.29/333.53/2.10/338301  0:01.81/1.71/0.04/17237
w=30,d=50   6:26.85/372.24/5.38/578343   139408k  5:42.21/336.65/1.30/260234  0:01.77/1.70/0.05/17108
w=30,d=100  6:34.31/381.72/5.40/744886   138040k  5:59.03/342.65/4.90/607681  0:01.93/1.79/0.06/17043

w=50,d=10   8:51.08/508.80/5.75/1050358  152168k  5:35.43/327.48/3.70/209655  0:01.70/1.64/0.04/18264
w=50,d=30   8:04.53/471.65/5.58/423755   139000k  5:42.06/335.67/1.55/335333  0:01.78/1.72/0.04/17046
w=50,d=50   8:14.87/479.93/7.09/617310   137244k  5:47.22/339.26/2.73/462412  0:01.79/1.72/0.04/16871
w=50,d=100  8:23.13/490.09/4.10/751742   136152k  5:51.10/343.89/2.29/503573  0:01.83/1.73/0.06/16920

w=100,d=10  12:00.34/702.07/6.27/1167403 150736k  5:34.42/328.88/1.09/207522  0:01.72/1.63/0.07/18024
w=100,d=30  11:56.34/702.36/2.93/436950  137240k  5:42.64/335.82/2.07/422743  0:01.77/1.67/0.05/16852
w=100,d=50  12:20.39/722.99/3.94/671655  135488k  5:47.20/339.38/2.44/468974  0:01.78/1.68/0.03/16621
w=100,d=100 12:37.69/740.63/4.12/733593  134492k  5:52.26/344.16/3.00/636120  0:01.85/1.80/0.03/16681

							- Ted
