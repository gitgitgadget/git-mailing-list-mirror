From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] send-pack: Filter unknown commits from alternates of the
	remote
Date: Wed, 28 Jan 2009 02:38:40 +0100
Message-ID: <20090128013840.GA7224@atjola.homenet>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzQO-0004Bo-80
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbZA1Bjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 20:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbZA1Bjj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:39:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:41808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751708AbZA1Bjj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:39:39 -0500
Received: (qmail invoked by alias); 28 Jan 2009 01:39:37 -0000
Received: from i577BB3F1.versanet.de (EHLO atjola.local) [87.123.179.241]
  by mail.gmx.net (mp041) with SMTP; 28 Jan 2009 02:39:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19rb0dRzCVrbynD7+0o7Q9lRelBaCxwKXz4YBwJIH
	2bMkoqAJjJ8Fgj
Content-Disposition: inline
In-Reply-To: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107445>

Since 40c155ff14c, receive-pack on the remote also sends refs from its
alternates. Unfortunately, we don't filter commits that don't exist in =
the
local repository from that list.  This made us pass those unknown commi=
ts
to pack-objects, causing it to fail with a "bad object" error.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 builtin-send-pack.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index a9fdbf9..10d7016 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -52,11 +52,15 @@ static int pack_objects(int fd, struct ref *refs, s=
truct extra_have_objects *ext
 	 * parameters by writing to the pipe.
 	 */
 	for (i =3D 0; i < extra->nr; i++) {
-		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
-		buf[0] =3D '^';
-		buf[41] =3D '\n';
-		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
-			break;
+		if (!is_null_sha1(&extra->array[i][0]) &&
+		    has_sha1_file(&extra->array[i][0])) {
+			memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
+			buf[0] =3D '^';
+			buf[41] =3D '\n';
+			if (!write_or_whine(po.in, buf, 42,
+						"send-pack: send refs"))
+				break;
+		}
 	}
=20
 	while (refs) {
--=20
1.6.1.284.g5dc13.dirty
