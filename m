From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH v2] builtin-shortlog.c: use string_list_append(), and don't strdup unnecessarily
Date: Tue, 30 Dec 2008 21:25:22 +0100
Message-ID: <1230668722-26394-1-git-send-email-dato@net.com.org.es>
References: <alpine.DEB.1.00.0812301319140.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 30 21:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHlCJ-0002gT-QH
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 21:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbYL3UZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Dec 2008 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYL3UZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 15:25:25 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1825
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbYL3UZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 15:25:24 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 02BD6801C078;
	Tue, 30 Dec 2008 21:25:23 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LHl9W-0006sp-2M; Tue, 30 Dec 2008 21:25:22 +0100
X-Mailer: git-send-email 1.6.1.307.g07803
In-Reply-To: <alpine.DEB.1.00.0812301319140.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104202>

Make cleanup in insert_one_record() use string_list_append(), instead o=
f
duplicating its code. Because of this, do not free the "util" member wh=
en
clearing the "onelines" string lists: with the new code path it is not
initialized to any value (was being initialized to NULL previously).

Also, avoid unnecessary strdup() calls when inserting names in log->lis=
t.
This list always has "strdup_strings" activated, hence strdup'ing nameb=
uf is
unnecessary. This change also removes a latent memory leak in the old c=
ode.

NB: The duplicated code mentioned above predated the appearance of
string_list_append().

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---

> FWIW I like the patch, but would like it even more if the strdup() re=
moval=20
> was squashed in (with an explanation in the commit message).

Ok, I myself prefer it the other way, but here it is. :-)

 builtin-shortlog.c |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index d03f14f..90e76ae 100644
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
@@ -68,12 +67,9 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " %.*s", maillen, boemail);
 	}
=20
-	buffer =3D xstrdup(namebuf);
-	item =3D string_list_insert(buffer, &log->list);
+	item =3D string_list_insert(namebuf, &log->list);
 	if (item->util =3D=3D NULL)
 		item->util =3D xcalloc(1, sizeof(struct string_list));
-	else
-		free(buffer);
=20
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
@@ -104,16 +100,7 @@ static void insert_one_record(struct shortlog *log=
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
@@ -323,7 +310,7 @@ void shortlog_output(struct shortlog *log)
 		}
=20
 		onelines->strdup_strings =3D 1;
-		string_list_clear(onelines, 1);
+		string_list_clear(onelines, 0);
 		free(onelines);
 		log->list.items[i].util =3D NULL;
 	}
--=20
1.6.1.307.g07803
