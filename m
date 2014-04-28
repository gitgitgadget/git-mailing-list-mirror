From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 17:37:37 +0200
Message-ID: <CABPQNSbpyFzg8A8gLp2nJZeTRSLSb0Qs8ytZDsJLmi6VyER71Q@mail.gmail.com>
References: <20140428083931.GA10257@camelia.ucw.cz> <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
 <20140428113815.GA10559@camelia.ucw.cz> <20140428114224.GA11186@camelia.ucw.cz>
 <CABPQNSbDkE+Vff=4MmPO9oMfjRay6Oin51zZRoZ8mOEhGoaD3Q@mail.gmail.com>
 <535E6E4B.6070308@viscovery.net> <20140428153527.GB12357@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Theodore Leblond <theodore.leblond@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:38:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WendV-0003ys-SA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbaD1PiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:38:20 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:55284 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbaD1PiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:38:17 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so6774421iec.37
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uz1KLPFdGMD12E3rOKmtM8cItWHY5nyYfvctOgZuEA0=;
        b=dKnBMj78NJBeHtT2mkaK75hR5d2RjLjerRWDLmrfv/xeZgAFKY3gCqspSwW1iGqnkd
         joPK7AM1dohaWDcBjauHvOhabwOJhq8IkxSLke4j+ri+1UhK2pFtmDUdLN5Nz71f0Sbk
         Oy9jsbuB89S6rh76itsKBIkwAf2FsoDqMX9CURkEHUwPepGHrfr/oXTECvuDV6xfpuY+
         c786FsNnITfKZ9I7yocVDY7A+3gKBibMU+Kv7KwCFlbbROyeC36/BkGPcZ0oQ7Qq90xs
         rR7zxUovUSj+P3SaYoNyApDwthJm0A9r+1YPB4N4q+GhpQQpBkw8ihO2egCiEyEHUVWO
         SrPg==
X-Received: by 10.50.85.37 with SMTP id e5mr24854588igz.43.1398699497256; Mon,
 28 Apr 2014 08:38:17 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:37:37 -0700 (PDT)
In-Reply-To: <20140428153527.GB12357@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247368>

On Mon, Apr 28, 2014 at 5:35 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: theoleblond <theodore.leblond@gmail.com>
> Date: Wed, 16 May 2012 06:52:49 -0700
>
> SwitchToThread() only gives away the rest of the current time slice
> to another thread in the current process. So if the thread that feeds
> the file decscriptor we're polling is not in the current process, we
> get busy-waiting.
>
> I played around with this quite a bit. After trying some more complex
> schemes, I found that what worked best is to just sleep 1 millisecond
> between iterations. Though it's a very short time, it still completely
> eliminates the busy wait condition, without hurting perf.
>
> There code uses SleepEx(1, TRUE) to sleep. See this page for a good
> discussion of why that is better than calling SwitchToThread, which
> is what was used previously:
> http://stackoverflow.com/questions/1383943/switchtothread-vs-sleep1
>
> Note that calling SleepEx(0, TRUE) does *not* solve the busy wait.
>
> The most striking case was when testing on a UNC share with a large repo,
> on a single CPU machine. Without the fix, it took 4 minutes 15 seconds,
> and with the fix it took just 1:08! I think it's because git-upload-pack's
> busy wait was eating the CPU away from the git process that's doing the
> real work. With multi-proc, the timing is not much different, but tons of
> CPU time is still wasted, which can be a killer on a server that needs to
> do bunch of other things.
>
> I also tested the very fast local case, and didn't see any measurable
> difference. On a big repo with 4500 files, the upload-pack took about 2
> seconds with and without the fix.
> ---
>
> On Mon, Apr 28, 2014 at 05:05:47PM +0200, Johannes Sixt wrote:
>> [...] but I very much prefer the commit message of the earlier post.
>
> ... but Paolo had a nice short description of the issue there;
> I inserted that to the top of the earlier commit message.
>
> The latter diff (without the comment), gets us closer to gnulib's poll.c.
>

Good stuff!
