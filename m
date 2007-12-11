From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Tue, 11 Dec 2007 18:02:35 +0100
Message-ID: <475EC2AB.60702@viscovery.net>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jon Smirl <jonsmirl@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J28Vb-0003Gs-NM
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbXLKRCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756023AbXLKRCj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:02:39 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14219 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009AbXLKRCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:02:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J28UJ-00071j-8w; Tue, 11 Dec 2007 18:01:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 244B2546; Tue, 11 Dec 2007 18:02:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67885>

Nicolas Pitre schrieb:
> @@ -1612,10 +1620,10 @@ static void *threaded_find_deltas(void *arg)
>  		pthread_mutex_lock(&data_ready);
>  		pthread_mutex_unlock(&data_request);
>  
> -		if (!me->list_size)
> +		if (!me->remaining)
>  			return NULL;
>  
> -		find_deltas(me->list, me->list_size,
> +		find_deltas(me->list, &me->remaining,
>  			    me->window, me->depth, me->processed);
>  	}
>  }

This hunk caught my attention. &data_ready is locked, but not released in
this function.

Looking more closely at the code surrounding this hunk, it seems that the
lock is released in a *different* thread than the one that locked it. This
works on Linux, but is not portable. We will have to use condition variables
like every one else does in a producer-consumer-like scenario.

-- Hannes
