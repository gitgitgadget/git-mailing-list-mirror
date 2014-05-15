From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 06/44] refs.c: add an err argument ro delete_loose_ref
Date: Thu, 15 May 2014 12:04:34 -0700
Message-ID: <20140515190434.GF26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:04:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0xN-0001Y7-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaEOTEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:04:38 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53389 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaEOTEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:04:37 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so1450033pad.39
        for <git@vger.kernel.org>; Thu, 15 May 2014 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TPabDXj8otbjOjvQR6Bugunq+9/7KKOA1MVvSy1w1Xc=;
        b=mkRWok4YLwMNBbyp3ToMCDirqhhgRK2KDTZnZa+x0HlFY6G0ZXFte/UHNc9YPwGn1v
         gjSqA5KLW2SWOfgjLiZMSrEfoPwrBvkp87dg3xAxupTYIrdqETkNQgFhGN3rIrsw1ImK
         0ioPCKtj77Sue6KgdORHPsgc3+Qg/fs3sHKU1bLlntS3H4BlZamSReKl4k2WImKkx/n6
         J+meQJeS8o7h3xpaCPPrSPfGbbg7z+5cVEBygH4Xcr5afaEb/SlXLpL6PfUrvsKCJF9i
         ZNfF3tKbgAbi+5xLADr43LN1+6OlOa0Bp57jAjvYVByet2Pqhk1ij/VYIw7pSUr+WiBU
         Fpqg==
X-Received: by 10.66.233.9 with SMTP id ts9mr14940305pac.37.1400180676850;
        Thu, 15 May 2014 12:04:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gu11sm10416037pbd.38.2014.05.15.12.04.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 12:04:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-7-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249183>

Ronnie Sahlberg wrote:

> [Subject: refs.c: add an err argument ro delete_loose_ref]

s/ro/to/
s/delete_loose_ref/delete_ref_loose/

> --- a/refs.c
> +++ b/refs.c
> @@ -2484,17 +2484,22 @@ static int repack_without_ref(const char *refname)
>  	return repack_without_refs(&refname, 1, NULL);
>  }
>  
> -static int delete_ref_loose(struct ref_lock *lock, int flag)
> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)

Should this get an onerr flag to suppress the message to stderr
or unconditionally suppress it when err != NULL?

[...]
>  		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> +		res = unlink_or_warn(lock->lk->filename);

It seems like in the new error handling scheme there should be a new
variant on wrapper.c's warn_if_unremovable:

	static int add_err_if_unremovable(const char *op, const char *file, struct strbuf *err, int rc)
	{
		int err = errno;
		if (rc < 0 && err != ENOENT) {
			strbuf_addf(err, "unable to %s %s: %s",
				    op, file, strerror(errno));
			errno = err;
		}
		return rc;
	}

	static int unlink_or_err(const char *file, struct strbuf *err)
	{
		return add_err_if_unremovable("unlink", file, err, unlink(file));
	}

		res = unlink_or_err(lock->lk->filename, err);
