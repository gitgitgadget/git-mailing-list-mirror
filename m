From: Jan Engelhardt <jengelh@medozas.de>
Subject: [patch] gitignore: warn about pointless syntax
Date: Mon, 9 Jan 2012 12:34:12 +0100 (CET)
Message-ID: <alpine.LNX.2.01.1201091233050.28805@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 12:34:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkDUf-0004Rx-NP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 12:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab2AILeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 06:34:20 -0500
Received: from seven.medozas.de ([188.40.89.202]:41644 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab2AILeT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 06:34:19 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 003EB21A0A20; Mon,  9 Jan 2012 12:34:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id D5BF621A0A1E
	for <git@vger.kernel.org>; Mon,  9 Jan 2012 12:34:12 +0100 (CET)
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188166>

parent eac2d83247ea0a265d923518c26873bb12c33778 (v1.7.9-rc0)
commit b629bde461aeb178b257ab7e0f6c180f69f98cb0
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 9 12:30:07 2012 +0100

gitignore: warn about pointless syntax

Add a warning to the gitignore parser if it sees "**". Git, using
fnmatch, does not consider the double-asterisk anything special like
rsync/zsh. Remind users of that, since too many seem to be Doing It
Wrong=E2=84=A2.

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 dir.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 0a78d00..60f65cb 100644
--- a/dir.c
+++ b/dir.c
@@ -376,6 +376,15 @@ void free_excludes(struct exclude_list *el)
 	el->excludes =3D NULL;
 }
=20
+static inline void check_bogus_wildcard(const char *file, const char *=
p)
+{
+	if (strstr(p, "**") =3D=3D NULL)
+		return;
+	warning(_("Pattern \"%s\" from file \"%s\": Double asterisk does not =
"
+		"have a special meaning and is interpreted just like a single "
+		"asterisk.\n"), file, p);
+}
+
 int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
@@ -427,6 +436,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
+				check_bogus_wildcard(fname, entry);
 				add_exclude(entry, base, baselen, which);
 			}
 			entry =3D buf + i + 1;
--=20
# Created with git-export-patch
