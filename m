From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/16] register_tempfile(): new function to handle an existing temporary file
Date: Mon, 10 Aug 2015 11:47:44 +0200
Message-ID: <8f223a2e98b18137673fe5b02fdddf3d93404108.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh6-00021w-Rn
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbbHJJsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49330 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754710AbbHJJsH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:07 -0400
X-AuditID: 1207440d-f79136d00000402c-ba-55c873569ab1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.F5.16428.65378C55; Mon, 10 Aug 2015 05:48:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lswx021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:05 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtWfCLU4OIaNYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGV2/N7IW
	7OWt2Lt+MlMD4zeuLkZODgkBE4mW96eYIWwxiQv31rN1MXJxCAlcZpS4sXgpI4Rzgkni14aD
	YFVsAroSi3qamUBsEQE1iYlth1hAbGaBdIkTC9qBbA4OYYEEidOHwkHCLAKqEi8PnmAEsXkF
	oiQ2vl3ABFIiISAnseBCOkiYU8BCYnvjBlYQW0jAXOLxvPPsExh5FzAyrGKUS8wpzdXNTczM
	KU5N1i1OTszLSy3SNdLLzSzRS00p3cQICR7eHYz/18kcYhTgYFTi4Z2x+XioEGtiWXFl7iFG
	SQ4mJVFei/wToUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeOMzgHK8KYmVValF+TApaQ4WJXFe
	tSXqfkIC6YklqdmpqQWpRTBZGQ4OJQle+SKgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSi
	xNKSjHhQXMQXAyMDJMUDtPdIIcje4oLEXKAoROspRkUpcd4/IAkBkERGaR7cWFhKeMUoDvSl
	MO9PkCoeYDqB634FNJgJaLBdINjgkkSElFQDo3md5I+CHMEZTmHaLRMef/xke2+6LPv57hmh
	Fe1x1+O7L29WyeMrDDpnurS+9JLZ3iPVOSfPzNS7e0xfbMsGYaHCYpPTC78+TNmW7BaqwpC8
	xH96VgvHpDtVWTHdiUdcZ0YvjckWXf/qbO8bZ+7lNS0lC1m/z/G80f6SqXfBnW87 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275594>

Allow an existing file to be registered with the tempfile-handling
infrastructure; in particular, arrange for it to be deleted on program
exit. This can be used if the temporary file has to be created in a
more complicated way than just open(). For example:

* If the file itself needs to be created via the lockfile API
* If it is not a regular file (e.g., a socket)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 8 ++++++++
 tempfile.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/tempfile.c b/tempfile.c
index 0b5d8ce..0af7ebf 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -137,6 +137,14 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	return tempfile->fd;
 }
 
+void register_tempfile(struct tempfile *tempfile, const char *path)
+{
+	prepare_tempfile_object(tempfile);
+	strbuf_add_absolute_path(&tempfile->filename, path);
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+}
+
 int mks_tempfile_sm(struct tempfile *tempfile,
 		    const char *template, int suffixlen, int mode)
 {
diff --git a/tempfile.h b/tempfile.h
index a30e12c..4219fe4 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -92,6 +92,14 @@ struct tempfile {
  */
 extern int create_tempfile(struct tempfile *tempfile, const char *path);
 
+/*
+ * Register an existing file as a tempfile, meaning that it will be
+ * deleted when the program exits. The tempfile is considered closed,
+ * but it can be worked with like any other closed tempfile (for
+ * example, it can be opened using reopen_tempfile()).
+ */
+extern void register_tempfile(struct tempfile *tempfile, const char *path);
+
 
 /*
  * mks_tempfile functions
-- 
2.5.0
