From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] refs.c: return error instead of dying when locking
 fails during transaction
Date: Fri, 25 Jul 2014 12:40:23 -0700
Message-ID: <20140725194023.GH12427@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
 <1406307521-10339-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:40:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAlLz-0003gz-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760887AbaGYTk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:40:27 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62915 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaGYTk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:40:26 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so6185888pdj.40
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 12:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SGQsNcTLgps1/Zl0OU7JDPBCekyl4BrHS8ANHrnh6w4=;
        b=n/uu9CaIaMJEfVX0w7JPskLP4UQKzJ2MU+q5zNHuW9nNHhUyNMvZ5fO09+dipUYcrg
         VaIxLDk6PgnDfFDAAewUTispXckJ9uGI42Bl7F01Ti5W/ppwrKlUAaa/yzcyD7olFh/D
         MOQePjqnFiuiFJd/GSzvo87sPZgPIN7W3w7Hr9BSqnrmdALS16yYHeZ1hVsclAkUwYRy
         rqU6VqrZKrHOROP7qIR0IkiUMGzeGZ3Lvqa8RE+gEXSMqaJNBjoDnr0StIIIrSe/wr3m
         WzxdDZGVr3q3Jc+ly8J24lE8GxLFPYhZNU2DUx0ZbHMN75JX2pG8ZInygtK3trFX272/
         vjEA==
X-Received: by 10.66.65.193 with SMTP id z1mr13834976pas.9.1406317226307;
        Fri, 25 Jul 2014 12:40:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id cm7sm12785610pdb.74.2014.07.25.12.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 12:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406307521-10339-3-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254265>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -2214,7 +2214,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  			 */
>  			goto retry;
>  		else
> -			unable_to_lock_index_die(ref_file, errno);
> +			goto error_return;

Should probably save last_errno so error_return can pass that
information back.

Can the caller recover from this error?  Does it have enough information
to produce the same helpful message as unable_to_lock_index_die?

If this could be done without regressing behavior (e.g., by passing
back error information as a message instead of through errno) then I
think it would make sense.

Jonathan
