From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] start_command: close cmd->err descriptor when fork/spawn
 fails
Date: Mon, 26 Apr 2010 08:48:41 +0200
Message-ID: <4BD53749.6040708@viscovery.net>
References: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: bert Dvornik <dvornik+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 08:48:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6I7h-00064t-J6
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 08:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611Ab0DZGso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 02:48:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44466 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751586Ab0DZGso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 02:48:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O6I7V-0004Q4-Eo; Mon, 26 Apr 2010 08:48:41 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3095A1660F;
	Mon, 26 Apr 2010 08:48:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1272244540-5960-1-git-send-email-dvornik+git@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145793>

Am 4/26/2010 3:15, schrieb bert Dvornik:
> Fix the problem where the cmd->err passed into start_command wasn't
> being properly closed when certain types of errors occurr.  (Compare
> the affected code with the clean shutdown code later in the function.)
> 
> On Windows, this problem would be triggered if mingw_spawnvpe()
> failed, which would happen if the command to be executed was malformed
> (e.g. a text file that didn't start with a #! line).  If cmd->err was
> a pipe, the failure to close it could result in a hang while the other
> side was waiting (forever) for either input or pipe close, e.g. while
> trying to shove the output into the side band.  On msysGit, this
> problem was causing a hang in t5516-fetch-push.
> 
> I'm not sure why (or if) this problem hasn't cropped up under Linux.
> The non-Windows code *does* try to check for execve() failures in the
> child, in addition to the fork() failures.

The problem does show up on Linux if you trigger the right error, such as
with this patch:

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2de98e6..2515a96 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -528,7 +528,8 @@ test_expect_success 'push does not update local refs
 	mk_test heads/master &&
 	mk_child child &&
 	mkdir testrepo/.git/hooks &&
-	echo exit 1 >testrepo/.git/hooks/pre-receive &&
+	echo "#!/bin/frobnicuty" >testrepo/.git/hooks/pre-receive &&
+	echo exit 1 >>testrepo/.git/hooks/pre-receive &&
 	chmod +x testrepo/.git/hooks/pre-receive &&
 	(cd child &&
 		git pull .. master
