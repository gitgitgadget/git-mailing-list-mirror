From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 22:15:41 +0530
Message-ID: <CALkWK0kLieAfPihX3j=BzD+ndo-g-2210Za2xN=HbHcRVwgMtA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4a2v-0008Kq-3D
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 17:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab3BJQqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 11:46:04 -0500
Received: from mail-ia0-f170.google.com ([209.85.210.170]:45536 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3BJQqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 11:46:02 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so5801297iak.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=o8n8qhCx9oUk6iPyTnD4USZF5VGKfG+bXzBjbT1bSo0=;
        b=G85GLgonYT88Exe4MpdQrtg9ya5BgSoffs3xmBlgzfm+QLo/CDVUzBRLYTRwNiNBaV
         sladK0dQ9WWhBtP5f5aWUkVAdW/+dhlppu3dF1mE+leDRvD4+atbwnslOZOMykwnC06K
         Vhr6UKdiwLrW/74cbUQCxEGzcD43JGPLRTN12ahoU9PWPM+QbACNz70AHDDDOjkUCPMg
         fUNCOO42W1ZcRh/N+D50t8QLSsFbTfqti6HO+TUhkJ13HOenspnCcPrtdLlotvECfNBr
         8V8oK/rjEFDUw5YfEmKiCLJX2BwVO5XVF02vK71K49TfHFxtZtumol/q5snjzauSTprg
         iQNQ==
X-Received: by 10.50.189.163 with SMTP id gj3mr9973953igc.14.1360514761700;
 Sun, 10 Feb 2013 08:46:01 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Sun, 10 Feb 2013 08:45:41 -0800 (PST)
In-Reply-To: <20130210111732.GA24377@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215924>

On Sun, Feb 10, 2013 at 4:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
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

Okay, we're saving 40k lstat() calls.

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

So you're skipping the rest of refresh_cache_ent(), which contains our
lstat() and returning immediately.  Instead of marking paths with the
"assume unchanged" bit, as core.ignoreStat does, you're directly
attacking the function that refreshes the index and bypassing the
lstat() call.  How are they different?  read-cache.c:1030 checks
ce->flags & CE_VALID (which is set in read-cache.c:88 if
assume_unchanged) and bypasses the lstat() call anyway.  So why didn't
you just set core.ignoreStat for your test?

> The following patch eliminates untracked search code. As we can see,
> open+getdents also disappears with this patch:
>
> 0.462909 40950 lstat   0.462909 40950 lstat
> 0.003417 129 brk       0.003417 129 brk
> 0.000762 53 read       0.000762 53 read
> 0.000720 36 open       0.000720 36 open
> 0.000544 12 munmap     0.000454 33 close

Okay, 5k open and 5k getdents calls are gone, but what does this mean?

Pulling the patch from your next email to figure this out:
> -- 8< --
> diff --git a/dir.c b/dir.c
> index 57394e4..1963c6f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1439,8 +1439,10 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const char
>                 return dir->nr;
>
>         simplify = create_simplify(pathspec);
> +#if 0
>         if (!len || treat_leading_path(dir, path, len, simplify))
>                 read_directory_recursive(dir, path, len, 0, simplify);
> +#endif
>         free_simplify(simplify);
>         qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
>         qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
> -- 8< --

Ah, read_directory(), from the .gitignore/ exclude angle.  Yes,
read_directory() seems to be the main culprit there, from my reading
of Documentation/technical/api-directory-listing.txt.

So, what did you do?  You short-circuited the function into never
executing read_directory_recursive(), so the opendir() and readdir()
are gone.  I'm confused about what this means: will new directories
fail to appear as "untracked" now?  Either way, I understand that
you've factored out the .gitignore/ excludes.  Let's look at the
timings now.

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

So, the .gitignore/ exclude does seem to be the elephant in the room,
after all!  There are only minor gains from not updating the index.

> and the syscall picture on gentoo-x86.git:
>
> 1.106615 101942 lstat    1.106615 101942 lstat
> 0.667235 47083 getdents  0.641604 47114 open
> 0.641604 47114 open      0.667235 47083 getdents
> 0.286711 23573 close     0.286711 23573 close
> 0.005842 350 brk         0.005842 350 brk

The lstat to getdents/ open is higher than in linux-2.6.git here, but
the profit in eliminating lstat is still very small.

> We can see that shortcuting untracked code gives bigger gain than
> index refresh code. So I have to agree that .gitignore may be the big
> elephant in this particular case.

Yes :)

> Bear in mind though this is Linux, where lstat is fast. On systems
> with slow lstat, these timings could look very different due to the
> large number of lstat calls compared to open+getdents. I really like
> to see similar numbers on Windows.

I see.

> read_directory/fill_directory code is mostly used by "git add" (not
> with -u) and "git status", while refresh code is executed in add,
> checkout, commit/status, diff, merge. So while smaller gain, reducing
> lstat calls could benefit in more cases.

Good point, although my major complaint with big repositories is
status and diff.  Checkout isn't too bad if the branches don't diverge
much, add is fast enough, but diff is a big problem.

> A relatively slow "git add" is acceptable. "git status" should be
> fast. Although in my workflow, I do "git diff [--stat] [--cached]"
> much more often than "git status" so relatively slow "git status" does
> not hurt me much. But people may do it differently.

Hm.

> On speeding up read_directory with inotify support. I haven't thought
> it through, but I think we could save (or get it via socket) a list of
> untracked files in .git, regardless ignore status, with the help from
> inotify. When this list is verified valid, read_directory could be
> modified to traverse the tree using this list (plus the index) instead
> of opendir+readdir. Not sure how the change might look though.

We could even tell if .gitignore has changed with inotify support, and
tell exactly when we need to update our path treatment.  And yes, we
can have inotify to tell us about new files and directories directly,
so we can traverse them.  I think we should go ahead with the
system-wide inotify daemon for now: its design needs to be discussed,
so that it's generic enough for all our usecases.  I'm thinking there
should be atleast two distinct calls to:
1. Report all changed paths, for use with read-cache.c.
2. Report only new paths, for use with dir.c.
Or can we figure out which of the changed paths are new ourselves?

Kudos to your great work on getting getting these numbers, Duy!
