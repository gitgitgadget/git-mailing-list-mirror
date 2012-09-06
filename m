From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/3] v5 index branch breakage on cygwin
Date: Thu, 6 Sep 2012 14:46:36 +0200
Message-ID: <20120906124636.GB25467@tommy-fedora.scientificnet.net>
References: <50464C13.6060307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 06 14:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9bTv-0003mx-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 14:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab2IFMqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 08:46:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:37456 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2IFMql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 08:46:41 -0400
Received: by weyx8 with SMTP id x8so1077254wey.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 05:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FSTfZ0n3I7MkHWcZbWrjfn2a0dCN3RBdwi1X4FzwqZg=;
        b=k0AHYqu7KTc3DGdFc6vTwfysyzhkUo5C0mfZ1jkLZdPvNZtslmRzub+ai5bGVw2Aw8
         whZpcCG8vln9q1Z2GFtjVi2H0B8p1rOvw/xnpEAYexXCxOrZLLVWdB3Xgm+5w7k1tdNj
         8fXmnWAiC4g8XK8GEmfEpHT+stTX3GwV6DIJ76UgFphEIyOlJpRuLAlgBRx0c5vrgJnl
         JfRem1L2aQsDFAY/y/yVFVaQ5sA0Lxp7bPHFb35nF89auDFfzT7l5OOwE1vvQyUKUVNN
         xfA93iiAaF/QuBbxJdLi/oRmlG0waAWiFuUc+sTz99Hza7XHkxWXoDJZgsuBjAGe+oG6
         GrCQ==
Received: by 10.180.20.11 with SMTP id j11mr4668375wie.12.1346935600345;
        Thu, 06 Sep 2012 05:46:40 -0700 (PDT)
Received: from localhost ([46.18.27.15])
        by mx.google.com with ESMTPS id cl8sm3980196wib.10.2012.09.06.05.46.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 05:46:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50464C13.6060307@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204881>

On 09/04, Ramsay Jones wrote:
> 
> Hi Thomas,
> 
> The current pu branch is *very* broken on cygwin; practically every
> test fails. A git-bisect session points to:
> 
>     $ git bisect good
>     a4f6670277d5dc0b082139efe162100c6d7a91b8 is the first bad commit
>     commit a4f6670277d5dc0b082139efe162100c6d7a91b8
>     Author: Thomas Gummerer <t.gummerer@gmail.com>
>     Date:   Thu Aug 16 11:58:38 2012 +0200
> 
>         read-cache.c: Re-read index if index file changed
> 
>         Add the possibility of re-reading the index file, if it changed
>         while reading.
> 
>         The index file might change during the read, causing outdated
>         information to be displayed. We check if the index file changed
>         by using its stat data as heuristic.
> 
>         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
>     :100644 100644 6a8b4b1e6859b7a8df2624e80b9da47df6cd1648 cdd8480cc7c3ab373dab1ca9
>     4d77a3154f7d0fbd M      read-cache.c
>     $
> 
> Since this appears to be a cygwin specific problem, I wasn't too surprised
> to see that the code added in this commit involves the stat functions. (Yes,
> this is another example of problems caused by the "schizophrenic stat()
> functions").
> 
> A little debugging shows that the index_changed() function was always returning
> true, so that the loop was executed 50 times and git then die()s.
> 
> We note that fstat() is a "cygwin native" function, whereas lstat() is executing
> the "WIN32 optimised" function. The problematic 'struct stat' fields are st_uid,
> st_gid and st_ino, which fstat() fills with "appropriate" values (st_uid=1005,
> st_gid=513, st_ino=<non-zero value>), whereas the the WIN32 version of lstat()
> always returns zero in these fields.
> 
> I have no wish to spread the insanity, but nonetheless I implemented a "WIN32
> optimised" version of fstat(). This was a great improvement, but there were
> still a few failing tests. git-stash, in particular, seemed to be problematic.
> A git-bisect session pointed at exactly the same commit as above! *ahem*
> 
> A spot of debugging shows that index_changed() was always returning true ...
> Here, the new fstat() function was returning zero in those fields, whereas the
> lstat() function was returning "appropriate values" ...
> 
> The difference here is caused by git-stash calling git with an GIT_INDEX_FILE
> set to an _absolute_ path, such as:
> 
>     /home/ramsay/git/t/trash directory.t3903-stash/.git/index.stash.2440
> 
> This has the effect of disabling the "optimisation" and calling the "cygwin
> native" lstat() function. *ho hum*
> 
> So, the only sensible fix is to not include those fields in the index_changed
> predicate on cygwin; which is what the first patch does. The testsuite now
> runs just fine (well as fine as before, anyway!).

Thanks for noticing that problem, and sending the patch to fix this.

> The other two patches don't affect the correctness of the code, so please
> feel free to ignore them if you like.

Thanks for those patches, they make sense to me.  I'm just not sure what
to do with the series at the moment, because of the lack of comments for
the rest of the series, and Junios comment in the latest What's cooking
in git.git:

> A GSoC project.  Was waiting for comments from mentors and
> stakeholders, but nothing seems to be happening, other than breakage
> fixes on Cygwin.  May discard.
