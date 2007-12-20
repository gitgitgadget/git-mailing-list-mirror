From: Luciano Rocha <luciano@eurotux.com>
Subject: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Thu, 20 Dec 2007 09:57:06 +0000
Message-ID: <20071220095706.GA9685@bit.office.eurotux.com>
References: <20071219232326.GA4135@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 10:57:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5I9q-00088A-36
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 10:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931AbXLTJ5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 04:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbXLTJ5O
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 04:57:14 -0500
Received: from os.eurotux.com ([216.75.63.6]:55590 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758472AbXLTJ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 04:57:12 -0500
Received: (qmail 17613 invoked from network); 20 Dec 2007 09:57:10 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Dec 2007 09:57:10 -0000
Content-Disposition: inline
In-Reply-To: <20071219232326.GA4135@bit.office.eurotux.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68987>


The previous sh version of git-commit evaluated the value of the define=
d
editor, thus allowing arguments.

Make the builtin version work the same, by adding an explicit check for
arguments in the editor command, and extract them to an additional argu=
ment.

Signed-off-by: Luciano Rocha <luciano@eurotux.com>
---
 builtin-tag.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

I personally use EDITOR=3D"gvim -f", thus this patch.
Now with free() of temporary buffer.

diff --git a/builtin-tag.c b/builtin-tag.c
index 274901a..0e8575e 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -46,7 +46,19 @@ void launch_editor(const char *path, struct strbuf *=
buffer, const char *const *e
 	if (!editor)
 		editor =3D "vi";
=20
-	if (strcmp(editor, ":")) {
+	if (strstr(editor, " -")) {
+		char *editor_cmd =3D xstrdup(editor);
+		char *editor_sep =3D strstr(editor_cmd, " -");
+		const char *args[] =3D { editor_cmd, editor_sep + 1,
+			path, NULL };
+
+		*editor_sep =3D '\0';
+
+		if (run_command_v_opt_cd_env(args, 0, NULL, env))
+			die("There was a problem with the editor %s.",
+					editor_cmd);
+		free(editor_cmd);
+	} else if (strcmp(editor, ":")) {
 		const char *args[] =3D { editor, path, NULL };
=20
 		if (run_command_v_opt_cd_env(args, 0, NULL, env))
--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>
