From: Aidan Van Dyk <aidan@highrise.ca>
Subject: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 14:52:25 -0400
Message-ID: <20080730185225.GG10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 21:15:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOH8o-0001zG-T9
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYG3TOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYG3TOL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:14:11 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:40005 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbYG3TOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:14:10 -0400
X-Greylist: delayed 1451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jul 2008 15:14:10 EDT
Received: from localhost (yugib.highrise.ca [205.150.199.213])
	by yugib.highrise.ca (Postfix) with ESMTP id 79738111E62;
	Wed, 30 Jul 2008 14:52:25 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90837>

This is similar to NO_CURL.

Signed-off-by: Aidan Van Dyk <aidan@highrise.ca>
---

I came about this because SCO OpenServer doesnt' have mkdtemp.  But I never use
rsync, so making it optional was an easy fix.

 Makefile    |    4 ++++
 transport.c |    9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 798a2f2..b0a2985 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,10 @@ else
        CC_LD_DYNPATH = -R
 endif

+ifdef NO_RSYNC
+       BASIC_CFLAGS += -DNO_RSYNC
+endif
+
 ifdef NO_CURL
        BASIC_CFLAGS += -DNO_CURL
 else
diff --git a/transport.c b/transport.c
index 6eb65b8..867b01f 100644
--- a/transport.c
+++ b/transport.c
@@ -142,6 +142,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
        }
 }

+#ifndef NO_RSYNC
 static struct ref *get_refs_via_rsync(struct transport *transport)
 {
        struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
@@ -232,6 +233,7 @@ static int fetch_objs_via_rsync(struct transport *transport,

        return result;
 }
+#endif

 static int write_one_ref(const char *name, const unsigned char *sha1,
                int flags, void *data)
@@ -276,6 +278,7 @@ static int write_refs_to_temp_dir(struct strbuf *temp_dir,
        return 0;
 }

+#ifndef NO_RSYNC
 static int rsync_transport_push(struct transport *transport,
                int refspec_nr, const char **refspec, int flags)
 {
@@ -345,6 +348,7 @@ static int rsync_transport_push(struct transport *transport,

        return result;
 }
+#endif

 /* Generic functions for using commit walkers */

@@ -731,10 +735,13 @@ struct transport *transport_get(struct remote *remote, const char *url)
        ret->url = url;

        if (!prefixcmp(url, "rsync://")) {
+#ifdef NO_RSYNC
+               error("git was compiled without rsync support.");
+#else
                ret->get_refs_list = get_refs_via_rsync;
                ret->fetch = fetch_objs_via_rsync;
                ret->push = rsync_transport_push;
-
+#endif
        } else if (!prefixcmp(url, "http://")
                || !prefixcmp(url, "https://")
                || !prefixcmp(url, "ftp://")) {
--
1.6.0.rc1.dirty
