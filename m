From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Tue, 9 Dec 2008 09:36:27 +0100
Message-ID: <20081209093627.77039a1f@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tyler@slide.com
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9y6L-0006iG-Vq
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 09:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYLIIgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYLIIgg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 03:36:36 -0500
Received: from zoidberg.org ([213.133.99.5]:49540 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbYLIIgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 03:36:35 -0500
Received: from perceptron (xdsl-78-34-132-210.netcologne.de [::ffff:78.34.132.210])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Tue, 09 Dec 2008 09:36:33 +0100
  id 00185BCD.493E2E11.0000619B
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102607>

=46or fixing a corrupted repository by using backup copies of individua=
l
files, allow write_sha1_file() to write loose files even if the object
already exists in a pack file, but only if the existing entry is marked
as corrupted.

Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
---

On IRC I talked to rtyler who had a corrupted pack file and plenty of
object backups by way of cloned repositories. We decided to try
extracting the corrupted objects from the other object database and
injecting them into the broken repo as loose objects, but this failed
because sha1_write_file() refuses to write loose objects that are
already present in a pack file.

This patch expands the check to see if the pack entry has been marked
as corrupted and, if so, allows writing a loose object with the same
ID. Unfortunately, when Tyler tried a merge while using this patch,
something we didn't manage to track down happened and now git doesn't
consider the object corrupted anymore. I'm not sure enough that it
wasn't caused by the patch to submit this patch without hesitation.

Apart from that, I think the change is not all too great since it makes
write_sha1_file() walk the list of pack entries twice. That's a bit of
a waste.

So those are the reasons why I wanted a few opinions first. Another
reason is that there might be a way smarter method to fix this kind of
problem, in which case I'd love hearing about it for future reference.

 sha1_file.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6c0e251..17085cc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2373,14 +2373,17 @@ int write_sha1_file(void *buf, unsigned long le=
n, const char *type, unsigned cha
 	char hdr[32];
 	int hdrlen;
=20
-	/* Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
-	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (has_sha1_file(sha1))
-		return 0;
+	/* Normally if we have it in the pack then we do not bother writing
+	 * it out into .git/objects/??/?{38} file. We do, though, if there
+	 * is no chance that we have an uncorrupted version of the object.
+	 */
+	if (has_sha1_file(sha1)) {
+		if (has_loose_object(sha1) || !has_packed_and_bad(sha1))
+			return 0;
+	}
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }
=20
--=20
1.6.0.4.766.g6fc4a
