From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 12/16] bash prompt: use bash builtins to check for unborn
 branch for dirty state
Date: Mon, 24 Jun 2013 18:39:22 +0200
Message-ID: <1372091966-19315-13-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9st-00046K-Ix
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3FXQow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:44:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:60512 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab3FXQov (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:44:51 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MfNmw-1UcEKx2Gfy-00OpB9; Mon, 24 Jun 2013 18:44:49 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:u0AAIZfiFWUMT0oIyutQBW4svynmb/u6eWYtw38bFDB
 9LmejbG1r0HUFmRZg8qu5VcCA7UhB9QZ8OaL3yqqA+K5WyiTNI
 9uVpdN8qesIwCqZGFo9RCzIhZS7KiEQoLU1evUVlk9MFM2bvXs
 ActrCyBUj3ZAvX9ke4hf24yU9CZFlPuYYCaXw9t/3r/w2rxRNf
 l4eFdgCmjO+GxPTxNiV0tZ6Gkqwr0rWccWG+8zs7Ec6bsd2CW8
 d0dDUGGo2BAizs8ppms2ChvYsBw6slW2gUUvrb904q9WWW5qGw
 CnyTCFwq4LRmIzK/uQWmVHdZxHkzoX/KUf0H2K1FoCz9JnZ0cl
 XX6CT4nhquQMEII2JRdnWcfksSrV2KiQchiVrPwUaVSDdMlNsm
 Ob1TxgrMBfrgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228864>

When the dirty work tree and index status indicator is enabled,
__git_ps1() checks for changes in the index by running 'git diff-index
--cached --quiet HEAD --' and looking at its exit code.  However, that
makes sense only when HEAD points to a valid commit: on an unborn
branch the failure of said command would be caused by the invalid
HEAD, not by changes in the index.  Therefore, __git_ps1() first
checks for a valid HEAD by running 'git rev-parse --quiet --verify
HEAD'.

Since the previous patch we implicitly check HEAD's validity by
running 'git rev-parse ... --short HEAD', making the dirty status
indicator's 'git rev-parse' check redundant.  It's sufficient to check
for non-emptyness of the variable holding the abbreviated commit
object name, thereby sparing the overhead of fork()+exec()ing a git
process.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 88d6121d..6e8f486e 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -429,7 +429,7 @@ __git_ps1 ()
 		   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
 		then
 			git diff --no-ext-diff --quiet --exit-code || w=3D"*"
-			if git rev-parse --quiet --verify HEAD >/dev/null; then
+			if [ -n "$short_sha" ]; then
 				git diff-index --cached --quiet HEAD -- || i=3D"+"
 			else
 				i=3D"#"
--=20
1.8.3.1.599.g4459181
