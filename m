From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Do not use SHELL_PATH from build system in prepare_shell_cmd
 on Windows
Date: Tue, 17 Apr 2012 09:03:21 +0200
Message-ID: <4F8D15B9.70803@viscovery.net>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org> <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK2Rp-000740-O2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab2DQHD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 03:03:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40948 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750987Ab2DQHD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 03:03:28 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SK2Re-0000i6-22; Tue, 17 Apr 2012 09:03:22 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7678C1660F;
	Tue, 17 Apr 2012 09:03:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195734>

From: Johannes Sixt <j6t@kdbg.org>

The recent change to use SHELL_PATH instead of "sh" to spawn shell commands
is not suited for Windows:

- The default setting, "/bin/sh", does not work when git has to run the
  shell because it is a POSIX style path, but not a proper Windows style
  path.

- If it worked, it would hard-code a position in the files system where
  the shell is expected, making git (more precisely, the POSIX toolset that
  is needed alongside git) non-relocatable. But we cannot sacrifice
  relocatability on Windows.

- Apart from that, even though the Makefile leaves SHELL_PATH set to
  "/bin/sh" for the Windows builds, the build system passes a mangled path
  to the compiler, and something like "D:/Src/msysgit/bin/sh" is used,
  which is doubly bad because it points to where /bin/sh resolves to on
  the system where git was built.

- Finally, the system's CreateProcess() function that is used under
  mingw.c's hood does not work with forward slashes and cannot find the
  shell.

Undo the earlier change on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 3/31/2012 3:33, schrieb Ben Walton:
> +#ifndef SHELL_PATH
> +# define SHELL_PATH "/bin/sh"
> +#endif
> +
>  struct child_to_clean {
>  	pid_t pid;
>  	struct child_to_clean *next;
> @@ -90,7 +94,7 @@ static const char **prepare_shell_cmd(const char **argv)
>  		die("BUG: shell command is empty");
>  
>  	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
> -		nargv[nargc++] = "sh";
> +		nargv[nargc++] = SHELL_PATH;
>  		nargv[nargc++] = "-c";
>  
>  		if (argc < 2)

This looked so obviously correct, that I carelessly did not test the
change. But given that the first two points addressed in the commit
message above are actually dealbreakers, I should have noticed this issue
much earlier.

-- Hannes

 run-command.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/run-command.c b/run-command.c
index 2af3e0f..e4edede 100644
--- a/run-command.c
+++ b/run-command.c
@@ -94,7 +94,11 @@ static const char **prepare_shell_cmd(const char **argv)
 		die("BUG: shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
+#ifndef WIN32
 		nargv[nargc++] = SHELL_PATH;
+#else
+		nargv[nargc++] = "sh";
+#endif
 		nargv[nargc++] = "-c";
 
 		if (argc < 2)
-- 
1.7.10.1370.ga6f62.dirty
