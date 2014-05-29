From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Thu, 29 May 2014 18:42:49 +0700
Message-ID: <CACsJy8Dy2quFrXynH7g5DzNMikwkOiyJZGMoSqLyjxzzvRreYQ@mail.gmail.com>
References: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com> <CAKpPgvfvrdBr7oxyKg2G1XDHwS=Dzs9=K9MmQLtLzUx-Zi+1dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 13:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpyk1-0000ij-Rg
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 13:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbaE2LnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 07:43:21 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:62329 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaE2LnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 07:43:20 -0400
Received: by mail-qg0-f51.google.com with SMTP id q107so516704qgd.24
        for <git@vger.kernel.org>; Thu, 29 May 2014 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/E4JW4XROXFdR/pYMF9ji8KuoJ8wmo/rRg8N/UQ40DE=;
        b=UHKzOIpfPKOrJe+LTbBksgCG4j+jpUMPj3A/brz8KCxAH3ULBGlS9gcRNXZRfg6OFV
         7kxAizf9+SgJHxR0wMSWgcq6v5DgqHWxUPSS6S/yK5i3Wf7wzregtAqYozurifT7sm2D
         IJjbp+u2oEvKK8auspe6POxKafvgO87injEaGPaEivcRPHQ9iqsNFNfHA6ugJqX90CFJ
         9HcEE31dKh2oMuwPT9NLcQ8/8TIyywWyiexOpUdhQbtfz+MAfTh/ruQrEYilL2s8aPix
         ViatqkZXIbvWt0995iA/tMjwQD4MDIvUv0Yl0mxGKEQ1n5uk0A58NvOskSuyOgV9az/U
         OG0A==
X-Received: by 10.140.47.167 with SMTP id m36mr8580383qga.21.1401363800034;
 Thu, 29 May 2014 04:43:20 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 29 May 2014 04:42:49 -0700 (PDT)
In-Reply-To: <CAKpPgvfvrdBr7oxyKg2G1XDHwS=Dzs9=K9MmQLtLzUx-Zi+1dA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250363>

On Thu, May 29, 2014 at 5:11 AM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
>>> +       len = strlen(n_git); /* real_path() has stripped trailing slash */
>>> +       for (i = len - 1; i > 0 && !is_dir_sep(n_git[i]); i--) ;
>>> +       basename = n_git + i;
>>> +       if (is_dir_sep(*basename))
>>> +               basename++;
>>> +       if (strcmp(basename, ".git")) {
>>
>> I think normalize_path_copy makes sure that dir sep is '/', so this
>> code may be simplified to "if (strcmp(n_git, .git") && (len == 4 ||
>> strcmp(n_git + len - 5, "/.git")))"?
>
> Then if "n_git" is "/ab"  =>  coredump. But I agree there is logic to
> this (if we check len >= 4 first). However, we still need the
> basename.

Ah I missed this at add_exclude()

> So I've just shortened it a bit, what do you think: (notice
> the condition "i >= 0" btw)
>
>         for (i = len - 1; i >= 0 && n_git[i] != '/'; i--) ;

There's basename() that does this for you. A compat version is
provided for Windows port so no portability worries.

>         basename = n_git + i + 1;
>         if (strcmp(basename, ".git)) {
>
>>
>>> +               const char *worktree = get_git_work_tree();
>>> +
>>> +               if (worktree == NULL ||
>>> +                   dir_inside_of(n_git, get_git_work_tree()) >= 0) {
>>> +                       struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
>>> +                                                       "GIT_DIR setup");
>>> +
>>> +                       /* append a trailing slash to exclude directories */
>>> +                       n_git[len] = '/';
>>> +                       n_git[len + 1] = '\0';
>>> +                       add_exclude(basename, "", 0, el, 0);

Hmm.. I overlooked this bit before. So if  $GIT_DIR is /something/foo,
we set to ignore "foo/". Because we know n_git must be part of
(normalized) get_git_work_tree() at this point, could we path n_git +
strlen(get_git_work_tree()) to add_exclude() instead of basename? Full
path makes sure we don't accidentally exclude too much.

The case when $GIT_DIR points to a _file_ seems uncovered.
setup_git_directory() will transform the file to the directory
internally and we never know the .git file's path (so we can't exclude
it). So people could accidentally add the .git file in, then remove it
from from work tree and suddenly the work tree becomes repo-less. It's
not as bad as .git _directory_ because we don't lose valuable data. I
don't know if you want to cover this too.
-- 
Duy
