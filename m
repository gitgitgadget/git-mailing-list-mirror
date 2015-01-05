From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv10 02/10] receive-pack.c: die instead of error in
 assure_connectivity_checked
Date: Mon, 5 Jan 2015 12:17:29 -0800
Message-ID: <20150105201728.GK29365@google.com>
References: <CAGZ79ka8TMvF1s=ZL=4Lj1EaDrLVn8HRA2PR4JLAHWasHmvkFA@mail.gmail.com>
 <1420482355-24995-1-git-send-email-sbeller@google.com>
 <1420482355-24995-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	sunshine@sunshineco.com, mhagger@alum.mit.edu,
	ronniesahlberg@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:20:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8E5o-0003fk-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 21:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbbAEURd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 15:17:33 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:53853 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323AbbAEURc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 15:17:32 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so20511197iec.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CWOpsErpJp0tyvK+hnMQSRrbzbHy8bwLPYF5Wn+MLPA=;
        b=wTFNeqrtbZZoJ1Y0To9Rq8GzWJP0SyfERqbfQIS5FizF7SqVRUrAUBtYRTT6MW9MtB
         gRc0CWZCttEI1zfvh27NeHrCw17hjmMdY3rExhhi2PqKUyhmIBMDubl6z308JhaBzTC5
         xwkixrEZ2EeiQIovjXGmMANrbV2/g9qplE/oYrh5Gm3FeeLFMAXwZBeXFKQNLt//Ul7Z
         7oPbvu4YDeqBMeWZWVKhukz3f9O3QllRaHqP2g7QB/H4wOd3OQVuRREDg477l4i4lY8j
         +ehLVCNve9ZgWNJLFYloJDU6fRmZDgo8Zw2S3/GEK5HsBKXz576WgIJqO6MgQMDhuzJ4
         ndsg==
X-Received: by 10.42.14.8 with SMTP id f8mr71129027ica.53.1420489051862;
        Mon, 05 Jan 2015 12:17:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cbe:c7db:3064:452c])
        by mx.google.com with ESMTPSA id x6sm4024568igl.10.2015.01.05.12.17.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 12:17:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420482355-24995-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262031>

Stefan Beller wrote:

> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1055,15 +1055,15 @@ static void assure_connectivity_checked(struct command *commands,
>  
>  	for (cmd = commands; cmd; cmd = cmd->next) {
>  		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
> -			error("BUG: connectivity check has not been run on ref %s",
> -			      cmd->ref_name);
> +			die("BUG: connectivity check has not been run on ref %s",
> +			    cmd->ref_name);

This could stay as error() so that the caller gets to see the list of
refs that didn't experience a connectivity check.  Or if that list
isn't important, this error/die call could be dropped and the
'checked_connectivity = 0' setting would be enough.

>  			checked_connectivity = 0;
>  		}
>  	}
>  	if (!checked_connectivity)
> -		error("BUG: run 'git fsck' for safety.\n"
> -		      "If there are errors, try to remove "
> -		      "the reported refs above");
> +		die("BUG: run 'git fsck' for safety.\n"
> +		    "If there are errors, try to remove "
> +		    "the reported refs above");

I find this error message misleading and confusing.  It makes it seem
like this is an expected error that we are trying to help the user
recover from.  Instead, something impossible has happened.  "Try to
remove the reported refs" is actively harmful advice --- that would be
a way for the user to work around a serious bug instead of figuring
out what went wrong and getting git fixed.

Jonathan
