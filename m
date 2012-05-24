From: mhagger@alum.mit.edu
Subject: [PATCH] Avoid sorting if references are added to ref_cache in order
Date: Thu, 24 May 2012 14:16:50 +0200
Message-ID: <1337861810-9366-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 14:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXWyY-00085Y-1m
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 14:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560Ab2EXMRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 08:17:00 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:64750 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753763Ab2EXMQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 08:16:59 -0400
X-AuditID: 12074412-b7f1c6d00000092d-1d-4fbe26ba33a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 14.02.02349.AB62EBF4; Thu, 24 May 2012 08:16:58 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4OCGqcO013494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 08:16:57 -0400
X-Mailer: git-send-email 1.7.10
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsUixO6iqLtLbZ+/wdZ/ZhZdV7qZLBp6rzBb
	3H+/jsni9or5zBY/WnqYHVg9/r7/wORxua+XyeNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7YeMq94I5AxZtlfA2M53m7GDk5JARMJObs/cMGYYtJXLi3Hsjm4hASuMwoceb7ImYI
	5wyTxO7/x5lBqtgEpCReNvawg9giAmoSE9sOsYAUMQt0MEq8/HiGCSQhLOAjsfVIK1gDi4Cq
	xLLGpYwgNq+As8TNneuZIdbJSzy938c2gZF7ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
	M73czBK91JTSTYyQEBHawbj+pNwhRgEORiUe3i6Bvf5CrIllxZW5hxglOZiURHmjVff5C/El
	5adUZiQWZ8QXleakFh9ilOBgVhLhbZICyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5N
	LUgtgsnKcHAoSfD6AGNBSLAoNT21Ii0zpwQhzcTBCSK4QDbwAG3gAinkLS5IzC3OTIcoOsWo
	KCXO+w3kLAGQREZpHtwAWDS/YhQH+keY1wSknQeYCOC6XwENZgIavOXxXpDBJYkIKakGRmG7
	vwwx20+tyV/LZJnS0PGz3szzRdNdvfxbFV+NJ0dInjto5K2zlz8uznDf46wHK1dfLPV91JJk
	+lt4nfVWNkYBYZG6me8L7daHS4nZ3L5z9FLMklYrzuAL0msYVjycefRA9v6/qydV/lvyT2OK
	fedhicUP5u4XuTDhSL/KuvuHFMzzbvf5TFZiKc5INNRiLipOBAC9taQnwQIAAA== 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198368>

From: Michael Haggerty <mhagger@alum.mit.edu>

The old code allowed many references to be efficiently added to a
single directory, because it just appended the references to the
containing directory unsorted without doing any searching (and
therefore without requiring any intermediate sorting).  But the old
code was inefficient when a large number of subdirectories were added
to a directory, because the directory always had to be searched to see
if the new subdirectory already existed, and this search required the
directory to be sorted first.  The same was repeated for every new
subdirectory, so the time scaled like O(N^2), where N is the number of
subdirectories within a single directory.

In practice, references are often added to the ref_cache in
lexicographic order, for example when reading the packed-refs file.
So build some intelligence into add_entry_to_dir() to optimize for the
case of references and/or subdirectories being added in lexicographic
order: if the existing entries were already sorted, and the new entry
comes after the last existing entry, then adjust ref_dir::sorted to
reflect the fact that the ref_dir is still sorted.

Thanks to Peff for pointing out the performance regression that
inspired this change.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This patch can be applied to either mh/ref-api or next.  It should fix
the performance regression discovered by Peff [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/198163

 refs.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/refs.c b/refs.c
index 09322fe..98f6425 100644
--- a/refs.c
+++ b/refs.c
@@ -208,6 +208,12 @@ static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry)
 {
 	ALLOC_GROW(dir->entries, dir->nr + 1, dir->alloc);
 	dir->entries[dir->nr++] = entry;
+	/* optimize for the case that entries are added in order */
+	if (dir->nr == 1 ||
+	    (dir->nr == dir->sorted + 1 &&
+	     strcmp(dir->entries[dir->nr - 2]->name,
+		    dir->entries[dir->nr - 1]->name) < 0))
+		dir->sorted = dir->nr;
 }
 
 /*
-- 
1.7.10
