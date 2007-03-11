From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 19:42:02 +0700
Message-ID: <fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 13:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQNNN-0007OX-90
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 13:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348AbXCKMmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 08:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933457AbXCKMmG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 08:42:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:59688 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbXCKMmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 08:42:04 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1890343uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 05:42:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sWMxN9qVICAnHQO3HPJN/TTurquJhDSDKlGacG05a0me7d+Ufsatu8m5cNVjegNs3de7HTc00kow022V7R5yovB8fx69C7+QVHCtSc8Qjp7X1APWlqHclmdDrlUIsPGojmWWiI2+NV3Y/WWhxLZDONB9DeEPbxJz+N1ZuxatY9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uji3krzKpYWf4S4+kdxQwpQHGVlG0CUdftcIHLjQpJH4Vl7oeXpaK3oJv2RgdNNXOu2noSX24qplhrXQtcRqdipkdS7I4OQkS/Cs7nslou0aIZYSUV1y9F23VI42nKqW9o4UpLTXIcD0tZxoB3wslC50NIdlTy7U7ITFbAxCjww=
Received: by 10.115.54.1 with SMTP id g1mr787707wak.1173616922280;
        Sun, 11 Mar 2007 05:42:02 -0700 (PDT)
Received: by 10.115.19.15 with HTTP; Sun, 11 Mar 2007 05:42:02 -0700 (PDT)
In-Reply-To: <20070311043250.GA21331@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41920>

On 3/11/07, Matthias Lederhofer <matled@gmx.net> wrote:
> +               gitwd = getenv(GIT_WORKING_DIR_ENVIRONMENT);
> +               if (!gitwd || stat(gitwd, &st_work))
>                         return NULL;

I propose the following instead of the last two lines:

                if (!gitwd)
                        return NULL;
                if (stat(gitwd, &st_work))
                        die("Unable to stat git working directory %s",gitwd);

> +               if (inside_git_dir == -1 && stat(gitdirenv, &st_git))
> +                       die("Unable to stat git directory");
> +               if (!getcwd(cwd, sizeof(cwd)-1) || cwd[0] != '/')
> +                       die("Unable to read current working directory");
> +               len = strlen(cwd);
> +
> +               prefix = cwd+len;
> +               for (;;) {
> +                       c = *prefix;
> +                       *prefix = '\0';
> +                       if (stat(cwd, &st))
> +                               die("Unable to stat '%s'", cwd);
> +                       if (st_work.st_dev == st.st_dev &&
> +                           st_work.st_ino == st.st_ino)
> +                               break;
> +                       if (inside_git_dir == -1 &&
> +                           st_git.st_dev == st.st_dev &&
> +                           st_git.st_ino == st.st_ino)
> +                               inside_git_dir = 1;
> +                       *prefix = c;
> +
> +                       if (prefix == cwd+1) {
> +                               has_working_directory = 0;
> +                               return NULL;

My case seems a bit complicated than usual. The working directory
(/home/pclouds/blog/data) was not a prefix of cwd (/home/pclouds/blog)
so the code failed silently at this line. If I replace
"has_working_directory = 0; return NULL;" with "strcpy(cwd,gitwd);c =
0;break;", it may work but see below

> +                       }
> +                       while (*(--prefix) != '/')
> +                               ; /* do nothing */
> +                       if (prefix == cwd)
> +                               prefix++;
> +               }
> +
> +               if (chdir(cwd))
> +                       die("Cannot change directory to '%s'", cwd);
> +

If cwd changed and GIT_DIR is a relative path, git can no longer
access GIT_DIR properly.
-- 
Duy
