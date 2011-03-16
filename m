From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [PATCH] diff-lib.c: Fix diff-files --diff-filter --quiet exit code
Date: Wed, 16 Mar 2011 17:56:33 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D80EBC1.7010105@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jens.Lehmann@web.de,
	johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 17:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzu1l-0007aj-6s
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1CPQ4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 12:56:47 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:41207 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab1CPQ4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 12:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 28E771B4ACC;
	Wed, 16 Mar 2011 17:56:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AfuiltnghQ9x; Wed, 16 Mar 2011 17:56:34 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 43E231B4AF2;
	Wed, 16 Mar 2011 17:56:34 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169176>

Given the following status:

	$ git status -s
	 M bar
	UU foo

There is an unexpected difference in the return code of git diff-files
when used with --quiet as opposed to --exit-code:

	$ git diff-files --diff-filter=U --quiet
	$ echo $?
	0

	$ git diff-files --diff-filter=U --exit-code
	<usual output, lots of 0's and U<TAB>foo>
	$ echo $?
	1

Notice the different return codes. Now, according to the documentation,
--quiet implies --return-code. However, the return code of the former is
clearly not correct if --return-code was supposed to be on.

This patch removes a useless bit of code that caused the return codes to
differ.

Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
---
  diff-lib.c |    4 ----
  1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..a7aa42b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -102,10 +102,6 @@ int run_diff_files(struct rev_info *revs, unsigned 
int option)
  		int changed;
  		unsigned dirty_submodule = 0;

-		if (DIFF_OPT_TST(&revs->diffopt, QUICK) &&
-			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
-			break;
-
  		if (!ce_path_match(ce, revs->prune_data))
  			continue;

-- 
1.7.0.4
