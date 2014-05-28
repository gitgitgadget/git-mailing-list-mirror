From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Tue, 27 May 2014 17:42:00 -0700
Message-ID: <20140528004200.GK12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-14-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpRwY-0002d2-Hc
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 02:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbaE1AmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 20:42:05 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46867 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaE1AmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 20:42:04 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so10004281pad.23
        for <git@vger.kernel.org>; Tue, 27 May 2014 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tthyl9gTleRA81jKleqiQvxHdbKW7SdC9tHU3RRdsGI=;
        b=shahUPFhEx+uLT/9X49XsNLvL8gsRHMYeGWFp0LfKp+pbQSnD8XztY4vYyFgCHyz+d
         33AmKj/VL+/MQnI2S2vp8kYtQ/j4klDTdkLMSlnKE4WQjtsCECKpXdlp3ssV4QmaSc+P
         jtTi6uybUy0cNeKnS90kq/k9rOZEBV9l+4iLMafAKSOtCVYN2WlMk2iu8VrEXPFQ8uYP
         /O0FVnUEqyxNcOGqCHAJi/WRGxCzr2p1IQffdSReQq2xQFPz1VSw/cs538fL1GhfiM5F
         K0mmW7tPI2bGw29qpJKSf1+4tJwoRKpurqp7BGJX1BI2H2K+yXHEpS11qKgZ6Jy7XUbm
         WtDw==
X-Received: by 10.67.23.135 with SMTP id ia7mr40425368pad.5.1401237723586;
        Tue, 27 May 2014 17:42:03 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ja8sm25327568pbd.3.2014.05.27.17.42.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 17:42:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-14-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250253>

Hi,

Ronnie Sahlberg wrote:

> --- a/refs.h
> +++ b/refs.h
> @@ -215,6 +215,15 @@ enum action_on_err {
>  };
>  
>  /*
> + * Transaction functions that take an err argument will append an error
> + * string to this buffer if there was a failure.
> + * This string is not cleared on each call and may contain an aggregate of
> + * errors from several previous calls.
> + * If the caller needs a guarantee that the buffer will only contain the
> + * current or most recent error it must call strbuf_reset before calling
> + * the transaction function.
> + */
> +/*

If I look at the documentation for ref_transaction_create(), it is not
obvious I should look up here for how it handles errors.  Not sure how
to fix that --- maybe this should go in a new
Documentation/technical/api-ref-transactions.txt file?  Or maybe the
top of refs.h where struct ref_transaction is declared.

The content seems odd to me.  It says the string will contain an
aggregate of errors from previous calls, but what it doesn't say is
that that aggregate is a bunch of error messages juxtaposed without a
newline or space between.  Is the idea that some callers will want
this aggregate?

Wouldn't it be clearer to say how the err argument is meant to be used
from the caller's perspective?  E.g.,

	On error, transaction functions append a message about what
	went wrong to the 'err' argument.  The message mentions what
	ref was being updated (if any) when the error occurred so it
	can be passed to 'die' or 'error' as-is:

		if (ref_transaction_update(..., &err)) {
			ret = error("%s", err.buf);
			goto cleanup;
		}

If it's expected that the err argument will be used to aggregate
multiple messages in some callers then it would be useful to give an
example of that, too, but I don't think that's needed.

Jonathan
