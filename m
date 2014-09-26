From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 23/39] git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
Date: Fri, 26 Sep 2014 12:08:23 +0200
Message-ID: <1411726119-31598-24-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSa9-0002oT-VH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbaIZKQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:48 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47268 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755976AbaIZKQq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:46 -0400
X-AuditID: 1207440d-f797f6d000000a4a-df-54253b58fece
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DE.5E.02634.85B35245; Fri, 26 Sep 2014 06:09:28 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM8013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:26 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1I2wVg0xaGzltei60s1k0dB7hdni
	ydy7zBZvby5htLi9Yj6zxY+WHmaLfxNqLDo7vjI6cHj8ff+ByWPnrLvsHgs2lXo8fNXF7vGs
	dw+jx8VLyh6fN8l53H62jSWAI4rbJimxpCw4Mz1P3y6BO+PtwUamghWsFY8fuTQwLmbpYuTk
	kBAwkZi8qJMdwhaTuHBvPRuILSRwmVHibqtzFyMXkL2JSeL6yz9gDWwCuhKLepqZQGwRATWJ
	iW2HWECKmAUWM0lMOLQJrFtYIF5i9e5lYEUsAqoSzz7PA4vzCrhKPJzUyQSxTU5iw+7/jCA2
	J1C8cfs1RojNLhIt6yezTGDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10gvN7NELzWl
	dBMjJBR5dzD+XydziFGAg1GJh/fGOpUQIdbEsuLK3EOMkhxMSqK8XyxUQ4T4kvJTKjMSizPi
	i0pzUosPMUpwMCuJ8N4xAsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4
	lCR4L1oCNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiO+GBgbICkeoL1cViB7
	iwsSc4GiEK2nGI05Wpre9jJxrOv81s8kxJKXn5cqJc57BGSTAEhpRmke3CJYEnrFKA70tzDv
	DZAqHmACg5v3CmgVE9AqpSPKIKtKEhFSUg2MCZmv6zyijA+qLpx0eZ5F8I9JbxIEOL6+up+2
	J3z2U/G57/Q7ra4oZEprp0mYb9cL9pQP5vnavvxfX5RZ3AWLBX82C8oIC7PmOi8O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257534>

After commit_lock_file() is called, then the lock_file object is
necessarily either committed or rolled back.  So there is no need to
call rollback_lock_file() again in either of these cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index a677eb6..123ed29 100644
--- a/config.c
+++ b/config.c
@@ -2083,6 +2083,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	if (commit_lock_file(lock) < 0) {
 		error("could not commit config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
+		lock = NULL;
 		goto out_free;
 	}
 
-- 
2.1.0
