From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 21:48:10 +0100
Message-ID: <56D4AE8A.2050403@kdbg.org>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 29 21:48:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaUjr-00073v-CK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 21:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbcB2UsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 15:48:15 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:43555 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbcB2UsP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 15:48:15 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qDYZg61lKz5tlD;
	Mon, 29 Feb 2016 21:48:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id F2D5451D9;
	Mon, 29 Feb 2016 21:48:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287897>

Hi folks,

we have a major breakage in the parallel tasks infrastructure, and I'm
afraid it is already in master.

Instrument the code in sb/submodule-parallel-update like this and enjoy
the fireworks of './t7400-submodule-basic.sh -v -i -x --debug':

diff --git a/git-submodule.sh b/git-submodule.sh
index 0322282..482c7f6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -690,8 +690,9 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	set -x
 	{
-	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+	valgrind git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5572327..717e491 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -337,6 +337,7 @@ test_expect_success 'update should fail when path is used by a file' '
 
 	echo "hello" >init &&
 	test_must_fail git submodule update &&
+	false &&
 
 	test_cmp expect init
 '

The culprit seems to be default_task_finished(), which accesses argv[]
of the struct child_process after finish_command has released it,
provided the child exited with an error, for example:

==3395== Invalid read of size 8
==3395==    at 0x54F991: default_task_finished (run-command.c:932)
==3395==    by 0x49158F: update_clone_task_finished (submodule--helper.c:421)
==3395==    by 0x5504A2: pp_collect_finished (run-command.c:1122)
==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
==3395==    by 0x405CBE: run_builtin (git.c:353)
==3395==    by 0x405EAA: handle_builtin (git.c:540)
==3395==    by 0x405FCC: run_argv (git.c:594)
==3395==    by 0x4061BF: main (git.c:701)
==3395==  Address 0x5e49370 is 0 bytes inside a block of size 192 free'd
==3395==    at 0x4C2A37C: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==3395==    by 0x4A26EE: argv_array_clear (argv-array.c:73)
==3395==    by 0x54DFC4: child_process_clear (run-command.c:18)
==3395==    by 0x54EFA7: finish_command (run-command.c:539)
==3395==    by 0x550413: pp_collect_finished (run-command.c:1120)
==3395==    by 0x5507C7: run_processes_parallel (run-command.c:1194)
==3395==    by 0x4918EB: update_clone (submodule--helper.c:483)
==3395==    by 0x4919D8: cmd_submodule__helper (submodule--helper.c:527)
==3395==    by 0x405CBE: run_builtin (git.c:353)
==3395==    by 0x405EAA: handle_builtin (git.c:540)
==3395==    by 0x405FCC: run_argv (git.c:594)
==3395==    by 0x4061BF: main (git.c:701)

I haven't thought about a solution, yet. Perhaps you have ideas.

-- Hannes
