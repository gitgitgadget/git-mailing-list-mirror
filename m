From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
	an up-to-date cache entry
Date: Fri, 10 Jul 2009 01:05:13 +0400
Message-ID: <20090709210513.GB19425@dpotapov.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:05:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP0oX-00064w-MV
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 23:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788AbZGIVFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 17:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634AbZGIVFk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 17:05:40 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:33120 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099AbZGIVFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 17:05:40 -0400
Received: by bwz25 with SMTP id 25so460066bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LdODRmh09P6nyiRFH81+Rng1NpbMqhLA7h14GdEP1dI=;
        b=fZEoxz/yckvltI58xSidR0T2VldeWye8IBj9NYAS+AJ8Z3bMUASP2X6NiQTMFtMs8E
         r7okTtbtzWwtbUMaHS+rru+jkS36rSbrqKwriESLzvcfScqsB4G0TshnyDmPU5iA3wL7
         2K4ulLDSzmjmbHX0vatQAhZZJVCetwbfEeFio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LBbwgWt5lJfIYxPbrPq+J1GoJv+kyKa/m+x5FIi2xDWaMw7eId4A1CCW7sNtb+gSiQ
         Rn7wdfohMANZkq+1hyRZEm88TUtCopkG1OQ7AnjWHMYXZBfCxL5rQQtnMF9Q5yroCD69
         RNQ8yAYCfQdf7n6hOtoO7WUBOIf4p64I3cuPM=
Received: by 10.102.228.10 with SMTP id a10mr680626muh.16.1247173537940;
        Thu, 09 Jul 2009 14:05:37 -0700 (PDT)
Received: from localhost (ppp85-141-235-157.pppoe.mtu-net.ru [85.141.235.157])
        by mx.google.com with ESMTPS id y2sm1587262mug.13.2009.07.09.14.05.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 14:05:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123011>

On Thu, Jul 09, 2009 at 09:32:03AM -0700, Junio C Hamano wrote:
> 
> Yeah, in Dmitry's response that crossed with this update patch from you,
> he says lstat() on directories are still problem---it would be interesting to
> hear what he sees after applying this patch and retesting.

With this patch, I see one 'stat' less for each directory, which on my
repo resulted in about 10.7% less 'stat' or 4.8% less of the total
number of syscalls. The total run time decreased by 4.6%.

Still, there are many stats for directories -- for each directory I see
2 + number of subdirectories it has, but I am not sure about its cause.

There is one strange thing though. Before that patch the number of
'open' for each directory was always the same in each run. But after
that patch, it slightly differs in each run... Comparing with results
without this patch, the number of open for some directories in some
be less by one... which is puzzling...


Dmitry
