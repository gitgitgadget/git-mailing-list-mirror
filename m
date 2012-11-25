From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/8] imap-send: correctly report errors reading from stdin
Date: Sun, 25 Nov 2012 12:08:38 +0100
Message-ID: <1353841721-16269-6-git-send-email-mhagger@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tca5m-0004G0-8p
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab2KYLJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:09:27 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46366 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2KYLJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2012 06:09:25 -0500
X-AuditID: 12074414-b7f846d0000008b8-9b-50b1fc659e01
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F4.D7.02232.56CF1B05; Sun, 25 Nov 2012 06:09:25 -0500 (EST)
Received: from michael.fritz.box (p57A25314.dip.t-dialin.net [87.162.83.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAPB90UH002898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 25 Nov 2012 06:09:23 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJv6Z2OAwZIlzBZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8XtFfOZHVg9/r7/wOTx5Wojk8eHj3EeFy8pe3zeJBfAGsVtk5RYUhacmZ6n
	b5fAnXFz13+WgpXcFc8/H2VqYGzk7GLk5JAQMJFYtH41M4QtJnHh3nq2LkYuDiGBy4wSv0+c
	hHLOMEnMObmLFaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwGpGiclbzrODJIQFvCTa3n8Bs1kE
	VCX2rnvHCGLzCrhIzL7xhwVinZzEhz2PwGo4BVwlfux7wAZiCwHVbL6wn3ECI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCFBJbKD8chJuUOMAhyMSjy8txI3Bgix
	JpYVV+YeYpTkYFIS5Z37FSjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhDf0GVCONyWxsiq1KB8m
	Jc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCt/03UKNgUWp6akVaZk4JQpqJgxNEcIFs
	4AHaMB+kkLe4IDG3ODMdougUo6KUOG89SEIAJJFRmgc3ABb/rxjFgf4R5i0GqeIBpg647ldA
	g5mABidfBxtckoiQkmpgnNmvuEimTvrhMceO2p3/JnDPa86oc2gz67zqP3354umq3I8Eq53Y
	pxxdyDKtqeXRj8OVXE9tNQ6uVE8MPG/Vn7dbbN7lvitaThnhwrKV5rp1qi0VopavLr9r7qrj
	em1V/0K8X+2xvqBa9qJPajw5/1aLXJU0MjoeGOMYq5trOS3j8ybxCReUWIozEg21 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210357>

Previously, read_message() didn't distinguish between an error and eof
when reading its input.  This could have resulted in incorrect
behavior if there was an error: (1) reporting "nothing to send" if no
bytes were read or (2) sending an incomplete message if some bytes
were read before the error.

Change read_message() to return -1 on ferror()s and 0 on success, so
that the caller can recognize that an error occurred.  (The return
value used to be the length of the input read, which was redundant
because that is already available as the strbuf length.

Change the caller to report errors correctly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 50e223a..86cf603 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1398,7 +1398,7 @@ static int read_message(FILE *f, struct strbuf *all_msgs)
 			break;
 	} while (!feof(f));
 
-	return all_msgs->len;
+	return ferror(f) ? -1 : 0;
 }
 
 static int count_messages(struct strbuf *all_msgs)
@@ -1537,7 +1537,12 @@ int main(int argc, char **argv)
 	}
 
 	/* read the messages */
-	if (!read_message(stdin, &all_msgs)) {
+	if (read_message(stdin, &all_msgs)) {
+		fprintf(stderr, "error reading input\n");
+		return 1;
+	}
+
+	if (all_msgs.len == 0) {
 		fprintf(stderr, "nothing to send\n");
 		return 1;
 	}
-- 
1.8.0
