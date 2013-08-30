From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Fri, 30 Aug 2013 21:40:41 +0200
Message-ID: <5220F539.9050700@web.de>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr> <1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr> <521FA6ED.9010005@web.de> <vpqioyonqdn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 30 21:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFUYq-000648-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 21:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab3H3Tko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 15:40:44 -0400
Received: from mout.web.de ([212.227.15.3]:54615 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab3H3Tko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 15:40:44 -0400
Received: from [192.168.178.41] ([91.3.174.105]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MFL2m-1VC8Uv220y-00EMpS for <git@vger.kernel.org>;
 Fri, 30 Aug 2013 21:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <vpqioyonqdn.fsf@anie.imag.fr>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:ev4j/xglxbD3Il09d+OHsiplBnL9ezLAGx9OvDIblsRVoP3Iogx
 YlNNwAIOmy6sQgo+eoIb52eL8IK39PnFIvO+meQSOMhoNrRj7MGnTgpp3VsTxlJH3vFAB9+
 MhRonH700hmAbfTjziJ1H2uTH7huED69b95TE5VYaTcmLxXTE5mwS+UAFqiFfwAIXuX/PRH
 1nhDBLaHjGQa3WnFx/dCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233464>

Am 29.08.2013 23:23, schrieb Matthieu Moy:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 29.08.2013 15:05, schrieb Matthieu Moy:
>>> The --for-status option was an undocumented option used only by
>>> wt-status.c, which inserted a header and commented out the output. We can
>>> achieve the same result within wt-status.c, without polluting the
>>> submodule command-line options.
>>>
>>> This will make it easier to disable the comments from wt-status.c later.
>>
>> Cool, thanks for implementing this!
>>
>> But unfortunately this change collides with bc/submodule-status-ignored
>> (I added Brian to the CC) which is currently on its way to next.
> 
> Thanks for pointing that out. The patch looks buggy:

Ok, I'll tak

> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1036,6 +1036,13 @@ cmd_summary() {
>                 do
>                         # Always show modules deleted or type-changed (blob<->module)
>                         test $status = D -o $status = T && echo "$sm_path" && continue
> +                       # Respect the ignore setting for --for-status.
> +                       if test -n $for_status
> +                       then
> +                               name=$(module_name "$sm_path")
> +                               ignore_config=$(get_submodule_config "$name" ignore none)
> +                               test $status != A -a $ignore_config = all && continue
> +                       fi
> 
> Because of the missing quotes around $for_status, it seems the test is
> unconditionnaly true:
> 
> $ test -n t ; echo $?
> 0
> $ test -n   ; echo $?
> 0
> 
> This makes me wonder why the ignore configuration should be considered
> only with --for-status. Why not turn that into
> 
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1036,6 +1036,13 @@ cmd_summary() {
>                 do
>                         # Always show modules deleted or type-changed (blob<->module)
>                         test $status = D -o $status = T && echo "$sm_path" && continue
> +			# Respect the ignore setting
> +			name=$(module_name "$sm_path")
> +			ignore_config=$(get_submodule_config "$name" ignore none)
> +			test $status != A -a $ignore_config = all && continue
> 
> ?
> 
