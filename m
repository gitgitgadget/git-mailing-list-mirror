From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [updated patch v2 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 17:22:02 +0100
Message-ID: <4B3CCFAA.7060702@kdbg.org>
References: <1262256488-22985-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262256488-22985-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 17:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQNms-0004JW-LR
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 17:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbZLaQWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 11:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbZLaQWF
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 11:22:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:36277 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752184AbZLaQWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 11:22:04 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3F6162C4013;
	Thu, 31 Dec 2009 17:22:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262256488-22985-2-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135956>

Ilari Liusvaara schrieb:
> +static inline void force_close(int fd)
> +{
> +	int err = 0;
> +	/*
> +	 * Retry EINTRs undefinitely, exit on EBADF immediately, other
> +	 * errors retry only up to three times (even if pipe close
> +	 * shouldn't cause other errors, but you never know with
> +	 * what broken systems may return on closed file descriptor).
> +	 * consequences of failure to close pipe here may include
> +	 * deadlocking.
> +	 */
> +	while (close(fd) < 0 && errno != EBADF && err < 3)
> +		if(errno != EINTR)
> +			err++;

What's the point to iterate on all errors except EBADF? If the close() 
fails once, it will fail again.

> +			/*
> +			 * Clean up the process that did the failed execution
> +			 * so no zombies remain.
> +			 */
> +wait_again:
> +			r = waitpid(cmd->pid, &ret, 0);
> +			if (r < 0 && errno != ECHILD)
> +				goto wait_again;

You really should iterate only on well-known errors. What's wrong with

		while (waitpid(pid, &status, 0) < 0 && errno == EINTR)
			;	/* nothing */

similar to wait_or_whine()'s call to waitpid() and to avoid goto.

> +int main(int argc, char **argv)
> +{
> +	char* procs[2];
> +	struct child_process proc;
> +	memset(&proc, 0, sizeof(proc));
> +
> +	if(argc < 2)
> +		return 1;
> +
> +	if (argv[1][1] == '1')
> +		procs[0] = "does-not-exist-62896869286";
> +	procs[1] = NULL;
> +	proc.argv = (const char **)procs;
> +
> +	if (!run_command(&proc))
> +		return 1;
> +	if (errno != ENOENT)
> +		return 1;
> +	return 0;
> +}

This test is not specific enough: It would pass even without your change 
to start_command(), because finish_command() detects the ENOENT case. You 
really want to test that you see ENOENT after start_command() (i.e., 
before finish_command()).

-- Hannes
