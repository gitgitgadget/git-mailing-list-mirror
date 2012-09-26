From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/8] longest_ancestor_length(): always add a slash to the end of prefixes
Date: Wed, 26 Sep 2012 21:34:47 +0200
Message-ID: <1348688090-13648-6-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOi-0004jo-FS
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313Ab2IZTfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:41 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:49306 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758324Ab2IZTfg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:36 -0400
X-AuditID: 12074412-b7f216d0000008e3-78-5063590798f2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.8F.02275.70953605; Wed, 26 Sep 2012 15:35:35 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfj010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:34 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqMsemRxgsHmeqEXXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGc8
	ec5V8Ie7ovPyDdYGxuWcXYycHBICJhLTrrewQ9hiEhfurWfrYuTiEBK4zCjR1n+OGcI5wySx
	eMceNpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXMApMYJXo2PAAbJSwQKfHg5zlGEJtFQFVi1Z8t
	zCA2r4CLRMuPj0wQ6xQlfnxfAxbnFHCV+LLhAtgCIaCaw69uMU9g5F3AyLCKUS4xpzRXNzcx
	M6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIySQhHYwrj8pd4hRgINRiYfX0yE5QIg1say4MvcQ
	oyQHk5Ior3UYUIgvKT+lMiOxOCO+qDQntfgQowQHs5II77OspAAh3pTEyqrUonyYlDQHi5I4
	78/F6n5CAumJJanZqakFqUUwWRkODiUJXo0IoKGCRanpqRVpmTklCGkmDk4QwQWygQdogzBI
	IW9xQWJucWY6RNEpRkUpcd5/4UAJAZBERmke3ABYzL9iFAf6R5hXDKSdB5gu4LpfAQ1mAhq8
	dBPI6cUliQgpqQbGqvofvRx57RUBZun2pxPr2mrXRJ3WdmH95hOZO/nhnOtWUu1lb50fXczY
	dOqOQM4PwyMKp6czOFRv/Z++6knCiu1TWW5ssTuRPsHCLf6N8F8zwX09H4OqdV79LF7d8XR6
	k3rOPX2NyJw8n7NH3T49cn00u3qm0Qoxr7JEi0xPMzYF5frENZpKLMUZiYZazEXF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206437>

Previously we stripped off any slashes that were present.  Instead,
add a slash if it is missing.  This removes the need for an extra
check that path has a slash following the prefix and makes the
handling of the root directory more natural, making the way clear to
use string_list_longest_prefix().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index 6da7029..90ef53d 100644
--- a/path.c
+++ b/path.c
@@ -570,7 +570,7 @@ int normalize_path_copy(char *dst, const char *src)
 
 static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 {
-	char buf[PATH_MAX+1];
+	char buf[PATH_MAX+2];
 	const char *ceil = item->string;
 	int len = strlen(ceil);
 
@@ -580,8 +580,10 @@ static int normalize_path_callback(struct string_list_item *item, void *cb_data)
 	if (normalize_path_copy(buf, buf) < 0)
 		return 0;
 	len = strlen(buf);
-	if (len > 0 && buf[len-1] == '/')
-		buf[--len] = '\0';
+	if (len == 0 || buf[len-1] != '/') {
+		buf[len++] = '/';
+		buf[len++] = '\0';
+	}
 	free(item->string);
 	item->string = xstrdup(buf);
 	return 1;
@@ -616,9 +618,8 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 		int len = strlen(ceil);
 
 		if (!strncmp(path, ceil, len) &&
-		    path[len] == '/' &&
-		    len > max_len) {
-			max_len = len;
+		    len - 1 > max_len) {
+			max_len = len - 1;
 		}
 	}
 
-- 
1.7.11.3
