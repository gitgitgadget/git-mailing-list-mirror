Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57601C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbjEKGlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKGle (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 02:41:34 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 23:41:32 PDT
Received: from impout004.msg.chrl.nc.charter.net (impout004aa.msg.chrl.nc.charter.net [47.43.20.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0167B103
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:41:31 -0700 (PDT)
Received: from [10.11.12.100] ([97.71.114.58])
        by cmsmtp with ESMTPA
        id wzy3pOuvPZcgSwzy3p5kQD; Thu, 11 May 2023 06:39:59 +0000
Authentication-Results: sunshineco.com; none
X-Authority-Analysis: v=2.4 cv=QfZ1A+Xv c=1 sm=1 tr=0 ts=645c8dbf
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=3IDPcM1VdqhRhBs_RmQA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <305ccc55-25e3-6b01-cd86-9a9035839d06@sunshineco.com>
Date:   Thu, 11 May 2023 02:39:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] fsck: mention file path for index errors
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <Y/hxW9i9GyKblNV4@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBD7OOjtT+Fw8naz7m9xDSdge7cBPTXZQBxPVyZgLW3vTGHiVJkObZNTYeJ0/2akAy7RInwlFjQ+SppCfdGutxoyCNPTBlaj3eSZWzEGu4Bkin6mG4zX
 Jr9puQPpLRy+uFUGluvhxnxXej3+shtTHkCyJYYe3JlpL0gonjEAJsVuhWOH/d1sN1gyA3IrUoOKhVdFHx/k+1rv+CJcaW1enpKFqhTiSGlybWzkhES/0/uo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/23 3:12 AM, Jeff King wrote:
> If we encounter an error in an index file, we may say something like:
> 
>    error: 1234abcd: invalid sha1 pointer in resolve-undo
> 
> But if you have multiple worktrees, each with its own index, it can be
> very helpful to know which file had the problem. So let's pass that path
> down through the various index-fsck functions and use it where
> appropriate. After this patch you should get something like:
> 
>    error: 1234abcd: invalid sha1 pointer in resolve-undo of .git/worktrees/wt/index
> 
> That's a bit verbose, but since the point is that you shouldn't see this
> normally, we're better to err on the side of more details.
> 
> I've also added the index filename to the name used by "fsck
> --name-objects", which will show up if we find the object to be missing,
> etc. This is bending the rules a little there, as the option claims to
> write names that can be fed to rev-parse. But there is no revision
> syntax to access the index of another worktree, so the best we can do is
> make up something that a human will probably understand.
>
> I did take care to retain the existing ":file" syntax for the current
> worktree. So the uglier output should kick in only when it's actually
> necessary. See the included tests for examples of both forms.

This made me think of the work Duy did[1,2] to make it possible to 
reference per-worktree refs from other worktrees which allows one to 
say, for instance:

     git rev-parse main-worktree/HEAD:somefile
     git rev-parse worktrees/foo/HEAD:somefile

but, of course, that special syntax doesn't extend to "index", so your 
made-up syntax is probably good enough.

[1]: 3a3b9d8cde (refs: new ref types to make per-worktree refs visible 
to all worktrees, 2018-10-21)

[2]: ab3e1f78ae (revision.c: better error reporting on ref from 
different worktrees, 2018-10-21)

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> @@ -795,7 +797,8 @@ static int fsck_resolve_undo(struct index_state *istate)
> -static void fsck_index(struct index_state *istate)
> +static void fsck_index(struct index_state *istate, const char *index_path,
> +		       int is_main_index)

This adds an `is_main_index` flag, but...

> @@ -993,12 +998,19 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> +			if (read_index_from(&istate, path,
>   					    get_worktree_git_dir(wt)) > 0)
> -				fsck_index(&istate);
> +				fsck_index(&istate, path, wt->is_current);

...this accesses `is_current`, the value of which is "true" only for the 
worktree in which the Git command was run, which is not necessarily the 
main worktree. The main worktree, on the other hand, is guaranteed to be 
the first entry returned by get_worktrees(), so shouldn't this instead be:

     worktrees = get_worktrees();
     for (p = worktrees; *p; p++) {
         ...
         fsck_index(&istate, path, p == worktrees);
         ...
     }
     free_worktrees(worktrees);

Or am I fundamentally misunderstanding something?

