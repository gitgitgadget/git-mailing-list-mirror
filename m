From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 07/35] hold_lock_file_for_append(): release lock on
 errors
Date: Tue, 16 Sep 2014 13:48:53 -0700
Message-ID: <20140916204853.GH29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:49:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzgL-0003G7-0B
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbaIPUs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:48:57 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37589 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbaIPUs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:48:56 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so557333pde.12
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kHYA8jiWx2eBGKyTi5X2ZlwXHXeb/Dg+Iy69GklwGHQ=;
        b=dPKwkoOtQaoy8wir+pQAI+rk6C0WTtsz6RcP76lGeQlXamF2u6/tDtc+iuh2lDGizU
         B/IBHFBy9cRJWqKMnOb+AnbsLMX0xr88Z6egSdk3vK9c4OfGHIMUegu+TXYREXa/Apjp
         soWkvfjYDBtef0928icUktg5JZgCD5U2Qx7lYzPgjwh9Pk9ZMLsl1g1s8/optHgIJLyV
         wmOTWPD8nMALA+QCxytWSiSeMIjmpsef2BmLwm41wsqyUxyz3LeSibdmjJA7qP583y3c
         rCdUnOKWs7r+/4KxrUh0AyFLD43o5SEpBmg/G/qbsfUK9bS7ZUZNNaJPpEoEvfKPc46a
         4bSg==
X-Received: by 10.70.40.229 with SMTP id a5mr63802111pdl.17.1410900536287;
        Tue, 16 Sep 2014 13:48:56 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id xr10sm15438563pab.35.2014.09.16.13.48.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:48:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-8-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257191>

Michael Haggerty wrote:

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -219,13 +219,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
>  		if (errno != ENOENT) {
>  			if (flags & LOCK_DIE_ON_ERROR)
>  				die("cannot open '%s' for copying", path);
> -			close(fd);
> +			rollback_lock_file(lk);
>  			return error("cannot open '%s' for copying", path);

Makes sense.

Now that I'm here, I wonder a little at the error convention.  If the
caller doesn't pass LOCK_DIE_ON_ERROR, are they supposed to be able to
use unable_to_lock_message?  What errno would they pass in the err
parameter?  Would callers want handle failure to acquire a lock
differently from other errors (e.g., by sleeping and trying again),
and if not, what is the optionally-die behavior in hold_lock_file
about?

In any case,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
