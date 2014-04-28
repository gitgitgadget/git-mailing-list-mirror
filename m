From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Sleep 1 millisecond in poll() to avoid busy wait
Date: Mon, 28 Apr 2014 11:07:24 +0200
Message-ID: <CABPQNSaC30p7TEOvc85u=+skjrFj17182vWWSL=QNVuvzVFE=w@mail.gmail.com>
References: <20140428083931.GA10257@camelia.ucw.cz>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	theoleblond <theodore.leblond@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehXo-0003hx-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbaD1JIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:08:07 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:40761 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbaD1JIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:08:05 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so4532598igb.5
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=824CjqLmaf6qKSkjZwjLilMXpdd2o67zrEKgbrLo/R4=;
        b=qYXHJzYau9jn5HSEDB4pLuWy3okThJnWZ9LtwMCcp8/CA0REtu6jgzgJhl0oaQT7+d
         hHRKAdVIKmpN+R1B+3kSbtL+zHAi8xaH7VWIbe+litH3dljyPETi5uCKLr1zWPv8i6bX
         O1vOsVzVBDSUYuTiEFcoAUpRU+R0cDnj3ViZV9OweRj3guoTxjJywP1vB2yq/0DwN6AT
         PCHPya+gYnD9Wv8FENcvy2l3IRl+UwLUd3NVn50RDH/z+sFblXXtgVe48xQaPImCRHVt
         prxHlC3sV+4R3/9z3TFhVfQ3Pb3zopD/02G4c8HvxzIOf1ukqho+Z15yV7JF4ZXulOb5
         vwLg==
X-Received: by 10.50.85.18 with SMTP id d18mr22200119igz.42.1398676084622;
 Mon, 28 Apr 2014 02:08:04 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 02:07:24 -0700 (PDT)
In-Reply-To: <20140428083931.GA10257@camelia.ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247255>

On Mon, Apr 28, 2014 at 10:39 AM, Stepan Kasal <kasal@ucw.cz> wrote:
> From: theoleblond <theodore.leblond@gmail.com>
> Date: Wed, 16 May 2012 06:52:49 -0700
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
> This is one of the patches that lives in msysGit, could it be
> accepted upstream?
> It modifies the Windows compat function only.

compat/poll/poll.c comes from Gnulib, so it would be better to submit
the patch there and update.
