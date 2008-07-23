From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] builtin-branch.c: remove unused code in append_ref()
 callback function
Date: Wed, 23 Jul 2008 15:09:12 -0700
Message-ID: <7v63qwb6d3.fsf_-_@gitster.siamese.dyndns.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
 <20080723140441.GA9537@elte.hu> <7vy73seb2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmXL-0005TM-Rb
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYGWWJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbYGWWJU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:09:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbYGWWJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:09:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 561973BF53;
	Wed, 23 Jul 2008 18:09:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 722333BF50; Wed, 23 Jul 2008 18:09:14 -0400 (EDT)
In-Reply-To: <7vy73seb2p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Jul 2008 10:59:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEAB1C80-5903-11DD-8161-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89792>

We let for_each_ref() to feed all refs to append_ref() but we are only
ever interested in local or remote tracking branches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I ended up splitting the patch into two, not three as I originally
   thought I would.

 builtin-branch.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index b885bd1..3708a50 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -22,10 +22,8 @@ static const char * const builtin_branch_usage[] = {
 	NULL
 };
 
-#define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
 #define REF_REMOTE_BRANCH   0x02
-#define REF_TAG             0x04
 
 static const char *head;
 static unsigned char head_sha1[20];
@@ -215,7 +213,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
-	int kind = REF_UNKNOWN_TYPE;
+	int kind;
 	int len;
 	static struct commit_list branch;
 
@@ -226,10 +224,8 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	} else if (!prefixcmp(refname, "refs/remotes/")) {
 		kind = REF_REMOTE_BRANCH;
 		refname += 13;
-	} else if (!prefixcmp(refname, "refs/tags/")) {
-		kind = REF_TAG;
-		refname += 10;
-	}
+	} else
+		return 0;
 
 	/* Filter with with_commit if specified */
 	if (!has_commit(sha1, ref_list->with_commit))
-- 
1.6.0.rc0.31.g128c7
