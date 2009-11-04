From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Wed, 04 Nov 2009 13:10:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kJe-0000TO-LY
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565AbZKDSKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757544AbZKDSKS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:10:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15465 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbZKDSKR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:10:17 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSL00L60JTAGUF0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 13:10:22 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132110>

On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:

> +	NO_STATIC_PTHREADS_INIT = YesPlease

Let's not go that route please.  If Windows can't get away without 
runtime initializations then let's use them on all platforms.  There is 
no gain in exploding the code path combinations here wrt testing 
coverage.

> +static THREAD_RET_TYPE threaded_find_deltas(void *arg)

Why can't you just cast the function pointer in your pthread_create 
wrapper instead?  No one cares about the returned value anyway.

> @@ -2327,6 +2354,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  #ifdef THREADED_DELTA_SEARCH
>  	if (!delta_search_threads)	/* --threads=0 means autodetect */
>  		delta_search_threads = online_cpus();
> +
> +	init_threaded_delta_search();

What about doing this at the beginning of ll_find_deltas() instead?
And similarly for cleanup_threaded_delta_search(): call it right before 
leaving ll_find_deltas().  This way thread issues would remain more 
localized.  In fact I'd move the whole thing above in ll_find_deltas() 
as well (separately from this patch though).


Nicolas
