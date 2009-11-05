From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Wed, 04 Nov 2009 19:22:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911041915120.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 01:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5q75-0008Rm-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 01:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbZKEAV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 19:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZKEAV5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 19:21:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9537 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZKEAV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 19:21:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSM00KOF10PW740@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 19:22:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4AF214D5.6050202@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132180>

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> @@ -1638,6 +1657,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
>  				delta_search_threads);
>  	p = xcalloc(delta_search_threads, sizeof(*p));
>  
> +	init_threaded_search();

Careful.  At the beginning of the function you'll find:

        if (delta_search_threads <= 1) {
                find_deltas(list, &list_size, window, depth, processed);
                return;
        }

That is, if we have thread support compiled in but we're told to use 
only one thread, then the bulk of the work splitting is bypassed 
entirely.  Inside find_deltas() there will still be pthread_mutex_lock() 
and pthread_mutex_unlock() calls even if no threads are spawned.


Nicolas
