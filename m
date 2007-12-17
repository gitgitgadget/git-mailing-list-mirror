From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] threaded pack-objects: Use condition variables for
 thread communication.
Date: Mon, 17 Dec 2007 08:44:17 +0100
Message-ID: <476628D1.4020300@viscovery.net>
References: <200712160018.54171.johannes.sixt@telecom.at> <200712161941.38109.johannes.sixt@telecom.at> <20071216190016.GC4999@xp.machine.xx> <200712162045.34456.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Aed-0003V3-8R
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762220AbXLQHoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbXLQHoX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:44:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8918 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbXLQHoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:44:23 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4AeQ-00033m-HD; Mon, 17 Dec 2007 08:44:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6CBE5546; Mon, 17 Dec 2007 08:44:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200712162045.34456.johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68512>

I just discovered a theoretical resource leakage:

> +	/* Partition the work amongst work threads. */
>  	for (i = 0; i < delta_search_threads; i++) {
...
> +		pthread_mutex_init(&p[i].mutex, NULL);
> +		pthread_cond_init(&p[i].cond, NULL);

These two initializations...

>  	}
>  
> +	/* Start work threads. */
> +	for (i = 0; i < delta_search_threads; i++) {
> +		if (!p[i].list_size)
> +			continue;

... should go here because...

> +		ret = pthread_create(&p[i].thread, NULL,
> +				     threaded_find_deltas, &p[i]);
> +		if (ret)
> +			die("unable to create thread: %s", strerror(ret));
> +		active_threads++;
> +	}
...
> +	while (active_threads) {
...
>  		if (!sub_size) {
>  			pthread_join(target->thread, NULL);
> +			pthread_cond_destroy(&target->cond);
> +			pthread_mutex_destroy(&target->mutex);

... we tear down only those for which we actually started a thread.

>  			active_threads--;
>  		}
> +	}

Will send a patch this evening.

-- Hannes
