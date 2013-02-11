From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 18:12:38 +0700
Message-ID: <CACsJy8B3rOROJ2HoQ0iLjfvxfcEGjJgP7MH0yhq+8Gjnm-EGAg@mail.gmail.com>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
 <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 12:13:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4rKL-0005nQ-4H
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 12:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab3BKLNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 06:13:11 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48595 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237Ab3BKLNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 06:13:09 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so6005782obb.0
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 03:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oOOunbvLGy3ndJSw9q+3PO6JvnH2dAnXSumCQp28q2c=;
        b=JFmk9z00MipnC+tqjbXknB7MNA5wkDjp3wDTPXe1uZmGt3rX3j9pAhVLB2arPwK8sk
         yvjZw2OKLg+pvCG/bD7DrA0ft3H5WdA6kP2+4XBHj1TzRdyxKoU2yRz177/BJKbL6IR4
         dXrs/E9sUj4GSbCCZXVpIEFOwBIdPf4PFXr30vJZbvIR9iYhbags4xEnphoWr4+K42V/
         R5neGJWrITwUr+s0Mtlt375/mrrW8Sb1Ipq/DLHaxF84KDp2vP+Tjm7H4yi+K+YFYFBS
         1LrVAiaRhKvc9vsvSSGkRYAxOTTIqcwi6K6ow5Vo4Fg9gtJUS/1jqBa18qX1Kp+458sJ
         /LiQ==
X-Received: by 10.182.89.36 with SMTP id bl4mr10441189obb.22.1360581188959;
 Mon, 11 Feb 2013 03:13:08 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 11 Feb 2013 03:12:38 -0800 (PST)
In-Reply-To: <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216029>

On Mon, Feb 11, 2013 at 9:56 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Yeah, it did not cut out syscall cost, I also cut a lot of user-space
> processing (plus .gitignore content access). From the timings I posted
> earlier,
>
>>         unmodified  dir.c
>> real    0m0.550s    0m0.287s
>> user    0m0.305s    0m0.201s
>> sys     0m0.240s    0m0.084s
>
> sys time is reduced from 0.24s to 0.08s, so readdir+opendir definitely
> has something to do with it (and perhaps reading .gitignore). But it
> also reduces user time from 0.305 to 0.201s. I don't think avoiding
> readdir+openddir will bring us this gain. It's probably the cost of
> matching .gitignore. I'll try to replace opendir+readdir with a
> no-syscall version. At this point "untracked caching" sounds more
> feasible (and less complex) than ".gitignore cachine".

And this is read_directory's timing breakdown (again, "git status" on
gentoo-x86,git, built with -O2 on x86-64 if I did not mention before)

opendir   = 0.030s
readdir   = 0.083s
closedir  = 0.020s
{open,read,close}dir = 0.132s
treat_path           = 0.094s (172534 times)
dir_add_name         = 0.050s (101917 times)
read_directory       = 0.292s
# On branch master
nothing to commit, working directory clean

real    0m0.511s
user    0m0.347s
sys     0m0.157s

Instrumentation is done with gettimeofday. Without gettimeofday calls
inside read_directory_recursive, read_directory takes 0.267s (iow,
gettimeofday cost is about 0.30s). {open,read,close}dir + treat_path +
dir_add_name + gettimeofday add up quite close to 0.292s (strbuf_*
takes just about 0.005s)

Eliminating xxxdir syscalls may save us 0.132s (or less, we need to
pay to get the information elsewhere).

Because my worktree is clean, dir_add_name spends all 0.05s in
cache_name_exists(). If we somehow know the input path is not a
tracked entry, we could avoid cache_name_exists() and save 0.05s.

If we do the "untracked cache", the number of treat_path calls should
be much lower. In this particular case of gentoo-x86, I'd expect no
more than a dozen of untracked files, which cuts down treat_path and
dir_add_name's time to near zero. On a normal repository like git.git,
untracked files are about 1075 files with 2552 tracked files, we
should be able to save 2/3 to 1/2 of treat_path calls.
-- 
Duy
