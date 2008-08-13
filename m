From: Geert Bosch <bosch@adacore.com>
Subject: Re: pack operation is thrashing my server
Date: Tue, 12 Aug 2008 23:58:22 -0400
Message-ID: <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <20080813031503.GC5855@spearce.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:59:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT7WC-0004GH-92
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbYHMD6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbYHMD6Z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:58:25 -0400
Received: from rock.gnat.com ([205.232.38.15]:43468 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333AbYHMD6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:58:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 8D42A2A9B48;
	Tue, 12 Aug 2008 23:58:24 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pyZB0oF9q-UA; Tue, 12 Aug 2008 23:58:24 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 22C012A9B3F;
	Tue, 12 Aug 2008 23:58:24 -0400 (EDT)
In-Reply-To: <20080813031503.GC5855@spearce.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92178>


On Aug 12, 2008, at 23:15, Shawn O. Pearce wrote:

> Geert Bosch <bosch@adacore.com> wrote:
>> I've always felt that keeping largish objects (say anything >1MB)
>> loose makes perfect sense. These objects are accessed infrequently,
>> often binary or otherwise poor candidates for the delta algorithm.
>
> Sadly this causes huge problems with streaming a pack because the
> loose object has to be inflated and then delfated again to fit into
> the pack stream.
Sure, but that really is not that much of an issue. For people
with large systems connected by very fast networks, the current
situation is probably fine, and spending a lot of effort for
packing often makes sense.

However, for a random repository of Joe User, all the effort spent
on packing will probably never be gained back. Most people just
suck content from upstream and at most maintain a couple of local
hacks on top of that. Little or nothing is ever pushed to other
systems.

Even when pushing to other systems, this often is just a handful of  
objects
though a slow line and compression/decompression speeds just don't  
matter
much.

> The new style loose object format was meant to fix this problem,
> and it did, but the code was difficult to manage so it was backed
> out of the tree.

One nice optimization we could do for those pesky binary large objects
(like PDF, JPG and GZIP-ed data), is to detect such files and revert
to compression level 0. This should be especially beneficial
since already compressed data takes most time to compress again.

   -Geert
