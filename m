From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 35/44] refs.c: make delete_ref use a transaction
Date: Wed, 21 May 2014 16:22:11 -0700
Message-ID: <20140521232211.GK12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-36-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:22:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnFq6-0004BA-02
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 01:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbaEUXWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 19:22:18 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37535 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbaEUXWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 19:22:14 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so1866255pad.11
        for <git@vger.kernel.org>; Wed, 21 May 2014 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=31mVHGT24GaSxzNfImQd7XTHtRb7sLYx6+aFd7pv7bY=;
        b=ywuaK4+S/yCoipygiYN418GMAXvNqVtVMRvWciK2aHRaihVnjKx9975d0hzc/vKuQH
         PhtIilGYYpOhnT+UWI0tYq2IOI6Os51GiO5NMzlPyhI+VbicsTEF4nhTW6NocguSIV+z
         bxInV2U0tYxM8bb9Knr1eZxF9bwtWf0F3uxoxtJJg6bGlyIQSW4gMGG3RtzSK2L/WwY3
         WyGBmYZ6tM8EI0AjczUU5ZxwL1YDKlKdxEDs8q//gq17V9Ga5oNQLAGrnmTY2zJcswM9
         Z1yb29EBY1pz6rsnib1zKuVLSNIY1jZTWk/h3jae1T7ls8ZIVU1usBz727+xThybbhoc
         5OoQ==
X-Received: by 10.66.136.131 with SMTP id qa3mr61632048pab.77.1400714534348;
        Wed, 21 May 2014 16:22:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z3sm111067386pas.15.2014.05.21.16.22.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 16:22:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-36-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249859>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
[...]
> @@ -2515,24 +2510,18 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  
>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  {
> -	struct ref_lock *lock;
> -	int ret = 0, flag = 0;
> +	struct ref_transaction *transaction;
>  
[...]
> -	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
> +	if (!transaction ||
> +	    ref_transaction_delete(transaction, refname, sha1, delopt,
> +				   sha1 && !is_null_sha1(sha1), &err) ||

What should happen when is_null_sha1(sha1)?  In that case the
caller has asked us to check that the ref doesn't exist before
deleting it, which doesn't make a lot of sense, but the old
code did exactly that if I read it correctly.  The new code
seems to disable verification instead.

Do we know that no callers call delete_ref with such an argument?
Would it make sense to just die with a "BUG:" message to make
the contract more clear?

[...]
> -	unlink_or_warn(git_path("logs/%s", lock->ref_name));

When does the reflog get deleted in the new code?

Thanks,
Jonathan
