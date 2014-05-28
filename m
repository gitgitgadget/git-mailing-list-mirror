From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 06/41] refs.c: add an err argument to
 repack_without_refs
Date: Tue, 27 May 2014 17:11:17 -0700
Message-ID: <20140528001117.GH12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpRSq-0007ql-BA
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 02:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbaE1ALW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 20:11:22 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54494 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbaE1ALV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 20:11:21 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so10144148pbc.15
        for <git@vger.kernel.org>; Tue, 27 May 2014 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eQpGphTXaxAG4+bJV3imeO6aG5YQ/Jf7YiBHiug1J1I=;
        b=TN7jf9AuvbgYB9K0lJDBXamhUPl1o2ucihXrmqJKReC/umxGvnrdx31V2wTdFO/FvY
         YzH85Nx98WilWo/Jz85rAzzxfb5jJ314qrXxemdtzJxh0WDDZ2yaHBpXQEL32pN19C3b
         QRC0yBkyuoUXbur4A+xBPTCyjr16WRjCkG3a2CCW7YWe0U6sCIyNyvmSuejEPjvxuh14
         LlC4goh7yNEJia8lEi9ie6HGhgPwFzqBf/b3xGGClFBQz6SGQepzGTyTTqdufyi9FCqL
         K7srPoHUp1PiEqfn0ll2IMKwziMIZxgUo6n4775C6eVciHXYuulquVNQuGxXPV7ZfEQh
         uM0g==
X-Received: by 10.68.139.36 with SMTP id qv4mr41579070pbb.82.1401235880863;
        Tue, 27 May 2014 17:11:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wn7sm8174857pab.18.2014.05.27.17.11.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 17:11:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-7-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250250>

Hi,

Comments from http://marc.info/?l=git&m=140079653930751&w=2:

Ronnie Sahlberg wrote:

> --- a/cache.h
> +++ b/cache.h
> @@ -559,6 +559,8 @@ struct lock_file {
>  #define LOCK_DIE_ON_ERROR 1
>  #define LOCK_NODEREF 2
>  extern int unable_to_lock_error(const char *path, int err);
> +extern void unable_to_lock_strbuf(const char *path, int err,
> +				  struct strbuf *buf);

"unable_to_lock_strbuf" could be called "unable_to_lock_message" (which
would make its behavior more obvious IMHO).

[...]
> --- a/refs.c
> +++ b/refs.c
> @@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
>  	struct packed_ref_cache *packed_ref_cache =
>  		get_packed_ref_cache(&ref_cache);
>  	int error = 0;
> +	int save_errno = 0;

This is about making errno meaningful when commit_packed_refs returns
an error.  Probably its API documentation should say so to make it
obvious when people modify it in the future that they should preserve
that property or audit callers.

[...]
> @@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
>  		return 0; /* no refname exists in packed refs */
>  
>  	if (lock_packed_refs(0)) {
> +		if (err) {
> +			unable_to_lock_strbuf(git_path("packed-refs"), errno,
> +					      err);
> +			return -1;
> +		}
>  		unable_to_lock_error(git_path("packed-refs"), errno);

Via the new call to unable_to_lock_..., repack_without_refs cares
about errno after a failed call to lock_packed_refs.  lock_packed_refs
can only fail in hold_lock_file_for_update.  hold_lock_file_for_update
is a thin wrapper around lockfile.c::lock_file.  lock_file can error
out because

	strlen(path) >= max_path_len
	adjust_shared_perm failed [calls error(), clobbers errno]
	open failed

So lock_file needs a similar kind of fix, and it's probably worth
updating API documentation for these calls to make it clear that their
errno is used (though that's not a new problem since
repack_without_refs already called unable_to_lock_error).  Could be a
separate, earlier patch (or a TODO comment in this patch to be
addressed with a later patch) since it's fixing an existing bug.

Hope that helps,
Jonathan
