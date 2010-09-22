From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: never deltify objects bigger than
 window_memory_limit.
Date: Wed, 22 Sep 2010 08:00:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009220749440.13233@xanadu.home>
References: <1285151105-32454-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 14:00:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyO04-00035O-5M
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 14:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0IVMAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 08:00:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33637 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0IVMAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 08:00:30 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9500JYFDCFOY30@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Sep 2010 08:00:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1285151105-32454-1-git-send-email-apenwarr@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156801>

On Wed, 22 Sep 2010, Avery Pennarun wrote:

> With very large objects, just loading them into the delta window wastes a
> huge amount of memory.  In one repo, I have some objects around 1GB in size,
> and git-pack-objects seems to require about 8x that in order to deltify it,
> even when the window memory limit is small (eg. --window-memory=100M).  With
> this patch, the maximum memory usage is about halved.
> 
> Perhaps more importantly, however, disabling deltification for large objects
> seems to reduce memory thrashing when you can't fit multiple large objects
> into physical RAM at once.  It seems to be the difference between "never
> finishes" and "finishes eventually" for me.
> 
> Test:
> 
> I created a test repo with 10 sequential commits containing a bunch of
> nearly-identical 110MB files (just appending a line each time).
> 
> Without this patch:
> 
>     $ /usr/bin/time git repack -a --window-memory=100M
> 
>     Counting objects: 43, done.
>     warning: suboptimal pack - out of memory
>     Compressing objects: 100% (43/43), done.
>     Writing objects: 100% (43/43), done.
>     Total 43 (delta 14), reused 0 (delta 0)
>     42.79user 1.07system 0:44.53elapsed 98%CPU (0avgtext+0avgdata
>       866736maxresident)k
>       0inputs+2752outputs (0major+718471minor)pagefaults 0swaps
> 
> With this patch:
> 
>     $ /usr/bin/time -a git repack -a --window-memory=100M
> 
>     Counting objects: 43, done.
>     Compressing objects: 100% (30/30), done.
>     Writing objects: 100% (43/43), done.
>     Total 43 (delta 14), reused 0 (delta 0)
>     35.86user 0.65system 0:36.30elapsed 100%CPU (0avgtext+0avgdata
>       437568maxresident)k
>       0inputs+2768outputs (0major+366137minor)pagefaults 0swaps
> 
> It apparently still uses about 4x the memory of the largest object, which is
> about twice as good as before, though still kind of awful.  (Ideally, we
> wouldn't even load the entire large object into memory even once.)

To not load big objects into memory, we'd have to add support for the 
core.bigFileThreshold config option in more places.

>  builtin/pack-objects.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0e81673..9f1a289 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1791,6 +1791,9 @@ static void prepare_pack(int window, int depth)
>  		if (entry->size < 50)
>  			continue;
>  
> +		if (window_memory_limit && entry->size > window_memory_limit)
> +                	continue;
> +

I think you should even use entry->size/2 here, or even entry->size/4.  
The reason for that is 1) you need at least 2 such similar objects in 
memory to find a possible delta, and 2) reference object to delta 
against has to be block indexed and that index table is almost the same 
size as the object itself especially on 64-bit machines.


Nicolas
