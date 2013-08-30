From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Fri, 30 Aug 2013 21:51:51 +0200
Message-ID: <5220F7D7.2000300@web.de>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr> <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr> <521FA6ED.9010005@web.de> <vpqioyonqdn.fsf@anie.imag.fr> <5220F539.9050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 30 21:52:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFUjl-0003jg-Li
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 21:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab3H3Tvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 15:51:55 -0400
Received: from mout.web.de ([212.227.17.11]:64983 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab3H3Tvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 15:51:55 -0400
Received: from [192.168.178.41] ([91.3.174.105]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Ljrdd-1Vr2LB1Rft-00bwbV for <git@vger.kernel.org>;
 Fri, 30 Aug 2013 21:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <5220F539.9050700@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:9q3xnsSiOH8dp3pWygy9s4dElEEzuaurPYZ/6ZrC+K94UjthC4+
 GP2DGpsctlYowWaB7tG50+lDEz8WfKs2ksmdVQAgV7Jnk/bw1J5y/+mVtFteIqgjU8JuvOl
 77bSd43Uhr18FKNwLO0lVcM0zPEHO9ygXooYonTWGU7cR69QAnnhRJsywK4bu6fA88xq/nl
 sEMi41shwE8AiJvZDlYdg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233465>

Am 30.08.2013 21:40, schrieb Jens Lehmann:
> Am 29.08.2013 23:23, schrieb Matthieu Moy:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Am 29.08.2013 15:05, schrieb Matthieu Moy:
>>>> The --for-status option was an undocumented option used only by
>>>> wt-status.c, which inserted a header and commented out the output. We can
>>>> achieve the same result within wt-status.c, without polluting the
>>>> submodule command-line options.
>>>>
>>>> This will make it easier to disable the comments from wt-status.c later.
>>>
>>> Cool, thanks for implementing this!
>>>
>>> But unfortunately this change collides with bc/submodule-status-ignored
>>> (I added Brian to the CC) which is currently on its way to next.
>>
>> Thanks for pointing that out. The patch looks buggy:
> 
> Ok, I'll tak

Sorry, I accidentally hit "Send" ... :-(

Ok, I'll take a look and will comment on that soon.

>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1036,6 +1036,13 @@ cmd_summary() {
>>                 do
>>                         # Always show modules deleted or type-changed (blob<->module)
>>                         test $status = D -o $status = T && echo "$sm_path" && continue
>> +                       # Respect the ignore setting for --for-status.
>> +                       if test -n $for_status
>> +                       then
>> +                               name=$(module_name "$sm_path")
>> +                               ignore_config=$(get_submodule_config "$name" ignore none)
>> +                               test $status != A -a $ignore_config = all && continue
>> +                       fi
>>
>> Because of the missing quotes around $for_status, it seems the test is
>> unconditionnaly true:
>>
>> $ test -n t ; echo $?
>> 0
>> $ test -n   ; echo $?
>> 0
>>
>> This makes me wonder why the ignore configuration should be considered
>> only with --for-status. Why not turn that into

Please don't. That changes the default behavior of submodule summary,
which never ignores any submodules. The ignore logic was added to core
git after commands like diff and status learned to check submodules for
modifications too. That was bad for people who used submodules to store
many and/or huge files in a way that wouldn't slow down diff or status,
as it slowed them down again. The ignore option allowed them to continue
using submodules for that purpose. They still need to have the submodule
script ignore the ignore settings, because running them is the point in
time they want to take the extra effort to look into those submodules
they normally ignore. And that's why the submodule totally lacks any
option to control the ignore behavior, which we would also have to add
if we would follow your proposal.

So I think it's either changing the default behavior of --for-status or
adding another option (--for-status-wo-comment or such) which will honor
the ignore setting only when called from status.

>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1036,6 +1036,13 @@ cmd_summary() {
>>                 do
>>                         # Always show modules deleted or type-changed (blob<->module)
>>                         test $status = D -o $status = T && echo "$sm_path" && continue
>> +			# Respect the ignore setting
>> +			name=$(module_name "$sm_path")
>> +			ignore_config=$(get_submodule_config "$name" ignore none)
>> +			test $status != A -a $ignore_config = all && continue
>>
>> ?
>>
> 
