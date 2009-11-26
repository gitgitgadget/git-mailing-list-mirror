From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 06/11] run-command: add kill_async() and  is_async_alive()
Date: Thu, 26 Nov 2009 22:46:13 +0100
Message-ID: <200911262246.13342.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-6-git-send-email-kusmabite@gmail.com> <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 22:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmAb-0000W4-HN
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZKZVqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZKZVqU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:46:20 -0500
Received: from [93.83.142.38] ([93.83.142.38]:59352 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750919AbZKZVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 16:46:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 76FB219F4D0;
	Thu, 26 Nov 2009 22:46:13 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133836>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> +int kill_async(struct async *async)
> +{
> +#ifndef WIN32
> +	return kill(async->pid, SIGTERM);
> +#else
> +	DWORD ret = 0;
> +	if (!TerminateThread(async->tid, 0))
> +		ret = error("killing thread failed: %lu", GetLastError());

Ugh! Did you read the documentation of TerminateThread()?

We need to kill processes/threads when we detect that there are too many 
connections. But TerminateThread() is such a dangerous function that we 
cannot pretend that everything is good, and we continue to accept 
connections.

Unless we find a different solution, I would prefer to punt and die instead.

> +	else if (!GetExitCodeThread(async->tid, &ret))
> +		ret = error("cannot get thread exit code: %lu", GetLastError());

What should the exit code be good for? The return value of this function can 
only be -1 (failure, could not kill) or 0 (success, process killed).

-- Hannes
