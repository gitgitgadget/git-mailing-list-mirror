From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] run_hook(): enhance the interface to pass arbitrary
 environment
Date: Sun, 11 Mar 2012 04:15:24 -0700
Message-ID: <7vlin7xub7.fsf_-_@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
 <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 12:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gkO-0006se-Uf
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab2CKLP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:15:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50000 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:15:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 381836F5A;
	Sun, 11 Mar 2012 07:15:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eizukJ+vtvR1Es2Av5HQWRGSFYM=; b=W65xE9
	TBc1L9i+Cfg8pCXMEJdx2Tr3ignCL1Qq7Xmwa9/mGGqH/Tfe53FaK2YFCysNOSlp
	8iBwi0WRWWKu5RbfHS2uarV05LF98CS4iPt7uO1sSPBxxuz8iqKMnZkTZkffpFSY
	WvqVqiMstobnkzD6i80zZSYSktfeEQPS3O344=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I9ntTn3DXDv+cdCTxAu66CadXvDLZfKs
	We6mHW0BVdmKlibxiEn4d5Du5BHJ4AZQnDokjacZBfAWeQtUGZv+nvFyVzyLhXVG
	4DNWNkGfg0Kq1SoDl6GQAf4EXbD0fGAR+YRdISgLeDklgEaM3kInrRlO5QVSh8yu
	0J/c4Inx1Yk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3316F59;
	Sun, 11 Mar 2012 07:15:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 524E26F56; Sun, 11 Mar 2012
 07:15:26 -0400 (EDT)
In-Reply-To: <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 04:09:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80BE98B4-6B6B-11E1-953C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192806>

Originally "run_hook()" that used to live in builtin/commit.c had a
perfectly appropriate API and name for a private function to spawn a
hook from "git commit" command. The only necessary tweak in the
context was to optionally specify which file to use as the index
file.

But then we stupidly moved this private API to run-command.c without
making the interface suitable for general consumption, and there is
no way to tweak environment variables other than GIT_INDEX_FILE when
running a hook.

Correct this mistake by adding run_hook_e() that takes an array of
environment variables.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is the third patch of the more complex of the two approaches.
   Instead of the simpler "setenv()" one, the final one tries to
   limit the environment change only to the hook scripts, without
   affecting the "git commit" process itself. It probably should not
   make much difference in the short run, but later when we want to
   distinguish where the authorship came from, it may be easier to
   tell with this approach as it does not contaminate the environment
   of "git commit" itself with what we obtained from "--author" option.

   Also this is independently a useful refactoring.

 run-command.c |   49 ++++++++++++++++++++++++++++++++++++-------------
 run-command.h |    1 +
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 1db8abf..a51d8e5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -672,36 +672,59 @@ int finish_async(struct async *async)
 #endif
 }
 
-int run_hook(const char *index_file, const char *name, ...)
+static int run_hook_le(const char *const *env,
+		       const char *name,
+		       va_list args)
 {
 	struct child_process hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *p, *env[2];
-	char index[PATH_MAX];
-	va_list args;
+	const char *p;
 	int ret;
 
 	if (access(git_path("hooks/%s", name), X_OK) < 0)
 		return 0;
 
-	va_start(args, name);
 	argv_array_push(&argv, git_path("hooks/%s", name));
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
-	va_end(args);
 
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv.argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
-	if (index_file) {
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		env[0] = index;
-		env[1] = NULL;
-		hook.env = env;
-	}
-
+	hook.env = env;
 	ret = run_command(&hook);
 	argv_array_clear(&argv);
 	return ret;
 }
+
+int run_hook(const char *index_file, const char *name, ...)
+{
+	const char *const *env = NULL, *env_buf[2];
+	struct strbuf index_buf = STRBUF_INIT;
+	int status;
+	va_list args;
+
+	va_start(args, name);
+	if (index_file) {
+		strbuf_addf(&index_buf, "GIT_INDEX_FILE=%s", index_file);
+		env_buf[0] = index_buf.buf;
+		env_buf[1] = NULL;
+		env = env_buf;
+	}
+	status = run_hook_le(env, name, args);
+	va_end(args);
+	strbuf_release(&index_buf);
+	return status;
+}
+
+int run_hook_e(const char *const *env, const char *name, ...)
+{
+	int status;
+	va_list args;
+
+	va_start(args, name);
+	status = run_hook_le(env, name, args);
+	va_end(args);
+	return status;
+}
diff --git a/run-command.h b/run-command.h
index 44f7d2b..87207b9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -47,6 +47,7 @@ int finish_command(struct child_process *);
 int run_command(struct child_process *);
 
 extern int run_hook(const char *index_file, const char *name, ...);
+extern int run_hook_e(const char *const *, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
-- 
1.7.10.rc0.33.g8866af
