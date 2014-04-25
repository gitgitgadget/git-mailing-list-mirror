From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 05/19] update-ref.c: use the error string from _commit
 to print better message
Date: Fri, 25 Apr 2014 15:36:20 -0700
Message-ID: <20140425223620.GD9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
 <1398442494-23438-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 00:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdojN-0001PO-DM
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 00:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbaDYWgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 18:36:24 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40571 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaDYWgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 18:36:23 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so3688367pbc.30
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5OcL63FNE9abJX8N9C9wlWOGry80NduD4HKZv18VIFc=;
        b=sNbb0j2aV8rB+wYgx6hMSqJnmGcqmG/yG1ps6swM2TOJ8hqPcHY7qIz5wciOO3/bPk
         K1wWSaiDWf3LKjYfxRDbHl482a/7UptEBR6mvXJKjAIFY+l4iobXEDzJgV5zMRupUE3X
         76qc3o9KfMIUdzA2/VbJZk6ekUH7TN4BcYygZhLI4MrQQ9ajrWZr7/ytK4gyvE/L2K2w
         F8b/lQJdap02ENJOUVlu0MSsaj4lJonsSu6b52kgfo3yr/vV1AeNFms2IbEH7lDb5gyF
         TIn7H2FO8QWL4xPk+lsNQCFcExYV4MCUYyE5WXhASKFRZXnhA985O4MCfwzSZ7NtGkqC
         lpaQ==
X-Received: by 10.66.141.197 with SMTP id rq5mr10830742pab.64.1398465383279;
        Fri, 25 Apr 2014 15:36:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm18247731pbc.74.2014.04.25.15.36.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 15:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-6-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247120>

Ronnie Sahlberg wrote:

> Call ref_transaction_commit with QUIET_ON_ERR and use the error string
> that is returned to print a better log message if/after the transaction
> fails.

Ah, so that's how the transition to a better API happens.  Makes sense.

(A mention of QUIET_ON_ERR in the patch that introduces the &err
parameter could help, or feel free to ignore these comments, since it's
all well by the end of the series.)

> Update the tests to reflect that the log message is now slightly different
>   fatal: update_ref failed: Cannot lock the ref 'some ref'
> versus from the previous
>   fatal: Cannot lock the ref 'some ref'

Makes sense as a demo of what the new code allows, but is this error
message better?  The use of 'git update-ref' is an implementation
detail that the user doesn't need to know about.

I think I'd prefer the result of plain die("%s", err), even though
that's a no-op.

[...]
> +++ b/builtin/update-ref.c
[...]
> @@ -359,17 +360,18 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  		die("Refusing to perform update with empty message.");
>  
>  	if (read_stdin) {
> -		int ret;
>  		transaction = ref_transaction_begin();
> -
> +		if (!transaction)
> +			die("failed to update refs");

This can't happen (xcalloc is defined to die() on malloc failure).
If you want to protect against it anyway, die("BUG: ...")?

Thanks,
Jonathan
