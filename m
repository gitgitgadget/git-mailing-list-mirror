From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in
 the process)
Date: Fri, 17 Aug 2007 09:56:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708170956140.30176@woody.linux-foundation.org>
References: <200707021356.58553.andyparkins@gmail.com>
 <200708170939.47214.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM58K-0005Ef-10
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 18:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbXHQQ5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 12:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXHQQ5H
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 12:57:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36068 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757149AbXHQQ5D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 12:57:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HGv0oa024248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 17 Aug 2007 09:57:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7HGutqc020143;
	Fri, 17 Aug 2007 09:56:55 -0700
In-Reply-To: <200708170939.47214.andyparkins@gmail.com>
X-Spam-Status: No, hits=-4.153 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_54,J_CHICKENPOX_64,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56065>



On Fri, 17 Aug 2007, Andy Parkins wrote:
>
> Could any of the guru's give me a guide to upload-pack.c?  I assume the 
> problem is going to be the same as it was for git-prune, the hash for the 
> gitlink object in the tree is being assumed to be an object in the ODB; 
> which isn't the case with gitlink entries.  Where would that be happening 
> in git-upload-pack?  The fix is going to be..
> 
>  if( S_ISGITLINK(mode))
>       continue;
> 
> But I've got no idea where to put it :-)

Maybe this one?

			Linus

---
 builtin-pack-objects.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 24926db..77481df 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -979,6 +979,8 @@ static void add_pbase_object(struct tree_desc *tree,
 	int cmp;
 
 	while (tree_entry(tree,&entry)) {
+		if (S_ISGITLINK(entry.mode))
+			continue;
 		cmp = tree_entry_len(entry.path, entry.sha1) != cmplen ? 1 :
 		      memcmp(name, entry.path, cmplen);
 		if (cmp > 0)
