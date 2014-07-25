From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] refs.c: allow passing raw git_committer_info as
 email to _update_reflog
Date: Fri, 25 Jul 2014 12:37:28 -0700
Message-ID: <20140725193728.GG12427@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
 <1406307521-10339-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAlJ9-0001NN-MS
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760803AbaGYThc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:37:32 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50524 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbaGYThb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:37:31 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so6674213pac.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ISlIOl/XFzFOxM4yko7HTkdEDcXn0dIiLt0gNRNDu/0=;
        b=UcgJgk60trrtm0D2Dw9iIElUDu92UyeGBWnUSVb1G91b+MCFd0uxkBi9VnhA8/jT/z
         x+urz0qjAAl0UwlJOLSiWkNC3PFVvhI87EEdwGDSTgMR2EFnYEOEI4Ca7pTwe/mirqbn
         x8jFP6bVgPGxKR7Kn2InzJnL6O4iGUrzz8vqQq32+sjX1NikEh0keuSrH4px7ug3jfmn
         ViJjrgZJg9Pv8g9Mm5ZusgfJ2v+kR/w5aFOQyoQo3L2UprMAT9VewWxDQ5RIwgzDhmKU
         OV6otD4WuEOi/FWKWCpizcE7HZkFC5AfBwQL5Wo06XtGwRP1SSEVqyoHXxvVYiUsBmKR
         cGdA==
X-Received: by 10.67.1.195 with SMTP id bi3mr21088431pad.74.1406317050954;
        Fri, 25 Jul 2014 12:37:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id r3sm12804368pdd.8.2014.07.25.12.37.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 12:37:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406307521-10339-2-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254263>

Ronnie Sahlberg wrote:

> Add a new flag REFLOG_EMAIL_IS_COMMITTER to _update_reflog to tell it
> that what we pass in as email is already the fully baked committer string
> we can use as-is.

With and without the new flag, the 'email' argument has two different
meanings:

 * with the new flag, it should be an ident string, like
   'Jonathan Nieder <jrnieder@gmail.com> 1406251347 -0700'

 * without it, it should be the name-part of an ident string,
   like 'Jonathan Nieder <jrnieder@gmail.com>

In neither case is it an email address.  This seems unnecessarily
confusing.

Is the caller responsible for checking the argument for validity?
Do callers do so?  Is this performance-critical or could the
transaction_update_reflog function do a sanity-check?

[...]
>  /*
>   * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
>   * this update will first truncate the reflog before writing the entry.
>   * If msg is NULL no update will be written to the log.
>   */
>  int transaction_update_reflog(struct ref_transaction *transaction,
>                                const char *refname,
>                                const unsigned char *new_sha1,
>                                const unsigned char *old_sha1,
>                                const char *email,
>                                unsigned long timestamp, int tz,
>                                const char *msg, int flags,
>                                struct strbuf *err);

This is a lot of parameters, some optional, not all documented.  Would
it make sense to pack some into a struct?

Thanks and hope that helps,
Jonathan
