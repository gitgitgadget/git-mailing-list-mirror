From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: refactor {diff,merge}_cmd logic
Date: Sun, 16 Jun 2013 22:31:29 -0700
Message-ID: <CAJDDKr5ewcYgtZn-oCQ5b=rGix5EALRdiSaNMatOwtP75e0h3g@mail.gmail.com>
References: <828585499e535649d14ef0ecd0f53403aefb10c2.1371405056.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jun 17 07:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoS2Q-0000iL-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 07:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3FQFba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 01:31:30 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49132 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab3FQFb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 01:31:29 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so2398794pdd.20
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 22:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wPt59pDn0obhz7+SQZ2BFV5qP6ytYa1kpWYQ/uGFryE=;
        b=tTDWOVSq2OZI4zMKZPOCVKaVBnK/1QrvEnxwJms47DcAfUDixLWovtQ1XBAQJS9t65
         ivF0Kh0jiVaUx/Li9LLRD8wSit5fuhIJTJhBm+tWXjP0aln/JTcjaOZY+t32HxZCoKRd
         dLooSmtAY4n92az20o2AfucfgxruoxeN4BCJACr7i+tZR3aO0WznNllG2SMbq9dZk4Z7
         4W5uPzAuKo/eNcYvCcgSTAXAS5GY2Y1zgORxvxzOHaWVTP1jxrv+XMUqXUiLkryKasXx
         /lnp8QcUXKx54FHIyU3bxFvt1t93J1p1YOcILw6JS+QkvrqK/W4gyFx7r5UIhCWg5hAt
         1JaQ==
X-Received: by 10.68.20.165 with SMTP id o5mr11100598pbe.220.1371447089310;
 Sun, 16 Jun 2013 22:31:29 -0700 (PDT)
Received: by 10.70.20.161 with HTTP; Sun, 16 Jun 2013 22:31:29 -0700 (PDT)
In-Reply-To: <828585499e535649d14ef0ecd0f53403aefb10c2.1371405056.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228043>

On Sun, Jun 16, 2013 at 10:51 AM, John Keeping <john@keeping.me.uk> wrote:
> Instead of needing a wrapper to call the diff/merge command, simply
> provide the diff_cmd and merge_cmd functions for user-specified tools in
> the same way as we do for built-in tools.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

This is a nice cleanup.

Acked-by: David Aguilar <davvid@gmail.com>


>  git-mergetool--lib.sh | 82 ++++++++++++++++++++++-----------------------------
>  1 file changed, 35 insertions(+), 47 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index e338be5..6a72106 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -114,6 +114,33 @@ valid_tool () {
>         test -n "$cmd"
>  }
>
> +setup_user_tool () {
> +       merge_tool_cmd=$(get_merge_tool_cmd "$tool")
> +       test -n "$merge_tool_cmd" || return 1
> +
> +       diff_cmd () {
> +               ( eval $merge_tool_cmd )
> +               status=$?
> +               return $status
> +       }
> +
> +       merge_cmd () {
> +               trust_exit_code=$(git config --bool \
> +                       "mergetool.$1.trustExitCode" || echo false)
> +               if test "$trust_exit_code" = "false"
> +               then
> +                       touch "$BACKUP"
> +                       ( eval $merge_tool_cmd )
> +                       status=$?
> +                       check_unchanged
> +               else
> +                       ( eval $merge_tool_cmd )
> +                       status=$?
> +               fi
> +               return $status
> +       }
> +}
> +
>  setup_tool () {
>         tool="$1"
>
> @@ -142,15 +169,15 @@ setup_tool () {
>
>         if ! test -f "$MERGE_TOOLS_DIR/$tool"
>         then
> -               # Use a special return code for this case since we want to
> -               # source "defaults" even when an explicit tool path is
> -               # configured since the user can use that to override the
> -               # default path in the scriptlet.
> -               return 2
> +               setup_user_tool
> +               return $?
>         fi
>
>         # Load the redefined functions
>         . "$MERGE_TOOLS_DIR/$tool"
> +       # Now let the user override the default command for the tool.  If
> +       # they have not done so then this will return 1 which we ignore.
> +       setup_user_tool
>
>         if merge_mode && ! can_merge
>         then
> @@ -187,20 +214,7 @@ run_merge_tool () {
>         status=0
>
>         # Bring tool-specific functions into scope
> -       setup_tool "$1"
> -       exitcode=$?
> -       case $exitcode in
> -       0)
> -               :
> -               ;;
> -       2)
> -               # The configured tool is not a built-in tool.
> -               test -n "$merge_tool_path" || return 1
> -               ;;
> -       *)
> -               return $exitcode
> -               ;;
> -       esac
> +       setup_tool "$1" || return 1
>
>         if merge_mode
>         then
> @@ -213,38 +227,12 @@ run_merge_tool () {
>
>  # Run a either a configured or built-in diff tool
>  run_diff_cmd () {
> -       merge_tool_cmd=$(get_merge_tool_cmd "$1")
> -       if test -n "$merge_tool_cmd"
> -       then
> -               ( eval $merge_tool_cmd )
> -               status=$?
> -               return $status
> -       else
> -               diff_cmd "$1"
> -       fi
> +       diff_cmd "$1"
>  }
>
>  # Run a either a configured or built-in merge tool
>  run_merge_cmd () {
> -       merge_tool_cmd=$(get_merge_tool_cmd "$1")
> -       if test -n "$merge_tool_cmd"
> -       then
> -               trust_exit_code=$(git config --bool \
> -                       "mergetool.$1.trustExitCode" || echo false)
> -               if test "$trust_exit_code" = "false"
> -               then
> -                       touch "$BACKUP"
> -                       ( eval $merge_tool_cmd )
> -                       status=$?
> -                       check_unchanged
> -               else
> -                       ( eval $merge_tool_cmd )
> -                       status=$?
> -               fi
> -               return $status
> -       else
> -               merge_cmd "$1"
> -       fi
> +       merge_cmd "$1"
>  }
>
>  list_merge_tool_candidates () {
> --
> 1.8.3.779.g691e267
>



--
David
