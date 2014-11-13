From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] On watchman support
Date: Thu, 13 Nov 2014 06:05:52 +0100
Message-ID: <54643C30.6010204@web.de>
References: <20141111124901.GA6011@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: dturner@twopensource.com
To: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 06:06:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XombY-00083C-5I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 06:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbaKMFF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 00:05:56 -0500
Received: from mout.web.de ([212.227.15.4]:53394 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbaKMFFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 00:05:55 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LnjAt-1YUPsc14lr-00hzTd; Thu, 13 Nov 2014 06:05:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141111124901.GA6011@lanh>
X-Provags-ID: V03:K0:MhvLswVS9ndm23LOYACWqAs/WqQa64pOAteFYfVNgE4xh/908lX
 Ie9ynvYEq4gwH9YJfdTq0Q2NVBkMDkP68ziTRIySflZX8B/DXAuKxoNPBmUlAZ+kGEPLgGA
 pYR01J9xeLIxE5P/Xznu765PqM4isDLh5rZc2Zc1pzBHYXYDea/znHMznzTxIdrmMziX1sk
 2QW7sQXpKpttFjIjELIBg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-11 13.49, Duy Nguyen wrote:
> I've come to the last piece to speed up "git status", watchman
> support. And I realized it's not as good as I thought.
> 
> Watchman could be used for two things: to avoid refreshing the index,
> and to avoid searching for ignored files. The first one can be done
> (with the patch below as demonstration). And it should keep refresh
> cost to near zero in the best case, the cost is proportional to the
> number of modified files.
> 
> For avoiding searching for ignored files. My intention was to build on
> top of untracked cache. If watchman can tell me what files are added
> or deleted since last observed time, then I can invalidate just
> directories that contain them, or even better, calculate ignore status
> for those files only.
> 
> This is important because in reality compilers and editors tend to
> update files by creating a new version then rename them, updating
> directory mtime and invalidating untracked cache as a consequence. As
> you edit more files (or your rebuild touches more dirs), untracked
> cache performance drops (until the next "git status"). The numbers I
> posted so far are the best case.
> 
> The problem with watchman is it cannot tell me "new" files since the
> last observed time (let's say 'T'). If a file exists at 'T', gets
> deleted then recreated, then watchman tells me it's a new file. I want
> to separate those from ones that do not exist before 'T'.
> 
> David's watchman approach does not have this problem because he keeps
> track of all entries under $GIT_WORK_TREE and knows which files are
> truely new. But I don't really want to keep the whole file list around,
> especially when watchman already manages the same list.
> 
> So we got a few options:
> 
> 1) Convince watchman devs to add something to make it work
> 
> 2) Fork watchman
> 
> 3) Make another daemon to keep file list around, or put it in a shared
>    memory.
> 
> 4) Move David's watchman series forward (and maybe make use of shared
>    mem for fs_cache).
> 
> 5) Go with something similar to the patch below and accept untracked
>    cache performance degrades from time to time
> 
> 6) ??
> 
> I'm working on 1). 2) is just bad taste, listed for completeness
> only. If we go with 3) and watchman starts to support Windows (seems
> to be in their plan), we'll need to rework some how. And I really
> don't like 3)
> 
> If 1-3 does not work out, we're left without 4) and 5). We could
> support both, but proobably not worth the code complexity and should
> just go with one.
> 
> And if we go with 4) we should probably think of dropping untracked
> cache if watchman will support Windows in the end. 4) also has another
> advantage over untracked cache, that it could speed up listing ignored
> files as well as untracked files.
> 
> Comments?
> 
[remove the patch]
From a Git user perspective it could be good to have something like this:

a) git status -u
b) git status -uno
c) git status -umtime
d) git status -uwatchman

We know that a) and b) already exist.
c) Can be convenient to have, in order to do benchmarking and testing.
  When the UNTR extension is not found, Git can give an error,
  saying something like this:
  No mtime information found, use "git update-index --untracked-cache"
d) does not yet exist

Of course we may want to configure the default for "git status" in a default variable,
like status.findUntrackedFiles, which can be empty "", "mtime" or "watchman",
and we may add other backends later.

A short test showed that watchman compiles under Mac OS.
The patch did not compile out of the box (both Git and watchman declare
there own version of usage(), some C99 complaints from the compiler in watchman,
nothing that can not be fixed easily)


I will test the mtime patch under networked file systems the next weeks.


The short version:
Go with c), d) then 5) until we have something better :-) 
