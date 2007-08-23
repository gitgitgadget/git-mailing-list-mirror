From: Nicolas Pitre <nico@cam.org>
Subject: Re: Strange code in diff-delta.c
Date: Wed, 22 Aug 2007 21:45:34 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708222126590.16727@xanadu.home>
References: <85k5rnjcbu.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 03:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO1lU-0000Tx-4q
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 03:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbXHWBph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 21:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbXHWBpg
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 21:45:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10119 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXHWBpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 21:45:36 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN700I02E7YPU00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Aug 2007 21:45:35 -0400 (EDT)
In-reply-to: <85k5rnjcbu.fsf@lola.goethe.zz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56447>

On Thu, 23 Aug 2007, David Kastrup wrote:

> 
> I am currently looking what can be done to speed up deltaing.  The
> following code can be found here:
> 
> 	for (i = 0; i < hsize; i++) {
> 		if (hash_count[i] < HASH_LIMIT)
> 			continue;
> 		entry = hash[i];
> 		do {
> 			struct index_entry *keep = entry;
> 			int skip = hash_count[i] / HASH_LIMIT / 2;
> 			do {
> 				entry = entry->next;
> 			} while(--skip && entry);
> 			keep->next = entry;
> 		} while(entry);
> 	}
> 
> If I analyze what happens for various values of hash_count[i], I get
> the following (the first case is by far the worst):
> 
> HASH_LIMIT <= hash_count[i] < 2*HASH_LIMIT:
>   skip = 0;
>   do .. while terminates with negative skip and entry == 0, keep->next
>   is set to 0 -> all hashes except the first one get dropped.
>   Result is new_hash_count = 1.  Ugh, ugh, ugh.
> 
> 2*HASH_LIMIT <= hash_count[i] < 4*HASH_LIMIT
>   skip = 1;
>   do .. while does one iteration, every second value is skipped,
>   result is that HASH_LIMIT <= new_hash_count < 2*HASH_LIMIT
> 
> 4*HASH_LIMIT <= hash_limit[i] < 6*HASH_LIMIT
>   skip = 2;
>   do .. while does two iterations, two of three values are skipped,
>   result is that 4*HASH_LIMIT/3 <= new_hash_count < 2*HASH_LIMIT
> 
> And so on.  It would appear that if HASH_LIMIT is supposed to do what
> it is seemingly intended for, the skip calculation has to be just
> 
> 			int skip = hash_count[i] / HASH_LIMIT;
> 
> Otherwise, there is completely broken behavior for values between
> HASH_LIMIT and 2*HASH_LIMIT (where only a single hash survives), and
> for larger values, the limit will be 2*HASH_LIMIT rather than
> HASH_LIMIT as was probably intended.

You're absolutely right.

I don't know what I was thinking when I wrote that code, but the /2 is 
bogus.

Please send a patch to Junio with my ACK.


Nicolas
