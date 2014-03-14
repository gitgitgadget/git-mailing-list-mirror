From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] simplifying branch.c:install_branch_config() if()
Date: Thu, 13 Mar 2014 19:10:52 -0700
Message-ID: <20140314021052.GH15625@google.com>
References: <1394761558-4888-1-git-send-email-neminaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 03:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOHaT-00061f-4I
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 03:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbaCNCLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 22:11:00 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61940 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbaCNCK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 22:10:59 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so1883201pdj.31
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 19:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J8QMuMf5TXrBlb8KJ5RwVCUQ70qpQrY4ke66mt/6kWU=;
        b=qFeSgZa9DvEP1vakmLq3UxOrrx2UV+NXJFdKhbEvngLW8x+qJ07len3cg23mveHYCz
         th+4z9bs7t7ao484jZ7+MftUTsh7sHJlD8d820JxO3THKG/CxR4Pr3Juurf3aVbFRydW
         bU7x3Wf/49d34wzreweT1/nflfosHEagALoJyN8cx20FM9lNfLPDhsmKQxlMhej9sweS
         HlJRTdaDwRhCd2+a3cCMKTO1RwM+dbMcf1s8pl482npLq+VzKYzpBglNAfUTpGj7XXK1
         s2ljSxaT0pYnqlZhHFSNTeLbf8O46+o5/rb7/Y6IYOhx6KNp1jGOGwmy+nMEkyQBciGL
         TfPg==
X-Received: by 10.66.193.202 with SMTP id hq10mr6044543pac.57.1394763055157;
        Thu, 13 Mar 2014 19:10:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ns7sm11292881pbc.32.2014.03.13.19.10.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 19:10:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394761558-4888-1-git-send-email-neminaa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244068>

Hi,

Nemina Amarasinghe wrote:

> Signed-off-by: Nemina Amarasinghe <neminaa@gmail.com>

The above is a place to explain why this is a good change.  For example:

	When it prints a message indicating what it has done,
	install_branch_config() treats the (!remote_is_branch && origin)
	and (!remote_is_branch && !origin) cases separately.  But they
	are the same, and it uses the same message for both.

	Simplify by just checking for !remote_is_branch.

	Noticed using the magic-identical-branch-checker tool.

	Signed-off-by: ...

(That's just a first random hypothetical guess --- of course please do
not use it but put your own rationale for the change there.)

[...]
> --- a/branch.c
> +++ b/branch.c
> @@ -87,16 +87,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>  				  _("Branch %s set up to track local branch %s by rebasing.") :
>  				  _("Branch %s set up to track local branch %s."),
>  				  local, shortname);
> -		else if (!remote_is_branch && origin)
> +		else if (!remote_is_branch)
>  			printf_ln(rebasing ?
>  				  _("Branch %s set up to track remote ref %s by rebasing.") :
>  				  _("Branch %s set up to track remote ref %s."),
>  				  local, remote);
> -		else if (!remote_is_branch && !origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track local ref %s by rebasing.") :
> -				  _("Branch %s set up to track local ref %s."),
> -				  local, remote);

Is this safe?  Today branch.c::create_branch checks that the argument
to e.g. --set-upstream-to is either in refs/heads/* or the image of
some remote, but what is making sure that remains true tomorrow?

So if changing this, I would be happier if the "if" condition were
still (!remote_is_branch && origin) so the impossible case could emit
a BUG.

Hope that helps,
Jonathan
