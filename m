From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 23/35] lockfile: avoid transitory invalid states
Date: Tue, 16 Sep 2014 15:45:23 -0700
Message-ID: <20140916224523.GW29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-24-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:45:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU1V6-0007ds-1a
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbaIPWp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:45:27 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64580 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbaIPWp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:45:27 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so738080pab.40
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tM+cQDTJJcSo/zOwZ+infKjeEXqM8vNg+TW1iwFShZU=;
        b=0C4z73oqUbHGNS6ndis232cauCNJgadh9vVNLoshqS/LUARdRyTzVXF0HxLashs1vl
         9z/efkYAV+2VnkJkk5RQzlgBLBZd8IcCNYXkEPFHvs99wTQxOSz2XJrKpzMIbaNUtCrn
         S0DgId336Nq9W8GPYOCg0X1HikxUtyHz4n3oAcH3UmmsUGKDvWiR239pKeDa7U39IaCd
         5QoRVBtTmeVmKwctJQLWbxMeY+TXwpVHMcgd2Ts1keHj4sf0U0smJaEXTbPO0B0PbzQH
         KxdiQpq4hT4OH7JD/UaHKBV1JCBgR3bFFAiQMGeG0Vhox8aL5RPrAzJ2pehJnCwNi+wz
         0Xfw==
X-Received: by 10.70.35.48 with SMTP id e16mr46690749pdj.28.1410907526806;
        Tue, 16 Sep 2014 15:45:26 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id yh3sm15064783pbb.38.2014.09.16.15.45.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-24-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257208>

Michael Haggerty wrote:

> We could probably continue to use the filename field to encode the
> state by being careful to write characters 1..N-1 of the filename
> first, and then overwrite the NUL at filename[0] with the first
> character of the filename, but that would be awkward and error-prone.
> 
> So, instead of using the filename field to determine whether the
> lock_file object is active, add a new field "lock_file::active" for
> this purpose.

Nice.

[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -576,6 +576,7 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
>  
>  struct lock_file {
>  	struct lock_file *next;
> +	volatile sig_atomic_t active;
>  	int fd;
>  	pid_t owner;
>  	char on_list;
[...]
> +++ b/lockfile.c
> @@ -27,16 +27,19 @@
[...]
> @@ -189,9 +198,14 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  		atexit(remove_lock_file);
>  	}
>  
> +	if (lk->active)
> +		die("BUG: lock_file(\"%s\") called with an active lock_file object",
> +		    path);

The error message doesn't make it entirely obvious to me what went
wrong.

Maybe something like

		die("BUG: cannot lock_file(\"%s\") on active struct lock_file",
		    path);

lock_file already assumed on_list was initialized to zero but it
wasn't particularly obvious since everything else is blindly
scribbled over.  Probably worth mentioning in the API docs that
the lock_file should be zeroed before calling hold_lock_file_...

[...]
> @@ -326,6 +341,7 @@ int commit_lock_file(struct lock_file *lk)
>  	if (rename(lk->filename, result_file))
>  		goto rollback;
>  
> +	lk->active = 0;
>  	lk->filename[0] = 0;

Is it useful to set filename[0] any more?

It seems potentially fragile to set both, since new code can appear
that only sets or checks one or the other.  Would it make sense to
rename the filename field to make sure no new callers relying on the
filename[0] convention sneak in (with the new convention being that
the filename doesn't get cleared, to avoid problems)?

Jonathan
