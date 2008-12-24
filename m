From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] builtin-shortlog.c: use string_list_append() instead of duplicating its code
Date: Wed, 24 Dec 2008 17:34:36 +0100
Message-ID: <1230136476-11081-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 24 17:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFWuN-0000Kk-TY
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 17:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLXQqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Dec 2008 11:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYLXQql
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 11:46:41 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3468
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYLXQql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 11:46:41 -0500
X-Greylist: delayed 720 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Dec 2008 11:46:40 EST
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id CF1BA801BF68;
	Wed, 24 Dec 2008 17:34:37 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LFWgu-0002y1-Bl; Wed, 24 Dec 2008 17:34:36 +0100
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103861>

Also, when clearing the "onelines" string lists, do not free the "util"
member: with string_list_append() is not initialized to any value (and
was being initialized to NULL previously anyway).

NB: The duplicated code in builtin-shortlog.c predated the appearance o=
f
string_list_append().

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 builtin-shortlog.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index d03f14f..4c5d761 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -36,7 +36,6 @@ static void insert_one_record(struct shortlog *log,
 	const char *dot3 =3D log->common_repo_prefix;
 	char *buffer, *p;
 	struct string_list_item *item;
-	struct string_list *onelines;
 	char namebuf[1024];
 	size_t len;
 	const char *eol;
@@ -104,16 +103,7 @@ static void insert_one_record(struct shortlog *log=
,
 		}
 	}
=20
-	onelines =3D item->util;
-	if (onelines->nr >=3D onelines->alloc) {
-		onelines->alloc =3D alloc_nr(onelines->nr);
-		onelines->items =3D xrealloc(onelines->items,
-				onelines->alloc
-				* sizeof(struct string_list_item));
-	}
-
-	onelines->items[onelines->nr].util =3D NULL;
-	onelines->items[onelines->nr++].string =3D buffer;
+	string_list_append(buffer, item->util);
 }
=20
 static void read_from_stdin(struct shortlog *log)
@@ -323,7 +313,7 @@ void shortlog_output(struct shortlog *log)
 		}
=20
 		onelines->strdup_strings =3D 1;
-		string_list_clear(onelines, 1);
+		string_list_clear(onelines, 0);
 		free(onelines);
 		log->list.items[i].util =3D NULL;
 	}
--=20
1.6.0.4
