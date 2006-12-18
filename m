X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] add for_each_reflog_ent() iterator
Date: Mon, 18 Dec 2006 01:40:04 -0800
Message-ID: <7vzm9lzgnf.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 09:40:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 15:10:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34733>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwEyi-0007uu-8M for gcvg-git@gmane.org; Mon, 18 Dec
 2006 10:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753645AbWLRJkI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 04:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbWLRJkH
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 04:40:07 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33343 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753645AbWLRJkG (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 04:40:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218094005.RVPS25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 04:40:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 09gH1W00G1kojtg0000000; Mon, 18 Dec 2006
 04:40:17 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 refs.c |   25 +++++++++++++++++++++++++
 refs.h |    4 ++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index d911b9e..db8fdd4 100644
--- a/refs.c
+++ b/refs.c
@@ -1093,3 +1093,28 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 		logfile, show_rfc2822_date(date, tz));
 	return 0;
 }
+
+void for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+{
+	const char *logfile;
+	FILE *logfp;
+	char buf[1024];
+
+	logfile = git_path("logs/%s", ref);
+	logfp = fopen(logfile, "r");
+	if (!logfp)
+		return;
+	while (fgets(buf, sizeof(buf), logfp)) {
+		unsigned char osha1[20], nsha1[20];
+		int len;
+
+		/* old SP new SP name <email> SP time TAB msg LF */
+		len = strlen(buf);
+		if (len < 83 || buf[len-1] != '\n' ||
+		    get_sha1_hex(buf, osha1) || buf[40] != ' ' ||
+		    get_sha1_hex(buf + 41, nsha1) || buf[81] != ' ')
+			continue; /* corrupt? */
+		fn(osha1, nsha1, buf+82, cb_data);
+	}
+	fclose(logfp);
+}
diff --git a/refs.h b/refs.h
index 51aab1e..de43cc7 100644
--- a/refs.h
+++ b/refs.h
@@ -44,6 +44,10 @@ extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, cons
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1);
 
+/* iterate over reflog entries */
+typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, char *, void *);
+void for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
+
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
-- 
1.4.4.2.gc30f

