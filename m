From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] string_list_add_refs_from_colon_sep(): use string_list_split()
Date: Sun,  4 Nov 2012 08:07:10 +0100
Message-ID: <1352012830-13591-6-git-send-email-mhagger@alum.mit.edu>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJL-0001EE-9M
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2KDHHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:42 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:44795 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752035Ab2KDHHj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:39 -0500
X-AuditID: 12074413-b7f786d0000008bb-de-5096143a98e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 98.92.02235.A3416905; Sun,  4 Nov 2012 02:07:38 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw8028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:37 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqGslMi3AYNJCDYuuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xvm3p9gK
	vnFVtPS9YGtg7ObsYuTkkBAwkfh3cAUjhC0mceHeerYuRi4OIYHLjBJfN25ngnDOMEkcOnCc
	DaSKTUBXYlFPMxOILSIgK/H98EawbmaBXInF726zg9jCAsES01/uBathEVCVuLrlN1gNr4CL
	xM0ty5khtslJfNjzCKyeU8BVYsOVNpYuRg6gZS4SnW/rJzDyLmBkWMUol5hTmqubm5iZU5ya
	rFucnJiXl1qka66Xm1mil5pSuokREj7COxh3nZQ7xCjAwajEw/trxdQAIdbEsuLK3EOMkhxM
	SqK8ngLTAoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8G75DFTOm5JYWZValA+TkuZgURLnVVui
	7ickkJ5YkpqdmlqQWgSTleHgUJLgLRIGGipYlJqeWpGWmVOCkGbi4AQRXCAbeIA2VIAU8hYX
	JOYWZ6ZDFJ1iVJQS5zUCSQiAJDJK8+AGwCL9FaM40D/CvP+FgKp4gEkCrvsV0GAmoMHbL00B
	GVySiJCSamCsY9ziMds18uT62K0XO9jvqTH0nJ7WJ8r4sNi5q5AjcV7Lp74HDW7y65MfrA3f
	uFsl+uC5c3VPF6plGFezsZx1Py4f+eSz08PXpWLBr+NSON7k7FAQCBC/rLLs4KFZTT2MW1j8
	Pr3WdNgbaThl7Vc+a+7cvSzc86615AU2RtdvZM/+7/h1ep4SS3FGoqEWc1FxIgAs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209020>

It makes for simpler code than strbuf_split().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/notes.c b/notes.c
index 63b2a09..b823701 100644
--- a/notes.c
+++ b/notes.c
@@ -943,23 +943,18 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
 void string_list_add_refs_from_colon_sep(struct string_list *list,
 					 const char *globs)
 {
-	struct strbuf globbuf = STRBUF_INIT;
-	struct strbuf **split;
+	struct string_list split = STRING_LIST_INIT_NODUP;
+	char *globs_copy = xstrdup(globs);
 	int i;
 
-	strbuf_addstr(&globbuf, globs);
-	split = strbuf_split(&globbuf, ':');
+	string_list_split_in_place(&split, globs_copy, ':', -1);
+	string_list_remove_empty_items(&split, 0);
 
-	for (i = 0; split[i]; i++) {
-		if (split[i]->len && split[i]->buf[split[i]->len-1] == ':')
-			strbuf_setlen(split[i], split[i]->len-1);
-		if (!split[i]->len)
-			continue;
-		string_list_add_refs_by_glob(list, split[i]->buf);
-	}
+	for (i = 0; i < split.nr; i++)
+		string_list_add_refs_by_glob(list, split.items[i].string);
 
-	strbuf_list_free(split);
-	strbuf_release(&globbuf);
+	string_list_clear(&split, 0);
+	free(globs_copy);
 }
 
 static int notes_display_config(const char *k, const char *v, void *cb)
-- 
1.8.0
