From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] gitk: add -C <path> commandline parameter to change path
Date: Fri, 6 Nov 2015 04:48:02 -0500
Message-ID: <CAPig+cT9K2H_jzVNOHS0vaarU+tfDfp_=Z4c1n6o5EX9wE6JXA@mail.gmail.com>
References: <CAPig+cSs0v88AiQwSrqm-wK7rY4RdykaVf5Axh5jFyij25rfvg@mail.gmail.com>
	<1446715164-19165-1-git-send-email-juhapekka.heikkila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 10:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zudd0-0003QI-5G
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 10:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032905AbbKFJsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 04:48:08 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34610 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698AbbKFJsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 04:48:03 -0500
Received: by vkgs66 with SMTP id s66so10621063vkg.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 01:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/XIGjQwE5CnxkF9slwrCi6c3v+MLrkA7QPI7Y/JhZ+k=;
        b=u0ccZbjWRgbI9lLDN7CqgE76F1iY0cBD5eCD5S30LNJkvXCxhL0KKKH4UWznz5mXzj
         BEH0nHvsCsZxgqSxTr7rZ4MxJTErp97/s2yMU1BIMmobjugq5TehYxx4Bf//NftSDE/G
         eynPTcN3CY6HpUO/uSmsYmURK2KmhSY7gv6CzCzCsowm+XpmOCC3rdW/jogS/5fwfujO
         AD4dCCkSXeJuNR9xy9ifQVvqAmjvzcsqPRcALrooDyuhQJgkjuN3vJVvKqjLGCMYVQTD
         VQVB9cBRYzI82WgWBrv1YiMWYkCCpA54S2LJzFY0Al8e6I0cVKSYR4g2o3xj2Hp4qSZp
         WYug==
X-Received: by 10.31.163.85 with SMTP id m82mr11504247vke.19.1446803282901;
 Fri, 06 Nov 2015 01:48:02 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Fri, 6 Nov 2015 01:48:02 -0800 (PST)
In-Reply-To: <1446715164-19165-1-git-send-email-juhapekka.heikkila@gmail.com>
X-Google-Sender-Auth: hujh-_3dzIHe9apVWYA0xGVain8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280971>

On Thu, Nov 5, 2015 at 4:19 AM, Juha-Pekka Heikkila
<juhapekka.heikkila@gmail.com> wrote:
> This patch adds -C (change working directory) parameter to
> gitk. With this parameter, instead of need to cd to directory
> with .git folder, one can point the correct folder from
> commandline.

Thanks, -C makes more sense than --cwd, and is more consistent with
other commands.

You'll want to also address the patch to Paul Mackerras (I've cc:'d
him) since he's the gitk maintainer, and Junio pulls gitk from him.

> v2: Adjusted the parameter as per Eric's suggestion. I think
>     it now work in similar manner as in many GNU tools as well
>     as git itself.

This sort of explanation of of changes between versions is definitely
welcome, but should be placed below the "---" line just under your
sign-off so that it does not become part of the permanent commit
message.

> Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
> ---

You'd place your commentary about changes between patch versions here.
More below...

>  Documentation/gitk.txt |  7 +++++++
>  gitk-git/gitk          | 26 +++++++++++++++++---------
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> @@ -12279,20 +12279,14 @@ setui $uicolor
>
>  setoptions
>
> -# check that we can find a .git directory somewhere...
> -if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
> -    show_error {} . [mc "Cannot find a git repository here."]
> -    exit 1
> -}
> -
>  set selecthead {}
>  set selectheadid {}
>
>  set revtreeargs {}
>  set cmdline_files {}
> -set i 0
>  set revtreeargscmd {}
> -foreach arg $argv {
> +for {set i 0} {$i < [llength $argv]} {incr i} {
> +       set arg [lindex $argv [expr {$i}]]
>      switch -glob -- $arg {
>         "" { }
>         "--" {
> @@ -12305,11 +12299,25 @@ foreach arg $argv {
>         "--argscmd=*" {
>             set revtreeargscmd [string range $arg 10 end]
>         }
> +       "-C*" {
> +               if {[string length $arg] < 3} {
> +                       incr i
> +                       cd [lindex $argv [expr {$i}]]

What happens if no arguments follow -C (that is, the entire
command-line is "gitk -C")? Will this simply run "cd" with no argument
or with an empty argument or error out or what? Should there be a
check for this condition?

> +                       continue

Why does this 'continue' need to be here? Am I missing something obvious?

> +               } else {
> +                       cd [string range $arg 2 end]
> +               }
> +       }
>         default {
>             lappend revtreeargs $arg
>         }
>      }
> -    incr i
> +}
> +
> +# check that we can find a .git directory somewhere...
> +if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
> +    show_error {} . [mc "Cannot find a git repository here."]
> +    exit 1
>  }
>
>  if {$selecthead eq "HEAD"} {
> --
> 1.9.1
