From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 17:58:11 +0100
Message-ID: <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4aFP-000735-Lp
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 17:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425Ab3BJQ6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 11:58:52 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:58687 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316Ab3BJQ6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 11:58:52 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so5667467iaj.20
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 08:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7vLfiSvvZaxSyxx3S/UbDFFbAuDuQEGU7ANiDTq5z54=;
        b=j40N16WLcAjLzrev5niGOl27TsmpYA1mQzU6DIiCzUgh6rUTt55htorux9FKjJDGil
         G6GUu1eWZQJ/1EjrCtENhqA0/O5aF29DMDB0ePHHI2L1hVostU02RXQXlwusnE6GT7C3
         MT+QLqhfYFXRpPy49NGfKBfDx98ku4r/dxBS/hI2g8XoudWm1IbH26kuzs1vXOlWKdGQ
         B2kT8mpyxXDTsDlV47mgUcPjqzXxo8aSzp1Nsp9OnUhWvUahjOrj71YHQlrw8TlrF+Ip
         uBpskO7fxA2M9/JghBMCEUQD3g8b0LMoOAEKCngnYqzZK2vmnogR1JcxnrHb+Djmv8x1
         aboA==
X-Received: by 10.50.88.228 with SMTP id bj4mr9880396igb.85.1360515531348;
 Sun, 10 Feb 2013 08:58:51 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Sun, 10 Feb 2013 08:58:11 -0800 (PST)
In-Reply-To: <20130210111732.GA24377@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215925>

On Sun, Feb 10, 2013 at 12:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Feb 10, 2013 at 12:24:58PM +0700, Duy Nguyen wrote:
>> On Sun, Feb 10, 2013 at 12:10 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>> > Finn notes in the commit message that it offers no speedup, because
>> > .gitignore files in every directory still have to be read.  I think
>> > this is silly: we really should be caching .gitignore, and touching it
>> > only when lstat() reports that the file has changed.
>> >
>> > ...
>> >
>> > Really, the elephant in the room right now seems to be .gitignore.
>> > Until that is fixed, there is really no use of writing this inotify
>> > daemon, no?  Can someone enlighten me on how exactly .gitignore files
>> > are processed?
>>
>> .gitignore is a different issue. I think it's mainly used with
>> read_directory/fill_directory to collect ignored files (or not-ignored
>> files). And it's not always used (well, status and add does, but diff
>> should not). I think wee need to measure how much mass lstat
>> elimination gains us (especially on big repos) and how much
>> .gitignore/.gitattributes caching does.
>
> OK let's count. I start with a "standard" repository, linux-2.6. This
> is the number from strace -T on "git status" (*). The first column is
> accumulated time, the second the number of syscalls.
>
> top syscalls sorted     top syscalls sorted
> by acc. time            by number
> ----------------------------------------------
> 0.401906 40950 lstat    0.401906 40950 lstat
> 0.190484 5343 getdents  0.150055 5374 open
> 0.150055 5374 open      0.190484 5343 getdents
> 0.074843 2806 close     0.074843 2806 close
> 0.003216 157 read       0.003216 157 read
>
> The following patch pretends every entry is uptodate without
> lstat. With the patch, we can see refresh code is the cause of mass
> lstat, as lstat disappears:
>
> 0.185347 5343 getdents  0.144173 5374 open
> 0.144173 5374 open      0.185347 5343 getdents
> 0.071844 2806 close     0.071844 2806 close
> 0.004918 135 brk        0.003378 157 read
> 0.003378 157 read       0.004918 135 brk
>
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index 827ae55..94d8ed8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1018,6 +1018,10 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>         if (ce_uptodate(ce))
>                 return ce;
>
> +#if 1
> +       ce_mark_uptodate(ce);
> +       return ce;
> +#endif
>         /*
>          * CE_VALID or CE_SKIP_WORKTREE means the user promised us
>          * that the change to the work tree does not matter and told
> -- 8< --
>
> The following patch eliminates untracked search code. As we can see,
> open+getdents also disappears with this patch:
>
> 0.462909 40950 lstat   0.462909 40950 lstat
> 0.003417 129 brk       0.003417 129 brk
> 0.000762 53 read       0.000762 53 read
> 0.000720 36 open       0.000720 36 open
> 0.000544 12 munmap     0.000454 33 close
>
> So from syscalls point of view, we know what code issues most of
> them. Let's see how much time we gain be these patches, which is an
> approximate of the gain by inotify support. This time I measure on
> gentoo-x86.git [1] because this one has really big worktree (100k
> files)
>
>         unmodified  read-cache.c  dir.c     both
> real    0m0.550s    0m0.479s      0m0.287s  0m0.213s
> user    0m0.305s    0m0.315s      0m0.201s  0m0.182s
> sys     0m0.240s    0m0.157s      0m0.084s  0m0.030s
>
> and the syscall picture on gentoo-x86.git:
>
> 1.106615 101942 lstat    1.106615 101942 lstat
> 0.667235 47083 getdents  0.641604 47114 open
> 0.641604 47114 open      0.667235 47083 getdents
> 0.286711 23573 close     0.286711 23573 close
> 0.005842 350 brk         0.005842 350 brk
>
> We can see that shortcuting untracked code gives bigger gain than
> index refresh code. So I have to agree that .gitignore may be the big
> elephant in this particular case.
>
> Bear in mind though this is Linux, where lstat is fast. On systems
> with slow lstat, these timings could look very different due to the
> large number of lstat calls compared to open+getdents. I really like
> to see similar numbers on Windows.

Karsten Blees has done something similar-ish on Windows, and he posted
the results here:

https://groups.google.com/forum/#!topic/msysgit/fL_jykUmUNE/discussion

I also seem to remember he doing a ReadDirectoryChangesW version, but
I don't remember what happened with that.
