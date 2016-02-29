From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:01:21 -0800
Message-ID: <xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUwd-0006EV-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbcB2VB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:01:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750910AbcB2VB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:01:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B7F547EFA;
	Mon, 29 Feb 2016 16:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S0BzJ2A8pVkBVuwG2U/xqHZH53o=; b=Tmk0bB
	Kjn0JzZxrIax3hwe1eelGg9RBSKEH02/5HxtKh7oRNI/Q2mHKiyw+dXLuhZOUOa+
	2oNCrPXUyNh7YOTYXp4M2GYJj6fP0MbxGt8L6plDbfQkWq7R5oVsX5Zp4MjPK3xM
	LsluEJfKEZzzZOThEF6u+nhERApzVbjbpOWCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYd2zaOpGk43B3GHsw7KdoYQFky/ZVbv
	VV+fe371Nfb/0sdhHZkxXwdRuwViruu6BPJxEJL/s+HXUMssABfrdW38M57/8iQI
	3i6LifeJ36v4tmGmkXJTtSt5luiaJG4Gq4wVGAkhZi+LSQH2SLTr5N0MtwJF7hpO
	DN2FtovW5ME=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 471CE47EF7;
	Mon, 29 Feb 2016 16:01:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93B2347EF5;
	Mon, 29 Feb 2016 16:01:22 -0500 (EST)
In-Reply-To: <56D4AE8A.2050403@kdbg.org> (Johannes Sixt's message of "Mon, 29
	Feb 2016 21:48:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 968D3F90-DF27-11E5-BEAB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287900>

Johannes Sixt <j6t@kdbg.org> writes:

> The culprit seems to be default_task_finished(), which accesses argv[]
> of the struct child_process after finish_command has released it,
> provided the child exited with an error, for example:

Thanks for a report.

> ==3395== Invalid read of size 8
> ==3395==    at 0x54F991: default_task_finished (run-command.c:932)

That one and also start_failure() do run after child_process_clear()
has cleaned things up, so they shouldn't be looking at argv[] (or
anything in that structure for that matter).



> ==3395==    by 0x49158F: update_clone_task_finished (submodule--helper.c:421)
> ==3395==    by 0x5504A2: pp_collect_finished (run-command.c:1122)
> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
> ==3395==    by 0x405CBE: run_builtin (git.c:353)
> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
> ==3395==    by 0x405FCC: run_argv (git.c:594)
> ==3395==    by 0x4061BF: main (git.c:701)
> ==3395==  Address 0x5e49370 is 0 bytes inside a block of size 192 free'd
> ==3395==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==3395==    by 0x4A26EE: argv_array_clear (argv-array.c:73)
> ==3395==    by 0x54DFC4: child_process_clear (run-command.c:18)
> ==3395==    by 0x54EFA7: finish_command (run-command.c:539)
> ==3395==    by 0x550413: pp_collect_finished (run-command.c:1120)
> ==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
> ==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
> ==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
> ==3395==    by 0x405CBE: run_builtin (git.c:353)
> ==3395==    by 0x405EAA: handle_builtin (git.c:540)
> ==3395==    by 0x405FCC: run_argv (git.c:594)
> ==3395==    by 0x4061BF: main (git.c:701)
>
> I haven't thought about a solution, yet. Perhaps you have ideas.
>
> -- Hannes
