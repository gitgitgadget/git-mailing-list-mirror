From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/17] add_rev_cmdline(): make a copy of the name argument
Date: Sun, 19 May 2013 22:26:58 +0200
Message-ID: <1368995232-11042-4-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADB-0004Io-4K
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3ESU2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:04 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52338 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541Ab3ESU2B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:01 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-ed-519935d03b19
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.AC.02380.0D539915; Sun, 19 May 2013 16:28:00 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5M026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:27:58 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqHvBdGagwdQn3BZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj0UzLgu/sFa+2nGdvYFzJ1sXIySEhYCLxd/k8VghbTOLCvfVAcS4OIYHLjBL7Lt1i
	gXDOM0lc+faEGaSKTUBXYlFPMxOILSIgK/H98EZGEJtZYAKjxNL+wi5GDg5hAS+JyT+tQMIs
	AqoS134+AivnFXCR+LDtMSPEMgWJy7PWgI3kFHCV2NK+C+wIIaCaf/23WScw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERJQfDsY29fLHGIU4GBU4uHVeDc9UIg1
	say4MvcQoyQHk5Io7zuTmYFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj3CAHleFMSK6tSi/Jh
	UtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvObAyBESLEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAG6RBCnmLCxJzizPTIYpOMSpKifNeBDlLACSRUZoHNwAW+68YxYH+Eea1BWnnAaYNuO5X
	QIOZgAazXpsKMrgkESEl1cA4b4fa5a4HjZuVsz9lulcLX57w7Na6zP26Ne6/tlr0+Z7eJ3HV
	zmnr/dz6GwySVx0unUhIy182u/djDffUjzxsXw/8mJQyx7Ko5mRMs575+sTPiyrZ14pPFNkx
	7e2n5oilSRHmexZNieJRi85MZ1kdI3VX9l1Ki9+91gXNxepVm0Ktv25QuqGoxFKc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224909>

Instead of assuming that the memory pointed to by the name argument
will live forever, make a local copy of it before storing it in the
ref_cmdline_info.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a67b615..25e424c 100644
--- a/revision.c
+++ b/revision.c
@@ -898,6 +898,10 @@ static int limit_list(struct rev_info *revs)
 	return 0;
 }
 
+/*
+ * Add an entry to refs->cmdline with the specified information.
+ * *name is copied.
+ */
 static void add_rev_cmdline(struct rev_info *revs,
 			    struct object *item,
 			    const char *name,
@@ -909,7 +913,7 @@ static void add_rev_cmdline(struct rev_info *revs,
 
 	ALLOC_GROW(info->rev, nr + 1, info->alloc);
 	info->rev[nr].item = item;
-	info->rev[nr].name = name;
+	info->rev[nr].name = xstrdup(name);
 	info->rev[nr].whence = whence;
 	info->rev[nr].flags = flags;
 	info->nr++;
-- 
1.8.2.3
