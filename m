From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [updated patch v3 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 20:03:04 +0100
Message-ID: <4B3CF568.1050705@kdbg.org>
References: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262284003-1417-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 20:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQQIj-0001DN-5j
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 20:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbZLaTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 14:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZLaTDH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 14:03:07 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:50730 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753065AbZLaTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 14:03:07 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 37E80CDF92;
	Thu, 31 Dec 2009 20:03:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262284003-1417-2-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135965>

Ilari Liusvaara schrieb:
> +static inline void force_close(int fd)
> +{
> +	/*
> +	 * The close is deemed success or failed in non-transient way if
> +	 * close() suceeds, returns EBADF or error other than EINTR or
> +	 * EAGAIN.
> +	 */
> +	while (close(fd) < 0 && errno != EBADF)
> +		if(errno != EINTR && errno != EAGAIN)
> +			break;

You are constantly ignoring proposals to iterate only on EINTR and EAGAIN, 
but do not make an argument why you do otherwise. Did I miss something?

>  	cmd->pid = fork();
> -	if (!cmd->pid) {
> +	if (cmd->pid > 0) {
> +		int r = 0, ret;
> +		force_close(report_pipe[1]);
> +read_again:
> +		if (report_pipe[0] >= 0)
> +			r = read(report_pipe[0], &ret, sizeof(ret));
> +		if (r < 0 && (errno == EAGAIN || errno == EINTR ||
> +			errno == EWOULDBLOCK))
> +			goto read_again;
> +		else if (r < 0)
> +			warning("Can't read exec status report: %s\n",
> +				strerror(errno));
> +		else if (r == 0)
> +			;
> +		else if (r < sizeof(ret)) {
> +			warning("Received incomplete exec status report.\n");
> +			errno = EBADMSG;
> +		} else {
> +			failed_errno = ret;
> +			/*
> +			 * Clean up the process that did the failed execution
> +			 * so no zombies remain.
> +			 */
> +			if(waitpid(cmd->pid, &ret, 0) < 0 && errno == EINTR)
> +				/* Nothing. */ ;
> +			cmd->pid = -1;

As per Documentation/technical/api-run-command.txt, you should write an 
error here, except if (failed_errno==ENOENT && cmd->silent_exec_failure!=0).

> +test_expect_success "reporting ENOENT" \
> +"test-run-command 1"

I wonder what this parameter "1" is good for...

-- Hannes
