From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v8 4/4] worktree: add 'list' command
Date: Wed, 23 Sep 2015 22:58:53 -0400
Message-ID: <CANoM8SX28TPt_U8v9HO4yo=M46-JKn5S11DrhZ0-EdrjkDT3EQ@mail.gmail.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
 <1442583027-47653-5-git-send-email-rappazzo@gmail.com> <xmqq37y644x7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 04:59:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zewkh-00054k-S9
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 04:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbbIXC7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 22:59:15 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:32945 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbbIXC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 22:59:14 -0400
Received: by vkgd64 with SMTP id d64so40018213vkg.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qdAvy4qeUM8m/lO4newNc5MDoywzQjqp1M9LuE2NZaY=;
        b=RXiVX7kin/QN3Ar1UvA+ivvIAQmbDnfwVM4KwZ6yu34SJPY2Ap5CmlaxGuMG53SWS7
         5I6LEu+d2YuoC/k8yaA4bKej4dVX7rrn2gwDlQz0yZtnPm11AuVEvHmxrJr/+QR1drCu
         9ndvjb52D6km94sR91oFEKXxyBJHxOG1bs1ijJmcIwu5CDfCilMN3WjNO7J0qb/CXdy5
         1roYV3pgxnMGheFeX6eA0fxmYfXKEVAyTep3IDe/XgIT9potH53V1tig+Qfh0mfFLc5n
         zdX6KKspGALt/lcyY/VYLr6aS3dXPhzdxaQy7UTKYJWzWaypMq7tkF+jHS1dU/oykUAQ
         tu8w==
X-Received: by 10.31.155.2 with SMTP id d2mr24538564vke.55.1443063552811; Wed,
 23 Sep 2015 19:59:12 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Wed, 23 Sep 2015 19:58:53 -0700 (PDT)
In-Reply-To: <xmqq37y644x7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278529>

On Tue, Sep 22, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>>
>> +--porcelain::
>> +     With `list`, output in an easy-to-parse format for scripts.
>> +     This format will remain stable across Git versions and regardless of user
>> +     configuration.
>
> ... and exactly what does it output?  That would be the first
> question a reader of this documentation would ask.
>

I will add that description.  I have mostly followed what Eric
suggested in the v7 series for a porcelain format.  Does the porcelain
format restrict additive changes?  That is, is it OK for a future
patch to add another field in the format, as long as it doesn't alter
the other values?  Is the format that I have used here acceptable
(assuming the changes proposed below are made)?

>
>> @@ -93,6 +106,7 @@ OPTIONS
>>  --expire <time>::
>>       With `prune`, only expire unused working trees older than <time>.
>>
>> +
>
> ?
>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index 71bb770..e6e36ac 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -8,10 +8,13 @@
>>  #include "run-command.h"
>>  #include "sigchain.h"
>>  #include "refs.h"
>> +#include "utf8.h"
>> +#include "worktree.h"
>>
>>  static const char * const worktree_usage[] = {
>>       N_("git worktree add [<options>] <path> <branch>"),
>>       N_("git worktree prune [<options>]"),
>> +     N_("git worktree list [<options>]"),
>>       NULL
>>  };
>>
>> @@ -359,6 +362,79 @@ static int add(int ac, const char **av, const char *prefix)
>>       return add_worktree(path, branch, &opts);
>>  }
>>
>> +static void show_worktree_porcelain(struct worktree *worktree)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>> +     strbuf_addf(&sb, "worktree %s\n", worktree->path);
>> +     if (worktree->is_bare)
>> +             strbuf_addstr(&sb, "bare");
>> +     else {
>> +             if (worktree->is_detached)
>> +                     strbuf_addf(&sb, "detached at %s", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
>> +             else
>> +                     strbuf_addf(&sb, "branch %s", shorten_unambiguous_ref(worktree->head_ref, 0));
>> +     }
>
> Writing the above like this:
>
>         if (worktree->is_bare)
>                 ...
>         else if (worktree->is_detached)
>                 ...
>         else
>                 ...
>
> would make it a lot more clear that there are three cases.
>
> Also, I doubt --porcelain output wants shorten or abbrev.
>
> Human-readability is not a goal.  Reproducibility is.  When you run
> "worktree list" today and save the output, you want the output from
> "worktree list" taken tomorrow to exactly match it, even after
> creating many objects and tags with conflicting names with branches,
> as long as you didn't change their HEADs in the meantime.
>
>> +
>> +     printf("%s\n\n", sb.buf);
>> +
>> +     strbuf_release(&sb);
>
> I am not sure what the point of use of a strbuf is in this function,
> though.  Two printf's for each case (one for the common "worktree
> %s", the other inside if/elseif/else cascade) should be sufficient.
>
>> +static void show_worktree(struct worktree *worktree, int path_maxlen)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>
> Remove this blank line.  You are still declaring variables.
>
>> +     int cur_len = strlen(worktree->path);
>> +     int utf8_adj = cur_len - utf8_strwidth(worktree->path);
>
> Have a blank line here, instead, as now you start your statements.
>
>> +     strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + utf8_adj, worktree->path);
>> +     if (worktree->is_bare)
>> +             strbuf_addstr(&sb, "(bare)");
>> +     else {
>> +             strbuf_addf(&sb, "%s ", find_unique_abbrev(worktree->head_sha1, DEFAULT_ABBREV));
>
> Personally I am not a big fan of the the alignment and use of
> utf8_strwidth(), but by using find_unique_abbrev() here, you are
> breaking the alignment, aren't you?  " [branchname]" that follows
> the commit object name would not start at the same column, when
> you have many objects that default-abbrev is not enough to uniquely
> identify them.
>
> And it can easily be fixed by computing the unique-abbrev length for
> all the non-bare worktree's HEADs in the same loop you computed
> path_maxlen() in the caller, passing that to this function, and use
> that as mininum abbrev length when computing the unique-abbrev.
>

I only intended for the path to be right padded, since paths can vary
in length so widely.  I found it much easier to read with the path
right-padded.  I think that doing a full column align isn't the best
looking output in this case.  I tried to model this output after `git
branch -vv`.  I didn't notice if that does a full align if the
shortened refs are differently sized.  I will try it out, and see if
it makes a significant visual impact.

>> +             if (!worktree->is_detached)
>> +                     strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(worktree->head_ref, 0));
>> +             else
>> +                     strbuf_addstr(&sb, "(detached HEAD)");
>> +     }
>> +     printf("%s\n", sb.buf);
>
>
>> diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
>> new file mode 100755
>> index 0000000..b68dfb4
>> --- /dev/null
>> +++ b/t/t2027-worktree-list.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/sh
>> +
>> +test_description='test git worktree list'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +     test_commit init
>> +'
>> +
>> +test_expect_success '"list" all worktrees from main' '
>> +     echo "$(git rev-parse --show-toplevel)       $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
>
> Are the number of SPs here significant and if so in what way?  Does
> it depend on your environment or will there always be six of them?
> Either way feels like an indication of a problem.

The number of spaces is significant in this case, but it should not be
platform dependent.  It is just the padding for the different worktree
paths.

>
>> +     git worktree add --detach here master &&
>> +     test_when_finished "rm -rf here && git worktree prune" &&
>
> Aren't these two the other way around?  When "add" fails in the
> middle, you would want it to be removed to proceed to the next test
> without leaving 'here' in the list of worktrees, no?

Sure, I'll switch it.
