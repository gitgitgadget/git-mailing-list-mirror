From: Aaron Dufour <thedufer@gmail.com>
Subject: Fwd: bug: git branch -d and case-insensitive file-systems
Date: Tue, 25 Aug 2015 11:42:03 -0400
Message-ID: <CAJrRhQyiiAQi6RqHJcVFn7=jBfxNvpp_mbOXTsAWHQMWc6gcuQ@mail.gmail.com>
References: <CAJrRhQz1UmnDi6Giejetfoh3aPX08aYcgY-neZfcKjpUav0=sA@mail.gmail.com>
 <20150825052123.GA523@sigill.intra.peff.net> <CAJrRhQw-+kbQLexPwa0A6ih-LH9DgbyoTD0DiWWhQeXrOvkYbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 17:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUGMm-0001WQ-Se
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 17:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbbHYPmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 11:42:24 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:32953 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbHYPmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 11:42:24 -0400
Received: by lalv9 with SMTP id v9so100810614lal.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=f/nhD1KFnAAIwN76oQLrgwE3CmXv/Q2cyawq0DV2aN8=;
        b=JPeJe1JhxaFde8MFhoIFUElEL3I56dahVz9Gs0yPURwEzvbPLBF48UOapNOtz0GhIL
         OMQ2hP/+v8aCdZP2em1VOJ45M4V5jMO6A6O287J7h0z9is/w3EG+xk4bRawIvbAtpSWV
         iC5Y5oaGrb07smQxKIMwYrWJnY2AajpiUPv4Lndr6Ge5E5zsr0TjP9AJ/o8zfpXcn7C/
         bMhjxgRECTycS0s5TNeblgHdvTj7Ko85RybGuQyr7znUo4By6O+WuNsCg7NbE6LIPymo
         mTSK7H5i2xCoNREPtcE1dB2txGt1NOhs6qbBZbCOsEXZihkvRkQ+Fif9D0CpFUyg9Ro7
         oLjg==
X-Received: by 10.152.27.134 with SMTP id t6mr26619561lag.100.1440517342621;
 Tue, 25 Aug 2015 08:42:22 -0700 (PDT)
Received: by 10.25.21.84 with HTTP; Tue, 25 Aug 2015 08:42:03 -0700 (PDT)
In-Reply-To: <CAJrRhQw-+kbQLexPwa0A6ih-LH9DgbyoTD0DiWWhQeXrOvkYbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276533>

On Tue, Aug 25, 2015 at 1:21 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 24, 2015 at 12:11:13PM -0400, Aaron Dufour wrote:
>
>> I use git (2.2.1) on OS X (10.9.5) and recently my repo got into a bad
>> state.  I think this involves a mis-handling of case-insensitive file
>> systems.
>>
>> This reproduces the problem:
>>
>>     > git init
>>     Initialized empty Git repository in /Users/aarond_local/code/git-test/.git/
>>     > git commit --allow-empty -m 'first commit'
>>     [master (root-commit) 923d8b8] first commit
>>     > git checkout -b feature
>>     Switched to a new branch 'feature'
>>     > git checkout -b Feature
>>     fatal: A branch named 'Feature' already exists.
>>     > git checkout -B Feature
>>     Switched to and reset branch 'Feature'
>>     > git branch -d feature
>>     Deleted branch feature (was 923d8b8).
>>     > git log
>>     fatal: bad default revision 'HEAD'
>
> I don't work on a case-insensitive filesystem, so my knowledge may be
> out of date, but as far as I know, we do not do anything special to
> handle ref case-sensitivity. I expect your problem would go away with
> this patch:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 58aa84f..c5545de 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -19,6 +19,7 @@
>  #include "column.h"
>  #include "utf8.h"
>  #include "wt-status.h"
> +#include "dir.h"
>
>  static const char * const builtin_branch_usage[] = {
>         N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
> @@ -223,7 +224,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                 int flags = 0;
>
>                 strbuf_branchname(&bname, argv[i]);
> -               if (kinds == REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
> +               if (kinds == REF_LOCAL_BRANCH && !strcmp_icase(head, bname.buf)) {
>                         error(_("Cannot delete the branch '%s' "
>                               "which you are currently on."), bname.buf);
>                         ret = 1;
>
> but I think that is just the tip of the iceberg. E.g. (on a vfat
> filesystem I just created):
>
>   $ git init
>   $ git commit -q --allow-empty -m one
>   $ git branch foo
>   $ git branch FOO
>   fatal: A branch named 'FOO' already exists.
>
>   $ git pack-refs --all --prune ;# usually run as part of git-gc
>   $ git commit -q --allow-empty -m two
>   $ git branch FOO
>   $ git for-each-ref --format='%(refname) %(subject)'
>   refs/heads/FOO two
>   refs/heads/foo one
>   refs/heads/master two
>
> Now the patch I showed above would do the wrong thing. Running "git
> checkout foo; git branch -d FOO" would be rejected, even though I really
> do have two separate branches.
>
> It would be a much more invasive change to fix this correctly. It is
> probably less work overall to move to a pluggable ref system, and to
> design ref storage that isn't dependent on the filesystem (this work is
> already underway).

That's great news!

>
> In the meantime, I think the best advice for mixed-case branch names on
> a case-insensitive filesystem is: don't.

Yeah, that's definitely the solution.  I got into a weird place
because our build system uses branch names, but it restricts them to
lowercase letters and I made the mistake of camel-casing.  I'll just
be more careful.

>
> -Peff

-Aaron
