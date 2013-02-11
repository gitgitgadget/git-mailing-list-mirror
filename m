From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 09:56:27 +0700
Message-ID: <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh> <7vhaljudos.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4ja7-0000S6-P4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 03:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab3BKC47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 21:56:59 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47714 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3BKC46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 21:56:58 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so5691115obb.17
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 18:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ox0FY1qP92FAHHPzowIRXlLzx3G1ZOheo1f3U66dnrE=;
        b=sGQDTF/J/yuZm6gwi5HFwZVT5GVkk9ca8JHYZdh9ji9jQUUXHgBT4Ck/gU0nR89Tz1
         LB1VJttxcO17CCl4f1VyJEq2pmpVTaAawVk5GPUzF2+cQwTnwpVYbsFUDKUv+zwAu+np
         mEPMlwiCeMwzZ2RqJKYAa4pjQUfiDOjozc3H3MQlNZcbHBb6xGNpOqEhc+h2CC+LMOQm
         Z2vGgMcIqcet77S5NlTkuyKiviev/MH24T+KGNG4YZEYRpqweHIexU7WdxOxbtr9t7rf
         3hdi8HxgY0VaVUSwohi3evyzCbgWo9n1j8QXMrzxrx4TaGSn4w4xpfOStLpn6b2Mjb6E
         dfJw==
X-Received: by 10.182.39.69 with SMTP id n5mr9797445obk.72.1360551417718; Sun,
 10 Feb 2013 18:56:57 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 10 Feb 2013 18:56:27 -0800 (PST)
In-Reply-To: <7vhaljudos.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215977>

On Mon, Feb 11, 2013 at 3:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The other "lstat()" experiment was a very interesting one, but this
> is not yet an interesting experiment to see where in the "ignore"
> codepath we are spending times.
>
> We know that we can tell wt_status_collect_untracked() not to bother
> with the untracked or ignored files with !s->show_untracked_files
> already, but I think the more interesting question is if we can show
> the untracked files with less overhead.
>
> If we want to show untrackedd files, it is a given that we need to
> read directories to see what paths there are on the filesystem. Is
> the opendir/readdir cost dominating in the process? Are we spending
> a lot of time sifting the result of opendir/readdir via the ignore
> mechanism? Is reading the "ignore" files costing us much to prime
> the ignore mechanism?
>
> If readdir cost is dominant, then that makes "cache gitignore" a
> nonsense proposition, I think.  If you really want to "cache"
> something, you need to have somebody (i.e. a daemon) who constantly
> keeps an eye on the filesystem changes and can respond with the up
> to date result directly to fill_directory().  I somehow doubt that
> it is a direction we would want to go in, though.

Yeah, it did not cut out syscall cost, I also cut a lot of user-space
processing (plus .gitignore content access). From the timings I posted
earlier,

>         unmodified  dir.c
> real    0m0.550s    0m0.287s
> user    0m0.305s    0m0.201s
> sys     0m0.240s    0m0.084s

sys time is reduced from 0.24s to 0.08s, so readdir+opendir definitely
has something to do with it (and perhaps reading .gitignore). But it
also reduces user time from 0.305 to 0.201s. I don't think avoiding
readdir+openddir will bring us this gain. It's probably the cost of
matching .gitignore. I'll try to replace opendir+readdir with a
no-syscall version. At this point "untracked caching" sounds more
feasible (and less complex) than ".gitignore cachine".
-- 
Duy
