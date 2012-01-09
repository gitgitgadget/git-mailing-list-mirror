From: Jan Engelhardt <jengelh@medozas.de>
Subject: [PATCH] gitignore: warn about pointless syntax
Date: Mon,  9 Jan 2012 16:40:47 +0100
Message-ID: <1326123647-18352-2-git-send-email-jengelh@medozas.de>
References: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 16:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkHLK-0008VK-6n
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 16:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab2AIPky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 10:40:54 -0500
Received: from seven.medozas.de ([188.40.89.202]:42886 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab2AIPkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 10:40:53 -0500
Received: by seven.medozas.de (Postfix, from userid 25121)
	id BEC2A21A0A6D; Mon,  9 Jan 2012 16:40:50 +0100 (CET)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1326123647-18352-1-git-send-email-jengelh@medozas.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188174>

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
1.7.7
