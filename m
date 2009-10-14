From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 3/4] fix output for deleted submodules in git diff --submodule-summary
Date: Wed, 14 Oct 2009 20:31:40 +0200
Message-ID: <4AD6190C.4050804@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:41:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8mm-0005gB-BI
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbZJNScT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbZJNScT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:32:19 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56489 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350AbZJNScS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:32:18 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id ECBB3130AF080;
	Wed, 14 Oct 2009 20:31:41 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My8dQ-00028T-00; Wed, 14 Oct 2009 20:31:40 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <4AD61880.4040600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX182FZrhXKu4WZAOQu5L2WSDLd+LE7/JaY3P78PQ
	xLOsm0+GfgtO+27cBSVt491JHJC+Esbb8lW+6Bhhnkuyt+4vH9
	ZPPDN69QYRgkH8tJfkLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130315>

When a submodule has been deleted, add_submodule_odb() returns false
because the directory of the submodule is gone. So we have to test the
second sha for null before we call add_submodule_odb() to get the correct
output.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5076113..d5fce7a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -45,12 +45,12 @@ void show_submodule_summary(FILE *f, const char *path,
 	static const char *format = "  %m %s";
 	int fast_forward = 0, fast_backward = 0;

-	if (add_submodule_odb(path))
+	if (is_null_sha1(two))
+		message = "(submodule deleted)";
+	else if (add_submodule_odb(path))
 		message = "(not checked out)";
 	else if (is_null_sha1(one))
 		message = "(new submodule)";
-	else if (is_null_sha1(two))
-		message = "(submodule deleted)";
 	else if (!(left = lookup_commit_reference(one)) ||
 		 !(right = lookup_commit_reference(two)))
 		message = "(commits not present)";
-- 
1.6.5.4.g707c
