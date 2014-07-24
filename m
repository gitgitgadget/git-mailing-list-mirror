From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already
 checked out
Date: Thu, 24 Jul 2014 17:09:28 +0700
Message-ID: <CACsJy8CTYyjqmwGgkKZQFX4YC9-X=TGx9Ex5QfNWRNKFjgpKag@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406115795-24082-4-git-send-email-pclouds@gmail.com> <xmqqzjfzdbds.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 12:10:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAFyU-0002eH-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 12:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbaGXKKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 06:10:01 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:63817 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758734AbaGXKJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 06:09:59 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so2957671qgd.13
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RmQYhn2xAu1pxATweabYVGW2xeTHxbA26zN5Q6eLGBQ=;
        b=xOeOSY1xTdzgqYXqLs7sAZDwVl6K5O34+8CJfPtNHadKK6AtKj0V48Ax/lMy6Mlut9
         5vwgz8ljkCwz9y//V4tiLKtoWSTLjspNRhIOog50F1IGUMK40Ewk8YyHRZo2IzftjAAa
         wuz9m3/zLpE6BK4xqUWSG6C0ewfzIDtlXRdvxDQ4zKI3E1s+l5zz2ncoQE88eImf9CG7
         JnWZ15Yv9KZzySgRk10c8yDrJqfpIcpwAOPWsxx4OheDsKWrrqri5TR7dFjj6/ev5TbA
         S/B6R+vU4+KK5LVLHdqu0ArW655S4tWkZC4QBCyBpDD1Tx8PdVNP6TSaCnzX/PAxZiH/
         stWA==
X-Received: by 10.140.30.73 with SMTP id c67mr12830692qgc.16.1406196598091;
 Thu, 24 Jul 2014 03:09:58 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 24 Jul 2014 03:09:28 -0700 (PDT)
In-Reply-To: <xmqqzjfzdbds.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254152>

On Thu, Jul 24, 2014 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     if (strbuf_read_file(&sb, path.buf, 0) <= 0 ||
>> +         !skip_prefix(sb.buf, "ref:", &start))
>> +             goto done;
>>       while (isspace(*start))
>>               start++;
>>       end = start;
>>       while (*end && !isspace(*end))
>>               end++;
>
> Not new in this round of update, and may not even be an issue, but:
>
>  - Earlier, the code returned early on a negative return value from
>    read-file (i.e., an error), but this round it also does so for
>    zero.  Intended?

Yes. But it does not make any difference. strbuf_read_file returns
sb.len, if it's empty, the next skip_prefix would fail anyway.

>  - The above duplicates the logic in resolve_ref_unsafe() and
>    resolve_gitlink_ref_recursive(); three places now knows what a
>    textual symref looks like (i.e. begins with "ref:", zero or more
>    whitespaces, the target ref and then zero or more trailing
>    whitespaces).  Perhaps we need to consolidate the code further,
>    so that this knowledge does not leak out of refs.c?

OK. Will do (unless Mike has a different opinion about this).

>
>> +     if (strncmp(start, new->path, end - start) ||
>> +         new->path[end - start] != '\0')
>> +             goto done;
>> +     if (id) {
>> +             strbuf_reset(&path);
>> +             strbuf_addf(&path, "%s/repos/%s/gitdir",
>> +                         get_git_common_dir(), id);
>> +             if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
>> +                     goto done;
>> +             while (gitdir.len && (gitdir.buf[gitdir.len - 1] == '\n' ||
>> +                                   gitdir.buf[gitdir.len - 1] == '\r'))
>> +                     gitdir.buf[--gitdir.len] = '\0';
>
> Accepting arbitrary numbers of '\r' and '\n' sounds as if the code
> is allowing it, but text editors would not end their files with a
> nonsense sequence like "\r\r\n\r" unless the end-user works to do
> so, and if you are prepared to be lenient to noisy human input, not
> trimming trailing whitespaces does not look it is going far enough
> to help them.
>
> I do not see a good reason to allow random text editors to edit this
> file in the first place, so my preference is:
>
>         if (strbuf_read_file(...) < 0 ||
>             gitdir.len == 0 ||
>             gitdir.buf[gitdir.len - 1] != '\n')
>             goto error_return;
>         gitdir.buf[--gitdir.len] = '\0';
>
> Alternatively, if you are trying to be lenient to human input, I
> would understand:
>
>         if (strbuf_read_file(...) < 0)
>                 goto error_return;
>         strbuf_rtrim(&gitdir);
>
> The code in the patch, which is something in between, does not make
> much sense to me.

I think more about "echo abc > $this_file" where the echo command may
output '\r\n' on Windows (wild guess though, I don't use Windows
much). I think I'm going with _rtrim.
-- 
Duy
