From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Hook "post-merge" does not get executed in case of confilicts
Date: Thu, 21 Aug 2014 12:07:16 -0700
Message-ID: <20140821190716.GI20185@google.com>
References: <20140821185141.GA93319@becker.bs.l>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bertram Scharpf <lists@bertram-scharpf.de>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKXhk-00082g-NQ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 21:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbaHUTHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 15:07:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43888 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaHUTHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 15:07:19 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so15174229pab.30
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W3vX0AKEG9QJpkfcnh82brtbgQpCoXUWYuYU1SB+V1o=;
        b=Sja23JELv/LfoQKo/Y8rjkVDLjSYt1B3tKzRoSs19LR3/RXTEq9BA1K+JUidNNJ1sx
         buEj6vlGGfJRLmVR0pd9rGBRKXUj5/pH3rs+OWUIFrE5Jpt/PJCm8Ecp6qPd+NpZNaUv
         oaJR+B58cpc5d3wRxslRB85mT8q/nhQMSEjBXz+5zGqY8lxIrGzqeAd8E2UYmZT1IMLo
         A8VmDvJTdo1bRNTBLYCUTFpQ8uscn/H3EXQRrwfOH0MCxpwcs1izXVkObg77pcciWCAF
         7Se5+aGe6p5fE3M6fvpQYZP6/5MvpzN3tjw9EWAsUgB/6yQoEGUp/r/UCuxB7quetetf
         MCQw==
X-Received: by 10.68.228.106 with SMTP id sh10mr470559pbc.109.1408648039305;
        Thu, 21 Aug 2014 12:07:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:3460:788e:6b19:7e67])
        by mx.google.com with ESMTPSA id up2sm26289130pbc.21.2014.08.21.12.07.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Aug 2014 12:07:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140821185141.GA93319@becker.bs.l>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255633>

Hi,

Bertram Scharpf wrote:

> today I wrote a port-merge hook. Then I just detected that it only gets
> executed when the merge is immediately successful. In case there is a
> conflict, I have to finish the merge using the command "git commit".
> This will not call the post-merge hook.
>
> I think the hook should be reliable to be executed on _every_ non-failed
> merge. Therefore I propose the below extension.

I agree that at first glance this sounds like a good thing.  A manual
conflict resolution is not so different from a very smart merge
strategy, after all.

Nits:

> Bertram

Sign-off?  (See Documentation/SubmittingPatches, section 5 "Sign your
work" for what this means.

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1783,6 +1783,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	rerere(0);
>  	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
> +	if (whence == FROM_MERGE)
> +		run_hook_le(NULL, "post-merge", "0", NULL);

"git merge" doesn't run the post-commit hook, so there's a new
asymmetry being introduced here.  Should "git merge" run the
post-commit hook?  Should a "git commit" that means "git merge
--continue" avoid running it?

Also if doing this for real, the documentation should be updated
and tests introduced to make sure the behavior doesn't get broken
in the future.  Documentation/githooks.txt currently says

	This hook cannot affect the outcome of git merge and is not
	executed if the merge failed due to conflicts.

which would need to be updated to say that the hook will run later
in that case, when the merge is finally committed.

Thanks and hope that helps,
Jonathan
