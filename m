From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH/RFC] completion: filter sources of git scripts from available commands
Date: Sun, 15 Mar 2015 21:45:48 +0100
Message-ID: <1426452348-6304-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 21:46:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXFQJ-0002Ai-HK
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 21:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbCOUqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 16:46:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46567 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751166AbbCOUqF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 16:46:05 -0400
Received: from x590c5c95.dyn.telefonica.de ([89.12.92.149] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YXFQA-0007fX-5H; Sun, 15 Mar 2015 21:46:04 +0100
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1426452364.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265521>

A bit of background first:

- The completion script gets the lists of available and porcelain git
  commands from the output of 'git help -a', which, besides the
  "official" git commands from $GIT_EXEC_PATH, includes all executables
  from $PATH whose name begins with 'git-'.  Great, this way the
  completion script can include the user's custom git commands that he
  dropped somewhere in his $PATH.

- The lists of available and porcelain git commands are not initialized
  when the completion script is sourced, but it's done lazily when the
  first git completion is performed.  Great, this way interactive shell=
s
  start faster, see eaa4e6ee2a (Speed up bash completion loading,
  2009-11-17).

- MSysGit's /etc/profile by default includes the current working
  directory in $PATH.  Great, this way MSysGit Bash "mimics the Win32
  method of finding executables" (quoted from /etc/profile).

While all three things above are great by themselves, their combination=
,
however, has unwanted side-effects: it makes the list of git commands
non-deterministic on MSysGit, as it will depend on the current working
directory where the first git completion is performed.  Perhaps it's
worst when it is performed at the top of a git.git clone because the
source files of all git scripts are included in the lists of available
and porcelain commands, about twenty, some of them not even sources of
porcelains.

Possible solutions to avoid this issue are:

- Strip the current working directory from $PATH temporarily while we r=
un
  'git help -a' to get all the available commands.  Care must be taken,
  because '.' can appear at the very beginning, end, or in the middle o=
f
  $PATH, not to mention that on unixes it's unlikely but possible to ha=
ve
  a directory containing e.g. ':.:' in the $PATH.

- Filter out scripts from the output of 'git help -a'.  This can be don=
e
  by either
  * listing all possible script extensions, but this list will most lik=
ely
    never be complete, or
  * filtering out all commands containing a filename extension, i.e.
    anything with a '.' in it.
  This will bite users whose custom git commands have filename extensio=
ns,
  i.e. who put 'git-mycmd.sh' in '~/bin'.

Since this is an RFC, it goes with the last option, because that's the
shortest and simplest.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c21190d..9173c41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -637,6 +637,7 @@ __git_list_all_commands ()
 	do
 		case $i in
 		*--*)             : helper pattern;;
+		*.*)              : script sources;;
 		*) echo $i;;
 		esac
 	done
--=20
1.9.5.msysgit.0
