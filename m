From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/20] checkout: check_linked_checkout: improve "already checked out" aesthetic
Date: Thu, 16 Jul 2015 10:55:05 -0700
Message-ID: <xmqqy4ig3s3q.fsf@gitster.dls.corp.google.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
	<1437034825-32054-7-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFnNM-00044R-JK
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 19:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbbGPRzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 13:55:09 -0400
Received: from mail-ie0-f196.google.com ([209.85.223.196]:35606 "EHLO
	mail-ie0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbbGPRzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 13:55:07 -0400
Received: by iebmx2 with SMTP id mx2so4453285ieb.2
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=R18w5sZKFcQ0GYdWjrGTjaoE2om2x9S4J1T0/NU9bcA=;
        b=Ol79HF3vVdfFTk+QVmN36kO0pf1w3rv9/SIGMUBS0W4HIeGsk5jjTwet+u5wtnDb7O
         mMwSJbae+i7k6oxex+K3+j1Juqhx2vOW22H8/gNXIcw5nDmoIC88t1lIfqKjQ4lZmVLN
         K9LA3ddUMPzPL59GbrKB66ChAHZzMs1uNh4nGV9iWTIIur3gnxyLuPNFDeb/ftu1TbTK
         aRZhYoPwfPzqbFtoacX/L6anWMHrU4cuF2skNlYHcd4FlnHTKr5NtB/TFRL4NBYveIV+
         dAHLfX0owxL04jkhorU3vSmlSDgyOisgicGRCItnBJcpr3hF7kD2pfjF+OopPlh07FM7
         /WAA==
X-Received: by 10.107.153.206 with SMTP id b197mr12916776ioe.71.1437069306733;
        Thu, 16 Jul 2015 10:55:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id t7sm1795886ign.8.2015.07.16.10.55.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 10:55:06 -0700 (PDT)
In-Reply-To: <1437034825-32054-7-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Thu, 16 Jul 2015 04:20:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274035>

Eric Sunshine <sunshine@sunshineco.com> writes:

> When check_linked_checkout() discovers that the branch is already
> checked out elsewhere, it emits the diagnostic:
>
>     'blorp' is already checked out at '/some/path/.git'
>
> which is mildly misleading and a bit unsightly due to the trailing
> "/.git". For the user, "/some/path" is significant, whereas "/.git" is
> mere noise, so drop it.

More importantly, when a user hears "a checkout", the word means the
working tree location.  My top-level Makefile is at /some/path/Makefile,
not /some/path/.git/Makefile, so having /.git suffix is wrong.

How does this work with manually configured GIT_DIR environment, by
the way?  I think GIT_DIR=/collection/of/repos/foo.git would be OK,
as strbuf_strip_suffix() would hopefully leave it intact, but I am
more interested in the general working of linked checkout feature,
not just this error message.

In the new world order with GIT_DIR and GIT_COMMON_DIR, does
"$GIT_DIR" always have to be the same as "$GIT_WORK_TREE/.git"?  Do
we need some sanity check if that is the case?  Perhaps: if you have
$GIT_DIR set to $somewhere/.git/worktrees/$name, then

 - $GIT_COMMON_DIR must match $somewhere/.git,

 - $somewhere/.git/worktrees/$name/commondir must point at
   $GIT_COMMON_DIR,

 - $GIT_WORK_TREE/.git must match $GIT_DIR

or something like that?

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> New in v2.
>
>  builtin/checkout.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 177ad6a..a331345 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -909,6 +909,7 @@ static void check_linked_checkout(const char *branch, const char *id)
>  	} else
>  		strbuf_addstr(&gitdir, get_git_common_dir());
>  	skip_prefix(branch, "refs/heads/", &branch);
> +	strbuf_strip_suffix(&gitdir, "/.git");

Sick people have '/.git' and run "git add etc/passwd"; do we want to
consider such a use case?

>  	die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
>  done:
>  	strbuf_release(&path);
