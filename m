From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: GIT_DIR not auto ignored
Date: Sun, 01 Dec 2013 19:30:11 +0100
Message-ID: <1385922611.3240.6.camel@localhost>
References: <CAHJtQJ77drefyhjrs_C8bEq14ZiSNf6Boztqx+JYx51dRtrd-w@mail.gmail.com>
	 <1385921319.3240.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingy dot Net <ingy@ingy.net>
X-From: git-owner@vger.kernel.org Sun Dec 01 19:30:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnBmg-0006yL-LN
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 19:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab3LASaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 13:30:18 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:41654 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab3LASaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 13:30:16 -0500
Received: by mail-we0-f180.google.com with SMTP id t61so5332469wes.39
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 10:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=zeOWw+1QCp2pAjiI6E28H2rSVzkeeo3HqVACAcpN72c=;
        b=lUEyQrrlKBwyhHUzgYty8VgTBHxuv86RKpOJFzvJI4MCKtoYROqZ07XoaRxA4aM9Yn
         rLYvu8VZ2h7gpb1AcDPDRj6o5jiZjHhaLLDp1kYiDfeeHcfQep6nzo95dVMiMjh3832E
         S1pqyvSHBBS1T94LLvMvFWzNQWaSL8BABrt5bo17bvZCdoWlJ78ZuILRqdRrX1M4Yxcm
         5WoqHKol0xw/6spxc1ooSc/Kf2RD+gs+Vm0ZeF4GFGlgVkL3xm1Y4Mxh+ROqlbMHzQx6
         E+jASQDgvbRSPesxahGQ5PNUUbxPZqQVSu1uiKPjLssltJotkKasLvU4l0tcuytqsUKW
         OoWg==
X-Gm-Message-State: ALoCoQl9rigm+Sozs/USNeDUJi4cjF2/lsf9fkYmBp2/eLKuuvFQlpAJtPBAw4tiHqRAipNzXvSj
X-Received: by 10.180.74.174 with SMTP id u14mr14890206wiv.45.1385922615915;
        Sun, 01 Dec 2013 10:30:15 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id fu1sm114356287wib.8.2013.12.01.10.30.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 10:30:15 -0800 (PST)
In-Reply-To: <1385921319.3240.3.camel@localhost>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238592>

On zo, 2013-12-01 at 19:08 +0100, Dennis Kaarsemaker wrote:
> On za, 2013-11-30 at 23:06 -0800, Ingy dot Net wrote:
> > Greetings,
> > 
> > I found this probable bug:
> > https://gist.github.com/anonymous/01979fd9e6e285df41a2
> 
> Summary:
> 
> $ mv .git .foo
> $ export GIT_DIR=$PWD/.foo
> $ git status
> # On branch master
> #
> # Initial commit
> #
> # Untracked files:
> # .foo/
> nothing added to commit but untracked files present
> 
> 
> I checked with 1.8.5 and this still happens. 

This makes it go away:

diff --git a/dir.c b/dir.c
index 23b6de4..884b37d 100644
--- a/dir.c
+++ b/dir.c
@@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
                return path_none;
        strbuf_setlen(path, baselen);
        strbuf_addstr(path, de->d_name);
-       if (simplify_away(path->buf, path->len, simplify))
+       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
                return path_none;
 
        dtype = DTYPE(de);

I'll add a test and submit a proper patch.

> And this also happens:
> 
> $ mv .git .foo 
> $ export GIT_DIR=.foo
> dennis@lightning:~/code/git$ touch .git
> dennis@lightning:~/code/git$ git status
> On branch master
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
> 	.foo/
> 
> nothing added to commit but untracked files present (use "git add" to
> track)
> 
> (Note the absence of .git there)

Comments in dir.c indicate that this is expected, so I didn't try to
"fix" that.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
