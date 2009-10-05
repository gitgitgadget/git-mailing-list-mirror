From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 05 Oct 2009 19:32:43 +0200
Message-ID: <4ACA2DBB.5030908@web.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <4AC9D6EB.8090002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MurWq-0001nQ-7j
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 19:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZJEReU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 13:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbZJEReU
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 13:34:20 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:38328 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbZJEReU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 13:34:20 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id B7B93125444B9;
	Mon,  5 Oct 2009 19:33:42 +0200 (CEST)
Received: from [80.128.117.226] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MurQR-0003Fj-00; Mon, 05 Oct 2009 19:32:44 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <4AC9D6EB.8090002@web.de>
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129574>

A bug showed up in the tests, deleted submodules were labelled
"(not checked out)" instead of "(submodule deleted)". This patch
fixes that.

--------------------------8<--------------------
[PATCH] fix output for deleted submodules in git diff --submodule-summary

When a submodule has been deleted, add_submodule_odb() returns false
because the directory of the submodule is gone. So we have to test the
second sha for null before we call add_submodule_odb() to get the correct
output.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 11fce7d..54c8de8 100644
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
1.6.5.rc2.210.gac56a4.dirty
