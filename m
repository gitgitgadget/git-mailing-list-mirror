From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: [PATCH] Fix reduce_heads
Date: Sun, 13 Jul 2008 21:07:41 -0700
Message-ID: <402c10cd0807132107s29c470f7hb834bd5c00ef399e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 06:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIFMk-0005eW-SS
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 06:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYGNEHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 00:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbYGNEHs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 00:07:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:26000 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbYGNEHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 00:07:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2328398ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 21:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=NeGwFBvL+KxxMPz5ZwXqz9wSEdPoF1pXEhO3BnS8wyI=;
        b=o7+x6IF6A2jrhab3Npo4e3TmgL9dkfmcfycrF/VXANBsjLc6QobBLRY9mGPtmtET9S
         pKmK1Qyk5ry8LnoaSCYa9Hzk0l+DU2Sz8IeeZik2BakdnefLGbQuQ4r9dtEpodXafPmY
         Wgdq8sc637Tve+gDJXFN9MAH9exrJivHZKmVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=kQqndson+AZQlU+whX8KQQVmwdU5zToLzCgK83+lqq9aw4/UA6c1gaxpL5S/Vtfp5f
         iQ3niyC/hxcnVAsi2A57mg2doK6SYGZNZK3nwTrgPeEvNjH5UeYcVXFw5JmLV5pF7Se0
         dMZjV91ICmLc4miwRRxzAjgTAIp++ZY+VKuqI=
Received: by 10.151.11.19 with SMTP id o19mr12034421ybi.107.1216008462018;
        Sun, 13 Jul 2008 21:07:42 -0700 (PDT)
Received: by 10.150.197.6 with HTTP; Sun, 13 Jul 2008 21:07:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88374>

Reduce_heads used by build in merge failed to find the correct
heads in cases where duplicate heads are specified.
---
This should fix the last breakage I found. ([PATCH/Test] Build in
merge is broken)
I have squashed in Miklos's fix and the two tests cases to protect this.

I have several other test cases that were used for the --ff-only patch
I worked on.
Many of the cases for that patch gives protection not currently in any of the
existing tests.  If there is interest for it I can squash them in as well.

 commit.c         |    8 +++++++-
 t/t7600-merge.sh |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/commit.c b/commit.c
index d20b14e..4cacf4c 100644
--- a/commit.c
+++ b/commit.c
@@ -746,8 +746,14 @@ struct commit_list *reduce_heads(struct commit_list *heads)
                struct commit_list *q, *base;

                num_other = 0;
+               for (q = heads; q != p; q = q->next) {
+                       if (p->item == q->item)
+                               break;
+               }
+               if (q != p)
+                       continue;
                for (q = heads; q; q = q->next) {
-                       if (p == q)
+                       if (p->item == q->item)
                                continue;
                        other[num_other++] = q->item;
                }
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 16f4608..80cfee6 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -465,4 +465,26 @@ test_expect_success 'merge log message' '

 test_debug 'gitk --all'

+test_expect_success 'merge c1 with c0, c2, c0, and c1' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c0 c2 c0 c1 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c1 and c2' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 c2 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
Sverre Hvammen Johansen
