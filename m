From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Git add on deleted file
Date: Mon, 13 Aug 2012 20:18:13 +0200
Message-ID: <CAN0XMO+42uZ-D3Fz47G+gYr37wgZOqADB3Yvf5DyRB+ptaXkSQ@mail.gmail.com>
References: <CAOBOgRZRSk7+jxMg+v=GWcn3F9ZfDTGC89YhJ1s7o9=HaOx4Bg@mail.gmail.com>
	<7vipcmekzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 20:18:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0zDq-0001V3-AC
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 20:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab2HMSSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 14:18:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38043 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab2HMSSO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 14:18:14 -0400
Received: by weyx8 with SMTP id x8so2722056wey.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U9RbEGlK2dEZIdm4s0o0xkyCfXTFrTl17F+1KmyPSdM=;
        b=WcQAjVckw+aVJNpWJRz/C+4Z4PX8oOAFnNK0lhxemOLq/Sd56ciio7y7PQReoaOdyU
         hwSuMK9d4T1L1/gKDEbuHI2DGYACUUZhk9R0kdGQfx3XWldXBCdDqu+dWrVMvexqoqYg
         ed+sAase7BzUyMtcRbnr3fHOMogKk4xRHU6mGm+Re4JywpBZXqHQS5NC5xhcsqY+xeOa
         RawT6b499dlcBRboh8PtHu6C0XHVMTRlqry16DzmG6rZNiI7Pm30AZFUUmIq2x2SuXzU
         jbWlWGg9vkc3nat4I2+59Q3RCOohtLm3EYJ9pGnLOByJvAeLYw1A+8YstybkN8f9WvZ8
         pZzQ==
Received: by 10.180.85.167 with SMTP id i7mr20478434wiz.8.1344881893069; Mon,
 13 Aug 2012 11:18:13 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Mon, 13 Aug 2012 11:18:13 -0700 (PDT)
In-Reply-To: <7vipcmekzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203351>

I think the message

no changes added to commit (use "git add" and/or "git commit -a")

is not clear enough since it lacks on the "git rm" command which
is shown above.
#   (use "git add/rm <file>..." to update what will be committed)

Of course, applying this topic would solve this problem.
Alternatively we could adjust the message.

On Mon, Aug 13, 2012 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Angus Hammond <angusgh@gmail.com> writes:
>
>> ... Personally I'd like to see
>> "git add foo" here be equivalent "git rm --cached foo", but I can
>> understand how others might prefer git add not to be destructive like
>> that.
>
> Funny that you bring it up this week.  As I wrote in
>
>   http://git-blame.blogspot.com/2012/08/leftover-bits.html
>
> I think the following topic should be revisited:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/171811/focus=171841
>
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 19 Apr 2011 12:18:20 -0700
> Subject: [PATCH] git add: notice removal of tracked paths by default
>
> When run without "-u" or "-A" option,
>
>     $ edit subdir/x
>     $ create subdir/y
>     $ rm subdir/z
>     $ git add subdir/
>
> does not notice removal of paths (e.g. subdir/z) from the working tree.
> Make "git add" to pretend as if "-A" is given when there is a pathspec on
> the command line.  "git add" without any argument continues to be a no-op.
>
> When resolving a conflict to remove a path, the current code tells you to
> "git rm $path", but now with this patch you can say "git add $path".  Of
> course you can do "git add -A $path" without this patch.
>
> In either case, the operation "git add" is about "adding the state of the
> path in the working tree to the index".  The state may happen to be "path
> removed", not "path has an updated content".
>
> The semantic change can be seen by a breakage in t2200, test #15.  There,
> a merge has conflicts in path4 and path6 (which are removed from the
> working tree), and test checks "git add path4" to resolve it must fail,
> and makes sure "add -u" needs to be used.  We do not have to do this
> anymore.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/add.c         | 3 +++
>  t/t2200-add-update.sh | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 89dce56..4eae028 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -389,6 +389,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>
>         if (addremove && take_worktree_changes)
>                 die(_("-A and -u are mutually incompatible"));
> +       /* default "git add pathspec..." to "git add -A pathspec..." */
> +       if (!take_worktree_changes && argc)
> +               addremove = 1;
>         if (!show_only && ignore_missing)
>                 die(_("Option --ignore-missing can only be used together with --dry-run"));
>         if ((addremove || take_worktree_changes) && !argc) {
> diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
> index 4cdebda..b2fcd01 100755
> --- a/t/t2200-add-update.sh
> +++ b/t/t2200-add-update.sh
> @@ -150,10 +150,6 @@ test_expect_success 'add -u resolves unmerged paths' '
>         echo 2 >path3 &&
>         echo 2 >path5 &&
>
> -       # Explicit resolving by adding removed paths should fail
> -       test_must_fail git add path4 &&
> -       test_must_fail git add path6 &&
> -
>         # "add -u" should notice removals no matter what stages
>         # the index entries are in.
>         git add -u &&
> --
> 1.7.12.rc2.85.g1de7134
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
