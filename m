From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 03 Nov 2012 16:42:10 +0100
Message-ID: <50953B52.3070107@web.de>
References: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com> <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUfrj-000162-5h
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 16:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab2KCPmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 11:42:18 -0400
Received: from mout.web.de ([212.227.17.11]:57799 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab2KCPmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 11:42:17 -0400
Received: from [192.168.178.41] ([91.3.179.97]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MGiUP-1TYkKt24bx-00EGVn; Sat, 03 Nov 2012 16:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:2uY5zFqJ2cS+Og648GZOmQ/lMVpFiQuaNpEg3iUB5aq
 Hf3utd5o0KnWa2+/s0t+HUstzcE7GTYuAPvJEAahmvT6kpfBcx
 lmPbhgyYPRkAAAMD9arPoV8qydsiffaKsTjqGYiCdeFMwK6sQ9
 3u+bodAVXq2doWIw7FGmid2XVZQKdEOa+kCOeYFNqq3c6BD2Cn
 qG99RiIw0xiOh51L7KeuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208980>

Am 30.10.2012 19:11, schrieb Stefan Zager:
> This is a refresh of a conversation from a couple of months ago.
> 
> I didn't try to implement all the desired features (e.g., smart logic
> for passing a -j parameter to recursive submodule invocations), but I
> did address the one issue that Junio insisted on: the code makes a
> best effort to detect whether xargs supports parallel execution on the
> host platform, and if it doesn't, then it prints a warning and falls
> back to serial execution.

I suspect not passing on --jobs recursively like you do here is the
right thing to do, as that would give exponential growth of jobs with
recursion depth, which makes no sense to me.

A still unsolved issue is the unstructured output from the different
update jobs. It'll be hard (if not impossible) to see in what submodule
which update took place (or failed). I think we should have a solution
for that too (maybe one of those Heiko mentioned or something as simple
as implying "-q"?).

> Stefan
> 
> On Tue, Oct 30, 2012 at 11:03 AM,  <szager@google.com> wrote:
>> The --jobs parameter may be used to set the degree of per-submodule
>> parallel execution.
>
>> Signed-off-by: Stefan Zager <szager@google.com>
>> ---
>>  Documentation/git-submodule.txt |    8 ++++++-
>>  git-submodule.sh                |   40 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index b4683bb..cb23ba7 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -14,7 +14,8 @@ SYNOPSIS
>>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>  'git submodule' [--quiet] init [--] [<path>...]
>>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
>> -             [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>> +             [--reference <repository>] [--merge] [--recursive]
>> +             [-j|--jobs [jobs]] [--] [<path>...]
>>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
>>               [commit] [--] [<path>...]
>>  'git submodule' [--quiet] foreach [--recursive] <command>
>> @@ -146,6 +147,11 @@ If the submodule is not yet initialized, and you just want to use the
>>  setting as stored in .gitmodules, you can automatically initialize the
>>  submodule with the `--init` option.
>>  +
>> +By default, each submodule is treated serially.  You may specify a degree of
>> +parallel execution with the --jobs flag.  If a parameter is provided, it is
>> +the maximum number of jobs to run in parallel; without a parameter, all jobs are
>> +run in parallel.
>> ++

The new "--jobs" option should be documented under "OPTIONS", (and maybe
include that "--jobs 0" does the same as "--jobs" alone and that this is
not supported on all platforms).

>>  If `--recursive` is specified, this command will recurse into the
>>  registered submodules, and update any nested submodules within.
>>  +
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index ab6b110..60a5f96 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
>>  USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
>>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>     or: $dashless [--quiet] init [--] [<path>...]
>> -   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>> +   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-j|--jobs [jobs]] [--] [<path>...]
>>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>>     or: $dashless [--quiet] foreach [--recursive] <command>
>>     or: $dashless [--quiet] sync [--] [<path>...]"
>> @@ -500,6 +500,7 @@ cmd_update()
>>  {
>>         # parse $args after "submodule ... update".
>>         orig_flags=
>> +       jobs="1"
>>         while test $# -ne 0
>>         do
>>                 case "$1" in
>> @@ -518,6 +519,20 @@ cmd_update()
>>                 -r|--rebase)
>>                         update="rebase"
>>                         ;;
>> +               -j|--jobs)
>> +                       case "$2" in
>> +                       ''|-*)
>> +                               jobs="0"
>> +                               ;;
>> +                       *)
>> +                               jobs="$2"
>> +                               shift
>> +                               ;;
>> +                       esac
>> +                       # Don't preserve this arg.
>> +                       shift
>> +                       continue
>> +                       ;;
>>                 --reference)
>>                         case "$2" in '') usage ;; esac
>>                         reference="--reference=$2"
>> @@ -551,11 +566,34 @@ cmd_update()
>>                 shift
>>         done
>>
>> +       # Correctly handle the case where '-q' came before 'update' on the command line.
>> +       if test -n "$GIT_QUIET"
>> +       then
>> +               orig_flags="$orig_flags -q"
>> +       fi
>> +
>>         if test -n "$init"
>>         then
>>                 cmd_init "--" "$@" || return
>>         fi
>>
>> +       if test "$jobs" != 1
>> +       then
>> +               if ( echo test | xargs -P "$jobs" true 2>/dev/null )
>> +               then
>> +                       if ( echo test | xargs --max-lines=1 true 2>/dev/null ); then
>> +                               max_lines="--max-lines=1"
>> +                       else
>> +                               max_lines="-L 1"
>> +                       fi
>> +                       module_list "$@" | awk '{print $4}' |
>> +                       xargs $max_lines -P "$jobs" git submodule update $orig_flags
>> +                       return
>> +               else
>> +                       echo "Warn: parallel execution is not supported on this platform."
>> +               fi
>> +       fi
>> +
>>         cloned_modules=
>>         module_list "$@" | {
>>         err=
>> --
>> 1.7.7.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
