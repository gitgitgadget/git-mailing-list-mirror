From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] run-command: don't try to execute directories
Date: Tue,  2 Oct 2012 16:46:33 +0200
Message-ID: <1349189193-25497-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 16:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ3kF-0001l4-NF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 16:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab2JBOqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 10:46:36 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:42952 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2JBOqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 10:46:35 -0400
Received: from cmartin.tk (unknown [178.19.215.16])
	by hessy.dwim.me (Postfix) with ESMTPA id 0049E8141B
	for <git@vger.kernel.org>; Tue,  2 Oct 2012 16:46:33 +0200 (CEST)
Received: (nullmailer pid 25532 invoked by uid 1000);
	Tue, 02 Oct 2012 14:46:33 -0000
X-Mailer: git-send-email 1.8.0.rc0.175.g59a8d0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206799>

When looking through $PATH to try to find an external command,
locate_in_PATH doesn't check that it's trying to execute a file. Add a
check to make sure we won't try to execute a directory.

This also stops us from looking further and maybe finding that the
user meant an alias, as in the case where the user has
/home/user/bin/git-foo/git-foo.pl and an alias

    [alias] foo =3D !/home/user/bin/git-foo/git-foo.pl

Running 'git foo' will currently will try to execute ~/bin/git-foo and
fail because you can't execute a directory. By making sure we don't do
that, we realise that it's an alias and do the right thing

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

---

This comes from a case in #git. Not sure if this is worth it, or the
better solution is just to say no to dirs in $PATH.

After writing all of that, I thought to check the shell, and indeed

    % git-foo
    zsh: permission denied: git-foo

so if the shell doesn't do it, the benefits probably don't outweigh
having a dozen stat instead of access calls. strace reveals that zsh
does what git currently does. bash uses stat and says 'command not
found'.

Sending in case someone finds it useful or interesting. Feel free to
ignore it or make fun of it if you want.

 run-command.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 1101ef7..97e6960 100644
--- a/run-command.c
+++ b/run-command.c
@@ -85,6 +85,7 @@ static char *locate_in_PATH(const char *file)
 {
 	const char *p =3D getenv("PATH");
 	struct strbuf buf =3D STRBUF_INIT;
+	struct stat st;
=20
 	if (!p || !*p)
 		return NULL;
@@ -101,8 +102,9 @@ static char *locate_in_PATH(const char *file)
 		}
 		strbuf_addstr(&buf, file);
=20
-		if (!access(buf.buf, F_OK))
+		if (!stat(buf.buf, &st) && !S_ISDIR(st.st_mode)) {
 			return strbuf_detach(&buf, NULL);
+		}
=20
 		if (!*end)
 			break;
--=20
1.8.0.rc0.175.g59a8d0e
