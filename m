From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/18] struct nonmatching_ref_data: store a refname instead of a ref_entry
Date: Fri,  1 May 2015 14:25:47 +0200
Message-ID: <1430483158-14349-8-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1o-0001As-H4
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbbEAM0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:34 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42857 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753782AbbEAM0b (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:31 -0400
X-AuditID: 1207440e-f79bc6d000000c43-41-554370eaed26
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.01.03139.AE073455; Fri,  1 May 2015 08:26:18 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zk004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:17 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqPuqwDnUYNMJG4uuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ3z+Ppmt4DdnxbKVs5kbGNs5uhg5OSQETCRObTjLCGGLSVy4t56ti5GLQ0jgMqPEv3vr
	GCGcE0wSP1ZMBKtiE9CVWNTTzARiiwioSUxsO8QCUsQs0MEocWH5NnaQhLBAlMSnewdZQGwW
	AVWJHVfnM3cxcnDwCrhIdDSbQWyTkzh//CdYmFPAVeLL1ESQsBBQxf3vX9kmMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRESUHw7GNvXyxxiFOBgVOLh5TjpFCrE
	mlhWXJl7iFGSg0lJlNc2wTlUiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvPXWgHG9KYmVValE+
	TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgvdXPlCjYFFqempFWmZOCUKaiYMTZDiX
	lEhxal5KalFiaUlGPCgy4ouBsQGS4gHa+xCknbe4IDEXKArReopRUUqc9wRIQgAkkVGaBzcW
	liZeMYoDfSnMywpMGkI8wBQD1/0KaDAT0ODztxxABpckIqSkGhirLON4VVZHTOee8bnA7tOV
	jLXH59/4EF10dGLm44slm887BCSGZMy4F3GUw+NxKediK4Y42Q9FPIJmc4uXaNxN9PmrlL5k
	6v4MnSdpCZ+999+83WR+ovBhP48tg1Ry/49lEr3O3+qKuNf+bHtfIxz0JuTrm1Wc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268126>

Now that we don't need a ref_entry to pass to
report_refname_conflict(), it is sufficient to store the refname of
the conflicting reference.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index f1da87b..0ec3f0a 100644
--- a/refs.c
+++ b/refs.c
@@ -848,7 +848,7 @@ static void prime_ref_dir(struct ref_dir *dir)
 
 struct nonmatching_ref_data {
 	const struct string_list *skip;
-	struct ref_entry *found;
+	const char *conflicting_refname;
 };
 
 static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
@@ -858,7 +858,7 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 	if (data->skip && string_list_has_string(data->skip, entry->name))
 		return 0;
 
-	data->found = entry;
+	data->conflicting_refname = entry->name;
 	return 1;
 }
 
@@ -950,7 +950,8 @@ static int is_refname_available(const char *refname,
 		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
 			return 1;
 
-		error("'%s' exists; cannot create '%s'", data.found->name, refname);
+		error("'%s' exists; cannot create '%s'",
+		      data.conflicting_refname, refname);
 		return 0;
 	}
 
-- 
2.1.4
