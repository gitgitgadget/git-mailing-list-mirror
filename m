From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: [PATCH v4] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 28 May 2014 15:11:05 -0700
Message-ID: <CAKpPgvfvrdBr7oxyKg2G1XDHwS=Dzs9=K9MmQLtLzUx-Zi+1dA@mail.gmail.com>
References: <1401163007-5808-1-git-send-email-pasha.bolokhov@gmail.com> <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpm4M-00048v-67
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 00:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566AbaE1WL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 18:11:27 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:60466 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbaE1WLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 18:11:25 -0400
Received: by mail-oa0-f51.google.com with SMTP id n16so11806717oag.38
        for <git@vger.kernel.org>; Wed, 28 May 2014 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+HUcMoNe3nRU9Dj6ywE7v4R7CTbtmnbUTb50huCaPMU=;
        b=0zUqMnYTtmq5qzgwB6/KphGjRXKF89Pngnf1PmiIOSjOQqc9CpHvyty7CjE5s7U9PZ
         7Eh51JssOVYbSVm4J7E0+TIfWMlxfFWmWE3y6wRW7GQSeFU3wpJ9dwedceQC5d7fNKre
         zRswik7Efm2svTM54552i6SSRzrd/SANGsT11ufW69Kx5HzJIjBodMbf2QbXDnqck0j7
         8uFja5TYt+4ue+SBKk4Zqrp/FIRIh7oVcQtH9xN5N21kM1kCMv2+RdkxktI4xwbZVJio
         dzayodwaItrzvuGbLo4wOg8OffDSuaHuQ/hz0/Ierip1ECaxKX6afZrGSuE0bwFgqsZT
         4fCw==
X-Received: by 10.60.162.68 with SMTP id xy4mr3443175oeb.68.1401315085093;
 Wed, 28 May 2014 15:11:25 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Wed, 28 May 2014 15:11:05 -0700 (PDT)
In-Reply-To: <CACsJy8By-58wBoV8BydWbpDkpUG6jJhM16aO+Ed8J2ucq66VcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250338>

On Wed, May 28, 2014 at 5:36 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 27, 2014 at 10:56 AM, Pasha Bolokhov
> <pasha.bolokhov@gmail.com> wrote:
>> @@ -1588,6 +1588,38 @@ void setup_standard_excludes(struct dir_struct *dir)
>>  {
>>         const char *path;
>>         char *xdg_path;
>> +       const char *r_git, *gitdir = get_git_dir();
>> +       char *n_git, *basename;
>> +       int len, i;
>> +
>> +       /*
>> +        * Add git directory to the ignores; do this only if
>> +        * GIT_DIR does not end with "/.git"
>> +        */
>> +       r_git = real_path(absolute_path(gitdir));
>> +       n_git = xmalloc(strlen(r_git) + 1 + 1);
>> +       normalize_path_copy(n_git, r_git);
>> +
>> +       len = strlen(n_git); /* real_path() has stripped trailing slash */
>> +       for (i = len - 1; i > 0 && !is_dir_sep(n_git[i]); i--) ;
>> +       basename = n_git + i;
>> +       if (is_dir_sep(*basename))
>> +               basename++;
>> +       if (strcmp(basename, ".git")) {
>
> I think normalize_path_copy makes sure that dir sep is '/', so this
> code may be simplified to "if (strcmp(n_git, .git") && (len == 4 ||
> strcmp(n_git + len - 5, "/.git")))"?

Then if "n_git" is "/ab"  =>  coredump. But I agree there is logic to
this (if we check len >= 4 first). However, we still need the
basename. So I've just shortened it a bit, what do you think: (notice
the condition "i >= 0" btw)

        for (i = len - 1; i >= 0 && n_git[i] != '/'; i--) ;
        basename = n_git + i + 1;
        if (strcmp(basename, ".git)) {

>
>> +               const char *worktree = get_git_work_tree();
>> +
>> +               if (worktree == NULL ||
>> +                   dir_inside_of(n_git, get_git_work_tree()) >= 0) {
>> +                       struct exclude_list *el = add_exclude_list(dir, EXC_CMDL,
>> +                                                       "GIT_DIR setup");
>> +
>> +                       /* append a trailing slash to exclude directories */
>> +                       n_git[len] = '/';
>> +                       n_git[len + 1] = '\0';
>> +                       add_exclude(basename, "", 0, el, 0);
>> +               }
>> +       }
>> +       free(n_git);
>
> All this add-only code makes me think it may be nice to make it a
> separate function. A good function name could replace the comment near
> the beginning of the block.

Reasonable
I'll send the all-updated patch including doc when ready

> --
> Duy
