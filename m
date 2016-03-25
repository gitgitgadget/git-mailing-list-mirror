From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH] branch: update all per-worktree HEADs when renaming a
 branch
Date: Fri, 25 Mar 2016 20:33:51 +0900
Message-ID: <20160325113351.GC24729@chikuwa.rhe.jp>
References: <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:34:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQ0D-0004Im-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbcCYLd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:33:56 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:51558 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbcCYLdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:33:55 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 9708F5AA50;
	Fri, 25 Mar 2016 11:33:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289876>

Hello,

On 03/22/2016 03:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> @@ -126,7 +126,19 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
>>  test_expect_success 'git branch -M baz bam should succeed when baz is checked out' '
>> +test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
>> +       git checkout master &&
>> +       git branch &&
>> +       git worktree add -b baz bazdir &&
>> +       git branch -M baz bam &&
>> +       (
>> +               cd bazdir &&
>> +               test $(git rev-parse --abbrev-ref HEAD) = bam
>> +       )
>>  '
> 
> This can be done more easily without the subshell:
> 
>     test $(git -C bazdir rev-parse ...) = bam

Thank you for reviewing. And sorry for late response.
I didn't know -C option, thanks.

> 
> Can you also expand the test so that it verifies that the rename works
> as expected when the branch is checked out in multiple worktrees,
> rather than just one. Likewise, it would be nice to check branch
> rename from within a worktree in which the branch is checked out (in
> addition to the test above which does the rename from outside such a
> worktree).
> 

I'll add them.
And I noticed my patch is broken in the latter case (rename in a linked
working tree).
Since create_symref() calls resolve_ref_unsafe() and it uses $GIT_DIR
for worktree-specific refs thus my patch fails to update main tree's
HEAD when we are in a linked working tree.
I'm thinking about adding new flag to resolve_ref_unsafe(), to force
using $GIT_COMMON_DIR. This will at the same time allows to remove
parse_ref() in worktree.c.

> 
>> diff --git a/worktree.c b/worktree.c
>> @@ -217,3 +217,41 @@ char *find_shared_symref(const char *symref, const char *target)
>> +int update_worktrees_head_symref(const char *oldref, const char *newref)
>> +{
>> +       int error = 0;
>> +       struct strbuf path = STRBUF_INIT;
>> +       struct strbuf origref = STRBUF_INIT;
>> +       int i;
>> +       struct worktree **worktrees = get_worktrees();
>> +
>> +       for (i = 0; worktrees[i]; i++) {
>> +               if (worktrees[i]->is_detached)
>> +                       continue;
>> +
>> +               strbuf_reset(&path);
>> +               strbuf_reset(&origref);
>> +               strbuf_addf(&path, "%s/HEAD", worktrees[i]->git_dir);
>> +
>> +               if (parse_ref(path.buf, &origref, NULL))
>> +                       continue;
>> +
>> +               if (!strcmp(origref.buf, oldref)) {
>> +                       int prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
>> +                       const char *symref = path.buf + prefix_len;
>> +
>> +                       /* no need to pass logmsg here as HEAD didn't really move */
>> +                       if (create_symref(symref, newref, NULL)) {
>> +                               error = -1;
>> +                               break;
> 
> Is aborting upon the first error desired behavior? (Genuine question.)
> Would it make more sense to continue attempting the rename for the
> remaining worktrees (and remember that an error was encountered)?
> Related: Since you're now dealing with multiple worktrees, you can do
> a better job of letting the user know in which worktree something went
> wrong rather than merely emitting the relatively generic "Branch
> renamed to %s, but HEAD is not updated!".

I think both is ok.
But continuing shouldn't be harm, so continuing might be better in terms
of that it can tell the user what files need to be fixed manually.
I'll try it.

>> +}
>> diff --git a/worktree.h b/worktree.h
>> @@ -35,4 +35,11 @@ extern void free_worktrees(struct worktree **);
>> +/*
>> + * Update all per-worktree HEADs pointing the old ref to point the new ref.
>> + * This will be used when renaming a branch. Returns 0 if successful,
>> + * non-zero otherwise.
>> + */
>> +extern int update_worktrees_head_symref(const char *, const char *);
> 
> I guess I can understand the desire to libify this functionality,
> however, it feels as if it is a feature of "branch" rather than
> "worktree", hence perhaps it should reside in top-level branch.[hc]?

I agree, I'll move it.
I chose worktree.c just because it has parse_ref().
