From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] bare repository detection does not work with aliases
Date: Thu, 07 Mar 2013 22:27:04 -0800
Message-ID: <94c531c1-57a0-4464-9f30-3c63f0c1a056@email.android.com>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com> <20130308054824.GA24429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 07:29:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDqnv-0007TU-0H
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 07:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab3CHG2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 01:28:52 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:52464 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab3CHG2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 01:28:51 -0500
Received: by mail-da0-f54.google.com with SMTP id p1so158270dad.27
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 22:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:user-agent:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=z6MdiZhMGhOhD/rJ9RpjyMb3nIeAPqnF0/MzSbODDwk=;
        b=kS9V4v+MKPWUzCg1Ch1ZQt0dCoUGNGT877z2VFJKY4o1QXIELoUHVdVCVA0ax/jskU
         kpNP29SJCFnnvZDWUpblW1NGZTOs2robIX6VMEdr1+nsGxhsquEwCuDj/MzSvuiYvFnl
         XQnN6+xC27GC1BC5E9bx3mT5KlDVh5N1nNti+rWZo0RmsiplkrwYZxWWv8+yEZaDJKxu
         ZVeKHyY0Zhz8tKiEmNuOWs8LxWtLT9Uay1OCApeA/hRCSP6wddTnLXlIn/ykWlgrRCVO
         Uu4H97aXRxEQ4lvgiu3F395HF39SEOJqs73hvlsd3++YaxHfMyt5ww8OTfjOlT4qFYPv
         xZ7A==
X-Received: by 10.66.222.5 with SMTP id qi5mr2560279pac.32.1362724130935;
        Thu, 07 Mar 2013 22:28:50 -0800 (PST)
Received: from [192.168.2.101] (c-98-234-214-94.hsd1.ca.comcast.net. [98.234.214.94])
        by mx.google.com with ESMTPS id ev13sm5109552pac.1.2013.03.07.22.28.47
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Mar 2013 22:28:49 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20130308054824.GA24429@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217639>

The $GIT_BARE idea sounds very sensible to me.



Jeff King <peff@peff.net> wrote:

>On Thu, Mar 07, 2013 at 05:47:45PM -0500, Mark Lodato wrote:
>
>> It seems that the fallback bare repository detection in the absence
>of
>> core.bare fails for aliases.
>
>This triggered some deja vu for me, so I went digging. And indeed, this
>has been a bug since at least 2008. This patch (which never got
>applied)
>fixed it:
>
>  http://thread.gmane.org/gmane.comp.version-control.git/72792
>
>The issue is that we treat:
>
>  GIT_DIR=/some/path git ...
>
>as if the current directory is the work tree, unless core.bare is
>explicitly set, or unless an explicit work tree is given (via
>GIT_WORK_TREE, "git --work-tree", or in the config).  This is handy,
>and
>backwards compatible.
>
>Inside setup_git_directory, when we find the directory we put it in
>$GIT_DIR for later reference by ourselves or sub-programs (since we are
>typically moving to the top of the working tree next, we need to record
>the original path, and can't rely on discovery finding the same path
>again). But we don't set $GIT_WORK_TREE. So if you don't have core.bare
>set, the above rule will kick in for sub-programs, or for aliases
>(which
>will call setup_git_directory again).
>
>The solution is that when we set $GIT_DIR like this, we need to also
>say
>"no, there is no working tree; we are bare". And that's what that patch
>does. It's 5 years old now, so not surprisingly, it does not apply
>cleanly. The moral equivalent in today's code base would be something
>like:
>
>diff --git a/environment.c b/environment.c
>index 89d6c70..8edaedd 100644
>--- a/environment.c
>+++ b/environment.c
>@@ -200,7 +200,8 @@ void set_git_work_tree(const char *new_work_tree)
> 		return;
> 	}
> 	git_work_tree_initialized = 1;
>-	work_tree = xstrdup(real_path(new_work_tree));
>+	if (*new_work_tree)
>+		work_tree = xstrdup(real_path(new_work_tree));
> }
> 
> const char *get_git_work_tree(void)
>diff --git a/setup.c b/setup.c
>index e1cfa48..f0e1251 100644
>--- a/setup.c
>+++ b/setup.c
>@@ -544,7 +544,7 @@ static const char *setup_explicit_git_dir(const
>char *gitdirenv,
> 	worktree = get_git_work_tree();
> 
> 	/* both get_git_work_tree() and cwd are already normalized */
>-	if (!strcmp(cwd, worktree)) { /* cwd == worktree */
>+	if (!worktree || !strcmp(cwd, worktree)) { /* cwd == worktree */
> 		set_git_dir(gitdirenv);
> 		free(gitfile);
> 		return NULL;
>@@ -636,6 +636,8 @@ static const char *setup_bare_git_dir(char *cwd,
>int offset, int len, int *nongi
> 	}
> 	else
> 		set_git_dir(".");
>+
>+	setenv(GIT_WORK_TREE_ENVIRONMENT, "", 1);
> 	return NULL;
> }
> 
>
>which passes your test. Unfortunately, this patch runs afoul of the
>same
>complaints that prevented the original from being acceptable (weirdness
>on Windows with empty environment variables).
>
>Having read the discussion again, I _think_ the more sane thing is to
>actually just have a new variable, $GIT_BARE, which overrides any
>core.bare config (just as $GIT_WORK_TREE override core.worktree). And
>then we set that explicitly when we are in a bare $GIT_DIR, propagating
>our auto-detection to sub-processes.
>
>-Peff
>--
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pardon terseness, typo and HTML from a tablet.
