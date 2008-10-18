From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] force_object_loose: Fix memory leak
Date: Sat, 18 Oct 2008 02:37:31 +0200
Message-ID: <20081018003731.GA17290@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 02:38:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzqG-0003RD-03
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 02:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbYJRAhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Oct 2008 20:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755628AbYJRAhg
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 20:37:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:53090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755496AbYJRAhf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 20:37:35 -0400
Received: (qmail invoked by alias); 18 Oct 2008 00:37:33 -0000
Received: from i577AE087.versanet.de (EHLO atjola.local) [87.122.224.135]
  by mail.gmx.net (mp023) with SMTP; 18 Oct 2008 02:37:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19mMYpD0H9mFdDi33suC61+QQnpszQT/t3ehyDv9m
	5FxTf98XIub6b3
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98510>

read_packed_sha1 expectes its caller to free the buffer it returns, whi=
ch
force_object_loose didn't do.

This leak is eventually triggered by "git gc", when it is manually invo=
ked
or there are too many packs around, making gc totally unusable when the=
re
are lots of unreachable objects.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
Tested with a somewhat recent clone of linux-2.6.git:

git clone linux-2.6 test
cd test
git remote rm origin
git reset --hard v2.6.16
git for-each-ref --format=3D'%(refname)' refs/tags | \
	xargs -i git update-ref -d {}
git reflog expire --expire=3D0 --all
git repack -Ad

Without the fix, I killed repack when its memory usage got past 3 _GB_.
With the fix, it stays at around 300MB until it starts writing the
new pack, then it goes up to about 550MB or so.

 sha1_file.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 3fbb082..70bb453 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2333,6 +2333,7 @@ int force_object_loose(const unsigned char *sha1,=
 time_t mtime)
 	enum object_type type;
 	char hdr[32];
 	int hdrlen;
+	int ret;
=20
 	if (has_loose_object(sha1))
 		return 0;
@@ -2340,7 +2341,10 @@ int force_object_loose(const unsigned char *sha1=
, time_t mtime)
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen =3D sprintf(hdr, "%s %lu", typename(type), len) + 1;
-	return write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	ret =3D write_loose_object(sha1, hdr, hdrlen, buf, len, mtime);
+	free(buf);
+
+	return ret;
 }
=20
 int has_pack_index(const unsigned char *sha1)
--=20
1.6.0.2.541.g46dc1.dirty
