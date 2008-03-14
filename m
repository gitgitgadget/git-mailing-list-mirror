From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-parse.txt: clarify meaning of rev~ and rev~0.
Date: Fri, 14 Mar 2008 11:49:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803141141240.3557@woody.linux-foundation.org>
References: <87wso5mcs7.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaF0J-0003MJ-A4
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 19:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbYCNSun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 14:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbYCNSun
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 14:50:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54311 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbYCNSum (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 14:50:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EIocuC007414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 11:50:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EIneta014155;
	Fri, 14 Mar 2008 11:49:41 -0700
In-Reply-To: <87wso5mcs7.fsf@osv.gnss.ru>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.319 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77272>



On Fri, 14 Mar 2008, Sergei Organov wrote:
>
> +                      ...  'rev{tilde}' is equivalent to 'rev{tilde}0'
> +  which in turn is equivalent to 'rev'.

I'd actually prefer to just fix that. 

I think it would make more sense to have the same guarantees that rev^ 
has, namely to always return a commit. I would also suggest that not 
giving a number would have the same effect of defaulting to 1, not 0.

Right now it's a bit illogical, but at least it's an _undocumented_ 
illogical behaviour. If we document it, we should fix it and document the 
logical behaviour instead, no?

Here's a patch to make '^' and '~' act the same for the default count (ie 
both default to 1), and also have the same behaviour for a count of zero.

Before (no discernible pattern):

	[torvalds@woody git]$ git rev-parse v1.5.1 v1.5.1^0 v1.5.1~0 v1.5.1^ v1.5.1~
	45354a57ee7e3e42c7137db6c94fa968c6babe8d
	89815cab95268e8f0f58142b848ac4cd5e9cbdcb
	45354a57ee7e3e42c7137db6c94fa968c6babe8d
	045f5759c97746589a067461e50fad16f60711ac
	45354a57ee7e3e42c7137db6c94fa968c6babe8d

After (fairly logical):

	[torvalds@woody git]$ ./git rev-parse v1.5.1 v1.5.1^0 v1.5.1~0 v1.5.1^ v1.5.1~
	45354a57ee7e3e42c7137db6c94fa968c6babe8d
	89815cab95268e8f0f58142b848ac4cd5e9cbdcb
	89815cab95268e8f0f58142b848ac4cd5e9cbdcb
	045f5759c97746589a067461e50fad16f60711ac
	045f5759c97746589a067461e50fad16f60711ac

Hmm?

(That parent-finding loop is also now much tighter, not that it matters 
one whit ;)

		Linus

---
 sha1_name.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 8b6c76f..6afc0e8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -407,18 +407,22 @@ static int get_nth_ancestor(const char *name, int len,
 			    unsigned char *result, int generation)
 {
 	unsigned char sha1[20];
-	int ret = get_sha1_1(name, len, sha1);
+	struct commit *commit;
+	int ret;
+
+	ret = get_sha1_1(name, len, sha1);
 	if (ret)
 		return ret;
+	commit = lookup_commit_reference(sha1);
+	if (!commit)
+		return -1;
 
 	while (generation--) {
-		struct commit *commit = lookup_commit_reference(sha1);
-
-		if (!commit || parse_commit(commit) || !commit->parents)
+		if (parse_commit(commit) || !commit->parents)
 			return -1;
-		hashcpy(sha1, commit->parents->item->object.sha1);
+		commit = commit->parents->item;
 	}
-	hashcpy(result, sha1);
+	hashcpy(result, commit->object.sha1);
 	return 0;
 }
 
@@ -564,11 +568,10 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 		cp++;
 		while (cp < name + len)
 			num = num * 10 + *cp++ - '0';
-		if (has_suffix == '^') {
-			if (!num && len1 == len - 1)
-				num = 1;
+		if (!num && len1 == len - 1)
+			num = 1;
+		if (has_suffix == '^')
 			return get_parent(name, len1, sha1, num);
-		}
 		/* else if (has_suffix == '~') -- goes without saying */
 		return get_nth_ancestor(name, len1, sha1, num);
 	}
