From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 12/42] replace.c: use the ref transaction functions
 for updates
Date: Wed, 14 May 2014 17:30:31 -0700
Message-ID: <20140515003031.GI9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-13-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 02:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkjZH-0003sL-9o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 02:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbaEOAaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 20:30:35 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:59668 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaEOAaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 20:30:35 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so297604pbc.29
        for <git@vger.kernel.org>; Wed, 14 May 2014 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qzbrten6dRjAXslrai0Em/nNtkrZGVs1cyjle6iZW4A=;
        b=vxTdcJZYkICogd5/D7WHsfCQVyeU/uZoAigHVCf+zyxts8LW28LaBkAObyH13g/e2q
         eudxDnKyuumnsG2gsftNTimzoGC1Carm3GWdbBwonKKdLGYzd57o+NnNc07af5u6An0E
         mUU/g7DMFAqXoZRIDg+LL1yj0adNtiFej1cofo1+ZKxb4OeRd3FkIe09XBjm5hRSn8v4
         /ZR3hJUHoIu1vwP99n3qK5C/jJbELbVYK8SDD4gmkVmrzmCbIwg/Sd1k2DRils8YmETe
         udq9vKmU4QOlSZv+EqJl1MN2iUE7p2drOEcYuY2miaYTnvPdA2OMwMuAvrV/Cs12OMve
         WtLw==
X-Received: by 10.66.141.109 with SMTP id rn13mr8296859pab.117.1400113834384;
        Wed, 14 May 2014 17:30:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f2sm13792679pat.11.2014.05.14.17.30.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 17:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-13-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249055>

Ronnie Sahlberg wrote:

[...]
> +++ b/builtin/replace.c
[...]
> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
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
> +		die(_("%s: failed to replace ref: %s"), ref, err.buf);

Same question about the !transaction case.

This makes the message translated, which is a nice change but not
mentioned in the commit message.  (Generally speaking, I don't mind
either way about adding or not adding _() to new messages in files
that have not already undergone a pass of marking everything for
translation.)
