From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/18] entry_matches(): inline function
Date: Fri,  1 May 2015 14:25:45 +0200
Message-ID: <1430483158-14349-6-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1a-0000zA-Vl
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbbEAM0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:22 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55396 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753715AbbEAM0S (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:18 -0400
X-AuditID: 12074413-f79f26d0000030e7-00-554370e8c6d0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 88.EC.12519.8E073455; Fri,  1 May 2015 08:26:16 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zi004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:15 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPuiwDnU4P88EYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ0x6toixYD13Rc/uC2wNjF2cXYycHBICJhKT569khbDFJC7cW8/WxcjFISRwmVGi4cEq
	ZgjnBJPEiflf2UGq2AR0JRb1NDOB2CICahIT2w6xgBQxC3QwSlxYvg2sSFjAXKL7yiIwm0VA
	VeL8jScsIDavgItEc+cKJoh1chLnj/8E2sDBwSngKvFlaiJIWAio5P73r2wTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJKeEdjLtOyh1iFOBgVOLh5TjpFCrE
	mlhWXJl7iFGSg0lJlNc2wTlUiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvPXWgHG9KYmVValE+
	TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgjcxH6hRsCg1PbUiLTOnBCHNxMEJMpxL
	SqQ4NS8ltSixtCQjHhQb8cXA6ABJ8QDtXQbSzltckJgLFIVoPcWoKCXO2wOSEABJZJTmwY2F
	JYpXjOJAXwrzsgLThhAPMMnAdb8CGswENPj8LQeQwSWJCCmpBkY9iccav5/vChGSqD7zbXae
	bdjzPA7/w36Xmqszc5dbPO+Y9Fjz8LqVIVynVl18tt30+bqVfkqsLb99vb7Y5iRYZEyYtaH+
	R/mOHPVb1Yfig5hXlBbU+pwMZ3/q87+77MFzjW/rF1q7n7m9u5onKuquPl/wjlhG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268119>

It wasn't pulling its weight. And in a moment we will need similar
tests that take a refname rather than a ref_entry as parameter, which
would have made entry_matches() even less useful.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 2ef1c5e..e9c9146 100644
--- a/refs.c
+++ b/refs.c
@@ -846,11 +846,6 @@ static void prime_ref_dir(struct ref_dir *dir)
 	}
 }
 
-static int entry_matches(struct ref_entry *entry, const struct string_list *list)
-{
-	return list && string_list_has_string(list, entry->name);
-}
-
 struct nonmatching_ref_data {
 	const struct string_list *skip;
 	struct ref_entry *found;
@@ -860,7 +855,7 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 {
 	struct nonmatching_ref_data *data = vdata;
 
-	if (entry_matches(entry, data->skip))
+	if (data->skip && string_list_has_string(data->skip, entry->name))
 		return 0;
 
 	data->found = entry;
@@ -906,7 +901,7 @@ static int is_refname_available(const char *refname,
 		pos = search_ref_dir(dir, refname, slash - refname);
 		if (pos >= 0) {
 			struct ref_entry *entry = dir->entries[pos];
-			if (entry_matches(entry, skip)) {
+			if (skip && string_list_has_string(skip, entry->name)) {
 				/*
 				 * The fact that entry is a ref whose
 				 * name is a prefix of refname means
-- 
2.1.4
