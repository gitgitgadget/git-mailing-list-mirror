From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] run-command: Call get_next_task with a clean child process.
Date: Wed, 21 Oct 2015 13:30:38 -0700
Message-ID: <xmqqh9lkufpt.fsf@gitster.mtv.corp.google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-3-git-send-email-sbeller@google.com>
	<xmqq37x56sz6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp024-0004nb-2J
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 22:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbbJUUan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 16:30:43 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751996AbbJUUal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 16:30:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED34224897;
	Wed, 21 Oct 2015 16:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6niKax6iB41Pq+8FTFHOd9jTsgA=; b=Hg+gi2
	uhNKzDk+RzwGT8cM4vNtpf4bxS9C15BllXl10uMW3Borx42O2d3DmS/nuayE+edK
	7QvUo/cUwX04HqetqxQ6BUMUb6MLZls1jWznHN2on0DsHWHNoUbw6p/3SdmNYrYM
	LnNsiMrYguIybMW15ANo+MADyjBKllUHj1SUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ju/+NUqirUbdWfIptRu50M1z5obzxOUn
	GlZB0yMJ/KUebukbXlH//k5HTYOwXJp9IpREO/Mub7ySw6eW8aneZnUF8OiF1NKK
	QNTrIJz9oe6mnhoGZRS+6OmX0xdQiAZZpJuUFd/54jXDRyupGXY7mnCnurAaJ77Y
	ILt4dp5zxD8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3E8924896;
	Wed, 21 Oct 2015 16:30:40 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 34DF624894;
	Wed, 21 Oct 2015 16:30:40 -0400 (EDT)
In-Reply-To: <xmqq37x56sz6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 Oct 2015 16:05:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98447742-7832-11E5-BD70-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280014>

Junio C Hamano <gitster@pobox.com> writes:

> And of course we already have these array-clear calls in
> finish_command().
>
> So I agree that deinit helper should exist, but
>
>  * it should be file-scope static;
>
>  * it should be called by finish_command(); and
>
>  * if you are calling it from collect_finished(), then existing
>    calls to array-clear should go.
>
> Other than that, this looks good.

I'll queue this instead (the above squashed in and description
corrected).

-- >8 --
From: Stefan Beller <sbeller@google.com>
Date: Tue, 20 Oct 2015 15:43:44 -0700
Subject: [PATCH] run-command: clear leftover state from child_process structure

pp_start_one() function finds an unused child_process structure
passes it to start_command(), but the structure may have already
been used earlier.  finish_command() has code to clear leftover
states in the structure so that it can be reused, but the parallel
execution machinery does not (and cannot) use it, and instead has
its own pp_collect_finished().  This function, after culling a
process that has just finished, forgot to clear the child_process
structure before marking it ready for reuse.

Introduce child_process_deinit() helper function that clears two
instances of argv_array (one for arg, the other for env) in the
structure, make the existing codepaths that clear them call the
helper instead (which in turn will make sure that we will not leak
resources later even when we add new fields to the structure), and
also add a call to it in pp_collect_finished() before the function
marks the structure read for reuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/run-command.c b/run-command.c
index b9363da..684ccee 100644
--- a/run-command.c
+++ b/run-command.c
@@ -13,6 +13,12 @@ void child_process_init(struct child_process *child)
 	argv_array_init(&child->env_array);
 }
 
+static void child_process_deinit(struct child_process *child)
+{
+	argv_array_clear(&child->args);
+	argv_array_clear(&child->env_array);
+}
+
 struct child_to_clean {
 	pid_t pid;
 	struct child_to_clean *next;
@@ -338,8 +344,7 @@ int start_command(struct child_process *cmd)
 fail_pipe:
 			error("cannot create %s pipe for %s: %s",
 				str, cmd->argv[0], strerror(failed_errno));
-			argv_array_clear(&cmd->args);
-			argv_array_clear(&cmd->env_array);
+			child_process_deinit(cmd);
 			errno = failed_errno;
 			return -1;
 		}
@@ -525,8 +530,7 @@ fail_pipe:
 			close_pair(fderr);
 		else if (cmd->err)
 			close(cmd->err);
-		argv_array_clear(&cmd->args);
-		argv_array_clear(&cmd->env_array);
+		child_process_deinit(cmd);
 		errno = failed_errno;
 		return -1;
 	}
@@ -552,8 +556,7 @@ fail_pipe:
 int finish_command(struct child_process *cmd)
 {
 	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
-	argv_array_clear(&cmd->args);
-	argv_array_clear(&cmd->env_array);
+	child_process_deinit(cmd);
 	return ret;
 }
 
@@ -962,6 +965,7 @@ static struct parallel_processes *pp_init(int n,
 
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
+		child_process_init(&pp->children[i].process);
 		pp->pfd[i].events = POLLIN;
 		pp->pfd[i].fd = -1;
 	}
@@ -973,8 +977,10 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
-	for (i = 0; i < pp->max_processes; i++)
+	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
+		child_process_deinit(&pp->children[i].process);
+	}
 
 	free(pp->children);
 	free(pp->pfd);
@@ -1128,12 +1134,11 @@ static int pp_collect_finished(struct parallel_processes *pp)
 				      &pp->children[i].data))
 			result = 1;
 
-		argv_array_clear(&pp->children[i].process.args);
-		argv_array_clear(&pp->children[i].process.env_array);
-
 		pp->nr_processes--;
 		pp->children[i].in_use = 0;
 		pp->pfd[i].fd = -1;
+		child_process_deinit(&pp->children[i].process);
+		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-- 
2.6.2-394-gc0a4d5b
