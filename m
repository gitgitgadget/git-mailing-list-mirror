From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/23] rebase -i: allow squashing empty commits without complaints
Date: Thu, 7 Aug 2014 18:03:21 -0400
Message-ID: <CAPig+cSvLwcwZ_8R0nRYst9V9mfRqc-HMDhyrCoU6cxE254Agg@mail.gmail.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Phil Hord <phil.hord@gmail.com>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 00:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFVmZ-0001z8-Uo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaHGWDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 18:03:23 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:63464 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaHGWDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 18:03:22 -0400
Received: by mail-yh0-f48.google.com with SMTP id i57so3421086yha.21
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HYPWq/RwFhVVJbvYPTq+R509kGR5AjUZQTDxsoj6OlA=;
        b=FxQsnEtARIe1hjxshZU9VcEy14jNyvz546VEeAd2ZnITylJ98AC4KaJD2YS8S2S+mG
         q9wCjYL3Eb4j+nnzt+bGUaxXw84h2SyIehi/RxjpYEaFVcCCxIdEpVpIvGG+EkC77eYQ
         ENxytoX1U9Ht7fKV2kT18kqykfYxqUS1wY+bkYPKDnPgOD4NgrJjI7HDJlVZQcn43e44
         I2DmHXUfwNjxhgB7h8QKKoL9P0d/x1mugk8TBggw7z+cBtKVhjnqVzdUpzgmxsS8HiId
         vYd1bNHJd/jfY7y/VB1i02Iotb9nfJ7DG7VRRllfhPSzCX2pGqSot0S/7orxY/zGZeJ2
         f3xg==
X-Received: by 10.236.120.130 with SMTP id p2mr7818170yhh.166.1407449001812;
 Thu, 07 Aug 2014 15:03:21 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Thu, 7 Aug 2014 15:03:21 -0700 (PDT)
In-Reply-To: <16751a4402233b6c2925bf00d7ecebdccedd0eef.1407368621.git.bafain@gmail.com>
X-Google-Sender-Auth: 4LNuLlMXwA0lopeFCC_n67AOd0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254998>

On Wed, Aug 6, 2014 at 7:59 PM, Fabian Ruch <bafain@gmail.com> wrote:
> The to-do list commands `squash` and `fixup` apply the changes
> introduced by the named commit to the tree but instead of creating
> a new commit on top of the current head it replaces the previous
> commit with a new commit that records the updated tree. If the
> result is an empty commit git-rebase stops with the error message
>
>    You asked to amend the most recent commit, but doing so would make
>    it empty. You can repeat your command with --allow-empty, or you can
>    remove the commit entirely with "git reset HEAD^".
>
> This message is not very helpful because neither does git-rebase
> support an option `--allow-empty` nor does the messages say how to
> resume the rebase. Firstly, change the error message to
>
>    The squash result is empty and --keep-empty was not specified.
>
>    You can remove the squash commit now with
>
>      git reset HEAD^
>
>    Once you are down, run

I guess you meant: s/down/done

Same issue with the actually message in the code (below).

>      git rebase --continue
>
> If the user wishes to squash a sequence of commits into one
> commit, f. i.
>
>    pick A
>    squash Revert "A"
>    squash A'
>
> , it does not matter for the end result that the first squash
> result, or any sub-sequence in general, is going to be empty. The
> squash message is not affected at all by which commits are created
> and only the commit created by the last line in the sequence will
> end up in the final history. Secondly, print the error message
> only if the whole squash sequence produced an empty commit.
>
> Lastly, since an empty squash commit is not a failure to rewrite
> the history as planned, issue the message above as a mere warning
> and interrupt the rebase with the return value zero. The
> interruption should be considered as a notification with the
> chance to undo it on the spot. Specifying the `--keep-empty`
> option tells git-rebase to keep empty squash commits in the
> rebased history without notification.
>
> Add tests.
>
> Reported-by: Peter Krefting <peter@softwolves.pp.se>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
> Hi,
>
> Peter Krefting is cc'd as the author of the bug report "Confusing
> error message in rebase when commit becomes empty" discussed on the
> mailing list in June. Phil Hord and Jeff King both participated in
> the problem discussion which ended with two proposals by Jeff.
>
> Jeff King writes:
>>   1. Always keep such empty commits. A user who is surprised by them
>>      being empty can then revisit them. Or drop them by doing another
>>      rebase without --keep-empty.
>>
>>   2. Notice ourselves that the end-result of the whole squash is an
>>      empty commit, and stop to let the user deal with it.
>
> This patch chooses the second alternative. Either way seems OK. The
> crucial consensus of the discussion was to silently throw away empty
> interim commits.
>
>    Fabian
>
>  git-rebase--interactive.sh    | 20 +++++++++++---
>  t/t3404-rebase-interactive.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 3222bf6..8820eac 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -549,7 +549,7 @@ do_next () {
>                 squash|s|fixup|f)
>                         # This is an intermediate commit; its message will only be
>                         # used in case of trouble.  So use the long version:
> -                       do_with_author output git commit --allow-empty-message \
> +                       do_with_author output git commit --allow-empty-message --allow-empty \
>                                 --amend --no-verify -F "$squash_msg" \
>                                 ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>                                 die_failed_squash $sha1 "$rest"
> @@ -558,18 +558,32 @@ do_next () {
>                         # This is the final command of this squash/fixup group
>                         if test -f "$fixup_msg"
>                         then
> -                               do_with_author git commit --allow-empty-message \
> +                               do_with_author git commit --allow-empty-message --allow-empty \
>                                         --amend --no-verify -F "$fixup_msg" \
>                                         ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>                                         die_failed_squash $sha1 "$rest"
>                         else
>                                 cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
>                                 rm -f "$GIT_DIR"/MERGE_MSG
> -                               do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
> +                               do_with_author git commit --allow-empty --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
>                                         ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>                                         die_failed_squash $sha1 "$rest"
>                         fi
>                         rm -f "$squash_msg" "$fixup_msg"
> +                       if test -z "$keep_empty" && is_empty_commit HEAD
> +                       then
> +                               echo "$sha1" >"$state_dir"/stopped-sha
> +                               warn "The squash result is empty and --keep-empty was not specified."
> +                               warn
> +                               warn "You can remove the squash commit now with"
> +                               warn
> +                               warn "  git reset HEAD^"
> +                               warn
> +                               warn "Once you are down, run"

s/down/done/

> +                               warn
> +                               warn "  git rebase --continue"
> +                               exit 0
> +                       fi
>                         ;;
>                 esac
>                 record_in_rewritten $sha1
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 9c71835..a95cb2a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -237,6 +237,68 @@ test_expect_success 'retain authorship' '
>         git show HEAD | grep "^Author: Twerp Snog"
>  '
>
> +test_expect_success 'setup squash/fixup reverted and fixed feature' '
> +       git checkout -b reverted-feature master &&
> +       test_commit feature &&
> +       git revert feature &&
> +       git checkout -b fixed-feature reverted-feature &&
> +       test_commit featurev2
> +'
> +
> +test_expect_success 'fixup fixed feature (empty interim commit)' '
> +       git checkout -b fixup-fixed-feature fixed-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 fixup 2 fixup 3" git rebase -i master &&
> +       git log --oneline master.. >actual &&
> +       test_line_count = 1 actual &&
> +       git diff --exit-code featurev2
> +'
> +
> +test_expect_success 'squash fixed feature (empty interim commit)' '
> +       git checkout -b squash-fixed-feature fixed-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 squash 2 squash 3" git rebase -i master &&
> +       git log --oneline master.. >actual &&
> +       test_line_count = 1 actual &&
> +       git diff --exit-code featurev2
> +'
> +
> +test_expect_success 'fixup reverted feature (empty final commit)' '
> +       git checkout -b fixup-reverted-feature reverted-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 fixup 2" git rebase -i master &&
> +       git reset HEAD^ &&
> +       git rebase --continue &&
> +       test_cmp_rev master HEAD
> +'
> +
> +test_expect_success 'squash reverted feature (empty final commit)' '
> +       git checkout -b squash-reverted-feature reverted-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 squash 2" git rebase -i master &&
> +       git reset HEAD^ &&
> +       git rebase --continue &&
> +       test_cmp_rev master HEAD
> +'
> +
> +test_expect_success 'fixup reverted feature (empty final commit with --keep-empty)' '
> +       git checkout -b fixup-keep-reverted-feature reverted-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 fixup 2" git rebase -i --keep-empty master &&
> +       git log --oneline master.. >actual &&
> +       test_line_count = 1 actual &&
> +       git diff --exit-code master
> +'
> +
> +test_expect_success 'squash reverted feature (empty final commit with --keep-empty)' '
> +       git checkout -b squash-keep-reverted-feature reverted-feature &&
> +       set_fake_editor &&
> +       FAKE_LINES="1 squash 2" git rebase -i --keep-empty master &&
> +       git log --oneline master.. >actual &&
> +       test_line_count = 1 actual &&
> +       git diff --exit-code master
> +'
> +
>  test_expect_success 'squash' '
>         git reset --hard twerp &&
>         echo B > file7 &&
> --
> 2.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
