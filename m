From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Tue, 3 Jun 2014 13:55:25 -0700
Message-ID: <CAKpPgvcv10-DNM4xetfmcckG6ancfEn_y7i8EJ3mWQLaELDdUQ@mail.gmail.com>
References: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com>
 <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com>
 <CAKpPgvfvrdBr7oxyKg2G1XDHwS=Dzs9=K9MmQLtLzUx-Zi+1dA@mail.gmail.com> <CACsJy8Dy2quFrXynH7g5DzNMikwkOiyJZGMoSqLyjxzzvRreYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrvkN-00033U-9h
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 22:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330AbaFCUzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 16:55:47 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36692 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbaFCUzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 16:55:46 -0400
Received: by mail-oa0-f48.google.com with SMTP id g18so6756983oah.7
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2BtwIY+8V8Lu39NGjKCcp4pdqX+YfKTUxicMUPPCoyE=;
        b=yxR0oKL10Eq+x6EOmTGDkUNq4HoDouQhhxsZqcQ+NgCw9MzZqbxlQ+6nyk+eW0FN4U
         CRaBG5+UDPLbLUVswrEDq59vm5dEFGId4glx2/2ieqAbLTt1ccEwLwke77pYyGHJ/KUr
         1S+VGdX/mmagJ1SjvT/nLWS05jWdeMDR1Y4A0PWHM/poAxMWZfEVLXFY8xjurxV8I/ED
         5UXwwOZTEgRQbgrWNqOiMZhIGEoDwPoJVlsx0sjP3pcKSeOXPJeoglfQKFNxW+EjP+p1
         9rZs4CGW7Ij5IieMKL2N8VCc8zeArCxz13pXqt0cGZLwl/CHNmjHOKDC7BZUnEdCJEpd
         ebRw==
X-Received: by 10.60.176.73 with SMTP id cg9mr15185683oec.76.1401828945912;
 Tue, 03 Jun 2014 13:55:45 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Tue, 3 Jun 2014 13:55:25 -0700 (PDT)
In-Reply-To: <CACsJy8Dy2quFrXynH7g5DzNMikwkOiyJZGMoSqLyjxzzvRreYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250644>

On Thu, May 29, 2014 at 4:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> +               const char *worktree = get_git_work_tree();
>>>> +
>>>> +               if (worktree == NULL ||
>>>> +                   dir_inside_of(n_git, get_git_work_tree()) >= 0) {
>>>> +                       struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
>>>> +                                                       "GIT_DIR setup");
>>>> +
>>>> +                       /* append a trailing slash to exclude directories */
>>>> +                       n_git[len] = '/';
>>>> +                       n_git[len + 1] = '\0';
>>>> +                       add_exclude(basename, "", 0, el, 0);
>
> Hmm.. I overlooked this bit before. So if  $GIT_DIR is /something/foo,
> we set to ignore "foo/". Because we know n_git must be part of
> (normalized) get_git_work_tree() at this point, could we path n_git +
> strlen(get_git_work_tree()) to add_exclude() instead of basename? Full
> path makes sure we don't accidentally exclude too much.

I guess so. In fact, dir_inside_of() already returns the relative
position, can reuse that (however, that function doesn't include the
leading path, making it a relative path; but it's not difficult to
work around). The only uncovered situation is when GIT_DIR=WORK_TREE.
But that's user's fault and I don't think we need to guarantee that
GIT_DIR will be excluded then

>
> The case when $GIT_DIR points to a _file_ seems uncovered.
> setup_git_directory() will transform the file to the directory
> internally and we never know the .git file's path (so we can't exclude
> it). So people could accidentally add the .git file in, then remove it
> from from work tree and suddenly the work tree becomes repo-less. It's
> not as bad as .git _directory_ because we don't lose valuable data. I
> don't know if you want to cover this too.

That's right, there is no way of knowing what the original .git file
was. I guess the only way to work around this problem is to modify
"read_gitfile()" so it saves the name of the original file. Then we
can add both that .git-file and GIT_DIR to the exclude list. Not a big
problem with me, but need to see what you guys think
