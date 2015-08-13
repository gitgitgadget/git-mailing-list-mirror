From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH 1/2 v4] worktree: add 'for_each_worktree' function
Date: Thu, 13 Aug 2015 19:32:09 -0400
Message-ID: <CANoM8SUGHzH-YjB9yK-juoX0S9zyUk=QhCK5JUqiQiqwOwwqJg@mail.gmail.com>
References: <1439490739-9361-1-git-send-email-rappazzo@gmail.com>
 <1439490739-9361-2-git-send-email-rappazzo@gmail.com> <1439493795.8855.16.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 01:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQ1z8-0002bo-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 01:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbbHMXca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 19:32:30 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34073 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405AbbHMXc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 19:32:29 -0400
Received: by obbfr1 with SMTP id fr1so49414085obb.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6qIyt2xSHEdiYcd9m880NqmhyW3JuP4EpUQSMZaE1eg=;
        b=xdg28JyUlhse2jAz7Sh+JObuAcqUUBUIrKY4OftVl6hnUuMbbdWlkSFZJ8tidlPZ0M
         NgYBJ59yagrQt+Z1/TLdOAepx78RTHn81Wbynb3GWF4AWdYK44RgI8jFfAlYGDWaQ5qH
         laieTJL8Kw3EJa9xzZ2c/gZY8/MyHFYxHXd3XlpuzrSf7mcTxBXKvWN0SXeY2y5WmXsj
         rAWncxzdFmZUoGd5SxS2xJB2EDWgc8srrdxM12uQJS+plFi1UDS9oGa1cxMmfF9mG40j
         r4X7V7YWuwxQvZcaH6pweek0PoOMBfbBnevCC3iLtlwIZfwKbRa2dN31dT3ftxEN2zUL
         5Vkg==
X-Received: by 10.182.66.14 with SMTP id b14mr32128023obt.80.1439508748922;
 Thu, 13 Aug 2015 16:32:28 -0700 (PDT)
Received: by 10.202.232.213 with HTTP; Thu, 13 Aug 2015 16:32:09 -0700 (PDT)
In-Reply-To: <1439493795.8855.16.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275895>

I will reroll this series with adjustments as you suggested, and I
will add the extra tests for bare repos.

On Thu, Aug 13, 2015 at 3:23 PM, David Turner <dturner@twopensource.com> wrote:
> The scope of d can be smaller; move it down to the place I've marked
> below

I have adjusted the scoping.  I misunderstood the meaning of some
comments from the v3 patch, but your statements have helped me
understand.


>
> strbuf_strip_suffix returns 1 if the suffix was stripped and 0
> otherwise, so there is no need for this strcmp.

Done.

>
> I'm a little worried about this path manipulation; it looks like the
> config setting core.bare is the actual thing to check?  (Along with
> maybe the GIT_WORK_TREE environment var; not sure how that interacts
> with worktrees).

As Junio pointed out in a previous version of this patch, the
core.bare will always be 'true' since they share the config.  He also
suggested that this could be the cause for concern.  Therefore, I can
use core.bare to check if the main is a bare repo.  I guess that with
the inclusion of tests using a bare repo, that will catch it if things
change in the future.

>
>> +     }
>> +
>> +     if (!main_is_bare) {
>> +             strbuf_addstr(&worktree_path, main_path.buf);
>> +
>> +             strbuf_addstr(&main_path, "/.git");
>> +             strbuf_addstr(&worktree_git, main_path.buf);
>> +
>> +             ret = fn(worktree_path.buf, worktree_git.buf, cb_data);
>> +             if (ret)
>> +                     goto done;
>> +     }
>> +     strbuf_addstr(&main_path, "/worktrees");
>
> Earlier, you said:
>                 strbuf_addstr(&main_path, common_dir);
>                 strbuf_strip_suffix(&main_path, "/.git");
>
> Now you are adding /worktrees.  Doesn't this mean, in the non-bare case,
> that you'll be looking in $common_dir/worktrees instead of
> $common_dir/.git/worktrees ?

I read the gitdir file from the common dir.

>> +                     while ((d = readdir(dir)) != NULL) {
>> +                             if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>> +                                     continue;
>> +
>> +                             strbuf_reset(&worktree_git);
>> +                             strbuf_addf(&worktree_git, "%s/%s/gitdir", main_path.buf, d->d_name);
>
> tioli: main_path never changes, so no need to keep chopping it off and
> adding it back on; just truncate worktree_git to main_path.len + 1 here
> and then add d->name.

I will try to clean it up a bit.  I am not very experienced with C,
but I will do my best.
