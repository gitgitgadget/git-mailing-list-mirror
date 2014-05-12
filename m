From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Mon, 12 May 2014 17:45:42 +0700
Message-ID: <CACsJy8C_j2bKVwqOQtOqGFkc_-_AmY=bQXquRfL-aqk=z9YKdw@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
 <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
 <1399747109.11843.137.camel@stross> <CACsJy8Cazm+6ixw3r8WYfdFYeD01Lmf0PSF0sdsh7PGy_6WDTQ@mail.gmail.com>
 <1399848982.11843.161.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 12 12:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjnkV-0006Wa-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 12:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbaELKqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 06:46:14 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:34161 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaELKqN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 06:46:13 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so7621337qcq.15
        for <git@vger.kernel.org>; Mon, 12 May 2014 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/+avnIjPww3lxlqaSwdxpTT8JF+eeB+TPW3CDlMx0KU=;
        b=XSEBbkX81QIn9d+r06vSDzZ697npZfKktNzIvxY7ZB4EQ6Va3y16yrn8RZ6jOAbl0R
         3slIFu/9OW0i5xvv401EY5lq15UTa7AlNNggB1i7lz7BLLtEhxsngT/gHERHjc/fxLOP
         o2pk0aSIH4TGvDpMFKzVgMz+1H/JVl8IYGt9KB5TXcFTwz7CZu/SmgYUy2xg+qL3m0/2
         GT+DNmE2ZjN2A/WazPf5cRumJInXQmQx0ns0uyDzB2UUknqLirm91fm2s6OxUAGnyFEp
         zzT62Bze7HGZLKQTu+cuuVBt3GQoA63suktyLxKyjjgC4hryjjjze8jrDxijB39UqGV3
         uaNw==
X-Received: by 10.140.107.198 with SMTP id h64mr33979755qgf.30.1399891572577;
 Mon, 12 May 2014 03:46:12 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 12 May 2014 03:45:42 -0700 (PDT)
In-Reply-To: <1399848982.11843.161.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248696>

On Mon, May 12, 2014 at 5:56 AM, David Turner <dturner@twopensource.com> wrote:
>> So without watchman I got
>>
>>    299.871ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
>>    498.205ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
>>    796.050ms wt_status_collect:622 wt_status_collect_untracked(s)
>>
>> and with watchman ("git status" ran several times to make sure it's cached)
>>
>>    301.950ms read_index_from:1538 if (verify_hdr(hdr, mmap_size) < 0) go
>>     34.918ms  read_fs_cache:347 if (verify_hdr(hdr, mmap_size) < 0) go
>>   1564.096ms  watchman_load_fs_cache:628 update_fs_cache(istate, result);
>>    161.930ms cmd_status:1300 refresh_index(&the_index, REFRESH_QUIE
>>    251.614ms wt_status_collect:622 wt_status_collect_untracked(s)
>>
>> Given the total time of "git status" without watchman is 1.9s,,
>> update_fs_cache() nearly matches that number alone. All that is spent
>> in the exclude update code in the function, but if you do
>> last_excluding_matching() anyway, why cache it?
>
> My numbers are different (for my test repository):
>
> ---
>     30.031ms read_index:1386 r = read_index_from(istate, get_index_
>     71.625ms cmd_status:1302 refresh_index(&the_index, REFRESH_QUIE
>    259.712ms wt_status_collect:622 wt_status_collect_untracked(s)
> ----
>     41.110ms read_index:1386 r = read_index_from(istate, get_index_
>      9.294ms read_fs_cache:347 if (verify_hdr(hdr, mmap_size) < 0) go
>      0.173ms watchman_load_fs_cache:628 update_fs_cache(istate, result)
>     41.901ms read_index:1386 r = read_index_from(istate, get_index_
>     18.355ms cmd_status:1302 refresh_index(&the_index, REFRESH_QUIE
>     50.911ms wt_status_collect:622 wt_status_collect_untracked(s)
> ---
>
> I think something must be going wrong with update_fs_cache on your
> machine.  I have a few hypotheses:
>
> 1. Maybe watchman isn't fully started up when you run your tests.
> 2. Maybe there is a bug.

It's probably me doing something wrong (I ran it more than a couple
times so watchman must have loaded the whole thing). I got small
numbers in update_fs_cache() now.

>> A bit surprised about wt_status_collect_untracked number. I verified
>> that last_excluding_matching() still runs (on the same number of
>> entries like in no-watchman case). Replacing fs_cache_open() in
>> add_excludes_from_file_to_list() to plain open() does not change the
>> number, so we probably won't need that (unless your worktree is filled
>> with .gitignore, which I doubt it's a norm).
>
> My test repo has a couple hundred of them.  Maybe that's unusual?  A
> repo with a lot of projects will tend to have lots of gitignore files,
> because each project will want to maintain them independently.

I tried the worst case, every directory had an empty .gitignore. The
numbers did not change much. And I found out that because
add_excludes.. were called twice, not on every .gitignore because of
the condition "!(dir->flags & DIR_EXCLUDE_CMDL_ONLY)". So the number
of .gitignore does not matter (yet).

This is your quote from above, moved down a bit:

> update_fs_cache should only have to update based on what it has learned
> from watchman.  So if no .gitignore has been changed, it should not have
> to do very much work.
>
> I could take the fe_excluded check and move it above the
> last_exclude_matching check in fs_cache_is_excluded; it causes t7300 to
> fail when run under watchman but presumably that's fixable

So you exclude files early and make the real read_directory() pass do
pretty much nothing. This is probably not a good idea. Assume that I
touch $TOP/.gitignore then do something other than "git status" (or
"git add") then I have to pay read_directory() cost.

Back to the open vs fs_cache_open and the number of .gitignore files
above. I touch $TOP/.gitignore then do "git status" to make it read
all .gitignore files (6k of them) and change between open and
fs_cache_open. I think the numbers still  do not make any visible
difference (~1620-1630ms).
-- 
Duy
