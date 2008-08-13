From: Geert Bosch <bosch@adacore.com>
Subject: Re: pack operation is thrashing my server
Date: Tue, 12 Aug 2008 23:12:58 -0400
Message-ID: <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Ken Pratt" <ken@kenpratt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 05:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT7Ev-00017g-Js
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 05:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453AbYHMDkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 23:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755445AbYHMDke
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 23:40:34 -0400
Received: from rock.gnat.com ([205.232.38.15]:46970 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432AbYHMDkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 23:40:33 -0400
X-Greylist: delayed 1652 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Aug 2008 23:40:33 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 1A71D2AAEF8;
	Tue, 12 Aug 2008 23:13:00 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9f361EXuBpXg; Tue, 12 Aug 2008 23:13:00 -0400 (EDT)
Received: from [172.16.1.95] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id BBF572AAEF7;
	Tue, 12 Aug 2008 23:12:59 -0400 (EDT)
In-Reply-To: <87vdy71i6w.fsf@basil.nowhere.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92175>


On Aug 11, 2008, at 15:10, Andi Kleen wrote:

> As a quick workaround you could try it with a 32bit git executable?
> (assuming you have a distribution with proper multilib support)
>
> I think the right fix would be to make git throttle itself (not
> use mmap, use very small defaults etc.) on low memory systems.
> It could take a look a /proc/meminfo for this.

I've always felt that keeping largish objects (say anything >1MB)
loose makes perfect sense. These objects are accessed infrequently,
often binary or otherwise poor candidates for the delta algorithm.

Many repositories are mostly well-behaved with large number of text
files that aren't overly large and compress/diff well. However, often
a few huge files creep in. These might be a 30 MB Word or PDF documents
(with lots of images of course), a bunch of artwork, some random .tgz  
files
with required tools or otherwise.

Regardless of their origin, the presence of such files in real-world  
SCMs
is a given and can ruin performance, even if they're hardly ever  
accessed
or updated. If we would leave such oddball objects loose, the pack would
be much smaller, easier to generate, faster to use and there should be  
no
memory usage issues.

   -Geert
