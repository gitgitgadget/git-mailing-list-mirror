From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 33/41] refs.c: pass the ref log message to
 _create/delete/update instead of _commit
Date: Fri, 30 May 2014 10:38:31 -0700
Message-ID: <20140530173831.GH12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-34-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 30 19:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQlL-0001cD-2s
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbaE3Rif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:38:35 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:41073 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbaE3Rie (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:38:34 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so1946428pbb.41
        for <git@vger.kernel.org>; Fri, 30 May 2014 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eYLs/5N8+uarBkdEQsIj37oLgCMN/U/UaOj+OVXknCg=;
        b=vpnikqWk1LuhIlV/e1ASuS0hNBRBB6DQwEIbeDc+Wrlfo9LayrLmzvu7DNEZ9FLsQj
         wNwRFLQ3N4xbGdh9Gs2ilX307pQsqZFjQl/Z53NfpXawtzCaqguy1CG/LoIxn16UBp6P
         ru754fqLALnu0EPy4abxKnpqDPOn2TWzphaWLrWA11qc3BrCNlixgf8HnPiPFfxrskKR
         wOsIAToFNfkG98MAZKNhctRXM3P3MyYkZrRSRHd1zrn2krDNxoLf1CYqAugRz4VjFauw
         dQI2P4VV17qG+tN9io7BmEtOX4bbC6RWq17s/9YFndOrgCfpLx7b92BppgqmdCTR4wEj
         g7Bw==
X-Received: by 10.68.249.2 with SMTP id yq2mr20501022pbc.70.1401471514263;
        Fri, 30 May 2014 10:38:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id i10sm21509850pat.36.2014.05.30.10.38.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 May 2014 10:38:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-34-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250452>

Ronnie Sahlberg wrote:

> Change the reference transactions so that we pass the reflog message
> through to the create/delete/update function instead of the commit message.
> This allows for individual messages for each change in a multi ref
> transaction.

Nice.

That reminds me: in the future, do we want to have some way to figure
out what ref updates happened together?  E.g., cvsnt introduced commit
identifiers to answer a similar kind of question in CVS per-file
history.  If some backend wants to support that, the API this patch
introduces would handle it fine --- good.

[...]
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -673,10 +673,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			}
>  		}
>  	}
> -
>  	if (rc & STORE_REF_ERROR_DF_CONFLICT)
>  		error(_("some local refs could not be updated; try running\n"
> -		      " 'git remote prune %s' to remove any old, conflicting "
> +		      "'git remote prune %s' to remove any old, conflicting "
>  		      "branches"), remote_name);

Unrelated change snuck in?

The rest of the patch is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/builtin/fetch.c b/builtin/fetch.c
index faa1233..55f457c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -673,9 +673,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-		      "'git remote prune %s' to remove any old, conflicting "
+		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
  abort:
