From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH 4/5] pack-objects: avoid reading uninitalized data
Date: Wed, 22 Oct 2008 21:11:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810222107540.26244@xanadu.home>
References: <20081022202810.GA4439@coredump.intra.peff.net>
 <20081022203103.GD4547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 23 03:13:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksol5-0000kR-AB
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbYJWBLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 21:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYJWBLX
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 21:11:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46960 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbYJWBLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 21:11:22 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9600J8739RZH30@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Oct 2008 21:10:39 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081022203103.GD4547@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98934>

On Wed, 22 Oct 2008, Jeff King wrote:

> In the main loop of find_deltas, we do:
> 
>   struct object_entry *entry = *list++;
>   ...
>   if (!*list_size)
> 	  ...
> 	  break
> 
> Because we look at and increment *list _before_ the check of
> list_size, in the very last iteration of the loop we will
> look at uninitialized data, and increment the pointer beyond
> one past the end of the allocated space. Since we don't
> actually do anything with the data until after the check,
> this is not a problem in practice.
> 
> But since it technically violates the C standard, and
> because it provokes a spurious valgrind warning, let's just
> move the initialization of entry to a safe place.
> 
> This fixes valgrind errors in t5300, t5301, t5302, t303, and
> t9400.
> 
> Signed-off-by: Jeff King <peff@peff.net>

OK.  Minor nit...

> ---
>  builtin-pack-objects.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 59c30d1..15b80db 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1375,7 +1375,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
>  	array = xcalloc(window, sizeof(struct unpacked));
>  
>  	for (;;) {
> -		struct object_entry *entry = *list++;
> +		struct object_entry *entry;
>  		struct unpacked *n = array + idx;
>  		int j, max_depth, best_base = -1;
>  
> @@ -1384,6 +1384,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
>  			progress_unlock();
>  			break;
>  		}

---> Please preserve the empty line here so the previous code
     chunk still appears logically separate.

> +		entry = *list++;
>  		(*list_size)--;
>  		if (!entry->preferred_base) {
>  			(*processed)++;


Nicolas
