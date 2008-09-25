From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Remove empty directories in recursive merge
Date: Thu, 25 Sep 2008 22:12:45 +0200
Message-ID: <20080925201245.GB3959@blimp.localhost>
References: <87k5d1v71l.fsf@cup.kalibalik.dk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 22:14:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KixDu-0002gi-PK
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbYIYUMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbYIYUMs
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:12:48 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:16770 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbYIYUMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 16:12:48 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81p7LJ
Received: from tigra.home (Fab79.f.strato-dslnet.de [195.4.171.121])
	by post.webmailer.de (mrclete mo44) (RZmta 17.4)
	with ESMTP id j0485fk8PIDEUb ; Thu, 25 Sep 2008 22:12:46 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C5CDD277AE;
	Thu, 25 Sep 2008 22:12:45 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id BAF1736D1E; Thu, 25 Sep 2008 22:12:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87k5d1v71l.fsf@cup.kalibalik.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96791>

The code was actually supposed to do that, but was accidentally broken.
Noticed by Anders Melchiorsen.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Anders Melchiorsen, Wed, Sep 24, 2008 18:32:22 +0200:
> I got an empty directory left over today, and have reduced the problem
> to this sequence. If I leave out the second add (so the merge is a
> fast forward), the directory is removed as I would expect.

Ach, an old bug. Thanks for reminding!

 builtin-merge-recursive.c  |    4 +---
 t/t3030-merge-recursive.sh |   11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index dfb363e..a29b47f 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -444,10 +444,8 @@ static int remove_file(int clean, const char *path, int no_wd)
 			return -1;
 	}
 	if (update_working_directory) {
-		unlink(path);
-		if (errno != ENOENT || errno != EISDIR)
+		if (remove_path(path) && errno != ENOENT)
 			return -1;
-		remove_path(path);
 	}
 	return 0;
 }
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index de0cdb1..0de613d 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -535,4 +535,15 @@ test_expect_success 'reset and bind merge' '
 
 '
 
+test_expect_success 'merge removes empty directories' '
+
+	git reset --hard master &&
+	git checkout -b rm &&
+	git rm d/e &&
+	git commit -mremoved-d/e &&
+	git checkout master &&
+	git merge -s recursive rm &&
+	test_must_fail test -d d
+'
+
 test_done
-- 
1.6.0.2.328.g14651
