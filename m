From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC/PATCH 1/2] for-each-ref: add new format 'refbasename'
Date: Fri, 29 Aug 2008 12:37:19 +0200
Message-ID: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 12:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ1NA-0007zR-3J
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 12:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYH2KhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2008 06:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYH2KhZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 06:37:25 -0400
Received: from francis.fzi.de ([141.21.7.5]:20511 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753128AbYH2KhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 06:37:23 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 12:37:21 +0200
X-Mailer: git-send-email 1.6.0.1.133.g10dd.dirty
X-OriginalArrivalTime: 29 Aug 2008 10:37:21.0360 (UTC) FILETIME=[37A4F500:01C909C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fot-each-ref's refname format outputs each ref in its full format, e.g.
'refs/heads/foo' and 'refs/tags/bar'.  However, there are tools that
need only the last part of the refname, e.g. only 'foo' and 'bar'.  Suc=
h
a tool is git's bash completion script, which spends considerable amoun=
t
of time removing the unneeded parts from for-each-ref's output.

Therefore, we introduce a new for-each-ref format called 'refbasename',
which strips everything before and including the second '/' in the ref'=
s
name from the output.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

  I assumed that refs always look like 'refs/{heads,tags,whatever}/foo'=
,
  hence this patch breaks if a ref might look like 'refs/foo' or just
  'foo'.  But can I really rely on that?

 builtin-for-each-ref.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..1993ff4 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -66,6 +66,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "refbasename" },
 };
=20
 /*
@@ -577,6 +578,10 @@ static void populate_value(struct refinfo *ref)
 			char *s =3D xmalloc(len + 4);
 			sprintf(s, "%s^{}", ref->refname);
 			v->s =3D s;
+		} else if (!strcmp(name, "refbasename")) {
+			char * p =3D strchr(ref->refname, '/');
+			p =3D strchr(p+1, '/');
+			v->s =3D p+1;
 		}
 	}
=20
--=20
1.6.0.1.133.g10dd.dirty
