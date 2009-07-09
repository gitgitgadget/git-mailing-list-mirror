From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we
	have?an up-to-date cache entry
Date: Fri, 10 Jul 2009 03:30:24 +0400
Message-ID: <20090709233024.GD19425@dpotapov.dyndns.org>
References: <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <20090709210513.GB19425@dpotapov.dyndns.org> <loom.20090709T214734-78@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP350-0006Ol-Lx
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZGIXav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZGIXau
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:30:50 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41337 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbZGIXau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 19:30:50 -0400
Received: by fxm18 with SMTP id 18so529563fxm.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cFVwLRvLf2VkqVbIwQnYw6sARvTmFIbboTGUQOcp56Q=;
        b=Xuc9AYbVczEBU3WVU1dCsm80Kk9pTpPwFqgPnjTgqwUXS7X4MLAfc23DnWX4hvgtQF
         es6UpGu0E+U0scOitlk67ig89eA4Z331foIVhOnNHINnafZhbCNLZYZhoK0ByjIoGliZ
         kIuqWkOVnZN1P3vF8B2AYOXjOx+ygqRtq1P8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G0FxRHbxrRhwqr/Bti/Zdnpz7QCyq2VfRGiGgjrogVfulReeVV3nORAlOZKoEVbjqe
         qbpS9wsJLKGEVE4CD3Ffte1l82kwHPTBL2iOTTMhZbG3xt+K8b2hrVHgQ7LNhDM2+8pf
         wr+/fDM5B8obn1fmz8nXMbQ8WQS+2jUmwzugA=
Received: by 10.103.214.4 with SMTP id r4mr742426muq.35.1247182248472;
        Thu, 09 Jul 2009 16:30:48 -0700 (PDT)
Received: from localhost (ppp85-141-235-157.pppoe.mtu-net.ru [85.141.235.157])
        by mx.google.com with ESMTPS id u26sm2083520mug.22.2009.07.09.16.30.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 16:30:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20090709T214734-78@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123022>

On Thu, Jul 09, 2009 at 09:52:24PM +0000, Eric Blake wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
> 
> > With this patch, I see one 'stat' less for each directory, which on my
> > repo resulted in about 10.7% less 'stat' or 4.8% less of the total
> > number of syscalls. The total run time decreased by 4.6%.
> > 
> > Still, there are many stats for directories -- for each directory I see
> > 2 + number of subdirectories it has, but I am not sure about its cause.
> 
> That would probably be the fact that in cygwin 1.5, a stat() of a directory
> results in querying all the contents of the directory so as to correctly
> populate the st_link member based on the number of subdirectories.

We do not use lstat or fstat provided by Cygwin. Instead of it, we use
their fast and dirty analogues, which you can find in compat/cygwin.c
(they do not provide all information that normal functions provide, but
this information is sufficient for Git.

But we still use readdir() from Cygwin and that may be source of extra
syscalls that I observe...

Dmitry
