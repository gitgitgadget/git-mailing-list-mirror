From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
	an up-to-date cache entry
Date: Fri, 10 Jul 2009 03:29:21 +0400
Message-ID: <20090709232921.GC19425@dpotapov.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <20090709210513.GB19425@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP33s-000666-Lm
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZGIX3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbZGIX3t
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:29:49 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42405 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZGIX3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 19:29:48 -0400
Received: by fxm18 with SMTP id 18so529178fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HVzhKs9sJkm0dYGh2ELIMjO3aR6Lowyr3dNlEdp8ddQ=;
        b=LWD9iLmcdOENNM0Jm1+Eziqgni9cr7bXO6edq/B4YsZHaqjMSpqSxQ8E8mr4Dq2FFR
         bvPvzX2UlPH6+P837oEj9cuEmQjDr8SnTQifm8rbyQYiloWYejstwOu/hyEdFZ5BxUJw
         HZxm+faYsRb3+HF2MgxbkZqHkmTFoq43vwcKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KT8NWUV0E2fqoHE2JuTfQdP7TpSXQaLHAXtGa/cUuPb3bkawI15hj84WupEnGvp4hD
         rttjK7f1d92mqOU0Ad5PprZw699WHdR3kX2yWYmVB9bpW05cTE9y0GK+uhWBZot1Ttk/
         xhxl3Uv0drVVY9QXyH7GhszhT0EZlAXsG+ca0=
Received: by 10.103.173.15 with SMTP id a15mr732095mup.59.1247182185881;
        Thu, 09 Jul 2009 16:29:45 -0700 (PDT)
Received: from localhost (ppp85-141-235-157.pppoe.mtu-net.ru [85.141.235.157])
        by mx.google.com with ESMTPS id 23sm1994824mum.5.2009.07.09.16.29.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 16:29:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090709210513.GB19425@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123021>

On Fri, Jul 10, 2009 at 01:05:13AM +0400, Dmitry Potapov wrote:
> 
> There is one strange thing though. Before that patch the number of
> 'open' for each directory was always the same in each run. But after
> that patch, it slightly differs in each run... Comparing with results
> without this patch, the number of open for some directories in some
> be less by one... which is puzzling...

It appears that is a purely Windows thing... It seems extra opens for
directories inside of the working tree are caused by Windows Prefetcher.
http://en.wikipedia.org/wiki/Prefetcher

Accordingly to the Process Monitor, during start-up, it opens and reads
most directories in the repo that have subdirectories but sometimes it
skips some of them... So, the patch works as expected... Perhaps, I
should disable this prefetcher for testing to get more reproduceable
results. Anyway, this prefetecher does not issue QueryOpen (stat) for
files in the repo, so my numbers for 'stat' are not affected by it.


Dmitry
