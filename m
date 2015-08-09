From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] worktrees: add find_shared_symref
Date: Sat, 8 Aug 2015 22:56:53 -0400
Message-ID: <CAPig+cS9s4Odk6dXtBZdq8++KEjiYOa05uYc571Oa8FJG99srg@mail.gmail.com>
References: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
	<CAPig+cTFWn6mWtmmG9KrDhK1++r7fgXM_mK4BvCktThoErnBzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 04:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOGnD-0006du-VB
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 04:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992846AbbHIC4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 22:56:55 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33169 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992842AbbHIC4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 22:56:54 -0400
Received: by ykaz130 with SMTP id z130so8904548yka.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2015 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4MzHlm54poOrX6KUzrl6kx3slod2DfDbxTasc/JroMY=;
        b=B5gpXnSV2gHYx5H5NO5tMjc99z67dKlKdJVWs3c2FvdZ9oN4HH7OnsNJpUe55qlWDq
         h9NlqGN93+rLZoYOX8/iFN8nhEI3bbilNtS9bueO/YA7n8AH1BgCIIuoojY7HYLVMuwt
         a/xM1rRPWtliXFK6vrUAhmFZfbt9v/VeRZBib+1ZJndmz7bM02YAO97NMuPi10+Dr4jg
         a/EjcUfGgTWemhkPyB8d+oUown16Ki52XwjN7cixuuvx/PO3XwH/6JRlNgAzkj1nROW0
         aDmWN479h38cDoyBMjPSheSENdbLZGZgDfPHs+29NmieDgcIxNy35WecqT0+ruerBzdv
         EyFQ==
X-Received: by 10.13.220.132 with SMTP id f126mr15122816ywe.39.1439089014012;
 Sat, 08 Aug 2015 19:56:54 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 8 Aug 2015 19:56:53 -0700 (PDT)
In-Reply-To: <CAPig+cTFWn6mWtmmG9KrDhK1++r7fgXM_mK4BvCktThoErnBzA@mail.gmail.com>
X-Google-Sender-Auth: QsxtTIRAR4K987IVFE7weG_hbRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275524>

On Mon, Aug 3, 2015 at 7:06 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 3, 2015 at 2:48 PM, David Turner <dturner@twopensource.com> wrote:
>> Add a new function, find_shared_symref, which contains the heart of
>> die_if_checked_out, but works for any symref, not just HEAD.  Refactor
>> die_if_checked_out to use the same infrastructure as
>> find_shared_symref.
>>
>> Soon, we will use find_shared_symref to protect notes merges in
>> worktrees.
>>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>> diff --git a/branch.c b/branch.c
>> index c85be07..d2b3586 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -349,31 +350,53 @@ static void check_linked_checkout(const char *branch, const char *id)
>>                 strbuf_addstr(&gitdir, get_git_common_dir());
>>         skip_prefix(branch, "refs/heads/", &branch);
>>         strbuf_strip_suffix(&gitdir, ".git");
>> -       die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);

In addition to the other issues already mentioned, this one is a bit
more serious (though still rather superficial):

With this change, the skip_prefix(branch, "refs/heads/", &branch)
becomes meaningless. It was used by the die() to provide a nicer
looking error message, however, 'branch' now is never used after
skip_prefix(). More below...

>> +
>> +       strbuf_release(&path);
>> +       strbuf_release(&sb);
>> +       return strbuf_detach(&gitdir, NULL);
>>  done:
>>         strbuf_release(&path);
>>         strbuf_release(&sb);
>>         strbuf_release(&gitdir);
>> +
>> +       return NULL;
>>  }
>
> This would be cleaner and less redundant if you assign the existing
> location to a variable and just fall through to the 'done' label:
>
>     char *existing = NULL;
>     ...
>         skip_prefix(branch, "refs/heads/", &branch);
>         strbuf_strip_suffix(&gitdir, ".git");
>         existing = strbuf_detach(&gitdir, NULL);
>     done:
>         strbuf_release(&path);
>         strbuf_release(&sb);
>         strbuf_release(&gitdir);
>         return existing;
>
> There's no worry that the "existing" path will be clobbered by
> strbuf_release(&gitdir) since it's been detached already (and it's
> safe to release the strbuf without affecting what has been detached
> from it).
>
>> -void die_if_checked_out(const char *branch)
>> +char *find_shared_symref(const char *symref, const char *target)
>>  {
>>         struct strbuf path = STRBUF_INIT;
>>         DIR *dir;
>>         struct dirent *d;
>> +       char *existing;
>>
>> -       check_linked_checkout(branch, NULL);
>> +       if ((existing = find_linked_symref(symref, target, NULL)))
>> +               return existing;
>>
>>         strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
>>         dir = opendir(path.buf);
>>         strbuf_release(&path);
>>         if (!dir)
>> -               return;
>> +               return NULL;
>>
>>         while ((d = readdir(dir)) != NULL) {
>>                 if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>>                         continue;
>> -               check_linked_checkout(branch, d->d_name);
>> +               existing = find_linked_symref(symref, target, d->d_name);
>> +               if (existing) {
>> +                       closedir(dir);
>> +                       return existing;
>
> For consistency with code nearby, this could have been handled by
> adding a 'done' label above the closedir() below and jumping to it
> from here, and then 'return existing'.
>
>> +               }
>>         }
>>         closedir(dir);
>> +
>> +       return NULL;
>> +}
>> +
>> +void die_if_checked_out(const char *branch)
>> +{
>> +       char *existing;
>> +
>> +       existing = find_shared_symref("HEAD", branch);
>> +       if (existing)
>> +               die(_("'%s' is already checked out at '%s'"), branch, existing);

Unlike the original die() in check_linked_checkout() which printed the
branch named shortened by skip_prefix(), this one still prints the
long-form branch name. An easy fix would be to move the skip_prefix()
invocation down to here to skip the "refs/heads/" prefix just before
die().

>>  }
