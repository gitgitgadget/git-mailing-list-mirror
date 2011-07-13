From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Wed, 13 Jul 2011 09:24:30 +0200
Message-ID: <4E1D482E.4090403@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-23-git-send-email-newren@gmail.com> <4E1AA085.9010908@viscovery.net> <4E1BF77C.2020207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 09:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtoE-00040x-0e
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab1GMHYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:24:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14644 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752544Ab1GMHYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:24:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Qgto7-0002M7-5B; Wed, 13 Jul 2011 09:24:31 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DFB071660F;
	Wed, 13 Jul 2011 09:24:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <4E1BF77C.2020207@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177008>

Am 7/12/2011 9:27, schrieb Johannes Sixt:
> Am 7/11/2011 9:04, schrieb Johannes Sixt:
>> A heads-up: This test case fails here on Windows. The messages produced are:
> 
>> As you can see, "Removing letters..." is missing on Windows, and the file
>> 'letters' is indeed left in the working tree. Any quick ideas where to
>> begin debugging this?
> 
> And the reason for this is that the qsort call in record_df_conflict_files
> assumes that qsort is a stable sort; but this is not guaranteed. In
> particular, the entry "letters" can be moved after "letters/file", which
> is not expected by the loop that follows the qsort.

Perhaps something like below. It passes the tests that previously failed.

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] fixup! Do not assume that qsort is stable

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 merge-recursive.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 88167c3..81fac5f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -361,6 +361,8 @@ static int string_list_df_name_compare(const void *a, const void *b)
 {
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
+	int onelen = strlen(one->string);
+	int twolen = strlen(two->string);
 	/*
 	 * Here we only care that entries for D/F conflicts are
 	 * adjacent, in particular with the file of the D/F conflict
@@ -373,8 +375,15 @@ static int string_list_df_name_compare(const void *a, const void *b)
 	 * since in other cases any changes in their order due to
 	 * sorting cause no problems for us.
 	 */
-	return df_name_compare(one->string, strlen(one->string), S_IFDIR,
-			       two->string, strlen(two->string), S_IFDIR);
+	int cmp = df_name_compare(one->string, onelen, S_IFDIR,
+				  two->string, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
 }
 
 static void record_df_conflict_files(struct merge_options *o,
-- 
1.7.6.1317.gd8c5a.dirty
