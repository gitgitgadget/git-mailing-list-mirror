From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Function for updating refs.
Date: Wed, 5 Sep 2007 14:03:50 +0200
Message-ID: <1b46aba20709050503r6027ada3u79ca8f5cb662775f@mail.gmail.com>
References: <46DE0890.5020709@gmail.com>
	 <7vy7flk2z5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 14:04:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IStc0-0003Bj-RQ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 14:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbXIEMDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbXIEMDw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 08:03:52 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:13367 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbXIEMDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 08:03:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1434296rvb
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 05:03:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mef536obmnm/yfpiQeGDhZAjUoaio/BVo/PTS64hzcnOfCr1k2Fq8r4nd7fDJGurpA6z+mVjRUFA+LC+7RTi2gYUDrzp4UEPFIsd4QortmM9wQRkk9pKu0nRDUqdw9jTEm0YTT+9Ab60j1NseVIoWngtnJYBkU7VSkZ2nQzQ2eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agEaMfI/lPigFU/oaIQaCyqBRqCPTILx6nW47dKspFvtnb0oTMmkOUpwGEo7KZUNf2vs7KT6IPhDzToBtyu9J0bOauFgnlleIj1h1h2bmHKyPxcSm2XBcoUi/kYWUxpDSb0DufIIMYewA6kV+HHQP3krvIp0N8sokNi9R0lZ1lI=
Received: by 10.114.94.1 with SMTP id r1mr1456056wab.1188993830391;
        Wed, 05 Sep 2007 05:03:50 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Wed, 5 Sep 2007 05:03:50 -0700 (PDT)
In-Reply-To: <7vy7flk2z5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57710>

2007/9/5, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
> > -     snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> > -     lock = lock_any_ref_for_update(refname, oldval, 0);
> > -     if (!lock)
> > -             return 1;
> > -     if (write_ref_sha1(lock, sha1, msg) < 0)
> > -             return 1;
> > -     return 0;
> > +     if (snprintf(msg, sizeof(msg), "%s: %s", rla, action) >= sizeof(msg))
> > +             error("reflog message too long: %.*s...", 50, msg);
>
> The original I did was sloppy and did not detect this situation;
> thanks for fixing it.  You do not refuse the primary operation,
> which is to update the ref, so this should be a warning instead
> of an error, I think.

Yes, it is. Also, I tested what would happen when the lock fails. I tried to
lock an already locked ref, and it died printing the message
die("unable to create '%s.lock': %s", path, strerror(errno));  from
lockfile.c. I think this is interesting. There are other failing
reasons that could
make the update_ref function to print its error, but I haven't tested them.

> > diff --git a/send-pack.c b/send-pack.c
> > ...
> This removal makes "struct ref_lock *lock" (not shown in the
> context) unused.  I will remove the declaration.

Thank you. Also in builtin-update-ref.c the main function could return
directly that value returned from the call to update_ref().
