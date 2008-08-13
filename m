From: Geert Bosch <bosch@adacore.com>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 12:01:20 -0400
Message-ID: <3E057C8D-FF72-47A2-BBA8-27A22AD67167@adacore.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 18:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTInr-0000Ce-0H
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 18:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYHMQBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbYHMQBY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 12:01:24 -0400
Received: from rock.gnat.com ([205.232.38.15]:40836 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbYHMQBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 12:01:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 29DD12A968E;
	Wed, 13 Aug 2008 12:01:22 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XsNyLpfiFCQt; Wed, 13 Aug 2008 12:01:22 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id A91B92A967A;
	Wed, 13 Aug 2008 12:01:21 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92235>

On Aug 13, 2008, at 10:35, Nicolas Pitre wrote:
> On Tue, 12 Aug 2008, Geert Bosch wrote:
>
>> I've always felt that keeping largish objects (say anything >1MB)
>> loose makes perfect sense. These objects are accessed infrequently,
>> often binary or otherwise poor candidates for the delta algorithm.
>
> Or, as I suggested in the past, they can be grouped into a separate
> pack, or even occupy a pack of their own.

This is fine, as long as we're not trying to create deltas
of the large objects, or do other things that requires keeping
the inflated data in memory.

> As soon as you have more than
> one revision of such largish objects then you lose again by keeping  
> them
> loose.

Yes, you lose potentially in terms of disk space, but you avoid the
large memory footprint during pack generation. For very large blobs,
it is best to degenerate to having each revision of each file on
its own (whether we call it a single-file pack, loose object or  
whatever).
That way, the large file can stay immutable on disk, and will only
need to be accessed during checkout. GIT will then scale with good
performance until we run out of disk space.

The alternative is that people need to keep large binary data out
of their SCMs and handle it on the side. Consider a large web site
where I have all scripts, HTML content, as well as a few movies
to manage. The movies basically should be copied and stored, only
to be accessed when a checkout (or push) is requested.

If we mix the very large movies with the 100,000 objects representing
the webpages, the resulting pack will become unwieldy and slow even
to just copy around during repacks.

> You'll have memory usage issues whenever such objects are accessed,
> loose or not.
Why? The only time we'd need to access their contents for checkout
or when pushing across the network. These should all be steaming  
operations
with small memory footprint.

>  However, once those big objects are packed once, they can
> be repacked (or streamed over the net) without really "accessing"  
> them.
> Packed object data is simply copied into a new pack in that case which
> is less of an issue on memory usage, irrespective of the original pack
> size.
Agreed, but still, at least very large objects. If I have a 600MB
file in my repository, it should just not get in the way. If it gets
copied around during each repack, that just wastes I/O time for no
good reason. Even worse, it causes incremental backups or filesystem
checkpoints to become way more expensive. Just leaving large files
alone as immutable objects on disk avoids all these issues.

   -Geert
