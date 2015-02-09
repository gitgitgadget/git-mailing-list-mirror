From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 7/8] reflog_expire(): never update a reference to null_sha1
Date: Mon,  9 Feb 2015 10:12:43 +0100
Message-ID: <1423473164-6011-8-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkP2-0007jN-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbbBIJNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:13:04 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60676 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932517AbbBIJNC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:13:02 -0500
X-AuditID: 12074412-f79e46d0000036b4-8a-54d87a1e405d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.C9.14004.E1A78D45; Mon,  9 Feb 2015 04:13:02 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQd026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:13:01 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqCtXdSPEYPFeHouuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZS/rqCz4KVmx8sYmpgXE5XxcjJ4eEgIlE6/ylLBC2mMSFe+vZQGwh
	gcuMEi3fLboYuYDsE0wSSx8vYwJJsAnoSizqaQazRQTUJCa2HQJrZhZYzSSx9S5QMweHsIC3
	xKrDcSBhFgFVic03X7KD2LwCzhJ7722C2iUncf74T2YQm1PAReLduTlQe50lZk/exzyBkXcB
	I8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJAAE9rBuP6k3CFGAQ5GJR7e
	C5+vhwixJpYVV+YeYpTkYFIS5V2QeCNEiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv9wygHG9K
	YmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eSBC9XJVCjYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPCgq4ouBcQGS4gHa+7UCZG9xQWIuUBSi9RSjopQ47zeQhABI
	IqM0D24sLG28YhQH+lKYlxNkOw8w5cB1vwIazAQ0uKAAbHBJIkJKqoFR3IM98sjC20GOe5Rq
	17vel5NcfVk27pqlXPDspcHG/3ee3TK5hPl98MFYwzuPDk7/Lh5dsSvIqPjC/ciG1q7EOWyn
	1wt2mHwuFDlTnpGVM9ushS3veqTa/g77FT9MznDqJ0ovjDn3xZY1/Xr+tb0VTc5L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263548>

Currently, if --updateref is specified and the very last reflog entry
is expired or deleted, the reference's value is set to 0{40}. This is
an invalid state of the repository, and breaks, for example, "git
fsck" and "git for-each-ref".

The only place we use --updateref in our own code is when dropping
stash entries. In that code, the very next step is to check if the
reflog has been made empty, and if so, delete the "refs/stash"
reference entirely. Thus that code path ultimately leaves the
repository in a valid state.

But we don't want the repository in an invalid state even temporarily,
and we don't want leave an invalid state if other callers of "git
reflog expire|delete --updateref" don't think to do the extra cleanup
step.

So, if "git reflog expire|delete" leaves no more entries in the
reflog, just leave the reference un-updated.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Another alternative would be to delete the reference in this
situation. This behavior would be kindof logically consistent and
happens to be just the thing that "git stash drop" wants. It wouldn't
even really be backwards-incompatible, given that the current code
leaves a broken repository in this situation. However, this change
would require some special casing if the reference whose reflog is
being expired is the current reference, and it somehow seems too
"lossy" to me for some reason. I'm open to feedback on this point.

 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index c0001da..1b2a497 100644
--- a/refs.c
+++ b/refs.c
@@ -4077,10 +4077,13 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		/*
 		 * It doesn't make sense to adjust a reference pointed
 		 * to by a symbolic ref based on expiring entries in
-		 * the symbolic reference's reflog.
+		 * the symbolic reference's reflog. Nor can we update
+		 * a reference if there are no remaining reflog
+		 * entries.
 		 */
 		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			~(type & REF_ISSYMREF);
+			~(type & REF_ISSYMREF) &&
+			!is_null_sha1(cb.last_kept_sha1);
 
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
-- 
2.1.4
