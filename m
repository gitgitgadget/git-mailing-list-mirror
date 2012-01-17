From: mhagger@alum.mit.edu
Subject: [PATCH 3/4] add_packed_ref(): new function in the refs API.
Date: Tue, 17 Jan 2012 06:50:33 +0100
Message-ID: <1326779434-20106-4-git-send-email-mhagger@alum.mit.edu>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 06:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn1wq-00060x-Dx
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 06:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155Ab2AQFvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 00:51:03 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50018 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab2AQFvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 00:51:01 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEDA74.dip.t-dialin.net [84.190.218.116])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0H5oam5006829;
	Tue, 17 Jan 2012 06:50:42 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188687>

From: Michael Haggerty <mhagger@alum.mit.edu>

Add a new function add_packed_ref() that adds a reference directly to
the in-memory packed reference cache.  This will be useful for
creating local references while cloning.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This new function call only stores the new reference to the in-memory
cache.  The user has to remember to call pack_refs() to actually write
the new reference(s) to the packed-refs file.  (I don't think it is
practical to make the write happen automatically.)

 refs.c |    6 ++++++
 refs.h |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 268816f..14f764d 100644
--- a/refs.c
+++ b/refs.c
@@ -319,6 +319,12 @@ static struct ref_array *get_packed_refs(struct ref_cache *refs)
 	return &refs->packed;
 }
 
+void add_packed_ref(const char *refname, const unsigned char *sha1)
+{
+	add_ref(get_packed_refs(get_ref_cache(NULL)),
+			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+}
+
 static void get_ref_dir(struct ref_cache *refs, const char *base,
 			struct ref_array *array)
 {
diff --git a/refs.h b/refs.h
index d498291..00ba1e2 100644
--- a/refs.h
+++ b/refs.h
@@ -51,6 +51,12 @@ extern int for_each_rawref(each_ref_fn, void *);
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname);
 
 /*
+ * Add a reference to the in-memory packed reference cache.  To actually
+ * write the reference to the packed-refs file, call pack_refs().
+ */
+extern void add_packed_ref(const char *refname, const unsigned char *sha1);
+
+/*
  * Extra refs will be listed by for_each_ref() before any actual refs
  * for the duration of this process or until clear_extra_refs() is
  * called. Only extra refs added before for_each_ref() is called will
-- 
1.7.8.3
