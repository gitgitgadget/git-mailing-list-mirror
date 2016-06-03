From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/13] remote rm: handle symbolic refs correctly
Date: Fri,  3 Jun 2016 14:33:45 +0200
Message-ID: <157904e27af9c3377b21376c301f3e16ba6a5aa2.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oJ5-0005H2-2S
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbcFCMe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:26 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57987 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932439AbcFCMeR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:17 -0400
X-AuditID: 1207440f-8bbff700000008e4-4d-57517941480a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2A.CD.02276.14971575; Fri,  3 Jun 2016 08:34:09 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtip005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:07 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqOtYGRhu8P6QvMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDMu3pzJWNDDWdH97B9rA+Mq9i5G
	Tg4JAROJpw97WbsYuTiEBLYyStx5OIsZJCEkcJxJYk+bH4jNJqArsainmQnEFhGIkGh41cII
	0sAsMIdJ4vbDTrAGYQFnid97LzCC2CwCqhLdb16ygti8AlESrTdWsUBsk5O4PP0BG4jNKWAh
	0XfvBzvEMnOJh3N2s09g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdELzezRC81pXQT
	IyTo+Hcwdq2XOcQowMGoxMO7YkFAuBBrYllxZe4hRkkOJiVR3vNngUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeP8UBIYL8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	eM0rgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9BeA5B23uKC
	xFygKETrKUZFKXFeYZCEAEgiozQPbiwslbxiFAf6Upi3HaSKB5iG4LpfAQ1mAhpc8MgfZHBJ
	IkJKqoFx0YcANbY/c+fZbbu355NYhawG0+XH+yS33F11Nurm5CnHV+mIMx3aP/HW7aVTTDff
	6C25rf7zXM48bvWaz8uqlmVyHIvSb3kpmcveXPK+oPnv9TMpwYtnvjHVK9RTzeW8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296325>

In the modern world of reference backends, it is not OK to delete a
symref by unlink()ing the file directly. This must be done via the refs
API.

We do so by adding the symref to the list of references to delete along
with the non-symbolic references, then calling delete_refs() with the
new flags option set to REF_NODEREF.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 1bbf9b4..c4b4d67 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -539,10 +539,6 @@ static int add_branch_for_removal(const char *refname,
 		return 0;
 	}
 
-	/* make sure that symrefs are deleted */
-	if (flags & REF_ISSYMREF)
-		return unlink(git_path("%s", refname));
-
 	string_list_append(branches->branches, refname);
 
 	return 0;
@@ -788,7 +784,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs(&branches, 0);
+		result = delete_refs(&branches, REF_NODEREF);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
-- 
2.8.1
