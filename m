From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re:
Date: Fri, 08 May 2009 10:51:51 -0500
Message-ID: <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>  <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>  <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>  <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>  <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>  <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com> <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 17:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2SOW-00066X-F5
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 17:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761580AbZEHPxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 11:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761124AbZEHPxM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 11:53:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43988 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759268AbZEHPxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 11:53:11 -0400
Received: by mail.nrlssc.navy.mil id n48FpqCR024149; Fri, 8 May 2009 10:51:52 -0500
In-Reply-To: <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain>
X-OriginalArrivalTime: 08 May 2009 15:51:52.0776 (UTC) FILETIME=[E7FB8480:01C9CFF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118612>

Linus Torvalds wrote:
> 
> On Fri, 8 May 2009, Alex Riesen wrote:
>> I did (cygwin). My guess, the improvement is completely dwarfed by the
>> other overheads (like starting git and writing files).
> 
> Oh, I meant "git checkout" as in not even switching branches, or perhaps 
> switching branches but just changing a single file (among thousands).
> 
> If you actually end up re-writing all files, then yes, it will obviously 
> be totally dominated by other things.
> 
> For example, in the kernel, switching between two branches that only 
> differ in one file (Makefile) went from 0.18 seconds down to 0.14 seconds 
> for me just because of the fewer lstat() calls.
> 
> Noticeable? No. But it might be more noticeable on some other OS, or with 
> some networked filesystem.

plain 'git checkout' on linux kernel over NFS.

Best time without patch: 1.20 seconds

  0.45user 0.71system 0:01.20elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+15467minor)pagefaults 0swaps

Best time with patch (core.preloadindex = true): 1.10 seconds

  0.43user 4.00system 0:01.10elapsed 402%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+13999minor)pagefaults 0swaps

Best time with patch (core.preloadindex = false): 0.84 seconds

  0.42user 0.39system 0:00.84elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+13965minor)pagefaults 0swaps

Best time with read_cache_preload patch only: 1.38 seconds

  0.45user 4.42system 0:01.38elapsed 352%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+13990minor)pagefaults 0swaps

The read_cache_preload() changes actually slow things down for me for this
case.

Reduction in lstat's gives a nice 30% improvement.

-brandon
