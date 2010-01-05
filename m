From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [updated patch v3 1/2] Report exec errors from run-command
Date: Mon, 04 Jan 2010 21:11:35 -0800
Message-ID: <7vaawt87aw.fsf@alter.siamese.dyndns.org>
References: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1262284003-1417-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <4B3CF568.1050705@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 06:11:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS1hz-0000sv-RS
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab0AEFLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784Ab0AEFLq
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:11:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0AEFLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:11:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12282AD64E;
	Tue,  5 Jan 2010 00:11:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tnazvNI9Ixa99h8SgWtImzsnV6c=; b=OyR8FG
	laPlzBXXrndg+SpDlAm9qnWLvt0ew8NQmUrdAIw6BzBUCmE9WpqxUfArfiudBKkM
	KN2a8gFXVDbUNH8igraBUcb2LQbHQdVOwv2OKPuLMgiV1Gz3xR8UanS8RORArcJz
	AKu0UDgQdkiuOv0J5sdhrA+hlylmDWeiuxd1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdEx5mfJ1X8SXDvcX7PBUhafxElJu94m
	1HdI5IthMRhG/mg0HLKrnTWvPwUkUCqD6j7OsTf86ZwwsughjaX2gyaLaUyLzgrb
	qe2V8ZxgsS5QEqjyjffn7w5WpTavp/LtQqIgbAYa4sWtKXqGIbfUNQtfWChNYuI8
	K2B2TzornhM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3BB5AD64D;
	Tue,  5 Jan 2010 00:11:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C1D7AD64A; Tue,  5 Jan 2010
 00:11:37 -0500 (EST)
In-Reply-To: <4B3CF568.1050705@kdbg.org> (Johannes Sixt's message of "Thu\,
 31 Dec 2009 20\:03\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF6DF878-F9B8-11DE-8723-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136160>

Johannes Sixt <j6t@kdbg.org> writes:

> Ilari Liusvaara schrieb:
>> +static inline void force_close(int fd)
>> +{
>> +	/*
>> +	 * The close is deemed success or failed in non-transient way if
>> +	 * close() suceeds, returns EBADF or error other than EINTR or
>> +	 * EAGAIN.
>> +	 */
>> +	while (close(fd) < 0 && errno != EBADF)
>> +		if(errno != EINTR && errno != EAGAIN)
>> +			break;
>
> You are constantly ignoring proposals to iterate only on EINTR and
> EAGAIN, but do not make an argument why you do otherwise. Did I miss
> something?

Meaning something like this?

	static inline void force_close(int fd)
	{
		/*
		 * Retry failed close() on EINTR or EAGAIN
		 */
		while (close(fd) < 0 && (errno == EINTR || errno == EAGAIN))
			; /* try again */
	}

which should be equivalent as long as EBADF is different from EINTR and
EAGAIN, I think.

>> +	if (cmd->pid > 0) {
>> +		int r = 0, ret;
>> +		force_close(report_pipe[1]);
>> +read_again:
>> ...
>> +			if(waitpid(cmd->pid, &ret, 0) < 0 && errno == EINTR)
>> +				/* Nothing. */ ;
>> +			cmd->pid = -1;
>
> As per Documentation/technical/api-run-command.txt, you should write
> an error here, except if (failed_errno==ENOENT &&
> cmd->silent_exec_failure!=0).

I was planning to replace the earlier series that was dropped from pu with
this iteration, but I guess I'll wait for another round before doing so.

Thanks for reviewing.

>> +test_expect_success "reporting ENOENT" \
>> +"test-run-command 1"
>
> I wonder what this parameter "1" is good for...

I guessed that this is for adding more tests to test-run-command in the
future and not having to change this test, in which case I think it is a
sensible thing to do.
