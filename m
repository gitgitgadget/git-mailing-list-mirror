From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 16/35] commit_lock_file(): inline temporary variable
Date: Tue, 16 Sep 2014 15:16:47 -0700
Message-ID: <20140916221647.GP29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU13O-0006pY-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbaIPWQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:16:51 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43328 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbaIPWQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:16:50 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so686158pde.5
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L2w8Z7vE+mi8IFcvJ1qeGuUbjzurdg1yOkEZPNvx3D0=;
        b=GdLA3ia1R7TcADPMvVraeJJZlpp5yehUz6h7nwaMbC2ziIVyvNql+OEMPGqdA04TKo
         WTQWUFojQuGfuOpQMKrWW7xsh2hbw9nH2gAiQkTrKEY1PDOy8WDJpgcnR7CtXp3zILbO
         QaOrPFbD0MtFq6EfTRrLL59GUkqyF6jx9ayGUMi/S5g2xOqeH9nEsOA0Zr9fEGu+qnCR
         7uENJ1KODkuYpoKkNfCYxLQwFL9tqDSf97SspPloAy0FYul0BZ1S6LTfB8oi8WJRLs6t
         VCC7sQik0EwkR4nomTLPcM8ndgxNsjlOSmHMhKtwfwrgdwCoK/uMbNtWveJE8qRuvp8R
         qKQg==
X-Received: by 10.66.119.103 with SMTP id kt7mr53338456pab.95.1410905810061;
        Tue, 16 Sep 2014 15:16:50 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ix8sm15536259pac.32.2014.09.16.15.16.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:16:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-17-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257200>

Michael Haggerty wrote:

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -311,12 +311,14 @@ int reopen_lock_file(struct lock_file *lk)
>  int commit_lock_file(struct lock_file *lk)
>  {
>  	char result_file[PATH_MAX];
> -	size_t i;
> +
>  	if (lk->fd >= 0 && close_lock_file(lk))
>  		return -1;
> +
>  	strcpy(result_file, lk->filename);
> -	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
> -	result_file[i] = 0;
> +	/* remove ".lock": */
> +	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
> +

Same comment as the delete_ref_loose patch: the reader can gain some
piece of mind from an assertion at the top that makes sure filename is
valid (which it always should be, according to the API):

	assert(lk->filename[0]);

It would also be nice to use the same xmemdupz-based code as in the
delete_ref_loose case (ideally via a helper), to avoid having to work
with a PATH_MAX-sized buffer.

Otherwise looks good.

Thanks,
Jonathan
