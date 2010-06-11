From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.* 
	configurations ignored for known tools
Date: Fri, 11 Jun 2010 11:54:27 +0200
Message-ID: <AANLkTikK0t_-H5zgzUToiTlyWCFGCJ63wok-t7wX09OW@mail.gmail.com>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
	<1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
	<20100608083445.GC14366@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 12:01:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON13l-0005MF-6w
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 12:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760080Ab0FKKBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 06:01:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58839 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760013Ab0FKKBv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 06:01:51 -0400
Received: by wyb40 with SMTP id 40so608691wyb.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 03:01:49 -0700 (PDT)
Received: by 10.216.163.204 with SMTP id a54mr802558wel.2.1276250067283; Fri, 
	11 Jun 2010 02:54:27 -0700 (PDT)
Received: by 10.216.229.12 with HTTP; Fri, 11 Jun 2010 02:54:27 -0700 (PDT)
X-Originating-IP: [80.13.22.90]
In-Reply-To: <20100608083445.GC14366@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148934>

On Tue, Jun 8, 2010 at 10:34, David Aguilar <davvid@gmail.com> wrote:
>
> Hi, sorry for the delay in responding to this email.
>
> On Sat, Jun 05, 2010 at 04:31:52AM +0200, Sylvain Rabot wrote:
>> At this time when you define merge.tool with a known tool,
>> such as meld, p4merge, diffuse ... etc, mergetool.<tool>.*
>> configurations are ignored and git mergetool will use its
>> own templates.
>>
>> This patch adds a detection for mergetool.<tool>.cmd configuration
>> in the run_merge_tool function. If the configuration is set, it will
>> try to run the tool with mergetool.<tool>.path if its set. It also
>> consider the mergetool.<tool>.trustExitCode configuration.
>>
>> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
>> ---
>> =A0git-mergetool--lib.sh | =A0 60 ++++++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 60 insertions(+), 0 deletions(-)
>>
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> index 51dd0d6..2a58d88 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -84,9 +84,69 @@ get_merge_tool_cmd () {
>>
>> =A0run_merge_tool () {
>> =A0 =A0 =A0 merge_tool_path=3D"$(get_merge_tool_path "$1")" || exit
>> + =A0 =A0 merge_tool_cmd=3D"$(get_merge_tool_cmd "$1")"
>> + =A0 =A0 merge_tool_cmd_base=3D"$(echo $merge_tool_cmd | cut -f1 -d=
 " ")"
>> =A0 =A0 =A0 base_present=3D"$2"
>> =A0 =A0 =A0 status=3D0
>>
>> + =A0 =A0 # if mergetool.<tool>.cmd is set we execute it, not a temp=
late
>> + =A0 =A0 if test -n "$merge_tool_cmd"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.path is empty
>> + =A0 =A0 =A0 =A0 =A0 =A0 if test -z "$merge_tool_path"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.cmd not=
 found
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ! $(which "$merge_tool_=
cmd_base" > /dev/null 2>&1); then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "=
Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge_cmd=3D=
"$merge_tool_path/$merge_tool_cmd"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.path is a path
>
> Files and Directories are both paths...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 elif test -d "$merge_tool_path"; then
>
> But...
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.cmd not=
 found
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if !test -f "$merge_tool_p=
ath/$merge_tool_cmd_base"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "=
Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_c=
md_base" | sed 's#//\+#/#')\" not found"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.cmd not=
 executable
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 elif !test -x "$merge_tool=
_path/$merge_tool_cmd_base"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "=
Configuration mergetool.$1.cmd \"$(echo "$merge_tool_path/$merge_tool_c=
md_base" | sed 's#//\+#/#')\" is not executable"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # tool ok
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge_cmd=3D=
"$merge_tool_path/$merge_tool_cmd"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>
> I don't think we ever signed up to support this configuration.
> mergetool.<tool>.path has always (from my naive reading of the
> documentation) been the absolute path to <tool>.

I did not see it that way but it seems cleaner.
So mergetool.<tool>.path would be the absolute path to the tool and
mergetool.<tool>.cmd would be only the args to call the tool with.

>
> I don't think it should have a dual-role where it can be either
> the tool's parent directory or the path to the tool itself.
> I would prefer to keep it as simple as possible, if we can.
>
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.path is the same as mer=
getool.<tool>.cmd
>> + =A0 =A0 =A0 =A0 =A0 =A0 elif test "$merge_tool_path" =3D "$merge_t=
ool_cmd_base"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.cmd not=
 found
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ! $(which "$merge_tool_=
cmd_base" > /dev/null 2>&1); then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "=
Configuration mergetool.$1.cmd \"$merge_tool_cmd_base\" not found"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge_cmd=3D=
"$merge_tool_cmd"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.path is the tool itself
>> + =A0 =A0 =A0 =A0 =A0 =A0 elif $(which "$merge_tool_path" > /dev/nul=
l 2>&1); then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 merge_cmd=3D"$merge_tool_p=
ath $merge_tool_cmd"
>> + =A0 =A0 =A0 =A0 =A0 =A0 # mergetool.<tool>.path invalid
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo >&2 "Configuration me=
rgetool.$1.path \"$merge_tool_path\" is not valid path"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit 1
>> + =A0 =A0 =A0 =A0 =A0 =A0 fi
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 # trust exit code
>> + =A0 =A0 =A0 =A0 =A0 =A0 trust_exit_code=3D"$(git config --bool mer=
getool."$1".trustExitCode || echo false)"
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if test "$trust_exit_code" =3D "false"; th=
en
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch "$BACKUP"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (eval "$merge_cmd")
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_unchanged
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $status
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (eval "$merge_cmd")
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status=3D$?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $status
>> + =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 fi
>
> This section is getting pretty nested.
> Should we break the handling for configs-that-override-builtins
> into a separate function?

I think the whole patch can be simplified if we assume path can only
be the absolute path to the tool.

>
>> +
>> =A0 =A0 =A0 case "$1" in
>> =A0 =A0 =A0 kdiff3)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if merge_mode; then
>> --
>> 1.7.1
>
> One last thing -- I tried to fetch from the repo you
> mentioned elsewhere in this thread but it was offline.

My bad, new box, new setup, forgot to authorize git daemon port to ipta=
bles.

>
> Cheers,

Thanks for your time.

>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0David
>



--=20
Sylvain
