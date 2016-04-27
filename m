From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/29] ref_transaction_commit(): correctly report close_ref() failure
Date: Wed, 27 Apr 2016 18:57:33 +0200
Message-ID: <18490be7195bac46a955b385b6848a2383417188.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnU-0003nF-8h
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbcD0Q6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:33 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53611 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892AbcD0Q6b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:31 -0400
X-AuditID: 12074414-62bff700000008e6-39-5720efb60f0c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 30.72.02278.6BFE0275; Wed, 27 Apr 2016 12:58:30 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6T022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:28 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvtvUK4wczbAhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oy+u8dYCu6wVNzaPJ21gfEJcxcjB4eEgInEoXa1
	LkYuDiGBrYwSu3+cYIRwjjNJ/F+0h6WLkZODTUBXYlFPMxOILSLgILF85S92kCJmgSYmie/L
	m8CKhAVCJeadWQpWxCKgKvGnYzoziM0rECXR0H4MzJYQkJO4PP0BG4jNKWAh8aX1LSOILSRg
	LrHkwWr2CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEhJjIDsYj
	J+UOMQpwMCrx8J6QUggXYk0sK67MPcQoycGkJMq75CxQiC8pP6UyI7E4I76oNCe1+BCjBAez
	kgjv9DdAOd6UxMqq1KJ8mJQ0B4uSOO+3xep+QgLpiSWp2ampBalFMFkZDg4lCd6j74AaBYtS
	01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kExEF8MjAKQFA/Q3lKQdt7igsRcoChE6ylG
	XY4FP26vZRJiycvPS5US530NUiQAUpRRmge3ApZQXjGKA30szBsEUsUDTEZwk14BLWECWnL5
	kCzIkpJEhJRUA+P0No4lPbGaegc/LUxrET5kJf9m5wn/km1sSjOalBov8os5cLnIu4vL6jXr
	rVzqFvPw8HPFnWYCYW6XW/bWqzs6hf2O4Q2bxy21LyZu8u1pepP3v+e8I3R0a6xQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292756>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
close() rarely fails, but it is possible.

 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8fcbd7d..e86e3de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3144,6 +3144,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			if (close_ref(update->lock)) {
 				strbuf_addf(err, "couldn't close '%s.lock'",
 					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 		}
-- 
2.8.1
