From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH v2] git-describe: Die early if there are no possible
 descriptions
Date: Thu, 6 Aug 2009 14:15:14 +0200
Message-ID: <20090806121514.GA1701@atjola.homenet>
References: <20090805154205.GA17792@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 14:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ1sd-0004FY-S6
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 14:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbZHFMPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 08:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbZHFMPV
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 08:15:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:43961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754917AbZHFMPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 08:15:20 -0400
Received: (qmail invoked by alias); 06 Aug 2009 12:15:18 -0000
Received: from i59F54D83.versanet.de (EHLO atjola.homenet) [89.245.77.131]
  by mail.gmx.net (mp020) with SMTP; 06 Aug 2009 14:15:18 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+tCkdiramtym72/4SRKYaq86SHguT4AZkRrrk7zB
	7ANGS8saHiSpJv
Content-Disposition: inline
In-Reply-To: <20090805154205.GA17792@atjola.homenet>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125065>

If we find no refs that may be used for git-describe with the current
options, then die early instead of pointlessly walking the whole
history.

In git.git with all the tags dropped, this makes "git describe" go down
from 0.244 to 0.003 seconds for me. This is especially noticeable with
"git submodule status" which calls describe with increasing levels of
allowed refs to be matched. For a submodule without tags, this means
that it walks the whole history in the submodule twice (first annotated=
,
then plain tags), just to find out that it can't describe the commit
anyway.

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
v2 improved the commit message and turned found_names into a boolean,
instead of a counter for the found names.

 builtin-describe.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 7a66298..75feb11 100644
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
@@ -49,6 +50,7 @@ static void add_to_known_names(const char *path,
 		memcpy(e->path, path, len);
 		commit->util =3D e;
 	}
+	found_names =3D 1;
 }
=20
 static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
@@ -195,6 +197,9 @@ static void describe(const char *arg, int last_one)
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
1.6.4.20.gd25bb.dirty
