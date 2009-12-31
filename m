From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 17:54:37 +0100
Message-ID: <4B3CD74D.7020605@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230105536.GC22959@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 17:54:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQOIN-0007mG-1y
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 17:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbZLaQyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 11:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZLaQyi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 11:54:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:56419 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752656AbZLaQyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 11:54:38 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 11748A7EBA;
	Thu, 31 Dec 2009 17:54:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091230105536.GC22959@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135957>

Jeff King schrieb:
> If there are no metacharacters in the program to be run, we
> can just skip running the shell entirely and directly exec
> the program.
> 
> The metacharacter test is pulled verbatim from
> launch_editor, which already implements this optimization.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Something inside me feels wrong with a catch-known-metacharacter test
> instead of an allow-known-good check. But this is the same test we have
> been using with launch_editor for some time, so I decided not to mess
> with it.

The git version that msysgit ships (and the one that I use on Windows) has 
this sequence in pager.c:

static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
...
	pager_process.argv = &pager_argv[2];
	pager_process.in = -1;
	if (start_command(&pager_process)) {
		pager_process.argv = pager_argv;
		pager_process.in = -1;
		if (start_command(&pager_process))
			return;
	}

to help people set

  PAGER=C:\Program Files\cygwin\bin\less

That is, we first try to run the program without the shell, then retry 
wrapped in sh -c.

Wouldn't it be possible to do the same here, assuming that we don't have 
programs such as "editor -f" in the path?

It does assume that we are able to detect execvp failure due to ENOENT 
which is currently proposed elsewhere by Ilari Liusvaara (and which is 
already possible on Windows).

-- Hannes
