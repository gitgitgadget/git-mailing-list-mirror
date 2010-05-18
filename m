From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 18 May 2010 15:41:05 -0400
Message-ID: <20100518194105.GA4723@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <4BF2E168.2020706@puckerupgames.com>
 <20100518191933.GB2383@coredump.intra.peff.net>
 <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 18 21:41:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESfD-0006KL-RN
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758076Ab0ERTlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:41:10 -0400
Received: from peff.net ([208.65.91.99]:39860 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572Ab0ERTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:41:09 -0400
Received: (qmail 20882 invoked by uid 107); 18 May 2010 19:41:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 May 2010 15:41:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 May 2010 15:41:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005181528550.12758@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147303>

On Tue, May 18, 2010 at 03:33:58PM -0400, Nicolas Pitre wrote:

> > It will have to write the whole 200M packfile out each time, though.
> 
> No.  gc will only create a pack with new loose objects by default.  
> Only if the number of packs grow too large will it combine them into one 
> pack.

I think that is only "gc --auto". With regular gc:

  $ git init
  $ echo content >file && git add file && git commit -m one
  $ git gc
  Counting objects: 3, done.
  Writing objects: 100% (3/3), done.
  Total 3 (delta 0), reused 0 (delta 0)
  $ du -a .git/objects/pack
  4  .git/objects/pack/pack-5f6fe4b14529d73f51d7c8efa69306edd35f2302.idx
  4  .git/objects/pack/pack-5f6fe4b14529d73f51d7c8efa69306edd35f2302.pack
  12 .git/objects/pack

  $ echo content >>file && git commit -a -m two
  $ git gc
  Counting objects: 6, done.
  Delta compression using up to 2 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (6/6), done.
  Total 6 (delta 0), reused 3 (delta 0)
  $ du -a .git/objects/pack
  4  .git/objects/pack/pack-ecf41a1c120eb911f50fdd2c159e94d5832974f7.idx
  4  .git/objects/pack/pack-ecf41a1c120eb911f50fdd2c159e94d5832974f7.pack
  12 .git/objects/pack

So six objects written in the second gc, and obviously a brand new
single pack.

-Peff
