X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames with spaces and non-ascii characters.
Date: Tue, 14 Nov 2006 22:27:43 -0800
Message-ID: <7vu011p6lc.fsf@assigned-by-dhcp.cox.net>
References: <20061115005530.26560.18222.stgit@lathund.dewire.com>
	<7v8xidqm1e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 06:27:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31422>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkEFQ-0003N7-Ak for gcvg-git@gmane.org; Wed, 15 Nov
 2006 07:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966538AbWKOG1q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 01:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966537AbWKOG1p
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 01:27:45 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:36063 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S966538AbWKOG1p
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 01:27:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115062744.EYSW18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 01:27:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id muTq1V00F1kojtg0000000; Wed, 15 Nov 2006
 01:27:51 -0500
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> But all of the above shows deficiency in the current set of
> tools -- they are not helping Porcelain writers enough.  I think
> we should enhance 'apply --numstat' to let it show binary diffs
> differently:
>
> 	git diff-tree -p $parent $commit >.tmpfile
>         git apply --numstat -z <.tmpfile
>
> would currently say "0 0" for binary files (the primary benefit
> of using "--numstat -z" here is that it would give Perl scripts
> pathnames parsable without C dequoting).  We should somehow have
> a way to show it differently from text files without any
> added/deleted lines (e.g. only the mode change), and that would
> make the life of Porcelain writers who needs to write something
> like the above code much more pleasant.  Perhaps show "- -"
> instead of "0 0", since there is no notion of lines in "binary
> files differ" case?

That is, something like this...

-- >8 --
[PATCH] apply --numstat: mark binary diffstat with - -, not 0 0

We do not even know number of lines so showing it as 0 0 is
lying.  This would also help Porcelains like cvsexportcommit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-apply.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index aad5526..b80ad2c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2116,7 +2116,11 @@ static void numstat_patch_list(struct pa
 	for ( ; patch; patch = patch->next) {
 		const char *name;
 		name = patch->new_name ? patch->new_name : patch->old_name;
-		printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
+		if (patch->is_binary)
+			printf("-\t-\t");
+		else
+			printf("%d\t%d\t",
+			       patch->lines_added, patch->lines_deleted);
 		if (line_termination && quote_c_style(name, NULL, NULL, 0))
 			quote_c_style(name, NULL, stdout, 0);
 		else
-- 
1.4.4.rc2.g2a54

