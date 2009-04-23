From: Geert Bosch <bosch@adacore.com>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 13:43:18 -0400
Message-ID: <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221548310.6741@xanadu.home> <20090422200502.GA14304@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 19:52:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx35y-0001Ft-R8
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbZDWRut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbZDWRus
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 13:50:48 -0400
Received: from rock.gnat.com ([205.232.38.15]:43998 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbZDWRus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 13:50:48 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2009 13:50:48 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 272EA2BAC9E;
	Thu, 23 Apr 2009 13:43:19 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EKSTIR2M6dLM; Thu, 23 Apr 2009 13:43:19 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id A6D9D2BAC9D;
	Thu, 23 Apr 2009 13:43:18 -0400 (EDT)
In-Reply-To: <20090422200502.GA14304@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117350>


On Apr 22, 2009, at 16:05, Jeff King wrote:
> The other tradeoff, mentioned by Matthieu, is not about speed, but  
> about
> rollover of files on disk. I think he would be in favor of a less
> optimal pack setup if it meant rewriting the largest packfile less
> frequently.
>
> However, it may be reasonable to suggest that he just not manually  
> "gc"
> then. If he is not generating enough commits to warrant an auto-gc,  
> then
> he is probably not losing much by having loose objects. And if he is,
> then auto-gc is already taking care of it.

For large repositories with lots of large files, git spends too much
time copying large packs for relatively little gain. This is obvious  
when
you include a few dozen large objects in any repository.
Currently, there is no limit to the number of times this data may
be copied. In particular, the average amount of I/O needed for
changes of size X depends linearly on the size of the total repository.
So, the mere presence of a couple of large objects has an large  
distributed overhead.

Wouldn't it be better to have a maximum of N packs, named
pack_0 .. pack_(N - 1),  in the repository with each pack_i being
between 2^i and 2^(i+1)-1 bytes large? We could even dispense
completely with loose objects and instead have each git operation
create a single new pack.

Then the repacking rule simply becomes: if a new pack_i would
overwrite one of the same name, both packs are merged into a new  
pack_(i+1).

To analyze performance, let's assume the worst case, where the
size of a pack is equal to the expanded size of all objects contained  
in it
and new packs only have unique objects. With these assumptions, an  
object
residing in pack_i can only be merged into a pack_j with j > i.
So, if any repository of size n has k objects, the maximum total I/O  
required
to create the repository (counting all operations in its history) is  
O(n log k).

The current situation, the number of repacks required is linear in the  
number of
objects, so the total work required is more like O(n k).

While I understand that the above is a gross simplification, and actual
performance is dictated by packing efficiency and constant factors  
rather
than asymptotic performance, I think the general idea of limiting the
number of packs in the way described is useful and will lead to  
significant
speedups, especially during large imports that currently require  
frequent
repacking of the entire repository.
