From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: git --literal-pathspecs add -u says "fatal: pathspec ':/' did not
 match any files"
Date: Sat, 24 Oct 2015 10:13:54 +0300
Message-ID: <562B2FB2.4080604@gmail.com>
References: <CAM-tV--Q=DjTwLk8sZVm7-xMQsGwKmyjy4XiT08QpQ5-dffL0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: vleschuk@accesssoftek.com
To: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 09:14:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpt1e-00077j-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 09:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbbJXHN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 03:13:58 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35134 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbJXHN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 03:13:58 -0400
Received: by lfbn126 with SMTP id n126so69473787lfb.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=XgJ/APTwyyICWPmLkVC8qOdCDPWEC8iEkUd51XJZFrQ=;
        b=1FyBQSHSxAkpDp7Zcmyq++BBPByiMONnAe3gf88S74sXB1tex/A+gm3Qkfhlj/OoW/
         KcaQ1Z33+wrnPqjD2wzBvaFJ32LMiqgkuX9AVblQXPc/6qwEhtrB7oxNX9PyDFPZgTGp
         xsqrKHO69CZuRtsZ+0pqggMRnlfbXxOQ85R/N4gCXFAviMVwRy9K8D3zkrV44nCm996s
         ogECasI+84wPVPa6t1bdHCbX3EkK4OsCEjC3jsVjmlfnMgZnlTPMfoSOtmt5K/9ES3st
         qQ4IggTPVo35xY5TM14en7s9Ti+HN1FGaXmf4Ots+J3YXgDxukqtnRDkc13n0yXjDLEv
         dZHA==
X-Received: by 10.112.209.4 with SMTP id mi4mr12981297lbc.7.1445670836738;
        Sat, 24 Oct 2015 00:13:56 -0700 (PDT)
Received: from [192.168.1.101] (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id i126sm3994645lfe.45.2015.10.24.00.13.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Oct 2015 00:13:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAM-tV--Q=DjTwLk8sZVm7-xMQsGwKmyjy4XiT08QpQ5-dffL0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280116>

Hello Noam,

The problem is that in the absence of explicit argument we set the list 
of files to special path ":/" which means repo root:

     if ((0 < addremove_explicit || take_worktree_changes) && !argc) {
         static const char *whole[2] = { ":/", NULL };
         argc = 1;
         argv = whole;
     }

And after that we treat it as regular file


             if (!seen[i] && path[0] &&
                 ((pathspec.items[i].magic &
                   (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
                  !file_exists(path))) {          /* <======== 
file_exists() here just checks lstat() result */
Maybe it'll make sense to modify file_exists() to treat ":/" specially. 
Something like that:

diff --git a/dir.c b/dir.c
index 109ceea..6cae3b9 100644
--- a/dir.c
+++ b/dir.c
@@ -2103,6 +2103,10 @@ int read_directory(struct dir_struct *dir, const 
char *path, int len, const stru
  int file_exists(const char *f)
  {
         struct stat sb;
+       if (!strcmp(f, ":/")) {
+               /* ":/" - root dir, always exists */
+               return 1;
+       }
         return lstat(f, &sb) == 0;
  }

--
Victor

On 10/24/2015 02:39 AM, Noam Postavsky wrote:
> ~/tmp/tmprepo$ git init
> Initialized empty Git repository in /home/npostavs/tmp/tmprepo/.git/
> ~/tmp/tmprepo$ git --literal-pathspecs add -u
> fatal: pathspec ':/' did not match any files
> ~/tmp/tmprepo$ git --version
> git version 2.6.1
>
> It was reported[1] that 2.0.2 and several following versions also fail
> with the same error; I found that version 1.9.5 succeeds.
>
> Adding a "." argument:
>
>     git --literal-pathspecs add -u .
>
> succeeds in all versions.
>
> [1]: https://github.com/magit/magit/issues/2354#issuecomment-150665961
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
