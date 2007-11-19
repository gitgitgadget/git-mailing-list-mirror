From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Mon, 19 Nov 2007 00:46:17 -0800
Message-ID: <7vfxz2oc6e.fsf@gitster.siamese.dyndns.org>
References: <1195407366-1610-1-git-send-email-pkufranky@gmail.com>
	<47413DB9.9030306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 09:46:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu2HC-0000u2-RW
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 09:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbXKSIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 03:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXKSIqY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 03:46:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45633 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbXKSIqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 03:46:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CE33C2EF;
	Mon, 19 Nov 2007 03:46:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EEBD96507;
	Mon, 19 Nov 2007 03:46:41 -0500 (EST)
In-Reply-To: <47413DB9.9030306@viscovery.net> (Johannes Sixt's message of
	"Mon, 19 Nov 2007 08:39:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65416>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ping Yin schrieb:
>> When 'FILE *fp' is assigned to child_process.out and then start_command or
>> run_command is run, the standard output of the child process is expected to
>> be outputed to fp. However, sometimes fp is not expected to be closed since
>> further IO may be still performmed on fp.
>> ---
>>  run-command.c |    4 ----
>>  1 files changed, 0 insertions(+), 4 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 476d00c..4e5f58d 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -115,13 +115,9 @@ int start_command(struct child_process *cmd)
>>   	if (need_in)
>>  		close(fdin[0]);
>> -	else if (cmd->in)
>> -		close(cmd->in);
>>   	if (need_out)
>>  		close(fdout[1]);
>> -	else if (cmd->out > 1)
>> -		close(cmd->out);
>>   	if (need_err)
>>  		close(fderr[1]);
>
> This is dangerous! You have to audit all current callers whether they
> close cmd->in or cmd->out (if they don't need the fd
> anymore).

I am reasonably sure that they are already relying on these auto
closing of the file descriptors.

Funny that somebody falls into the trap the day after we
discussed it on another thread.
