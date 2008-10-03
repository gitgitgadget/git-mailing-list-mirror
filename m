From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH (BUG)] builtin-blame: Fix blame -C -C with submodules.
Date: Fri, 3 Oct 2008 20:23:50 +0400
Organization: HOME
Message-ID: <200810032023.50559.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 18:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlnUE-0000T8-D6
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 18:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbYJCQZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 12:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYJCQZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 12:25:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:10963 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbYJCQZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 12:25:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1135354fgg.17
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OeJVbIQpgRuSAaadxYWLsIEq3kTazcX4pTO7X9JhbJw=;
        b=EqjyODljC0O0ulTvR7i+obKn/rlIImqIGg1Z1eTyue/75TrZzSSqCDRYJbacjq0NbH
         GTW3JVqbI5+hwwqlCxICK+68WdL8J9Xd0IZBR07aqlkRZFBmz1138PBgWYU+ecmUTGew
         mu/EE00pBW7arUJjltCpmkioiFXiIN7v6oAGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=QwPY4CACDUWU523yIJZl1Q7HYA/gf+EWcjdC5pTFW4zzaFT8zM/3Uy/aCU5TKwYWkK
         /eb+ZT9xRA+HH/cSXV1e3ZPk09JINzy8Kfg00NY2YAJ+NE2zs+bf2LovhtJZVqvf0moq
         NhAaLNUmTXEWKghLwazys6VDuIrNokWLr6r9M=
Received: by 10.180.230.6 with SMTP id c6mr918259bkh.27.1223051124101;
        Fri, 03 Oct 2008 09:25:24 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 13sm5146957fks.6.2008.10.03.09.25.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 09:25:23 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.1; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97435>

When performing copy detection, git-blame tries to
read gitlinks as blobs, which causes it to die.

This patch adds a check to skip them.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I don't know if this is enough for all cases, but it fixes mine.

	-- Alexander


	$ git blame --incremental -C -C ImpactMessages.cpp
	767f36d1ce2f361e9148bb23155e6aafad034f4b 6 6 10                      
	...
	767f36d1ce2f361e9148bb23155e6aafad034f4b 49 49 7                     
	filename BackEnd/Impact/ImpactMessages.cpp                           
	767f36d1ce2f361e9148bb23155e6aafad034f4b 57 57 1                     
	filename BackEnd/Impact/ImpactMessages.cpp                           
	767f36d1ce2f361e9148bb23155e6aafad034f4b 59 59 14                    
	filename BackEnd/Impact/ImpactMessages.cpp                           
	fatal: Cannot read blob 27152bb4f8b10d4ce5f9fa584c14511dceba3c06 for path BackEnd/Boost


 builtin-blame.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 9bc901c..101c416 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1136,6 +1136,8 @@ static int find_copy_in_parent(struct scoreboard *sb,
 
 			if (!DIFF_FILE_VALID(p->one))
 				continue; /* does not exist in parent */
+			if (S_ISGITLINK(p->one->mode))
+				continue; /* ignore git links */
 			if (porigin && !strcmp(p->one->path, porigin->path))
 				/* find_move already dealt with this path */
 				continue;
-- 
1.6.0.20.g6148bc
