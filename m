From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Take binary diffs into account for "git rebase"
Date: Sat, 18 Aug 2007 15:52:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708181547400.30176@woody.linux-foundation.org>
References: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com> 
 <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org> 
 <e7bda7770708181329i7a64e613y88187a608c323a07@mail.gmail.com> 
 <alpine.LFD.0.999.0708181334200.30176@woody.linux-foundation.org>
 <e7bda7770708181411v67730b57ibcd8df44695e036f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Torgil Svensson <torgil.svensson@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 19 01:00:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMXHi-000701-6t
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 01:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbXHRXA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755918AbXHRXA1
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 19:00:27 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48089 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754003AbXHRXA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2007 19:00:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IN0LEw029858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2007 16:00:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7IMqt1a015097;
	Sat, 18 Aug 2007 15:52:55 -0700
In-Reply-To: <e7bda7770708181411v67730b57ibcd8df44695e036f@mail.gmail.com>
X-Spam-Status: No, hits=-2.753 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56115>


We used to not generate a patch ID for binary diffs, but that means that 
some commits may be skipped as being identical to already-applied diffs 
when doing a rebase.

So just delete the code that skips the binary diff. At the very least, 
we'd want the filenames to be part of the patch ID, but we might also want 
to generate some hash for the binary diff itself too.

This fixes an issue noticed by Torgil Svensson.

Tested-by: Torgil Svensson <torgil.svensson@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Junio, you might want to do as the comment says, instead of just hashing 
whatever random binary patch. Your call.

On Sat, 18 Aug 2007, Torgil Svensson wrote:
> 
> This patch made the difference and solved the issue for me. Thanks

 diff.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 97cc5bc..a7e7671 100644
--- a/diff.c
+++ b/diff.c
@@ -2919,10 +2919,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 				fill_mmfile(&mf2, p->two) < 0)
 			return error("unable to read files to diff");
 
-		/* Maybe hash p->two? into the patch id? */
-		if (diff_filespec_is_binary(p->two))
-			continue;
-
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		if (p->one->mode == 0)
