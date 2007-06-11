From: "Stephen Cuppett" <cuppett@gmail.com>
Subject: Passing **envp around in git.c
Date: Mon, 11 Jun 2007 17:15:48 -0400
Message-ID: <316a20a40706111415i3181df45oabd1564313eea3bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 23:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxrFH-0002PQ-0X
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXFKVPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbXFKVPx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:15:53 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:14866 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbXFKVPw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:15:52 -0400
Received: by py-out-1112.google.com with SMTP id a29so2877408pyi
        for <git@vger.kernel.org>; Mon, 11 Jun 2007 14:15:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oAJFz2ApOP81HAWCODELArDZeXS657I+Ryusy7dJHcX8ox/BXJVb4aUwh6B/nOsiAcfouQACCLrMmGyaPbK0HaTj7c+8f6I01HCGDkiiBvUO++zrhrjg8l1OtLRPsReuSWMCD1M486sKnj5e0X3zi/r3oyf5jBF/5BeaJh3QCfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eRT2Dq+nC3aUJsClMU9+Hc9fKeuIysRq/aWwdk5NY8YJ/2uzxV595nbnlMiqYtELUK5Xgh7M1J7DGntqIz4/IHSdTCnB5pwoUPrcFEJ7Abcor0PjL4xtAdx1DE8wvHO1/5JPMIoKgNiLU5UOzGsaW6d9A8JRe4LWRC7KwriJyXo=
Received: by 10.65.40.16 with SMTP id s16mr10052613qbj.1181596548498;
        Mon, 11 Jun 2007 14:15:48 -0700 (PDT)
Received: by 10.65.15.1 with HTTP; Mon, 11 Jun 2007 14:15:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49885>

Is there a reason for passing char** envp around in git.c or is it a
vestige of something older?  It's sent into handle_internal_command
from main; however, it's never used.  Looks like it might have been
used before, but then replaced with getenv.  The code probably gets
optimized out at compile time, but to clean up:

diff --git a/git.c b/git.c
index 29b55a1..614baed 100644
--- a/git.c
+++ b/git.c
@@ -216,7 +216,7 @@ const char git_version_string[] = GIT_VERSION;
  */
 #define NOT_BARE       (1<<2)

-static void handle_internal_command(int argc, const char **argv, char **envp)
+static void handle_internal_command(int argc, const char **argv)
 {
        const char *cmd = argv[0];
        static struct cmd_struct {
@@ -358,7 +358,7 @@ int main(int argc, const char **argv, char **envp)
        if (!prefixcmp(cmd, "git-")) {
                cmd += 4;
                argv[0] = cmd;
-               handle_internal_command(argc, argv, envp);
+               handle_internal_command(argc, argv);
                die("cannot handle %s internally", cmd);
        }

@@ -390,7 +390,7 @@ int main(int argc, const char **argv, char **envp)

        while (1) {
                /* See if it's an internal command */
-               handle_internal_command(argc, argv, envp);
+               handle_internal_command(argc, argv);

                /* .. then try the external ones */
                execv_git_cmd(argv);
