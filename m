From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/27] update_refs(): fix constness
Date: Mon,  7 Apr 2014 15:47:57 +0200
Message-ID: <1396878498-19887-7-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9ut-0002aQ-QA
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbaDGNsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:47 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56682 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbaDGNsg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:36 -0400
X-AuditID: 1207440e-f79c76d000003e2c-12-5342acb376e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.39.15916.3BCA2435; Mon,  7 Apr 2014 09:48:35 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaD026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:33 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLt5jVOwwbQZyhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxLj56yFvQIVRx4sZyxgfEcXxcjJ4eEgInE3k+9
	TBC2mMSFe+vZuhi5OIQELjNKPJl/hAnCOcYkcWfie2aQKjYBXYlFPc1gHSICahIT2w6xgBQx
	C1xhlLjycTsLSEJYwEziyOTz7CA2i4CqRMfHxWA2r4CLxPEbF9gh1slJnDw2mRXE5hRwlZhx
	6BYjiC0EVHN/zTGWCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKE
	BB/fDsb29TKHGAU4GJV4eFcccgwWYk0sK67MPcQoycGkJMr7fJlTsBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiURXq7VQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv
	epBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO0dy7Y3uKCxFyg
	KETrKUZFKXHeEpCEAEgiozQPbiwspbxiFAf6Upj3OUgVDzAdwXW/AhrMBDTY0BVscEkiQkqq
	gXE2y9MlXzb+3R4V9st6//9C1VjnyelVM5WzrlRI+rTuTZezmnPOJewY20959hyZh+7Wvz8m
	H/iivXnCg00npU5J7BBdcWdJXUtoy0/v1fXb+u5cm+j5T0jGO5rFuuKkf80ZPpY5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245842>

The old signature of update_refs() required a
(const struct ref_update **) for its updates_orig argument.  The
"const" is presumably there to promise that the function will not
modify the contents of the structures.

But this declaration does not permit the function to be called with a
(struct ref_update **), which is perfectly legitimate.  C's type
system is not powerful enough to express what we'd like.  So remove
the first "const" from the declaration.

On the other hand, the function *can* promise not to modify the
pointers within the array that is passed to it without inconveniencing
its callers.  So add a "const" that has that effect, making the final
declaration
(struct ref_update * const *).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index f6345e5..a8a68e8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,7 +14,7 @@ static const char * const git_update_ref_usage[] = {
 
 static int updates_alloc;
 static int updates_count;
-static const struct ref_update **updates;
+static struct ref_update **updates;
 
 static char line_termination = '\n';
 static int update_flags;
diff --git a/refs.c b/refs.c
index 196984e..1305eb1 100644
--- a/refs.c
+++ b/refs.c
@@ -3306,7 +3306,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int update_refs(const char *action, const struct ref_update **updates_orig,
+int update_refs(const char *action, struct ref_update * const *updates_orig,
 		int n, enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
diff --git a/refs.h b/refs.h
index a713b34..08e60ac 100644
--- a/refs.h
+++ b/refs.h
@@ -228,7 +228,7 @@ int update_ref(const char *action, const char *refname,
 /**
  * Lock all refs and then perform all modifications.
  */
-int update_refs(const char *action, const struct ref_update **updates,
+int update_refs(const char *action, struct ref_update * const *updates,
 		int n, enum action_on_err onerr);
 
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
-- 
1.9.1
