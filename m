From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 14/44] replace.c: use the ref transaction functions
 for updates
Date: Thu, 15 May 2014 14:18:35 -0700
Message-ID: <20140515211835.GL26471@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-15-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 23:18:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl335-0004Am-BE
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbaEOVSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 17:18:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62937 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbaEOVSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 17:18:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1607914pbb.33
        for <git@vger.kernel.org>; Thu, 15 May 2014 14:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EWe0Bz+1pa7BQO6U847B0lXsjZs6NlgELaog4QUOovI=;
        b=rbDnSAygIfEcoL0/u651L2qUR6J2mNhx0/E9G/gYtUmv/YOZerIESecLVtf4ve0xnE
         Jnjn5PvRB7y7EOeTa69CkOY0KnGXUfQDpGrO+S4Kpzfb9THqHw1ZU1TyzyyJEBU1vKa3
         xiBQgOLB7B6s61p1bZNCClqeeke6ODxQqWqYoJZiate72+0sNnuWMRpEC0Dk02CqdCsb
         AoYKY7EetKRNEGIi3kcdOWkLRs0ZnI2LRJmixD1azzWHxycH/P5TCTVJybmR9XavPSJ+
         LWpZtEV8eKbBy5h19P0VTj3toedV3Ll2KuH/hFHATd1kIefV328KWaqHwx9DnS6raFlB
         sgUA==
X-Received: by 10.68.171.4 with SMTP id aq4mr15447673pbc.150.1400188718609;
        Thu, 15 May 2014 14:18:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ox3sm10738276pbb.88.2014.05.15.14.18.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 14:18:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-15-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249202>

Ronnie Sahlberg wrote:

> --- a/builtin/replace.c
> +++ b/builtin/replace.c
[...]
> @@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
>  	else if (!force)
>  		die("replace ref '%s' already exists", ref);
>  
> -	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -	if (!lock)
> -		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> -		die("%s: cannot update the ref", ref);
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref, repl, prev,
> +				   0, !is_null_sha1(prev)) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +		die("%s: failed to replace ref: %s", ref, err.buf);

This would write

	fatal: refs/replace/09c779943364d893c190066c385e6112af421db3: failed to replace ref: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.

Perhaps something like

	$ git replace foo bar
	fatal: replace foo: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.

would make sense (die("replace %s: %s", object_ref, err.buf)).  Plain

	$ git replace foo bar
	fatal: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.

also seems fine (die("%s", err.buf)).

Thanks,
Jonathan
