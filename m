From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 03/35] rollback_lock_file(): do not clear filename
 redundantly
Date: Tue, 16 Sep 2014 13:37:41 -0700
Message-ID: <20140916203741.GC29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 22:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzVV-0005Vz-26
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 22:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbaIPUhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 16:37:45 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33447 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaIPUho (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 16:37:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so530638pad.34
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D7fPaaMEy6WTFkti41Y7mJnjwDUegE3dCTTmRFhyXFU=;
        b=TKJoBLgRRWJICOjAeJxj6DeCq8HS3waCzrwdJ29a2YrVozCFwbupIuQZNbIee9L0sP
         B2H0DMc52aeQEOCYfCLNJCi1kQoIuwzQ1ZMDsszRHqkn2ElgYJXTPWrJvFh73rSZRhbh
         SOXMyGhXXUQNDnrqD9Y4arTohMz5PEr94GmT4xxoNjvNMhXp2FrvbtAPSwKvzj1HdPAI
         eOjGW2kqjZ+oyDgg+u0n+0nkxteOGUQWb5dCvxFkS2UYNfqUTGGUGN9QDbtH9FoJv0j0
         z2OnNIM0cvfSSnvx3HT8AM5XR2+xpjHnredcxCPXU7ZZ/wJgnTeTh4VZS8T8lzdatler
         ouJA==
X-Received: by 10.70.48.5 with SMTP id h5mr25176228pdn.125.1410899864152;
        Tue, 16 Sep 2014 13:37:44 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id tc5sm5464863pbc.51.2014.09.16.13.37.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 13:37:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-4-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257186>

Michael Haggerty wrote:

> It is only necessary to clear the lock_file's filename field if it was
> not already clear.
[...]
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -276,6 +276,6 @@ void rollback_lock_file(struct lock_file *lk)
>  		if (lk->fd >= 0)
>  			close(lk->fd);
>  		unlink_or_warn(lk->filename);
> +		lk->filename[0] = 0;
>  	}
> -	lk->filename[0] = 0;

Now that it does nothing when lk->filename[0] == '\0', this could be
de-indented a little:

	if (!lk->filename[0])
		return;
	if (lk->fd >= 0)
		close(lk->fd);
	unlink_or_warn(lk->filename);
	lk->filename[0] = 0;

This could technically double-close if interrupted by a signal that
tries to remove the file again, right?  Should this use
close_lock_file which sets fd to -1 before closing?

	if (!lk->filename[0])
		return;
	close_lock_file(lk);
	unlink_or_warn(lk->filename);
	lk->filename[0] = 0;

With or without such changes,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
