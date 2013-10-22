From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Tue, 22 Oct 2013 15:13:22 +0200
Message-ID: <526679F2.4060701@gmail.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>	<525FB287.7020204@gmail.com>	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>	<xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>	<526083E7.6080701@gmail.com> <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 15:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYbm9-0003Gy-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 15:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3JVNNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 09:13:30 -0400
Received: from mail-ea0-f171.google.com ([209.85.215.171]:64360 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3JVNNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 09:13:22 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so4207661ead.16
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PPCbFuiquTGfVceX8NXHYTnoNdtneP7Rhq5jSfD9vnc=;
        b=FcJq5LjdcCje1PcgcpMp1+HF3T0Lymej8ARTHwyOYXj32jFPTL07na3bGpMKoENsT4
         +yC5CHgcSbY+UlA22mI1h8n52eCSABtocCkFkZq/n4YQgi3VTME9lRNtegCVOCrSApJA
         j83xyPnSlPjQlDhG4mAHYyXznDvCAzN3k//3ueEOCx+YN8MqHcEaW18IE7NUlC0/219a
         G7yp58eNn+3qpI7c+bC22JsW/Dql31CJW5tjPw/zqjjXUjn3SLf+0Xclf4LtAV5O06F7
         8L1STkM2n4/hsGhzT3ruobsXWcfaFwrienIrZ6E3Y+0f4EQUyUIAK1VBUGbsJ+rRBYR7
         Hirg==
X-Received: by 10.15.61.137 with SMTP id i9mr8640573eex.50.1382447601776;
        Tue, 22 Oct 2013 06:13:21 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w6sm46170204eeo.12.2013.10.22.06.13.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 06:13:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236467>

Am 18.10.2013 21:09, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> The coredumps are caused by my patch #10, which free()s
>> cache_entries when they are removed, in combination with ...
> 
> Looking at that patch, it makes me wonder if remove_index_entry_at()
> and replace_index_entry() should be the ones that frees the old
> entry in the first place.  A caller may already have a ce pointing
> at an old entry and use the information from old_ce to update a new
> one after it installed it, e.g.
> 
> 	old_ce = ...
>         new_ce = make_cache_entry(... old_ce->name, ...);
>         replace_index_entry(... new_ce);
> 	new_ce->ce_mode = old_ce->cd_mode;
> 	free(old_ce);
> 
> The same goes for the functions that remove the entry.
> 

Moving free() to the callers or caller's callers would make it much more complicated (more places to change). Besides, most callers don't even have a reference to old_ce and simply remove by position. Of course, this doesn't prevent caller's caller's callers to keep a reference to a removed / replaced entry, as found by Thomas.

> 
> Going forward, I do agree with your patch #10 that removal or
> replacing that may make an existing entry unreferenced should free
> entries that are no longer used, and "use after free" should be
> forbidden.
> 

OK, I'll spend some more time analyzing the call hierarchies to see if there are more uses of removed cache_entries. I'll try to post an updated v4 by the end of the week.

Karsten
