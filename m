From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/14] register_tempfile(): new function to handle an existing temporary file
Date: Mon,  8 Jun 2015 11:07:38 +0200
Message-ID: <d0507ec9bdc63b9532bbb348e4505d311ef3c5dc.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2g-0002Yk-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbbFHJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:17 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57504 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728AbbFHJID (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:03 -0400
X-AuditID: 12074413-f79386d000000d23-7b-55755b703886
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D0.0F.03363.07B55755; Mon,  8 Jun 2015 05:08:00 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojV010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:59 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFsQXRpqMOm4oUXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749iaVtaC
	J9wV/RcusjUwnuXsYuTkkBAwkZg96wkbhC0mceHeeiCbi0NI4DKjxJ75NxkhnBNMEl+vzWIC
	qWIT0JVY1NMMZosIOEqceHCdFcRmFnCQ2Py5kRHEFhaIldjTfg1sKouAqkTb0v1gNq9AlMSB
	bZeZILbJSZw//pMZxOYUsJD49XUXUJwDaJm5xI+5rBMYeRcwMqxilEvMKc3VzU3MzClOTdYt
	Tk7My0st0jXXy80s0UtNKd3ECAkf4R2Mu07KHWIU4GBU4uE9sKgkVIg1say4MvcQoyQHk5Io
	78eI0lAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxMFkA53pTEyqrUonyYlDQHi5I4r9oSdT8h
	gfTEktTs1NSC1CKYrAwHh5IEr3kUUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8
	KDLii4GxAZLiAdrLDdLOW1yQmAsUhWg9xagoJc5rBJIQAElklObBjYUlhVeM4kBfCvOWg1Tx
	ABMKXPcroMFMQIO/fy0GGVySiJCSamDU0I6NepoueS3r2rpzVouXbTzk+83x7HfdswEW9ped
	A/ZdkVV9LH46IHgN/62Ap5uvyDG1fMrUMt4j7KNxpO/l4YATtRuYPPr1S857bOFlYM4tv6sW
	puq54tuOfI9E7gUfLD7u5op++OLnv6BXhavTHrv99u/+ecokkk+8emvA6xkLD96z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271001>

Allow an existing file to be registered with the tempfile-handling
infrastructure; in particular, arrange for it to be deleted on program
exit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 9 +++++++++
 tempfile.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/tempfile.c b/tempfile.c
index 890075f..235fc85 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -82,6 +82,15 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	return tempfile->fd;
 }
 
+void register_tempfile(struct tempfile *tempfile, const char *path)
+{
+	register_tempfile_object(tempfile, path);
+
+	strbuf_add_absolute_path(&tempfile->filename, path);
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+}
+
 int mks_tempfile_sm(struct tempfile *tempfile,
 		    const char *template, int suffixlen, int mode)
 {
diff --git a/tempfile.h b/tempfile.h
index 6276156..18ff963 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -145,6 +145,14 @@ struct tempfile {
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
2.1.4
