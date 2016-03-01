From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] run-command: do not pass child process data into
 callbacks
Date: Tue, 1 Mar 2016 08:13:45 +0100
Message-ID: <56D54129.4090007@kdbg.org>
References: <1456783026-3328-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 08:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaeVE-0005T3-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 08:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbcCAHNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 02:13:48 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:50004 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbcCAHNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 02:13:48 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qDqST6Gfnz5tlh;
	Tue,  1 Mar 2016 08:13:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 45FBC520F;
	Tue,  1 Mar 2016 08:13:45 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1456783026-3328-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288000>

Am 29.02.2016 um 22:57 schrieb Stefan Beller:
> The expected way to pass data into the callback is to pass them via
> the customizable callback pointer. The error reporting in
> default_{start_failure, task_finished} is not user friendly enough, that
> we want to encourage using the child data for such purposes.
> 
> Furthermore the struct child data is cleaned by the run-command API,
> before we access them in the callbacks, leading to use-after-free
> situations.

Thanks. The code changes match what I had prototyped. But please squash
in this documentation change:

diff --git a/run-command.h b/run-command.h
index c6a3e42..3d1e59e 100644
--- a/run-command.h
+++ b/run-command.h
@@ -191,9 +191,8 @@ typedef int (*task_finished_fn)(int result,
  * (both stdout and stderr) is routed to stderr in a manner that output
  * from different tasks does not interleave.
  *
- * If start_failure_fn or task_finished_fn are NULL, default handlers
- * will be used. The default handlers will print an error message on
- * error without issuing an emergency stop.
+ * start_failure_fn and task_finished_fn can be NULL to omit any
+ * special handling.
  */
 int run_processes_parallel(int n,
 			   get_next_task_fn,
