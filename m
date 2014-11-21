From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] prune_remote(): sort delete_refs_list references en masse
Date: Fri, 21 Nov 2014 15:09:07 +0100
Message-ID: <1416578950-23210-4-git-send-email-mhagger@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 15:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrp0d-0003Nt-5j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 15:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbaKUOQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 09:16:24 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59982 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755321AbaKUOQX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 09:16:23 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Nov 2014 09:16:23 EST
X-AuditID: 12074412-f79e46d0000036b4-7c-546f47912a32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.8C.14004.1974F645; Fri, 21 Nov 2014 09:09:21 -0500 (EST)
Received: from michael.fritz.box (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sALE9EqR000733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 09:09:20 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqDvRPT/EoPc0l0XXlW4mi4beK8wW
	b28uYbS4vWI+s8W/CTUWmze3sziwefx9/4HJY+esu+weCzaVely8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfG+58fmAvesles/DGdqYFxP1sXIyeHhICJRMfO1YwQtpjEhXvrgeJcHEIClxkl
	Dp9uBCsSEjjOJLF8ZxqIzSagK7Gop5kJxBYR8JI4tW4GM0gDs8B8RonZ62aCTRIW8JP49aAZ
	zGYRUJWY33QIbBCvgIvEo/6JLF2MHEDb5CS2rvMGCXMKuEo8XdHHDrGrRuJK33a2CYy8CxgZ
	VjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEBJbQDsb1J+UOMQpwMCrx8C6Y
	kxcixJpYVlyZe4hRkoNJSZTX0C0/RIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb7kwUI43JbGy
	KrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYL3litQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoMuKLgbEBkuIB2msLchNvcUFiLlAUovUUo6KUOC8PSEIAJJFR
	mgc3FpYuXjGKA30pzFsFUsUDTDVw3a+ABjMBDf67NBdkcEkiQkqqgZFV/6sj79dA+SJpU48E
	tm/m9z7yvY46vvuOnvWNqVPyxBM+tUXwLJ1Z3LT8/6PO7z61sTGZ167UZhkUTvJdEfdW1/1i
	5JtrD+duL7fhtfeSK/2Qui3z0NEnfmkbq1tZtmnfPnVIQiPM8p2N2RudvzF3dv8L 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inserting items into a list in sorted order is O(N^2) whereas
appending them unsorted and then sorting the list all at once is
O(N lg N).

string_list_insert() also removes duplicates, and this change loses
that functionality. But the strings in this list, which ultimately
come from a for_each_ref() iteration, cannot contain duplicates.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
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
