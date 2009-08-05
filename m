From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] git-describe: Die early if there are no possible
 descriptions
Date: Wed, 5 Aug 2009 16:17:40 +0200
Message-ID: <20090805141740.GA16846@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 16:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYhK7-0007Sm-MG
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 16:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934532AbZHEORp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 10:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934465AbZHEORp
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 10:17:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:50534 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934458AbZHEORo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 10:17:44 -0400
Received: (qmail invoked by alias); 05 Aug 2009 14:17:44 -0000
Received: from i59F55BB1.versanet.de (EHLO atjola.homenet) [89.245.91.177]
  by mail.gmx.net (mp052) with SMTP; 05 Aug 2009 16:17:44 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX192jlQjBwx2HtgWmNxtQWQethxFj/ztWCRYwB7zLj
	lE4xvn1043EWoQ
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124910>

If we found no refs that may be used for git-describe with the current
options, then die early instead of pointlessly walking the whole histor=
y.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
In git.git with all the tags dropped, this makes "git describe" go down
from 0.244 to 0.003 seconds for me. This is especially noticeable with
"git submodule" which calls describe with increasing levels of allowed
refs to be matched. Without tags, this means that it walks the whole
history in the submodule twice (first annotated, then plain tags), just
to find out that it can't describe the thing anyway.

I'm not particularly sure about found_names actually counting the found
names, it was just out of the thought that maybe the walking code could
make use of it, but I didn't actually check that and ran out of time, s=
o
I'm sending this version, hoping that it doesn't suck too much.

 builtin-describe.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 7a66298..cf802d1 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -20,6 +20,7 @@ static int tags;	/* Allow lightweight tags */
 static int longformat;
 static int abbrev =3D DEFAULT_ABBREV;
 static int max_candidates =3D 10;
+static int found_names =3D 0;
 static const char *pattern;
 static int always;
=20
@@ -39,6 +40,8 @@ static void add_to_known_names(const char *path,
 			       const unsigned char *sha1)
 {
 	struct commit_name *e =3D commit->util;
+	if (!e)
+		found_names++;
 	if (!e || e->prio < prio) {
 		size_t len =3D strlen(path)+1;
 		free(e);
@@ -195,6 +198,9 @@ static void describe(const char *arg, int last_one)
 		for_each_ref(get_name, NULL);
 	}
=20
+	if (!found_names)
+		die("cannot describe '%s'", sha1_to_hex(sha1));
+
 	n =3D cmit->util;
 	if (n) {
 		/*
--=20
1.6.4.19.g42af.dirty
