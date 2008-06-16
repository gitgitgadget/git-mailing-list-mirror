From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] diff: reset color before printing newline
Date: Tue, 17 Jun 2008 00:00:02 +0200
Message-ID: <1213653602-31307-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 00:01:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Ml8-0002UO-Ks
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756910AbYFPWAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756544AbYFPWAK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:00:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59714 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbYFPWAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:00:09 -0400
Received: from [127.0.1.1] (p5B133450.dip0.t-ipconnect.de [91.19.52.80])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1K8Mk546aO-0005pR; Tue, 17 Jun 2008 00:00:02 +0200
X-Mailer: git-send-email 1.5.6.rc2.55.g9b8c
X-Provags-ID: V01U2FsdGVkX1/KMr0hoxTTpO4AKUNn80TvKZpQQCQBMT03lU1
 KdWW4RJSIJFLK+IERMfHikCxEqAOpnEn8MPa1BxLnXOKl7i8jy
 LeBFMOjx2llKuk5xfCp8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85239>

It worked that way since commit 50f575fc (Tweak diff colors,
2006-06-22), but commit c1795bb0 (Unify whitespace checking, 2007-12-13=
)
changed it.  This patch restores the old behaviour.

Besides Linus' arguments in the log message of 50f575fc, resetting colo=
r
before printing newline is also important to keep 'git add --patch'
happy.  If the last line(s) of a file are removed, then that hunk will
end with a colored line.  However, if the newline comes before the colo=
r
reset, then the diff output will have an additional line at the end
containing only the reset sequence.  This causes trouble in
git-add--interactive.perl's parse_diff function, because @colored will
have one more element than @diff, and that last element will contain th=
e
color reset.  The elements of these arrays will then be copied to @hunk=
,
but only as many as the number of elements in @diff.  As a result the
last color reset is lost and all subsequent terminal output will be
printed in color.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I'm not sure about putting a newline unconditionally at the end of the
line, but this was the status quo before c1795bb0.

 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 62fdc54..f23657b 100644
--- a/diff.c
+++ b/diff.c
@@ -514,9 +514,13 @@ const char *diff_get_color(int diff_use_color, enu=
m color_diff ix)
=20
 static void emit_line(FILE *file, const char *set, const char *reset, =
const char *line, int len)
 {
+	if (len > 0 && line[len-1] =3D=3D '\n')
+		len--;
+
 	fputs(set, file);
 	fwrite(line, len, 1, file);
 	fputs(reset, file);
+	fputc('\n', file);
 }
=20
 static void emit_add_line(const char *reset, struct emit_callback *ecb=
data, const char *line, int len)
--=20
1.5.6.rc2.55.g9b8c
