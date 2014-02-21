From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Fri, 21 Feb 2014 16:46:29 +0100
Message-ID: <530774D5.8040101@web.de>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com> <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de> <xmqqsird6137.fsf@gitster.dls.corp.google.com> <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 16:46:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGsJD-0000Gw-QK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 16:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbaBUPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 10:46:35 -0500
Received: from mout.web.de ([212.227.15.3]:58866 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932145AbaBUPqe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 10:46:34 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MZlZK-1WYxej2rEc-00LV4M for <git@vger.kernel.org>;
 Fri, 21 Feb 2014 16:46:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
X-Provags-ID: V03:K0:dSqB5Z0+D/LlbteP9bhxP6CH1m7cTFwk3cGbFuRBqXbniGJclVF
 CAqxJ+aej+hOWMMm4EnHqpM76j97YJ/AlKPo7xFKodNvf3Oep8UuJ3JomDEPtfcAJ6GfNpf
 tuOmzEuxJj4GsKwkkni4sj3jAb5Ik0yy6cxTjv4J5ueDewkqz6QsDbUxtrh+xe9Zo9ae90H
 fu/rn2IAHkWaowrf6/gcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242466>

On 2014-02-21 10.55, Max Horn wrote:
> 
> On 20.02.2014, at 20:22, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Max Horn <max@quendi.de> writes:
>>
>>> On 19.02.2014, at 22:41, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> * fc/transport-helper-fixes (2013-12-09) 6 commits
>>>> - remote-bzr: support the new 'force' option
>>>> - test-hg.sh: tests are now expected to pass
>>>> - transport-helper: check for 'forced update' message
>>>> - transport-helper: add 'force' to 'export' helpers
>>>> - transport-helper: don't update refs in dry-run
>>>> - transport-helper: mismerge fix
>>>>
>>>> Reported to break t5541, and has been stalled for a while without
>>>> fixes.
>>> ...
>>> Since I somewhat care about transport-helpers, I had a closer look
>>> at this failure.
>>
>> Thanks.  Let's keep it a bit longer and see how your new
>> investigation (and possibly help from others) develops to a
>> solution.
> 
> So I had a closer look, and I now believe to now understand what the right fix is. Simply dropping 
>   transport-helper: check for 'forced update' message
> would be wrong, because it would cause the contrib/remote-helpers test cases to fail -- when I tested last night, I forgot that I had to run those separately. Silly me!
> 
> Indeed, these tests include a test with a force push, and trigger the code path added in that commit. The remaining problem then is that the new code should be changed to only tell git when a remote-helper signals a forced update; but it should not incorrectly reset the forced_update flag to 0 if git already considers the update to be forced.
> 
> In other words, the following patch should be the correct solution, as far as I can tell. I verified that it fixes t5541 and causes no regressions in the contrib/remote-helpers test suite.
> 
> -- 8< --
> diff --git a/transport-helper.c b/transport-helper.c
> index fa7c608..86e1679 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf *buf,
>         }
> 
>         (*ref)->status = status;
> -       (*ref)->forced_update = forced;
> +       (*ref)->forced_update |= forced;
>         (*ref)->remote_status = msg;
>         return !(status == REF_STATUS_OK);
>  }
> -- 8< --
> 
> 
Ack from my side:

There are 2 fields:
ref->force and ref->forced_update.

forced_update is set in set_ref_status_for_push() in remote.c:

		if (!force_ref_update)
			ref->status = reject_reason;
		else if (reject_reason)
			ref->forced_update = 1;
		}
And transport-helper.c sets it to 0 even if it had been 1, which is wrong.
