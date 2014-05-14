From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 05/42] update-ref.c: log transaction error from the
 update_ref
Date: Wed, 14 May 2014 15:08:31 -0700
Message-ID: <20140514220831.GB9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
 <1398976662-6962-6-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhLq-0002Qg-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbaENWIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:08:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41531 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaENWIe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:08:34 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so160915pad.30
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ccoVEHB3ZUGK1CNnGeoiLtaK1PQwoUf752RgEohBYJg=;
        b=TmLVAr+yAb/cmdnb6VuIvZb7yS+DYW2OogSoJ8zyBaICSBhttZ6vEbyNjrHUpCITkn
         f7YOxQWAyhhfgDECmq1UphNj5VVTrV9Wrc3fjl5DsbyUL1jxrkdRmjbEc2iCAi9PD483
         0X1nkufaVp30FJQ4DaeKmIw5vwwCd3uDQ7F7qETKUgW3/g2rX3uUxcfy88l/FwKL7GnC
         7W0BG8MASXNdwR2Jo8eGOOFkLUr7FhXlUjr8QYLL3QfOoKHe/gFEYcdS5+i6kTuVcfbE
         UAn6iWCXqQGEhMZ6wdB/d4hvxAW3Px7cwI3czs2HukYlEkL/WSmdAJasIrNqDbeLFLpF
         Cwsg==
X-Received: by 10.68.254.5 with SMTP id ae5mr7373232pbd.83.1400105314051;
        Wed, 14 May 2014 15:08:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vf9sm5293421pbc.94.2014.05.14.15.08.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 15:08:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-6-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249004>

Hi,

Ronnie Sahlberg wrote:

> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
[...]
> @@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
[...]
>  		if (delete || no_deref || argc > 0)
>  			usage_with_options(git_update_ref_usage, options);
>  		if (end_null)
>  			line_termination = '\0';
>  		update_refs_stdin();
> -		ret = ref_transaction_commit(transaction, msg, NULL,
> -					     UPDATE_REFS_DIE_ON_ERR);
> -		return ret;
> +		if (ref_transaction_commit(transaction, msg, &err,
> +					   UPDATE_REFS_QUIET_ON_ERR))
> +			die("%s", err.buf);

Nice.  I like this much more than passing a flag to each function to
tell it how to handle errors. :)

ref_transaction_commit didn't have any stray codepaths that return
some other exit code instead of die()-ing with UPDATE_REFS_DIE_ON_ERR,
so this should be safe as far as the exit code is concerned.

The only danger would be that some codepath leaves 'err' alone and
forgets to write a messages, so we die with

	"fatal: "

Alas, it looks like this patch can do that.

 i. The call to update_ref_write can error out without updating the
    error string.

 ii. delete_ref_loose can print a message and then fail without updating
     the error string so the output looks like

	warning: unable to unlink .git/refs/heads/master.lock: Permission denied
	fatal:
	$

 iii. repack_without_refs can similarly return an error

	error: Unable to create '/home/jrn/test/.git/packed-refs.lock: Permission denied
	error: cannot delete 'refs/heads/master' from packed refs
	fatal:
	$

 iv. commit_lock_file in commit_packed_refs is silent on error.
     repack_without_refs probably intends to write a message in that
     case but doesn't :(

I wish there were some way to automatically detect missed spots or
make them stand out (like with the current "return error()" idiom a
bare "return -1" stands out).

(i) is fixed by a later patch.  It would be better to put that before
this one for bisectability.

I don't see fixes to (ii), (iii), and (iv) in the series yet from a
quick glance.

Thanks,
Jonathan
