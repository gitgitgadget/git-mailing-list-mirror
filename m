From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] run-command: factor out child_process_clear()
Date: Sat, 24 Oct 2015 14:11:27 +0200
Message-ID: <562B756F.1020305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 24 14:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpxfw-0003Uf-9X
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 14:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbbJXMLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 08:11:47 -0400
Received: from mout.web.de ([212.227.17.12]:58713 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbbJXMLp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2015 08:11:45 -0400
Received: from [192.168.178.36] ([79.253.137.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LqlWY-1aT8Ea2nFy-00eLR7; Sat, 24 Oct 2015 14:11:30
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:nOllDZw/s58ZD5wCl8H4aLOfjEG6cMI4NNswMYT4SCeNRCfrJxi
 /yzs+pL4dAmHKXUtNGSb7KHaeRuZfly/XyVhGV+p3SuDtQmHcU3gfa2PF4hYKnAYkoJld+O
 vGi4qVIjp3dr6Ru4IwCVOWSYCllbjB/QwiaxBWyRjN9aL/qT1ZqZzC8S/wufeuPdZq8E9ZE
 0IICSYUnKAbdLzy5IeHwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TGxPm66gb+k=:jpZ3yl+DYXwmZbbhulxZax
 du+4GfIXzDnLmk2aI2CmidZ/e1ZV8dlPqXi54W7iYHfZOteHsMSegVPLavPWYw5/nDxkLVrej
 DzHyb8tFEg5S+22LOtSad8HtV/XXngtbXKkdgtuBgcA1BBwRguxn54JwF/AYOuAlmuuFpjc56
 4R4y1yTJfPmdAyu7BtD9DylFo9xOGOKW8t40lxPOqqIp/1GM6UUVmj8iNQLY1xwzrVo+6V5CS
 ho/0ZS4d7zlEnbeCUVRameXD3iD4K7Em9BucYamGvvw7wLw9EHCWkKWsN88LswjCyHTZzx+5z
 jl8t/abqH2peNRsud7EHBsw8mxWkvOa6zIc94hMJyVuLOSbGApBpzpfXC4Wx9oLfPXJFbiSfq
 cZgoe6Fgp4undnS6AlZxLZEqfPa/252Nx/SRoJwHezAXcrL9ODRXjTnI6yMVpRKd+2SObNLsY
 bUAgOh5FNR9pChAT79EsxZWkHmIwxL7lb4ydmaS6XFH/vJ4pEECVf/CTJ5U45os2bxXcUuTNd
 mUzmKb0h2YDNd98X6ReqE0GGTpm9hqUgU0zujQGF1SO2AObzAa4BRcn4BeLhIjs2r3rseR/NF
 iUpZKf+1aJOPxhyTLWkl0yBbjm4M1ep3VmAUBeGXJusHDgcE4nNXHYDs2xl5nMh/XOvUQbstq
 DiR8eCJ7Q/f7S2DkcA6nitW7rqxJ7Xd1x/pZHTbbWP7UL5R6CzeuzvnqWg4tWfWJA8WkyjvSo
 VIPNTgjC2GY2xxSyegAYQPZ1OmO575DMVEQsMzAq0HEme868CSj492tsJlJZ4/h3SzFZ6YNz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280118>

Avoid duplication by moving the code to release allocated memory for
arguments and environment to its own function, child_process_clear().
Export it to provide a counterpart to child_process_init().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-run-command.txt |  7 +++++++
 run-command.c                               | 15 +++++++++------
 run-command.h                               |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index a9fdb45..8bf3e37 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -46,6 +46,13 @@ Functions
 	The argument dir corresponds the member .dir. The argument env
 	corresponds to the member .env.
 
+`child_process_clear`::
+
+	Release the memory associated with the struct child_process.
+	Most users of the run-command API don't need to call this
+	function explicitly because `start_command` invokes it on
+	failure and `finish_command` calls it automatically already.
+
 The functions above do the following:
 
 . If a system call failed, errno is set and -1 is returned. A diagnostic
diff --git a/run-command.c b/run-command.c
index e17e456..13fa452 100644
--- a/run-command.c
+++ b/run-command.c
@@ -11,6 +11,12 @@ void child_process_init(struct child_process *child)
 	argv_array_init(&child->env_array);
 }
 
+void child_process_clear(struct child_process *child)
+{
+	argv_array_clear(&child->args);
+	argv_array_clear(&child->env_array);
+}
+
 struct child_to_clean {
 	pid_t pid;
 	struct child_to_clean *next;
@@ -327,8 +333,7 @@ int start_command(struct child_process *cmd)
 fail_pipe:
 			error("cannot create %s pipe for %s: %s",
 				str, cmd->argv[0], strerror(failed_errno));
-			argv_array_clear(&cmd->args);
-			argv_array_clear(&cmd->env_array);
+			child_process_clear(cmd);
 			errno = failed_errno;
 			return -1;
 		}
@@ -513,8 +518,7 @@ fail_pipe:
 			close_pair(fderr);
 		else if (cmd->err)
 			close(cmd->err);
-		argv_array_clear(&cmd->args);
-		argv_array_clear(&cmd->env_array);
+		child_process_clear(cmd);
 		errno = failed_errno;
 		return -1;
 	}
@@ -540,8 +544,7 @@ fail_pipe:
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0], 0);
-	argv_array_clear(&cmd->args);
-	argv_array_clear(&cmd->env_array);
+	child_process_clear(cmd);
 	return ret;
 }
 
diff --git a/run-command.h b/run-command.h
index 5428b04..12bb26c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -47,6 +47,7 @@ struct child_process {
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
+void child_process_clear(struct child_process *);
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
-- 
2.6.2
