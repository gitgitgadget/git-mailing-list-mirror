From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 08 Jul 2009 11:49:39 -0700
Message-ID: <7vd48b6md8.fsf@alter.siamese.dyndns.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <7viqi386th.fsf@alter.siamese.dyndns.org>
 <102A43B8-AD35-4B1D-850C-3642CEDB2864@uchicago.edu>
 <7vskh76pui.fsf@alter.siamese.dyndns.org>
 <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Fritz Anderson <fritza@uchicago.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOcDb-0004no-TE
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 20:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbZGHSts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbZGHSts
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 14:49:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960AbZGHStr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 14:49:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90DF7265E0;
	Wed,  8 Jul 2009 14:49:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7A0CD265DD; Wed, 
 8 Jul 2009 14:49:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B862B74-6BF0-11DE-B2DF-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122910>

Fritz Anderson <fritza@uchicago.edu> writes:

> On Jul 8, 2009, at 12:34 PM, Junio C Hamano wrote:
>
>> Which makes the initial "sudo git clone..." find git in _your_ path
>> before sanitization (and that is why it even starts), but then the path
>> is nuked for the git process it launches, and we cannot find
>> git-index-pack on the PATH.
>>
>> But this should be fine, as git is expected to find git-index-pack in
>> its GIT_EXEC_PATH that is compiled in the binary of "git" itself.
>>
>> Which makes me suspect that your "git" in /usr/local/bin may be
>> misconfigured.  You might want to check what these tell you.
>>
>> 	$ git --exec-path
>> 	$ /usr/local/bin/git --exec-path
>
> Glad to oblige. These are the four possibilities:
>
> $ git --exec-path
> /usr/local/libexec/git-core
> $ /usr/local/bin/git --exec-path
> /usr/local/libexec/git-core
> $ sudo git --exec-path
> /usr/local/libexec/git-core
> $ sudo /usr/local/bin/git --exec-path
> /usr/local/libexec/git-core
> $
>
> Same path every time, sudo or not, full path to git or not.

Hmm, there is something fishy going on, and I am a bit frustrated not
being able to see what it is.

The callpath should look like this:

  git.c::main()
  -> setup_path()
  -> cmd_clone()
     -> transport_fetch_refs()
        -> fetch_refs_via_pack()
           -> fetch_pack()
              -> do_fetch_pack()
                 -> get_pack()
                    -> start_command(), running either
                       "index-pack" or "unpack-objects"
                       on the incoming stream

and start_command() forks and eventually does execv_git_cmd() which is a
thin wrapper around execvp().

The PATH exported when this execvp() runs should have been adjusted to
have the exec-path at the beginning by calling setup_path() and this is
done way before cmd_clone() was called by git.c::main() function.

What am I not seeing?  There should be something obvious that I am
missing.  I do not see how your original command can fail with "exec
failed: No such file or directory".

Could you try your original (non-working) command with this debug patch?

 exec_cmd.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 408e4e5..000910b 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -101,6 +101,9 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;
 
+	trace_printf("trace: setup_path: the $PATH was: %s\n",
+		     old_path ? old_path : "NULL");
+
 	add_path(&new_path, git_exec_path());
 	add_path(&new_path, argv0_path);
 
@@ -110,7 +113,8 @@ void setup_path(void)
 		strbuf_addstr(&new_path, "/usr/local/bin:/usr/bin:/bin");
 
 	setenv("PATH", new_path.buf, 1);
-
+	trace_printf("trace: setup_path: the $PATH is now: %s\n",
+		     getenv("PATH") ? getenv("PATH") : "NULL");
 	strbuf_release(&new_path);
 }
 
@@ -138,7 +142,8 @@ int execv_git_cmd(const char **argv) {
 	execvp("git", (char **)nargv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
-
+	trace_printf("trace: the $PATH was: %s\n",
+		     getenv("PATH") ? getenv("PATH") : "NULL");
 	free(nargv);
 	return -1;
 }
