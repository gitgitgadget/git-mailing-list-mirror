From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: do not pass child process data into callbacks
Date: Tue, 01 Mar 2016 09:43:24 -0800
Message-ID: <xmqqd1re856r.fsf@gitster.mtv.corp.google.com>
References: <1456783026-3328-1-git-send-email-sbeller@google.com>
	<56D54129.4090007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 18:43:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaoKb-0006T2-8C
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 18:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbcCARna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 12:43:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751262AbcCARn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 12:43:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 936F448555;
	Tue,  1 Mar 2016 12:43:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8WSQpbaLqRZVjiR9mE7ImzAcJ9M=; b=YeDA2H
	oJLopLvH7QQ/qVUBpP5seyr55YvUm+aYaass9isHd1Yj0y02u9IGAx1yQ80gC++L
	gBF2M1DxsyhtXppWsvnx6e0ZpiXtCo7TUkqEU0KwywSIEgN99sI5SbS/obcX879b
	lLYGJnQwV8jcDarNpjdF1iSkH4WS69dp3unCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0HRilfmYJWgeXOiFsHjWWVFs8WMm8RJ
	91kk9NnZsUI5cwQBn/GSQxjX9+K6FEhMh6A1oDGzmpGyoySaKWoW7w9ve0LZerEf
	yXFKQJSa5Z4we27wwmjgYbyg427FUzbDKxzPAdNV7bWM2lPO5wfbSQy4cwGO+Z5b
	XjMuI52j8PE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8AEFE48554;
	Tue,  1 Mar 2016 12:43:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02B8248553;
	Tue,  1 Mar 2016 12:43:25 -0500 (EST)
In-Reply-To: <56D54129.4090007@kdbg.org> (Johannes Sixt's message of "Tue, 1
	Mar 2016 08:13:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 19E6B7E2-DFD5-11E5-83E6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288044>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.02.2016 um 22:57 schrieb Stefan Beller:
>> The expected way to pass data into the callback is to pass them via
>> the customizable callback pointer. The error reporting in
>> default_{start_failure, task_finished} is not user friendly enough, that
>> we want to encourage using the child data for such purposes.
>> 
>> Furthermore the struct child data is cleaned by the run-command API,
>> before we access them in the callbacks, leading to use-after-free
>> situations.
>
> Thanks. The code changes match what I had prototyped. But please squash
> in this documentation change:
>
> diff --git a/run-command.h b/run-command.h
> index c6a3e42..3d1e59e 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -191,9 +191,8 @@ typedef int (*task_finished_fn)(int result,
>   * (both stdout and stderr) is routed to stderr in a manner that output
>   * from different tasks does not interleave.
>   *
> - * If start_failure_fn or task_finished_fn are NULL, default handlers
> - * will be used. The default handlers will print an error message on
> - * error without issuing an emergency stop.
> + * start_failure_fn and task_finished_fn can be NULL to omit any
> + * special handling.
>   */
>  int run_processes_parallel(int n,
>  			   get_next_task_fn,

Thanks for careful reading.
