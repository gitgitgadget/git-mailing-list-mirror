From: Tamas Csabina <tcsabina@gmail.com>
Subject: Re: slow process of post-receive script on a remote (samba) share
Date: Fri, 14 Jun 2013 15:06:46 +0200
Message-ID: <CAH+Cn15buFMaf8Lp_vAmMBfUFqkctSjFvJ3Z748qf1pLUe-40w@mail.gmail.com>
References: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
	<87li6eqk2a.fsf@linux-k42r.v.cablecom.net>
	<CAH+Cn14neoV9eXqBAj6_MPXTXK00S=-MnBYs20gaBLZ7YjL00Q@mail.gmail.com>
	<87txl2jd8k.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTiO-0004HS-1C
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab3FNNGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:06:48 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64141 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3FNNGr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:06:47 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so571306obc.20
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GAosH35LYRZ4/Wrei/UCdlHXfsxiVigkwx2dkJdQmW8=;
        b=WGuTPN/oVHO4gycA2sblog4PbBdNCeOINEKNH0hHmIDLbMKFN36ZNpJi3y44WJVEWo
         1j+cW0nblQ0+ZmrRdCfFFKHialSJlL/T81pKR1Ye6WpYEbn6zGna/12NtQv3RqpMSI3Q
         4q1T0hQVM2XFiorV6igSQ3eKFXP8R+F67LoMM+kYJdsVGtxbJrWBEv50jsYsEyRRBQWp
         yceYFs3NUk8TEyvMbKyGoxLjJCEGVKZD9YflLKl28uonTAN8Neagj5OMIEOkTrls4Y2v
         CWrtVwzqzZvGcAqulI54lWO5gKnWgOsyqj0DIxSC/Xpk3LWuw9I7J5cMbdAcnaktJ4gy
         QNBQ==
X-Received: by 10.60.98.134 with SMTP id ei6mr1456874oeb.21.1371215206712;
 Fri, 14 Jun 2013 06:06:46 -0700 (PDT)
Received: by 10.76.110.71 with HTTP; Fri, 14 Jun 2013 06:06:46 -0700 (PDT)
In-Reply-To: <87txl2jd8k.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227822>

Thanks for the follow up ideas.

We also decided to access the repos through ssh. With that, there is
no delay at all.


Regards,
Tamas



On 13 June 2013 16:29, Thomas Rast <trast@inf.ethz.ch> wrote:
> Tamas Csabina <tcsabina@gmail.com> writes:
>
>> Meanwhile I`ve figured it out that the sluggish post-receive execution
>> was due to a (mis)-configuration in the samba share where the remote
>> repository is hosted. These are:
>> oplocks = No
>> level2 oplocks = No
> [...]
>> Now, do I have to worry about allowing oplocks on the remote
>> repository from the git point of view? Thinking about concurrent push
>> operations from different developers?
>
> From a brief glance at the relevant docs [1], it would seem that oplocks
> are actually just an implementation detail for safe (in the context of
> parallel access) client caching.  So they should be fully transparent to
> any application usage.  However, the docs do mention that you may be in
> trouble if the connection to the server times out.
>
> That being said, some FSes see more usage and thus have been tested more
> in this context, and git does tend to show some pretty weird issues on
> broken network FSes (one such case: Lustre[2]).
>
> In addition, there are some known races w.r.t. the handling of refs, and
> of pruning, if you run git-gc while concurrent pushes are going on.
> Jeff King and Michael Haggerty are currently working on getting them
> fixed, see e.g. [3].  To see these, you'll have to hit the repo much
> harder than a small team can.
>
> So it *should* work, at least if you disable gc.auto and run git-gc
> manually at some safe time.  But I wouldn't be surprised if there are
> bugs lurking in the context of Windows usage on a Samba-hosted repo,
> which sounds like a very rare combination.
>
> And in any case, don't take my word for it; if your life or company
> depends on this, you'll need to do your own testing to ensure that it
> holds up.
>
>
> Oh, and why do it that way?  You would most likely get much better
> performance out of it if you hosted the repo over ssh (e.g. with
> gitolite[4]) or a smart-http server, since the expensive operations (and
> they are *expensive*) would be completely local to the server.  The
> tradeoff there is that it also shifts a lot of CPU work to the server,
> but if you can afford it, you should see a great speedup especially when
> fetching large amounts of data (e.g. at cloen time).
>
>
>
> [1]  http://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/locking.html#id2615667
>
> [2]  http://thread.gmane.org/gmane.comp.version-control.git/212109
>
> [3]  http://thread.gmane.org/gmane.comp.version-control.git/223299
>
> [4]  http://gitolite.com/gitolite/
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
