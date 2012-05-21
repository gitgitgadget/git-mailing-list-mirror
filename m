From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] add sorting infrastructure for list refs
Date: Mon, 21 May 2012 18:19:28 -0400
Message-ID: <20120521221928.GC22914@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWawx-00060J-Un
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab2EUWTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 May 2012 18:19:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51140
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab2EUWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:19:31 -0400
Received: (qmail 7005 invoked by uid 107); 21 May 2012 22:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:19:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:19:28 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198138>

Since we store lists of refs as linked lists, we can use
llist_mergesort to efficiently sort them.

Signed-off-by: Jeff King <peff@peff.net>
---
Many thanks to Ren=C3=A9 for the llist_mergesort code.

 remote.c | 22 ++++++++++++++++++++++
 remote.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/remote.c b/remote.c
index b296d17..6833538 100644
--- a/remote.c
+++ b/remote.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "tag.h"
 #include "string-list.h"
+#include "mergesort.h"
=20
 enum map_direction { FROM_SRC, FROM_DST };
=20
@@ -918,6 +919,27 @@ void free_refs(struct ref *ref)
 	}
 }
=20
+int ref_compare_name(const void *va, const void *vb)
+{
+	const struct ref *a =3D va, *b =3D vb;
+	return strcmp(a->name, b->name);
+}
+
+static void *ref_list_get_next(const void *a)
+{
+	return ((const struct ref *)a)->next;
+}
+
+static void ref_list_set_next(void *a, void *next)
+{
+	((struct ref *)a)->next =3D next;
+}
+
+void sort_ref_list(struct ref **l, int (*cmp)(const void *, const void=
 *))
+{
+	*l =3D llist_mergesort(*l, ref_list_get_next, ref_list_set_next, cmp)=
;
+}
+
 static int count_refspec_match(const char *pattern,
 			       struct ref *refs,
 			       struct ref **matched_ref)
diff --git a/remote.h b/remote.h
index 9ad8eb6..251d8fd 100644
--- a/remote.h
+++ b/remote.h
@@ -72,6 +72,8 @@ extern const struct refspec *tag_refspec;
 struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
+void sort_ref_list(struct ref **, int (*cmp)(const void *, const void =
*));
+int ref_compare_name(const void *, const void *);
=20
 int check_ref_type(const struct ref *ref, int flags);
=20
--=20
1.7.10.1.19.g711d603
