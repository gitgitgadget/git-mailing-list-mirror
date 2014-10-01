From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/3] commit_packed_refs(): reimplement using fdopen_lock_file()
Date: Wed,  1 Oct 2014 13:14:49 +0200
Message-ID: <1412162089-3233-4-git-send-email-mhagger@alum.mit.edu>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:15:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHsC-0005XU-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 13:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaJALPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 07:15:03 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58431 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbaJALPA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 07:15:00 -0400
X-AuditID: 1207440e-f79da6d0000002fc-fb-542be234fd78
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F6.DA.00764.432EB245; Wed,  1 Oct 2014 07:15:00 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91BEp6m028682
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 07:14:58 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYndR1DV5pB1isGINp0XXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BnTH3UwFrxkq5jVsYO9gfEKaxcj
	J4eEgInExttrmSBsMYkL99azdTFycQgJXGaUuLFhKxOEc5xJYum53SwgVWwCuhKLeprBOkQE
	1CQmth1iASliFljMJDHh0CY2kISwgL9E95njzCA2i4CqRM+9nUBxDg5eAWeJtuP1ENvkJDbs
	/s8IEuYUcJGYdYUTJCwEVLFj3iemCYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvl
	ZpbopaaUbmKEhCLfDsb29TKHGAU4GJV4eBUStEOEWBPLiitzDzFKcjApifI6PgAK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuHNPgCU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2C
	ycpwcChJ8PI+BGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VGfDEwNkBSPEB7
	hUDaeYsLEnOBohCtpxiNOVqa3vYycazr/NbPJMSSl5+XKiXOGwJyvgBIaUZpHtwiWBJ6xSgO
	9LcwrxrIQB5gAoOb9wpoFRPQquQ1YKtKEhFSUg2Mmdr/fzNKSTkVmHzgOZ0mHXRzn28/X+HM
	jFQJjn/BAV7i+93+h676/ze3vvwQmyVPtGzoxIL2dSu9uRWkNn1fGfn/+Pv35z45 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257742>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 1d73f1d..a77458f 100644
--- a/refs.c
+++ b/refs.c
@@ -2309,16 +2309,13 @@ int commit_packed_refs(void)
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 
-	out = fdopen(packed_ref_cache->lock->fd, "w");
+	out = fdopen_lock_file(packed_ref_cache->lock, "w");
 	if (!out)
 		die_errno("unable to fdopen packed-refs descriptor");
 
 	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn, out);
-	if (fclose(out))
-		die_errno("write error");
-	packed_ref_cache->lock->fd = -1;
 
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
-- 
2.1.0
