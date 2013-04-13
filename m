From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH] submodule foreach: Added in --post-order=<command> and
 adjusted code per Jens Lehmann's suggestions
Date: Fri, 12 Apr 2013 23:11:32 -0500
Message-ID: <CA+aSAWviVWd3+89Wpv-1_6BSL=aN-u+60_oDXcyCG03enBmGTg@mail.gmail.com>
References: <515B3C0E.9000802@web.de>
	<1365825865-12858-1-git-send-email-eacousineau@gmail.com>
	<CA+aSAWuK9Yhvx-vO1fUteq-K=xOPgxkyeWeHG3UwZuDHsxLzAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 06:11:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQroa-0007ky-55
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 06:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab3DMELf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 00:11:35 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:40246 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab3DMELe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 00:11:34 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so3202565lbi.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 21:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=7mbqbELKu2VtFOyRc8XmcuFiaEmpUWpgEFEzQ2+rXXc=;
        b=ZRWc4pzrAgz8mwnz7EBqqnUKS7DtXxzOmdKdG+A+hDgINZ/hV1V3eunzX4jkbPE7Oh
         Rjo4lp5MEPCo46MWYpDu5/shoRG4WumJ9mF+30zdUJLM1MpaQe5bFE1/2PODKik1QMMJ
         Xx2huIp1Jy9sdidaV2bB4uJC9hjVoJ9nZpW7rasZr+KjwwWi44ou8a7wmJFmxizc1Lfc
         s2Xo43xrl40DkWhJqq0wgr4pItAxCWknlo1kcY3s5cqJDIQkNODPA0fiEdRN5dkBRgZ8
         Oni8Cs3CeU9q14kJqn8dxuKpPglHaLmxyesxL8TNw95mkgDQOYMuzEr8Tga0lrpDUaLA
         /VhQ==
X-Received: by 10.112.143.133 with SMTP id se5mr6565331lbb.101.1365826292360;
 Fri, 12 Apr 2013 21:11:32 -0700 (PDT)
Received: by 10.114.93.162 with HTTP; Fri, 12 Apr 2013 21:11:32 -0700 (PDT)
In-Reply-To: <CA+aSAWuK9Yhvx-vO1fUteq-K=xOPgxkyeWeHG3UwZuDHsxLzAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221045>

Had accidentally sent this as HTML, resending as plain-text.

On Fri, Apr 12, 2013 at 11:09 PM, Eric Cousineau <eacousineau@gmail.com> wrote:
>
> Oops... I tried out using git-send-email adding in the Message-Id, but forgot to change the title as well. My bad.
>
> This was in response to:
>
> [PATCH/RFC] Changing submodule foreach --recursive to be depth-first, --parent option to execute command in supermodule as well
> Message-Id: <515B3C0E.9000802@web.de>
>
> - Eric
>
>
> On Fri, Apr 12, 2013 at 11:04 PM, eacousineau <eacousineau@gmail.com> wrote:
>>
>> Signed-off-by: eacousineau <eacousineau@gmail.com>
>> ---
>> I see what you meant by the extra variables, so I've fixed that so the
>> original flags aren't needed with recursion. Also updated it to not
>> print the entering command if there is only a post-order command.
>>
>> Examples:
>>
>> $ git submodule foreach --recursive --post-order 'echo Goodbye' "echo \"'ello\""
>> Entering 'b'
>> 'ello
>> Entering 'b/d'
>> 'ello
>> Leaving 'b/d'
>> Goodbye
>> Leaving 'b'
>> Goodbye
>> Entering 'c'
>> 'ello
>> Leaving 'c'
>> Goodbye
>>
>> $ git submodule foreach --recursive --post-order :
>> Leaving 'b/d'
>> Leaving 'b'
>> Leaving 'c'
>>
>>  git-submodule.sh | 31 ++++++++++++++++++++++++++-----
>>  1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 79bfaac..e08a724 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
>>     or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
>>     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>> -   or: $dashless [--quiet] foreach [--recursive] <command>
>> +   or: $dashless [--quiet] foreach [--recursive] [--post-order <command>] <command>
>>     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>>  OPTIONS_SPEC=
>>  . git-sh-setup
>> @@ -449,6 +449,15 @@ cmd_foreach()
>>                 --recursive)
>>                         recursive=1
>>                         ;;
>> +               --post-order)
>> +                       test "$#" = "1" && usage
>> +                       post_order="$2"
>> +                       shift
>> +                       ;;
>> +               --post-order=*)
>> +                       # Will skip empty commands
>> +                       post_order=${1#*=}
>> +                       ;;
>>                 -*)
>>                         usage
>>                         ;;
>> @@ -471,7 +480,9 @@ cmd_foreach()
>>                 die_if_unmatched "$mode"
>>                 if test -e "$sm_path"/.git
>>                 then
>> -                       say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
>> +                       enter_msg="$(eval_gettext "Entering '\$prefix\$sm_path'")"
>> +                       leave_msg="$(eval_gettext "Leaving '\$prefix\$sm_path'")"
>> +                       die_msg="$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
>>                         name=$(module_name "$sm_path")
>>                         (
>>                                 prefix="$prefix$sm_path/"
>> @@ -479,13 +490,23 @@ cmd_foreach()
>>                                 # we make $path available to scripts ...
>>                                 path=$sm_path
>>                                 cd "$sm_path" &&
>> -                               eval "$@" &&
>> +                               if test $# -gt 0 -o -z "$post_order"
>> +                               then
>> +                                       say "$enter_msg" &&
>> +                                       eval "$@" || die "$die_msg"
>> +                               fi &&
>>                                 if test -n "$recursive"
>>                                 then
>> -                                       cmd_foreach "--recursive" "$@"
>> +                                       # subshell will use parent-scoped values
>> +                                       cmd_foreach "$@"
>> +                               fi &&
>> +                               if test -n "$post_order"
>> +                               then
>> +                                       say "$leave_msg" &&
>> +                                       eval "$post_order" || die "$die_msg"
>>                                 fi
>>                         ) <&3 3<&- ||
>> -                       die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
>> +                       die "$die_msg"
>>                 fi
>>         done
>>  }
>> --
>> 1.8.2.1.390.gd4ee029
>>
>
