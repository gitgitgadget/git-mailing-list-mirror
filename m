From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we have
	an up-to-date cache entry
Date: Thu, 9 Jul 2009 17:50:10 +0400
Message-ID: <20090709135010.GA19425@dpotapov.dyndns.org>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:51:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOu1l-000576-T2
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 15:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760147AbZGINui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 09:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760070AbZGINui
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 09:50:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61076 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759129AbZGINuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 09:50:37 -0400
Received: by fxm18 with SMTP id 18so185171fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 06:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wns8WAOJ0qX1K95pHCxyjPw6XrI8QGcC2NFIgeYqvbI=;
        b=rMlBmIjho3ZfY0VhcH8bPvZAMoP2cuqmFUIN78JzZKhSe1MQaoC3Xz2TBhQD8YHoPG
         A333U8j/rpT1WuGWnnSu9ToikC1qW0puknpkaKShznoa6gHBLmShoFeU3PPlfyKjQiM9
         cI0PRJaX0NNAYpZN86S9/jHy8m/LZnRtxnlno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RnE+x465KOLihxlMQA6MjqtTFRjWYesGM3WuKopMgwb/e1yrtS5202ZvDB5CFPGhPK
         BLhyhkoVWMW/DLYjvf2sKkkgs9e+cDJUkWjRdwbxPgV6XWkdN6crSWRBMdjlIF4OmzD1
         0LTW5a6ppaNCWNEtibfg0PTeHELNAIdo2JMGs=
Received: by 10.103.189.18 with SMTP id r18mr445833mup.80.1247147436299;
        Thu, 09 Jul 2009 06:50:36 -0700 (PDT)
Received: from localhost (ppp91-76-16-212.pppoe.mtu-net.ru [91.76.16.212])
        by mx.google.com with ESMTPS id w5sm45411828mue.4.2009.07.09.06.50.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 06:50:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122975>

On Wed, Jul 08, 2009 at 07:43:50PM -0700, Linus Torvalds wrote:
> 
> On filesystems without d_type, we can look at the cache entry first.
> Doing an lstat() can be expensive.
> 
> Reported by Dmitry Potapov for Cygwin.

I have tested it on Cygwin. The number of 'stat' for files is now 1, so
it works fine :)

I still have the same large number of 'stat' calls for directories, but I
suspect that due to that due to some Cygwin specific. I will investigate
that issue later when I have more time.

Because the repositoty on which I did testing has too many directories
(one directory per each 3.5 files) the effect was not as prominent as
it would be otherwise. Yet, it is 24.9% decrease of the number of 'stat'
or 14.8% descreased of the total number of syscalls. And my measurement
shows 14% descrease of run-time. So, it appears that on Windows the run
time almost directly proportional of the total number of syscalls...

BTW, I believe that this patch should help MinGW too, because AFAIK
MinGW does not have d_type either.


Thanks,
Dmitry
