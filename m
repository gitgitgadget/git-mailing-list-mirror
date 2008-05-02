From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 6/7] pack-objects: allow for early delta deflating
Date: Fri, 02 May 2008 18:44:51 -0400
Message-ID: <481B9963.6050605@gmail.com>
References: <1209755511-7840-1-git-send-email-nico@cam.org> <1209755511-7840-2-git-send-email-nico@cam.org> <1209755511-7840-3-git-send-email-nico@cam.org> <1209755511-7840-4-git-send-email-nico@cam.org> <1209755511-7840-5-git-send-email-nico@cam.org> <1209755511-7840-6-git-send-email-nico@cam.org> <1209755511-7840-7-git-send-email-nico@cam.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:46:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js412-0006uo-Al
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 00:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbYEBWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 18:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759772AbYEBWpT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 18:45:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18159 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019AbYEBWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 18:45:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so35315ywe.1
        for <git@vger.kernel.org>; Fri, 02 May 2008 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=G5HECoDKtPME5iWokzxN3x2c+IQdATXtEyviprOzXPk=;
        b=qQv0WRa8g9NnpHOOaQrOyVqY/aQpnU+CAygG6t3wX7uX4e/ts8J6DBDuDdbNRyTpzL3AjgKrXtT9NJZxGdL9GZx6NkN59gJcnK2zEV099WQyMlqvQPOOiGGG+leFufRQfbsH1nXrtIrlS8+X4mAFByPeRLvRfxg7kePIxn7M+Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oKnhM4tEok2oKeAldXj71Khq/dpIfjSsJafEnefJT3OGGYL6JhPMi3RSjzomqAUclVyR7+L6MNRjzkSAaq5JW5qRXuq6D2IGW6qNBt3J+OEEScoOrzFl1F8Sq+hB5bFWXdvSX5UdPf3vk0aCjkq2Ip8NEwKgEYWA9YgyagqTBWQ=
Received: by 10.151.83.12 with SMTP id k12mr4087444ybl.1.1209768303019;
        Fri, 02 May 2008 15:45:03 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 8sm398462ywg.6.2008.05.02.15.45.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 May 2008 15:45:01 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <1209755511-7840-7-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81042>

Nicolas Pitre wrote:
> When the delta data is cached in memory until it is written to a pack
> file on disk, it is best to compress it right away in find_deltas() for
> the following reasons:
> 
>   - we have to compress that data anyway;
> 
>   - this allows for caching more deltas with the same cache size limit;
> 
>   - compression is potentially threaded.
> 
> This last point is especially relevant for SMP run time.  For example,
> repacking the Linux repo on a quad core processor using 4 threads with
> all default settings produce the following results before this change:
> 
> 	real    2m27.929s
> 	user    4m36.492s
> 	sys     0m3.091s
> 
> And with this change applied:
> 
> 	real    2m13.787s
> 	user    4m37.486s
> 	sys     0m3.159s
> 
> So the actual execution time stayed more or less the same but the
> wall clock time is shorter.
> 
> This is however not a good thing to do when generating a pack for
> network transmission.  In that case, the network is most likely to
> throttle the data throughput, so it is best to make find_deltas()
> faster in order to start writing data ASAP since we can afford
> spending more time between writes to compress the data
> at that point.

[...]

>  
> +		/*
> +		 * If we decided to cache the delta data, then it is best
> +		 * to compress it right away.  First because we have to do
> +		 * it anyway, and doing it here while we're threaded will
> +		 * save a lot of time in the non threaded write phase,
> +		 * as well as allow for caching more deltas within
> +		 * the same cache size limit.
> +		 * ...
> +		 * But only if not writing to stdout, since in that case
> +		 * the network is most likely throttling writes anyway,
> +		 * and therefore it is best to go to the write phase ASAP
> +		 * instead, as we can afford spending more time compressing
> +		 * between writes at that moment.
> +		 */
> +		if (entry->delta_data && !pack_to_stdout) {
> +			entry->z_delta_size = do_compress(&entry->delta_data,
> +							  entry->delta_size);
> +			cache_lock();
> +			delta_cache_size -= entry->delta_size;
> +			delta_cache_size += entry->z_delta_size;
> +			cache_unlock();
> +		}
> +
>  		/* if we made n a delta, and if n is already at max
>  		 * depth, leaving it in the window is pointless.  we
>  		 * should evict it first.

Although I like the idea of changing the behavior if the output is 
likely to be throttled, I do not like the test for that condition being 
"is it going to stdout". This is something better suited to a command 
line argument.
