From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] refs.c: abort ref search if ref array is empty
Date: Fri,  7 Oct 2011 22:20:21 -0500
Message-ID: <5WORKOGzj9pUA6-WazYHWimMbFMh2dFdPh-tzgQwRKUjBmg5avzikX-E8YCuF6-WDVQwYJe92QfzjJryO0gSItzZkhfefVSSSpOvoOUGB9HVM7KEfTIWsriW5ZyQAa1YxwTYeujykWQ@cipher.nrlssc.navy.mil>
References: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
Cc: julian@quantumfyre.co.uk, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 05:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCNTQ-0002NB-KM
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 05:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab1JHDVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 23:21:05 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:52798 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753647Ab1JHDVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 23:21:02 -0400
Received: by mail3.nrlssc.navy.mil id p983KwlK006465; Fri, 7 Oct 2011 22:20:58 -0500
In-Reply-To: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 08 Oct 2011 03:20:57.0760 (UTC) FILETIME=[4BDAEA00:01CC8569]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183136>

From: Brandon Casey <drafnel@gmail.com>

The bsearch() implementation on IRIX 6.5 segfaults if it is passed NULL
for the base array argument even if number-of-elements is zero.  So, let's
work around it by detecting an empty array and aborting early.

This is a useful optimization in its own right anyway, since we avoid a
useless allocation and initialization of the ref_entry when the ref array
is empty.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 refs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index c31b461..cbc4c5d 100644
--- a/refs.c
+++ b/refs.c
@@ -110,6 +110,9 @@ static struct ref_entry *search_ref_array(struct ref_array *array, const char *n
 	if (name == NULL)
 		return NULL;
 
+	if (!array->nr)
+		return NULL;
+
 	len = strlen(name) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
 	memcpy(e->name, name, len);
-- 
1.7.7
