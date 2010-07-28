From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCH] bash-completion: Print a useful error when called in a non-bash
 shell
Date: Wed, 28 Jul 2010 23:32:37 +0100
Message-ID: <4C50B005.1030004@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 00:33:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeFBP-0000Zf-By
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 00:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab0G1Wc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 18:32:58 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:50010 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755848Ab0G1Wc5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 18:32:57 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100728223256.GTNR3192.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Wed, 28 Jul 2010 23:32:56 +0100
Received: from [192.168.1.6] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100728223253.NDKI1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.6]>;
          Wed, 28 Jul 2010 23:32:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
X-Cloudmark-Analysis: v=1.1 cv=4QByPj+6Iq2k/6L54d+eVKTdgQxdscpRskJJReCfdXo= c=1 sm=0 a=vRD6HyR_SOEA:10 a=8nJEP1OIZ-IA:10 a=TSbVqHtbAAAA:8 a=qOz2pZ_4AAAA:8 a=VwQbUJbxAAAA:8 a=nob1Ey18rzrw7XZGo1cA:9 a=lOGfpFdb27-1bqOh-PagDsK3K8QA:4 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152124>

Detect whether the shell supports process substitution with <()
Shells that fail the test will not be able to load git-completion.bash

If a bad shell is found, print a warning which gives the user as much debugging
information as possible.

This was added in response to a bug report on the git mailing list:
  http://permalink.gmane.org/gmane.comp.version-control.git/151723

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---

My thanks to solsTiCe d'Hiver for reporting this bug.

 contrib/completion/git-completion.bash |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6756990..3bbb4da 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -96,6 +96,31 @@ __gitdir ()
 	fi
 }
 
+# Check in case we were called with something like "sh git-completion.bash":
+$(
+	exec 2>/dev/null
+	$(exec < <( ))
+ )
+if [[ 0 -ne $? ]]
+then
+	cat <<EOF
+
+ERROR: you don't seem to be running a full bash shell.
+git-completion.bash is probably about to fail with a syntax error.
+If you are sure that your system is calling git-completion.bash from a bash,
+then please include the following in a bug report to git@vger.kernel.org:
+
+	BASH_VERSION: {$BASH_VERSION}
+	BASHOPTS: {$BASHOPTS}
+	SHELLOPTS: {$SHELLOPTS}
+	POSIXLY_CORRECT: {$POSIXLY_CORRECT}
+EOF
+	echo -n "	command line: {"
+	tr '\0' ' ' < /proc/$$/cmdline
+	echo "}"
+	echo
+fi
+
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
-- 
1.7.0.4
