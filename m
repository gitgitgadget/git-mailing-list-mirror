From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] diff: reset color before printing newline
Date: Tue, 17 Jun 2008 02:22:05 +0200
Message-ID: <20080617002205.GD7003@neumann>
References: <1213653602-31307-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 02:23:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8OzE-0006PQ-Qh
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 02:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbYFQAWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYFQAWy
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 20:22:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:51949 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYFQAWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 20:22:53 -0400
Received: from [127.0.1.1] (p5B133450.dip0.t-ipconnect.de [91.19.52.80])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1K8Oxa0ys4-0000ls; Tue, 17 Jun 2008 02:22:09 +0200
Content-Disposition: inline
In-Reply-To: <1213653602-31307-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/uVESBeWvurfWpiZA6kJrJPuBoOBWykg1Irvr
 omfCIdgqLdUyu8Wu2WQ9ik7shw61YnW0RvP9fMgpXbQqF6E4v+
 Den6ilfRu/SQFbXVlCjSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85250>

Junio,

On Tue, Jun 17, 2008 at 12:00:02AM +0200, SZEDER G=E1bor wrote:
> I'm not sure about putting a newline unconditionally at the end of th=
e
> line, but this was the status quo before c1795bb0.
we _must_ not print a newline when there was none, as it breaks
"normal" colored diffs very badly.

Since c1795bb0, for whatever reason, checkdiff_consume() first calls
emit_line() to print only the first '+' character of the line, without
trailing newline, and then calls check_and_emit_line() to print the
rest of the line.  Now if we restore the status quo prior to c1795bb0
regarding unconditional newlines in emit_line(), then there is always
a newline between the the '+' and the rest of the line, which is bad,
bad, bad.

So this should be squashed to the previous patch.

---
 diff.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index f23657b..722f577 100644
--- a/diff.c
+++ b/diff.c
@@ -514,13 +514,18 @@ const char *diff_get_color(int diff_use_color, en=
um color_diff ix)
=20
 static void emit_line(FILE *file, const char *set, const char *reset, =
const char *line, int len)
 {
-	if (len > 0 && line[len-1] =3D=3D '\n')
+	int trailing_newline =3D 0;
+
+	if (len > 0 && line[len-1] =3D=3D '\n') {
 		len--;
+		trailing_newline =3D 1;
+	}
=20
 	fputs(set, file);
 	fwrite(line, len, 1, file);
 	fputs(reset, file);
-	fputc('\n', file);
+	if (trailing_newline)
+		fputc('\n', file);
 }
=20
 static void emit_add_line(const char *reset, struct emit_callback *ecb=
data, const char *line, int len)
