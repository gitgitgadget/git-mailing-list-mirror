From: Richard Purdie <rpurdie@rpsys.net>
Subject: Overriding ~/.gitconfig using GIT_CONFIG
Date: Fri, 12 Aug 2011 16:38:18 +0100
Message-ID: <1313163498.14274.505.camel@rex>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QruNS-0000hY-Ut
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 18:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab1HLQO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 12:14:26 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:55595 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab1HLQOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 12:14:25 -0400
X-Greylist: delayed 2116 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Aug 2011 12:14:25 EDT
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFd8BI013284
	for <git@vger.kernel.org>; Fri, 12 Aug 2011 16:39:08 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 13071-02 for <git@vger.kernel.org>; Fri, 12 Aug 2011 16:39:04 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CFcxJb013278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 12 Aug 2011 16:38:59 +0100
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179235>

I work on build systems which need to check code out of source control
systems like git. I need to do this in a way in which there are not
outside influences and a user's $HOME/.gitconfig file can contain things
we don't want. I therefore need a way to disable it.

Looking through the manuals/code, it suggests I should be able to do:

GIT_CONFIG=/dev/null git XXX

and all should work happily. It doesn't though. As an example, with a
~/.gitconfig, "GIT_CONFIG=/dev/null git fetch --all" is clearly
accessing the file in ~ and then acting upon it.

I've searched through the code and whilst config_exclusive_filename
appears to be the magic variable that should get set when I set
GIT_CONFIG in the environment, nothing ever sets it apart from within a
git-config command.

The following patch sets the variable from the environment initially and
should do what the code intends if I read understand it correctly. Its
not ideal for my use case as I actually want the repo_config and only
the repo config to be used but I can live with setting GIT_CONFIG to
point at it.

Alternative ideas welcome, I've considered changing $HOME but that seems
a little too ugly and likely to cause other problems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/config.c b/config.c
index d06fb19..19e7565 100644
--- a/config.c
+++ b/config.c
@@ -860,6 +860,8 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	int ret = 0, found = 0;
 	const char *home = NULL;
 
+	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
+
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
 		return git_config_from_file(fn, config_exclusive_filename, data);


-- 
Linux Foundation
http://www.yoctoproject.org/
