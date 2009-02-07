From: Jonathan del Strother <jon.delStrother@bestbefore.tv>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Sat, 7 Feb 2009 12:01:37 +0000
Message-ID: <57518fd10902070401x14cc7cacrfb8bc88bbf2999cd@mail.gmail.com>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <7vr62ay8dh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 13:03:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVlts-0005zg-08
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 13:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbZBGMBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 07:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZBGMBk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 07:01:40 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:39556 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZBGMBj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 07:01:39 -0500
Received: by fxm13 with SMTP id 13so1738737fxm.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=nji/QQ2+nnEjScK+eaWqfYl6icIc4pOf8oyYovXbwA4=;
        b=lS0UfSFbQdipuf0lX9objNwqvK+cCZNrXbYqF5GFNRyeERUDdiQ9YkS+93ceV3iMyj
         M5rennVuk0xSu5uMblE+ERZ5K4NXKxg0cbA7xD/t7mqJU3NkuyDK4fPJ3sOqnfa/RtTs
         SllgdlgFQKdu2vFS5I39hFydMfHIX34jsh+Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sV2CEXqLZhFan//1vQR0/1urj0byieEP10xZBP+/DJtztrzF+Kt30UBRdPIu+Ld63M
         8vhWnEIvO7J3y1jvSDCsrmFgc0/9hzedgE8g09NA08X1/qf2cFDQtlwwqzyTSEZ/OYAU
         D4BbMXUWgF6zQdyAt2av3/kXnNZ6QbkvtWCXA=
Received: by 10.223.115.16 with SMTP id g16mr2220711faq.93.1234008097280; Sat, 
	07 Feb 2009 04:01:37 -0800 (PST)
In-Reply-To: <7vr62ay8dh.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 9087b35cfc5cbd65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108844>

On Sat, Feb 7, 2009 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan del Strother <jon.delStrother@bestbefore.tv> writes:
>
>> Add a "Show changes" option to each prompt in mergetool. This prints the
>> conflicted changes on the current file, using 'git log -p --merge
>> <file>'
>
> I think the patch should look like this, given the recent conversation I
> had with you.  It seems that the script thinks the unit of indentation is
> 4-places, and case arms are indented from case/esac (neither of which is
> the standard git shell script convention), and I tried to match that style
> used in the existing code.
>
> No, I didn't test it.
>
> Charles volunteered to take over mergetool, so he is on the Cc: list.
>
>  git-mergetool.sh |   60 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 47 insertions(+), 13 deletions(-)
>
> diff --git c/git-mergetool.sh w/git-mergetool.sh
> index 87fa88a..b8604d6 100755
> --- c/git-mergetool.sh
> +++ w/git-mergetool.sh
> @@ -14,6 +14,13 @@ OPTIONS_SPEC=
>  . git-sh-setup
>  require_work_tree
>
> +if test -f "$GIT_DIR/MERGE_HEAD"
> +then
> +    in_merge=t show_changes=", (s)how changes"
> +else
> +    in_merge=f show_changes=
> +fi
> +
>  # Returns true if the mode reflects a symlink
>  is_symlink () {
>     test "$1" = 120000
> @@ -62,22 +69,28 @@ describe_file () {
>
>  resolve_symlink_merge () {
>     while true; do
> -       printf "Use (l)ocal or (r)emote, or (a)bort? "
> +       printf "Use (l)ocal or (r)emote$show_changes, or (a)bort? "
>        read ans
> -       case "$ans" in
> -           [lL]*)
> +       case "$in_merge,$ans" in
> +           ?,[lL]*)
>                git checkout-index -f --stage=2 -- "$MERGED"
>                git add -- "$MERGED"
>                cleanup_temp_files --save-backup
>                return 0
>                ;;
> -           [rR]*)
> +           ?,[rR]*)
>                git checkout-index -f --stage=3 -- "$MERGED"
>                git add -- "$MERGED"
>                cleanup_temp_files --save-backup
>                return 0
>                ;;
> -           [aA]*)
> +           t,[sS]*)
> +               git log -p --merge "$MERGED"
> +               printf "\n"
> +               resolve_symlink_merge
> +               return
> +               ;;
> +           ?,[aA]*)
>                return 1
>                ;;
>            esac
> @@ -87,23 +100,29 @@ resolve_symlink_merge () {
>  resolve_deleted_merge () {
>     while true; do
>        if base_present; then
> -           printf "Use (m)odified or (d)eleted file, or (a)bort? "
> +           printf "Use (m)odified or (d)eleted file$show_changes, or (a)bort? "
>        else
> -           printf "Use (c)reated or (d)eleted file, or (a)bort? "
> +           printf "Use (c)reated or (d)eleted file$show changes, or (a)bort? "
>        fi
>        read ans
> -       case "$ans" in
> -           [mMcC]*)
> +       case "$in_merge,$ans" in
> +           ?,[mMcC]*)
>                git add -- "$MERGED"
>                cleanup_temp_files --save-backup
>                return 0
>                ;;
> -           [dD]*)
> +           ?,[dD]*)
>                git rm -- "$MERGED" > /dev/null
>                cleanup_temp_files
>                return 0
>                ;;
> -           [aA]*)
> +           t,[sS]*)
> +               git log -p --merge "$MERGED"
> +               printf "\n"
> +               resolve_deleted_merge
> +               return
> +               ;;
> +           ?,[aA]*)
>                return 1
>                ;;
>            esac
> @@ -184,8 +203,23 @@ merge_file () {
>     describe_file "$local_mode" "local" "$LOCAL"
>     describe_file "$remote_mode" "remote" "$REMOTE"
>     if "$prompt" = true; then
> -       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
> -       read ans
> +       while true; do
> +           case $in_merge in
> +               t)      msg_head="(S)how changes, or h" ;;
> +               f)      msg_head="H" ;;
> +           esac
> +           print "${msg_head}it return to start merge resolution tool (%s): " "$merge_tool"
> +           read ans
> +           case "$in_merge,$ans" in
> +               t,[sS]*)
> +                   git log -p --merge "$MERGED"
> +                   printf "\n"
> +                   ;;
> +               ?,*)
> +                   break
> +                   ;;
> +           esac
> +        done
>     fi
>
>     case "$merge_tool" in
>


Looks good to me, though there's a minor typo on this line :
print "${msg_head}it return to start merge resolution tool (%s): " "$merge_tool"

- print should be printf

Cheers,
Jonathan
