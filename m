From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Probably a GIT bug..
Date: Wed, 23 Apr 2008 21:13:55 +0400
Message-ID: <20080423171355.GE26950@dpotapov.dyndns.org>
References: <20080422164311.67c3d02b@Vorago> <7v63u8tt62.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomasz bla Fortuna <bla@thera.be>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:15:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoiZA-0002M5-Ir
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 19:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbYDWROn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 13:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbYDWROm
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 13:14:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:15431 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbYDWROm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 13:14:42 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2696161fgb.17
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=U0Xu8nUR+BYSuf+DdJq8pjbmP8ZLcaRmP34UKnXA2Mc=;
        b=Kqyqzq9La66k1g0/5wDK1PStJ1gjMkewMHBQyI/HH+I0Jg0XJ1fmchpv2mBMhAdmzkiZwRT8wMUG62XwrpEbbSF7ZL5TBYHpBn6QCXmgtc225odnyDCnPwnXqeU4ssKNi2VjQRCUqDEEjuasL3GxGDHAF6Qtq2NIaWo0DWxbdbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VKBHV4ZOSTTZpytWzRHMAjbXasIyn6gEDYmxGnGxo+Yb/mPs+XnIb0NlOG5XQz/1zaGp/jFF5NRIXLgYhUEVrgfDKqmANGcOLiYvRkAGNc7QgyTDnLm4uhIByr41nDAFO4dxLnC1FEzLbippFu059xhrtpGxHI0KKrEz+c93UyU=
Received: by 10.86.80.5 with SMTP id d5mr3570744fgb.57.1208970839440;
        Wed, 23 Apr 2008 10:13:59 -0700 (PDT)
Received: from localhost ( [85.141.151.187])
        by mx.google.com with ESMTPS id 3sm335837fge.7.2008.04.23.10.13.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Apr 2008 10:13:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v63u8tt62.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80233>

On Wed, Apr 23, 2008 at 09:47:17AM -0700, Junio C Hamano wrote:
> 
> That's a somewhat contrived example, and I do not know how you found it.
> 
> I suspect the same breakage would trigger when you ran out of disk quota
> to write out the tree while you still have barely enough quota to create
> the commit and update the ref, which would result in corrupt repository.

I have looked at write_sha1_file(), it appears to me that if you do not
have enough disk space (or exceed your disk quote) then this function
will die inside. For the described situation to happen, you probably
should have wrong permissions on directories (as it was simulated in the
bug report) or some other error with open() (such as exceeding the maximum
allowed number of descriptor).

So I wonder why errors in write_sha1_file() are treated differently,
i.e. the function may die on error in some error cases (such as not
enough disk space), but it indicates the error situation by return code
if open() failed.

BTW, the returned code of write_sha1_file() is also not checked in
write_tree() in mktree.c.

Dmitry
