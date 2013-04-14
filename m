From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/33] peel_ref(): use function get_packed_ref()
Date: Sun, 14 Apr 2013 14:54:23 +0200
Message-ID: <1365944088-10588-9-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMT4-00046X-SL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab3DNMze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:34 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:65520 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870Ab3DNMz3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:29 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-90-516aa7407bff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 09.52.02295.047AA615; Sun, 14 Apr 2013 08:55:28 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk5007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:27 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqOuwPCvQoOuKgkXXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf0PH7DWLCJteLtec8GxkUsXYycHBICJhLNzWsYIWwxiQv31rN1MXJxCAlcZpTY+fcd
	O4Rzlkli7/3p7CBVbAK6Eot6mpm6GDk4RASyJXavlQcJMws4SGz+3Ag2SBjIPtB4mxXEZhFQ
	lZj89xUTiM0r4CLRc3YnO8QyBYnj27eB1XMKuEpMf34MLC4EVDNr82zWCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBBTPDsZv62QOMQpwMCrx8L5gzAoUYk0s
	K67MPcQoycGkJMp7chlQiC8pP6UyI7E4I76oNCe1+BCjBAezkgivYytQjjclsbIqtSgfJiXN
	waIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXsRZKhgUWp6akVaZk4JQpqJgxNEcIFs4AHa
	cBekkLe4IDG3ODMdougUo6KUOO9ZkIQASCKjNA9uACz2XzGKA/0jDFHFA0wbcN2vgAYzAQ32
	2ZsOMrgkESEl1cAoKMShbtig32x0lvuj0o6zjNZ3ZWN2TzX/cNu2/6GJfY0yz5RbRga39z1n
	MHH8ONM90/WHUVf94ZeJ/38ee+8dsO/6euMjNS+vrSsoXN8brXV+duRD/XKeWY0xm/6clflq
	Fqod93C30tEn3t8zT+YFXRZZFTNrvtktz9PHC5b07/3FdXyf7GEVJZbijERDLeai 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221102>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index de5dc7d..cf017a5 100644
--- a/refs.c
+++ b/refs.c
@@ -1282,10 +1282,9 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return -1;
 
 	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
+		struct ref_entry *r = get_packed_ref(refname);
 
-		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
+		if (r && (r->flag & REF_KNOWS_PEELED)) {
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
 		}
-- 
1.8.2.1
