From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/22] config: change write_error() to take a (struct lock_file *) argument
Date: Tue,  1 Apr 2014 17:58:21 +0200
Message-ID: <1396367910-7299-14-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV16X-0002ve-Km
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbaDAP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:58:58 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54276 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887AbaDAP64 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:56 -0400
X-AuditID: 12074412-f79d46d000002e58-08-533ae23ffbde
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 50.4C.11864.F32EA335; Tue,  1 Apr 2014 11:58:56 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbH027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:54 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqOvwyCrYYNEuRouuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ2x6nQjU8EF7oq+C7eYGxj7OLsYOTkkBEwkbi1qY4ewxSQu3FvP1sXIxSEkcJlRYua0
	J6wQzjEmiffTZrCCVLEJ6Eos6mlmArFFBNQkJrYdYgGxmQVSJF793QVmCwtESyzuXs0MYrMI
	qErM33oLrJdXwEXid9dcqG1yElN+LwCzOYHilx7sAasREnCWOP1mMfMERt4FjAyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUKCSmgH4/qTcocYBTgYlXh4D5y3ChZiTSwr
	rsw9xCjJwaQkyvvjLlCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+sm0A53pTEyqrUonyYlDQH
	i5I478/F6n5CAumJJanZqakFqUUwWRkODiUJXvmHQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWp
	eSmpRYmlJRnxoNiILwZGB0iKB2ivIkg7b3FBYi5QFKL1FKOilDgvywOghABIIqM0D24sLFW8
	YhQH+lKYVxeknQeYZuC6XwENZgIazL0ObHBJIkJKqoHx4KGTWY/u2hefEtedxPngT22W42HH
	zZsUtRPWKturc1Q/uFS+6c/2AO7WuZK/t5tNYt1S718etz5K7pDQOce5FpO8zHenJbSvkijZ
	+3my8poCrmjneb7qOlLOtd+TFZ/bJt74pPXpqrXQ/WVZZ06/rjTPFc/RX/rXd/un 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245606>

Reduce the amount of code that has to know about the lock_file's
filename field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 6821cef..1ea3f39 100644
--- a/config.c
+++ b/config.c
@@ -1303,9 +1303,9 @@ static int store_aux(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-static int write_error(const char *filename)
+static int write_error(struct lock_file *lk)
 {
-	error("failed to write new configuration file %s", filename);
+	error("failed to write new configuration file %s", lk->filename);
 
 	/* Same error code as "failed to rename". */
 	return 4;
@@ -1706,7 +1706,7 @@ out_free:
 	return ret;
 
 write_err_out:
-	ret = write_error(lock->filename);
+	ret = write_error(lock);
 	goto out_free;
 
 }
@@ -1821,7 +1821,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 				}
 				store.baselen = strlen(new_name);
 				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(lock->filename);
+					ret = write_error(lock);
 					goto out;
 				}
 				/*
@@ -1847,7 +1847,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 			continue;
 		length = strlen(output);
 		if (write_in_full(out_fd, output, length) != length) {
-			ret = write_error(lock->filename);
+			ret = write_error(lock);
 			goto out;
 		}
 	}
-- 
1.9.0
