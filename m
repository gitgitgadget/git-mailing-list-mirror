From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] report which $PATH entry had trouble running execvp(3)
Date: Tue, 19 Apr 2011 21:01:21 -0700
Message-ID: <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7vipub6r3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 06:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCObh-0002YK-Mo
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 06:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741Ab1DTEBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 00:01:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab1DTEBa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 00:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FCE34ABC;
	Wed, 20 Apr 2011 00:03:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cJUGBdSX4+w5/S72If5vUEc91w=; b=J4Crxc
	tvRb8fmh5irDfL1ff6EaA1D+NfZsuiSYTABiuMgTb0KXPtNrDNSK2mIfngE/2Q9L
	nSqiA/UJQjyyWscKioWBADkbVf2inkZ/3q9ffKnPPIFHDYmk1Sic44YZevJbqD9U
	6SLsS7pomtr8Y7hZzd//kASAKmtnIKGuFGt6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+8Bugdr7Qelnif+k9m1kVFPgp1FTzFo
	pPCwf+QPcCxCuuBEUBli4GHUjRD1PWosHblHNQNT/zZGLXMLp6h0ZyZl16NZkQOi
	ZQ48B2MPexX0VpPl2peVCdjARCc/2hfsyyX0uaB31i4JgbYiT27waNNJ4aKUsvsw
	nMSdd2QIRv8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EC3E4ABB;
	Wed, 20 Apr 2011 00:03:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33DB54ABA; Wed, 20 Apr 2011
 00:03:23 -0400 (EDT)
In-Reply-To: <7vipub6r3s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Apr 2011 17:07:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2529DE46-6B03-11E0-A4DE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171838>

You can add your own custom subcommand 'frotz' to the system by adding
'git-frotz' in a directory somewhere in your $PATH environment variable.
When you ask "git frotz" from the command line, "git-frotz" is run via
execvp(3).

Three plausible scenarios that the execvp(3) would fail for us are:

 * The first 'git-frotz' found in a directory on $PATH was not a proper
   executable binary, and we got "Exec format error" (ENOEXEC);

 * The only 'git-frotz' found in the directories listed on $PATH were not
   marked with executable bit, and we got "Permission denied" (EACCES); or

 * No 'git-frotz' was found in the directories listed on $PATH, but one of
   the directories were unreadable, and we got EACCES.

The first one is easy to understand and to rectify.  Most likely, the user
made a typo, either on the command line, or when creating the custom
subcommand.  However, the latter two cases are harder to notice, as we do
not report 'git-frotz' in which directory we had trouble with.  We could
do better if we implemented the command search behaviour of execvp(3)
ourselves.

Add an internal function sane_execvp() that emulates execvp(3), skipping
ENOENT and EACCES while remembering a path that resulted in EACCES while
trying later directories on $PATH.  When failing the request at the end,
report the path that we had trouble with, and use it when reporting the
error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  >> The following is a tangent that was brought up at $work.
  > ...
  > We would need to emulate what execvp() does ourselves (i.e. split $PATH,
  > prefix each component and try execv(), ignoring ENOENT or EACCES while
  > trying next component in $PATH), plus note the first path that got EACCES
  > so that we can report which script (including its leading directories) had
  > trouble executing.  Perhaps a simple enough task for beginners.

 run-command.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index f91e446..4c95f50 100644
--- a/run-command.c
+++ b/run-command.c
@@ -135,6 +135,52 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	return code;
 }
 
+static const char *sane_execvp(const char *arg0, const char **argv)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf failed_path = STRBUF_INIT;
+	char *path = getenv("PATH");
+	char *next;
+
+	if (!path)
+		path = "";
+
+	for (;;) {
+		next = strchrnul(path, ':');
+		if (path < next)
+			strbuf_add(&sb, path, next - path);
+		else
+			strbuf_addch(&sb, '.');
+		if (sb.len && sb.buf[sb.len - 1] != '/')
+			strbuf_addch(&sb, '/');
+		strbuf_addstr(&sb, arg0);
+		execv(sb.buf, (char * const*) argv);
+
+		/*
+		 * execvp() skips EACCES and ENOENT and goes on to try
+		 * the next entry in the $PATH, but sets errno to EACCES
+		 * when it fails at the end.
+		 */
+		if (errno == EACCES && !failed_path.len)
+			strbuf_add(&failed_path, sb.buf, sb.len);
+		if (errno != ENOENT) {
+			strbuf_release(&failed_path);
+			return strbuf_detach(&sb, NULL);
+		}
+		strbuf_release(&sb);
+		if (!*next)
+			break;
+		path = next + 1;
+	}
+	if (failed_path.len) {
+		errno = EACCES;
+		return strbuf_detach(&failed_path, NULL);
+	}
+	strbuf_release(&sb);
+	strbuf_release(&failed_path);
+	return arg0;
+}
+
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
@@ -278,7 +324,7 @@ fail_pipe:
 		} else if (cmd->use_shell) {
 			execv_shell_cmd(cmd->argv);
 		} else {
-			execvp(cmd->argv[0], (char *const*) cmd->argv);
+			cmd->argv[0] = sane_execvp(cmd->argv[0], cmd->argv);
 		}
 		/*
 		 * Do not check for cmd->silent_exec_failure; the parent
