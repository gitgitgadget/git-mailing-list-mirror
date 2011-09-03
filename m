From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix completion after 'git --option <TAB>'
Date: Sat, 3 Sep 2011 12:32:52 +0200
Message-ID: <1315045972-29983-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 12:33:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QznX9-0004FG-9S
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 12:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab1ICKdC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Sep 2011 06:33:02 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:55681 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1ICKdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 06:33:00 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 3 Sep
 2011 12:32:55 +0200
Received: from localhost6.localdomain6 (141.21.34.14) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 3 Sep
 2011 12:32:56 +0200
X-Mailer: git-send-email 1.7.6.596.gedbca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180650>

Git's bash completion currently doesn't work when certain git options
are specified, e.g. 'git --no-pager <TAB>' errors out with "error:
invalid key: alias.--no-pager".

The main _git() completion function finds out the git command name by
looping through all the words on the command line and searching for
the first word that is not a known option for the git command.
Unfortunately the list of known git options was not updated in a long
time, and newer options are not skipped but mistaken for a git
command.  Such a misrecognized "command" is then passed to
__git_aliased_command(), which in turn passes it to a 'git config'
query, hence the error.

Currently the following options are misrecognized for a git command:

  -c --no-pager --exec-path --html-path --man-path --info-path
  --no-replace-objects --work-tree=3D --namespace=3D

To fix this we could just update the list of options to be skipped,
but the same issue will likely arise, if the git command learns a new
option in the future.  Therefore, to make it more future proof against
new options, this patch changes that loop to skip all option-looking
words, i.e. words starting with a dash.

We also have to handle the '-c' option specially, because it takes a
configutation parameter in a separate word, which must be skipped,
too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8648a36..8b0c695 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2622,8 +2622,9 @@ _git ()
 		case "$i" in
 		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
 		--bare)      __git_dir=3D"." ;;
-		--version|-p|--paginate) ;;
 		--help) command=3D"help"; break ;;
+		-c) c=3D$((++c)) ;;
+		-*) ;;
 		*) command=3D"$i"; break ;;
 		esac
 		c=3D$((++c))
--=20
1.7.6.596.gedbca
