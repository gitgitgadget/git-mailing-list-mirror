From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Implement rebase -q to fix pull --rebase -q
Date: Wed, 3 Dec 2008 05:09:50 +0100
Message-ID: <4ac8254d0812022009t6eed5406ve2acb0b020240448@mail.gmail.com>
References: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 03 05:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7j4t-00076c-68
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 05:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbYLCEJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 23:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYLCEJx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 23:09:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:40698 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbYLCEJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 23:09:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1371595ywe.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 20:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8FZu8oCqPf/oWF+7hXk5PTPoZSmxctVd2NAtZawG6dE=;
        b=fg9ZT8dHP5eohUVwEqTT7M371uAAtp+OYzJI8BSG2ITRNjZYbE4TSqm9wQPPPOe5sd
         PscSn6Q8of1nCt2fOnvy7mnCLMEUUi91FfGyMPq9JJTiKKEJYkRa/1By6T9fjD4hdprK
         BdwSZYafCFufRBl6MG+JeIXuUh9R3G0WXdFic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b9+r4O7r72+n3Przb2wHc7OfzQffhVtAo8S7WHJcZ5jCO+pKVNkOPv/cVsDO+pI2gV
         7YvkTp8OXexPzxTohZ+tWrqDDO7aoThHkA04kO9Ou/qLmlIbBKVeHJlJJuLQb4TIbBLA
         CPEumBDBT+uYlWHyPTCCdndidcyTNzbLi8BW4=
Received: by 10.65.123.10 with SMTP id a10mr13099146qbn.79.1228277390464;
        Tue, 02 Dec 2008 20:09:50 -0800 (PST)
Received: by 10.65.242.16 with HTTP; Tue, 2 Dec 2008 20:09:50 -0800 (PST)
In-Reply-To: <1228277212-5917-1-git-send-email-tuncer.ayaz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102212>

On Wed, Dec 3, 2008 at 5:06 AM, Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> This is needed on top of the fetch/pull -q/-v changes
> to make
> $ git pull --rebase -q
> as quiet as expected.
>
> Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
> ---
>  git-pull.sh   |    2 +-
>  git-rebase.sh |   31 +++++++++++++++++++++++--------
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 1cac898..57fcee9 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -184,6 +184,6 @@ fi
>  merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
>  test true = "$rebase" &&
>        exec git-rebase $strategy_args --onto $merge_head \
> -       ${oldremoteref:-$merge_head}
> +       $verbosity ${oldremoteref:-$merge_head}
>  exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
>        "$merge_name" HEAD $merge_head $verbosity
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 023a6dc..bbfdc2e 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -3,7 +3,7 @@
>  # Copyright (c) 2005 Junio C Hamano.
>  #
>
> -USAGE='[--interactive | -i] [-v] [--onto <newbase>] <upstream> [<branch>]'
> +USAGE='[--interactive | -i] [-q] [-v] [--onto <newbase>] <upstream> [<branch>]'
>  LONG_USAGE='git-rebase replaces <branch> with a new branch of the
>  same name.  When the --onto option is provided the new branch starts
>  out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
> @@ -45,7 +45,7 @@ strategy=recursive
>  do_merge=
>  dotest="$GIT_DIR"/rebase-merge
>  prec=4
> -verbose=
> +verbosity=1
>  git_am_opt=
>
>  continue_merge () {
> @@ -135,7 +135,10 @@ move_to_original_branch () {
>  finish_rb_merge () {
>        move_to_original_branch
>        rm -r "$dotest"
> -       echo "All done."
> +       if test $verbosity -gt 0
> +       then
> +               echo "All done."
> +       fi
>  }
>
>  is_interactive () {
> @@ -288,8 +291,11 @@ do
>                esac
>                do_merge=t
>                ;;
> +       -q|--quiet)
> +               verbosity=0
> +               ;;
>        -v|--verbose)
> -               verbose=t
> +               verbosity=2
>                ;;
>        --whitespace=*)
>                git_am_opt="$git_am_opt $1"
> @@ -401,11 +407,14 @@ if test "$upstream" = "$onto" && test "$mb" = "$onto" &&
>  then
>        # Lazily switch to the target branch if needed...
>        test -z "$switch_to" || git checkout "$switch_to"
> -       echo >&2 "Current branch $branch_name is up to date."
> +       if test $verbosity -gt 0
> +       then
> +               echo >&2 "Current branch $branch_name is up to date."
> +       fi

If anyone dislikes the additional three lines I could combine
the test with the action on one line. I'm just not sure that would
make it better, especially depending on log message length.

>        exit 0
>  fi
>
> -if test -n "$verbose"
> +if test $verbosity -gt 1
>  then
>        echo "Changes from $mb to $onto:"
>        # We want color (if set), but no pager
> @@ -413,7 +422,10 @@ then
>  fi
>
>  # Detach HEAD and reset the tree
> -echo "First, rewinding head to replay your work on top of it..."
> +if test $verbosity -gt 0
> +then
> +       echo "First, rewinding head to replay your work on top of it..."
> +fi
>  git checkout -q "$onto^0" || die "could not detach HEAD"
>  git update-ref ORIG_HEAD $branch
>
> @@ -421,7 +433,10 @@ git update-ref ORIG_HEAD $branch
>  # we just fast forwarded.
>  if test "$mb" = "$branch"
>  then
> -       echo >&2 "Fast-forwarded $branch_name to $onto_name."
> +       if test $verbosity -gt 0
> +       then
> +               echo >&2 "Fast-forwarded $branch_name to $onto_name."
> +       fi
>        move_to_original_branch
>        exit 0
>  fi
> --
> 1.6.0.2.GIT
>
>
