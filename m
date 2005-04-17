From: Mike Taht <mike.taht@timesys.com>
Subject: Re: [PATCH] libgit
Date: Sun, 17 Apr 2005 01:08:51 -0700
Message-ID: <42621993.10800@timesys.com>
References: <Pine.LNX.4.44.0504170027500.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:05:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4mR-0008S9-IZ
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDQIJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVDQIJE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:09:04 -0400
Received: from mail.timesys.com ([65.117.135.102]:17040 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261279AbVDQII5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 04:08:57 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 17 Apr 2005 04:04:16 -0400
X-Accept-Language: en-us, en
To: Brad Roberts <braddr@puremagic.com>
In-Reply-To: <Pine.LNX.4.44.0504170027500.2625-100000@bellevue.puremagic.com>
X-OriginalArrivalTime: 17 Apr 2005 08:04:16.0578 (UTC) FILETIME=[0CFDF220:01C54324]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Brad Roberts wrote:
>>Converted git to libgit. Moved all the main() calls into a single
>>multi-call binary - git-main.
>>Made extern a bunch of functions that were static. Verified it at least
>>still minimally worked.
>>Note: this is only a first step towards creating a generic library.
>>Figuring out what functions and variables *truly* need to be exported,
>>renaming them to a git_<function> api, making it thread safe
>>... and not least of all, keeping up with everybody working out of the
>>base tree... are problems that remain. Also - cleaning up the UI.
> 
> 
> Why do all that static and main rearrangement?  It would be a lot simpler
> and cleaner to simply rename the main's in place and add the new
> dispatcher by itself.

0) I like multi-call binaries.

1) I wanted to get a first pass at what functions needed to be exported, 
and pulling out the mains was the fastest way to see what might be  needed.

2) Agreed, about half of git-main.c needs to move back into the 
libraries, but that depends on deciding on the API for the formentioned 
functions... and leaving the mains parsing argv in the library itself 
seemed silly. So I moved them out. See 1)

In particular gotta chose the prefix itself git_<function> or 
cg_<_function> or cogito_<function>. I lean towards git_ myself - 
it'short and unique-looking, though I haven't verified that

When the useful to export functions are clearly identified they have to 
become named thus.

3) I'd really like to commonalize the UI and use longopts for the 
argument parsing. Linus indicated a preference for a certain argument 
order, longopts doesn't do that.

4) Like to make git thread safe (and ultimately, thread using - parallel 
diff, merge, fsck) and that means eliminating the globals, where 
appropriate. I've been thinking through the issues there (how about 
(GIT_THREAD)->some_variable and (GIT-GLOBAL)->some_variable where those 
define out when threads are disabled? Etc. There needs to be a git_init 
that does things like correctly and universally setting up the defaults, 
and atexit, etc, file locking needs to fixed...

5) I wanted to get something that still compiled, worked, and out for 
comment before I went to bed. :)

my current plan is to break out git.h back into it's subject 
"update-cache.h" etc, move all that into include/git, turn git.h into a 
master lazy man's include, come up with a scheme for the globals, get 
some sort of thread cleanliness and take a crack at making it shared.

and now to bed. All: Feel free to implement any of that....

> 
> Later,
> Brad
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 

Mike Taht


   "If you wait long enough, it will go away... after having done its 
damage.
If it was bad, it will be back."
