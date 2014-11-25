From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 3/7] prune_remote(): sort delete_refs_list references en masse
Date: Tue, 25 Nov 2014 09:02:31 +0100
Message-ID: <1416902555-10748-4-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:03:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB5Y-0001v2-CK
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaKYIC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:02:58 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52000 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752060AbaKYICv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:02:51 -0500
X-AuditID: 12074413-f79f26d0000030e7-f7-547437aaf45a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.CC.12519.AA734745; Tue, 25 Nov 2014 03:02:50 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0m027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:49 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLvKvCTE4MgUK4uuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6MZav2sRYs4Kg4NOkyUwPjW7YuRg4OCQETibUntLoYOYFMMYkL99YDhbk4hAQu
	M0q8fATicAI5x5kkzvRZgNhsAroSi3qamUBsEQE1iYlth1hAGpgFDjNKvN65jB0kISwQKHHg
	7lZGEJtFQFXixcvjTCDLeAVcJJ6dZIbYKyexdZ03SAWngKvEzL2HGCFWuUis3dfKPoGRdwEj
	wypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkKAS3sG466TcIUYBDkYlHt6G
	Y8UhQqyJZcWVuYcYJTmYlER5RQxLQoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8EbNAyrnTUms
	rEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwypsBDRUsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHRUV8MTAuQFI8QHuLQNp5iwsSc4GiEK2nGBWlxHlDQRICIImM
	0jy4sbBU8YpRHOhLYd4JIFU8wDQD1/0KaDAT0OC4mYUgg0sSEVJSDYwsVgdn3Ji8oORgAwdv
	eLzP4VS3jBnqF13vX5kxRZfBr/bx6m+Wt9xZP5QvnbdlTVnN3vCD5g1LDtQJu92x6Las4bW5
	Hzbxt1JTPs8fy4UJtbKRvxk/PvN1ccow+GZVv2nvXKWUWXJ9e42aLr2bY7Rb8pis 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260202>

Inserting items into a list in sorted order is O(N^2) whereas
appending them unsorted and then sorting the list all at once is
O(N lg N).

string_list_insert() also removes duplicates, and this change loses
that functionality. But the strings in this list, which ultimately
come from a for_each_ref() iteration, cannot contain duplicates.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d5a5a16..7d5c8d2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1341,8 +1341,9 @@ static int prune_remote(const char *remote, int dry_run)
 		const char *refname = states.stale.items[i].util;
 
 		delete_refs[i] = refname;
-		string_list_insert(&delete_refs_list, refname);
+		string_list_append(&delete_refs_list, refname);
 	}
+	sort_string_list(&delete_refs_list);
 
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
-- 
2.1.3
