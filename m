From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Introduce for_each_recent_reflog_ent().
Date: Mon, 19 Jan 2009 22:22:00 -0800
Message-ID: <7vpriimr93.fsf_-_@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 <7vprijra52.fsf@gitster.siamese.dyndns.org>
 <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 07:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPA1P-0000vw-33
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 07:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZATGWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 01:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbZATGWK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 01:22:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbZATGWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 01:22:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C9669914E2;
	Tue, 20 Jan 2009 01:22:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3F316914E1; Tue,
 20 Jan 2009 01:22:02 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon, 19 Jan 2009 13:33:34 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA666144-E6BA-11DD-9DB4-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106441>

This can be used to scan only the last few kilobytes of a reflog, as a
cheap optimization when the data you are looking for is likely to be
found near the end of it.  The caller is expected to fall back to the
full scan if that is not the case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c      |   17 ++++++++++++++++-
 refs.h      |    1 +
 sha1_name.c |    8 +++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 33ced65..024211d 100644
--- a/refs.c
+++ b/refs.c
@@ -1453,7 +1453,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	return 1;
 }
 
-int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long ofs, void *cb_data)
 {
 	const char *logfile;
 	FILE *logfp;
@@ -1464,6 +1464,16 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	logfp = fopen(logfile, "r");
 	if (!logfp)
 		return -1;
+
+	if (ofs) {
+		struct stat statbuf;
+		if (fstat(fileno(logfp), &statbuf) ||
+		    statbuf.st_size < ofs ||
+		    fseek(logfp, -ofs, SEEK_END) ||
+		    fgets(buf, sizeof(buf), logfp))
+			return -1;
+	}
+
 	while (fgets(buf, sizeof(buf), logfp)) {
 		unsigned char osha1[20], nsha1[20];
 		char *email_end, *message;
@@ -1497,6 +1507,11 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	return ret;
 }
 
+int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+{
+	return for_each_recent_reflog_ent(ref, fn, 0, cb_data);
+}
+
 static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 {
 	DIR *dir = opendir(git_path("logs/%s", base));
diff --git a/refs.h b/refs.h
index 06ad260..3bb529d 100644
--- a/refs.h
+++ b/refs.h
@@ -60,6 +60,7 @@ extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
+int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long, void *cb_data);
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
diff --git a/sha1_name.c b/sha1_name.c
index 4c0370b..38c9f1b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -775,7 +775,13 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 		strbuf_init(&cb.buf[i], 20);
 	cb.cnt = 0;
 	retval = 0;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	for_each_recent_reflog_ent("HEAD", grab_nth_branch_switch, 40960, &cb);
+	if (cb.cnt < nth) {
+		cb.cnt = 0;
+		for (i = 0; i < nth; i++)
+			strbuf_release(&cb.buf[i]);
+		for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	}
 	if (cb.cnt < nth)
 		goto release_return;
 	i = cb.cnt % nth;
-- 
1.6.1.267.g11c6e
