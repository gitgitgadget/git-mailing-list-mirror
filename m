From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 24/38] struct lock_file: declare some fields volatile
Date: Wed,  1 Oct 2014 12:28:28 +0200
Message-ID: <1412159322-2622-25-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAE-0002kF-D6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbaJAK3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62633 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683AbaJAK3b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:31 -0400
X-AuditID: 12074412-f792e6d000005517-85-542bd78ab745
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D1.2A.21783.A87DB245; Wed,  1 Oct 2014 06:29:30 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6N026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:29 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1O26rh1isP+EkUXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BkPz71nLZjKXzFjwWKmBsY5PF2M
	nBwSAiYSW6aeYISwxSQu3FvP1sXIxSEkcJlRYv7jfcwQznEmif7PG5hAqtgEdCUW9TSD2SIC
	ahIT2w6xgBQxCyxmkphwaBMbSEJYwENi+57rQN0cHCwCqhJNh5NBTF4BF4ldT6IglslJbNj9
	H2wxJ1B4+eVmFhBbSMBZYsedr0wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vN
	LNFLTSndxAgJRaEdjOtPyh1iFOBgVOLhVUjQDhFiTSwrrsw9xCjJwaQkyrvoElCILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCG/2AaAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKY
	rAwHh5IEL8M1oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGTEFwNjAyTFA7TX
	GaSdt7ggMRcoCtF6ilGXY13nt34mIZa8/LxUKXHe0KtARQIgRRmleXArYInnFaM40MfCvOEg
	o3iASQtu0iugJUxAS5LXgC0pSURISTUwLp9znfWd/+cbdwSaeSXb9x9iVO39snK+htasc8Hn
	b54K2jnv7pLkZoPK89llxpEKc5w/3Hvnub1uV5ga/xOH9683uUvecF7/9++/EOkg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257711>

The function remove_lock_file_on_signal() is used as a signal handler.
It is not realistic to make the signal handler conform strictly to the
C standard, which is very restrictive about what a signal handler is
allowed to do.  But let's increase the likelihood that it will work:

The lock_file_list global variable and several fields from struct
lock_file are used by the signal handler.  Declare those values
"volatile" to (1) force the main process to write the values to RAM
promptly, and (2) prevent updates to these fields from being reordered
in a way that leaves an opportunity for a jump to the signal handler
while the object is in an inconsistent state.

We don't mark the filename field volatile because that would prevent
the use of strcpy(), and it is anyway unlikely that a compiler
re-orders a strcpy() call across other expressions.  So in practice it
should be possible to get away without "volatile" in the "filename"
case.

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    | 6 +++---
 lockfile.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 8e25fce..c2ea6f1 100644
--- a/cache.h
+++ b/cache.h
@@ -575,10 +575,10 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 #define LOCK_SUFFIX_LEN 5
 
 struct lock_file {
-	struct lock_file *next;
+	struct lock_file *volatile next;
 	volatile sig_atomic_t active;
-	int fd;
-	pid_t owner;
+	volatile int fd;
+	volatile pid_t owner;
 	char on_list;
 	char filename[PATH_MAX];
 };
diff --git a/lockfile.c b/lockfile.c
index d35ac44..89043f5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -55,7 +55,7 @@
  *     on_list is set.
  */
 
-static struct lock_file *lock_file_list;
+static struct lock_file *volatile lock_file_list;
 
 static void remove_lock_file(void)
 {
-- 
2.1.0
