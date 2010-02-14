From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 12:55:24 +0100
Message-ID: <4B77E4AC.6030600@gnu.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix> <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix> <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> <20100214024259.GB9704@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 12:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngd4X-0006j7-Mi
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 12:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab0BNLz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 06:55:29 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:45530 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab0BNLz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 06:55:28 -0500
Received: by fxm27 with SMTP id 27so205189fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 03:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=0gdnoVmuR0Todmv0vq4F9moD2jtFGkCZQia7jcKNsOo=;
        b=ea2WHAoO9ZihHHQKP7ln4aOZmG0320Myn89BhWrPFqrwcWo5IceG17c9du1vx6JDw2
         ZHyW1yGIF6WyyT8HIKIrXJ9H4Nr+TuNkIYKq993K9u9mklpuQ26Feqx4dEaN5SWZS+zw
         +MJG/SUW/EtWPCc0uX4Arvlj/bkvHm0mJCdgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=t9DoCoc++YMdhgKc2qrDS4nlnkOb7pTtT5k0zv8c9jWk1phesoHZbY+qdRJbsZUl6E
         3q7DNVPcxCpkVM6Dw6qjT6H+rhc3QBq+bXlcUa0MjwhgwUeQlIX0+na6pVGfDU4EpVJX
         9TJV6MYku1IDxPhBJmKkpy3DaETVAtnpkPAVQ=
Received: by 10.223.4.145 with SMTP id 17mr4419451far.17.1266148526985;
        Sun, 14 Feb 2010 03:55:26 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 19sm8394722fkr.48.2010.02.14.03.55.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 03:55:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <20100214024259.GB9704@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139900>

On 02/14/2010 03:42 AM, Dmitry Potapov wrote:
> In fact, we know mmap() also may fail for huge files, so can
> strbuf_read().

On a 64-bit machine mmap should fail pretty much never, as it is limited
by address space and not available memory.

That said I can reproduce the result here too, and it's actually quite 
understandable from your "time" results: mmap has a minor page fault for 
every 4k you read (or at least that's the order of magnitude), read has 
basically none.  Furthermore, it's true that with read you touch the 
whole memory twice from beginning to end, while with mmap you touch a 
page twice and move on; however, a file's contents will almost always 
fit in the L2 cache, so it's not too expensive.

I tried madvise(buf, size, MADV_SEQUENTIAL) and MADV_WILLNEED but it has 
no effect.

I suspect mmap will be faster only if the data is not in cache (so the 
cost of a page fault is negligible compared to going to disk) and the 
average file size is a few megabytes.

Paolo
