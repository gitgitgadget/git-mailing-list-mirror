From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 08/41] refs.c: add an err argument to delete_ref_loose
Date: Tue, 27 May 2014 17:25:38 -0700
Message-ID: <20140528002538.GI12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpRgf-0007f3-84
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 02:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbaE1AZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 20:25:41 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56146 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaE1AZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 20:25:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so10074052pbb.5
        for <git@vger.kernel.org>; Tue, 27 May 2014 17:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xMyx+vgpbkwrGZzXdQLWIQNmEINCrcK18CLMjBYadw4=;
        b=kFKExMfVJWwRMWgfBzSM6m2uNOgEDNNDI0Er/VgNsbOa/J41bBy9kTgJMPte8zqryY
         FPjp+XdAN3ufT06wVdc6E7WtueC2/OZEJCndzzf5t46zfLZkXbpARdwwql3pkUcP125E
         pOJKdp/8sLb8SKeshxlZXe+EoXonv0Q19arrmHVm4j/2MZDxpwVUVOMVjIad6x5VTN9L
         psgbjwyksKXGtL+7EjWw2TlWnmyBJKg5QlAWb8lhzuh3mvv2VG8kZY9cRq0GILoQ8wOY
         5hou2wj9tDaM5/Htqw3SRnwzUcpeTXF182t4wSWvFMkgK6i8vB96L2RTAT59dfFLeAQF
         IdrA==
X-Received: by 10.66.146.170 with SMTP id td10mr42048715pab.105.1401236740622;
        Tue, 27 May 2014 17:25:40 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id jh2sm25229689pbd.93.2014.05.27.17.25.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 17:25:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-9-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250251>

Hi,

Comments from http://marc.info/?l=git&m=140079653930751&w=2:

Ronnie Sahlberg wrote:

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -2491,17 +2491,43 @@ static int repack_without_ref(const char *refname)
>  	return repack_without_refs(&refname, 1, NULL);
>  }
>  
> -static int delete_ref_loose(struct ref_lock *lock, int flag)
> +static int add_err_if_unremovable(const char *op, const char *file,
> +				  struct strbuf *e, int rc)
> +{
> +	int err = errno;
> +	if (rc < 0 && err != ENOENT) {
> +		strbuf_addf(e, "unable to %s %s: %s",
> +			    op, file, strerror(errno));
> +		errno = err;
> +	}
> +	return rc;
> +}
> +
> +static int unlink_or_err(const char *file, struct strbuf *err)
> +{
> +	if (err)
> +		return add_err_if_unremovable("unlink", file, err,
> +					      unlink(file));
> +	else
> +		return unlink_or_warn(file);
> +}

The new unlink_or_err has an odd contract when the err argument is passed.
On error:

 * if errno != ENOENT, it will append a message to err and return -1 (good)
 * if errno == ENOENT, it will not append a message to err but will
   still return -1.

This means the caller has to check errno to figure out whether err is
meaningful when it returns an error.

Perhaps it should return 0 when errno == ENOENT.  After all, in that
case the file does not exist any more, which is all we wanted.


> +
> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  {
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>  		/* loose */
> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> +		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
>  
>  		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> +		res = unlink_or_err(lock->lk->filename, err);
>  		lock->lk->filename[i] = '.';
> -		if (err && errno != ENOENT)
> +		if (res && errno != ENOENT) {
> +			if (err)
> +				strbuf_addf(err,
> +					    "failed to delete loose ref '%s'",
> +					    lock->lk->filename);

On failure we seem to add our own message to err, too, so the
resulting message would be something like

	fatal: unable to unlink .git/refs/heads/master: \
	Permission deniedfailed to delete loose ref '.git/refs/heads/master.lock'

Is the second strbuf_addf a typo?

Thanks,
Jonathan
