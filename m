From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] git-pack-objects: cache small deltas between big objects
Date: Sun, 20 May 2007 21:35:56 -0700
Message-ID: <56b7f5510705202135s8c9cd9qf4489b2b5bb2e264@mail.gmail.com>
References: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon May 21 06:36:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpzdB-0001ND-8F
	for gcvg-git@gmane.org; Mon, 21 May 2007 06:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXEUEf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 00:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXEUEf7
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 00:35:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:46885 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbXEUEf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 00:35:58 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1079427uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 21:35:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aY03Y0Xc+ZQu+tpL8oY+ZCckaRjYHqEpRZpcnDVlOs9JMxoE670oTrtT+LuY+JsKUtwR/wn4p6D4M4S7ldGtn5TWLvJZ3Efp8kv2gHAHmpGnjrlezmcsoDQxA9q6SDMlNXdwMQeNCu3fb2lhHxNuvFV58JBNAPyvkvcX2wu+k2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AfU5w3hJrlHjgl4clNOj1QzLrG5vOswkTtM+3Fp/FwS2HNJ+XU0vziihzFWScDhp6kQILJrtUJzPyN243q6ZVvToBqOZA2kjgV3kXI7ZGzrTTs6Juv31iowcjkkZY0b0ONK+oI4WTAoe6OEd39Nca5FwyoyDD3tbUCer5uM1DGU=
Received: by 10.78.200.3 with SMTP id x3mr986614huf.1179722156965;
        Sun, 20 May 2007 21:35:56 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sun, 20 May 2007 21:35:56 -0700 (PDT)
In-Reply-To: <11796954641778-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47963>

On 5/20/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> Creating deltas between big blobs is a CPU and memory intensive task.
> In the writing phase, all (not reused) deltas are redone.

Actually,  just the ones selected,  which is approx 1/window.
Do you have any numbers describing the effects on runtime
and memory size for a known repo like linux-2.6?

> This patch adds support for caching deltas from the deltifing phase, so
> that that the writing phase is faster.
>
> The caching is limited to small deltas to avoid increasing memory usage very much.
> The implemented limit is (memory needed to create the delta)/1024.

Your limit is applied per-object,  and there is no overall limit
on the amount of memory not freed in the delta phase.
I suspect this caching would be disastrous for the large repo
with "megablobs" I'm trying to wrestle with at the moment.

> @@ -1294,10 +1302,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>         trg_entry->delta = src_entry;
>         trg_entry->delta_size = delta_size;
>         trg_entry->depth = src_entry->depth + 1;
> -       free(delta_buf);
> +       /* cache delta, if objects are large enough compared to delta size */
> +       if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
> +               trg_entry->delta_data = delta_buf;
> +       else
> +               free(delta_buf);
>         return 1;
>  }

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
