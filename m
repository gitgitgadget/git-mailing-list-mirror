From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/17] safe_create_leading_directories(): split on first of multiple slashes
Date: Sat, 18 Jan 2014 23:48:49 +0100
Message-ID: <1390085341-2553-6-git-send-email-mhagger@alum.mit.edu>
References: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:50:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4eiE-0005CE-SP
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbaARWtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:45 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50653 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727AbaARWtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:35 -0500
X-AuditID: 1207440f-b7f306d000006d99-cf-52db04feb20c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D2.EB.28057.EF40BD25; Sat, 18 Jan 2014 17:49:34 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8w030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:33 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqPuP5XaQwcoOfYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y/qGfreAsR0XP/X3sDYxP
	2LoYOTgkBEwkNv8O72LkBDLFJC7cWw8U5uIQErjMKLFr+it2COcEk8TE3pVMIFVsAroSi3qa
	wWwRATWJiW2HWEBsZgEHic2fGxlBbGGBeIlpG14zgixgEVCVmPzJG8TkFXCW+PxLA2KtgsTq
	60IgxZwCLhJH5l8AGygEVHHz9RP2CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujl
	ZpbopaaUbmKEBAn/Dsau9TKHGAU4GJV4eA8y3Q4SYk0sK67MPcQoycGkJMqrDBLiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwhu84VaQEG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoR
	TFaGg0NJgtcbGA1CgkWp6akVaZk5JQhpJg5OEMEFsoEHZANIIW9xQWJucWY6RNEpRkUpcd5w
	kIQASCKjNA9uACyeXzGKA/0jDFHFA0wFcN2vgAYzAQ0Wib0JMrgkESEl1cCY4d/55GbAjQkK
	35zsOAt4Vy9/c+78RPbqNKmZzWc/NvEccE+criaUsWL7jtcmfW7ugZo2ZhndteWZRq8anutO
	e3XQtCsgfy3fYfZzO0Q6mn7+eyi9W/ymCceaqLTpnI906kMi2oTf2N0XyP18snHSNu3JC0Pz
	Ji5+ql3m9OKVpUmbw5UZb74qsRRnJBpqMRcVJwIAE/k/psICAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240656>

If the input path has multiple slashes between path components (e.g.,
"foo//bar"), then the old code was breaking the path at the last
slash, not the first one.  So in the above example, the second slash
was overwritten with NUL, resulting in the parent directory being
sought as "foo/".

When stat() is called on "foo/", it fails with ENOTDIR if "foo" exists
but is not a directory.  This caused the wrong path to be taken in the
subsequent logic.

So instead, split path components at the first intercomponent slash
rather than the last one.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1e1510d..9d4459f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -115,9 +115,10 @@ int safe_create_leading_directories(char *path)
 
 		if (!slash)
 			break;
-		while (*(slash + 1) == '/')
-			slash++;
+
 		next_component = slash + 1;
+		while (*next_component == '/')
+			next_component++;
 		if (!*next_component)
 			break;
 
-- 
1.8.5.2
