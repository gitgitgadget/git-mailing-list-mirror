From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 04/19] refs.c: return error string from
 ref_update_reject_duplicates on failure
Date: Fri, 25 Apr 2014 15:12:48 -0700
Message-ID: <20140425221248.GC9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
 <1398442494-23438-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:13:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdoMe-0004M5-5W
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaDYWMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:12:53 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44896 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbaDYWMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:12:51 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so3546896pde.26
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9+ynMLS79e7Ty5/9rTLAmPVbx4us4c49MoOYX6edZUc=;
        b=ycCCA/d5Gwu4cOFvfkfPo6jhNc2Bd0+3gKHX1Q/ORoHRJsZoVFh66G04SPoL+EaHnp
         hzNmJ57kwSvpYcZkYHGu+G4GN+qTZmOzWcFG50+n1CFxXTOGhKyVAWpUpG7bpMspZ1zD
         BdnvxzSaVqtLrkzoevm9aFOgmGGm4EQfCd0aTJNGccVp7Sx18T/c4ahxiW8siFfeg6KO
         B6o3RcA/+D4Lu7VBGxD/P/pw3FKkN4avh4Y3eegDLr69SypRxWtA2N50GxtBLc9AitMO
         WzAfbGyzUQ8krNpKFuaNftkwp9JtvarKKGJtzv/bOvg81EF7qGS3NMyrInUMfDCX/U4o
         SHJA==
X-Received: by 10.68.171.229 with SMTP id ax5mr10628592pbc.125.1398463971267;
        Fri, 25 Apr 2014 15:12:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yo9sm44840791pab.16.2014.04.25.15.12.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:12:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-5-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247119>

Ronnie Sahlberg wrote:

> --- a/refs.c
> +++ b/refs.c
> @@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
>  }
>  
>  static int ref_update_reject_duplicates(struct ref_update **updates, int n,
> +					char **err,
>  					enum action_on_err onerr)
>  {
>  	int i;
> @@ -3400,6 +3401,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
>  			const char *str =
>  				"Multiple updates for ref '%s' not allowed.";
> +			if (err) {
> +				*err = xmalloc(PATH_MAX + 41);
> +				snprintf(*err, PATH_MAX + 41, str,
> +					 updates[i]->refname);
> +			}

Same issues as the previous patch: it's too easy to get the buffer size
wrong when updating the message (or, worse, when making it
translatable).  aprintf or a strbuf should work better.

Otherwise seems sensible.
