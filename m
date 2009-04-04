From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] pack-objects: report actual number of threads to be used
Date: Sat,  4 Apr 2009 11:59:56 -0500
Message-ID: <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 19:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq9Fk-0006uk-Nk
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 19:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbZDDRA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZDDRAZ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 13:00:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:12735 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbZDDRAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 13:00:10 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1467811ywb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WElN5bm4UFAlxcjiTgVpnqwfv35JqvqmAs8AaU9Wj1M=;
        b=qeu/htoB2TYlhmRq2rzJDFtMWM6nx9eknCUmLpQdW88Z7uxunpw2G0+/OWRenrOGV6
         L4Nj1ZfQqTwusW+qrtCxQQlFxsQNZongIo8pDbj0I7kI51MRMzOXA3ctpg/T2CGAEpsd
         SGO7jPUsmFW9FWU4z/mWw617nYXcOJUHAko54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QPyzU4a6pDviicNWqNuDpFLYis2QHINkgwbjdbL8OfCTWLk9tSxBGZZfSi1pCZSghZ
         X1hJYJacJtOIDGr1eJ4CNTx9OYn6c/O/8NAiKgsS8roHMGPjc3K7UwENTiYNWOIJzP81
         V4EXgQpvbhHB7+LryPAz5udTsACMmw0Bw9uZE=
Received: by 10.100.189.10 with SMTP id m10mr3570350anf.153.1238864408350;
        Sat, 04 Apr 2009 10:00:08 -0700 (PDT)
Received: from localhost (adsl-76-193-181-72.dsl.chcgil.sbcglobal.net [76.193.181.72])
        by mx.google.com with ESMTPS id c1sm2346215ana.0.2009.04.04.10.00.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 10:00:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3.dirty
In-Reply-To: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115587>

In the case of a small repository, pack-objects is smart enough to not start
more threads than necessary. However, the output to the user always reports
the value of the pack.threads configuration and not the real number of
threads to be used. This is easily fixed by moving the printing of the
message after we have partitioned our work.

(pack.threads is on autodetect and would be set to 4)
$ git-repack -a -d -f
Counting objects: 55, done.
Delta compression using 2 threads.
Compressing objects: 100% (48/48), done.
Writing objects: 100% (55/55), done.
Total 55 (delta 10), reused 0 (delta 0)

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin-pack-objects.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9fc3b35..8c1b036 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1611,9 +1611,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		find_deltas(list, &list_size, window, depth, processed);
 		return;
 	}
-	if (progress > pack_to_stdout)
-		fprintf(stderr, "Delta compression using %d threads.\n",
-				delta_search_threads);
 
 	/* Partition the work amongst work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
@@ -1638,11 +1635,18 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		p[i].list = list;
 		p[i].list_size = sub_size;
 		p[i].remaining = sub_size;
+		if(sub_size)
+			active_threads++;
 
 		list += sub_size;
 		list_size -= sub_size;
 	}
 
+	if (progress > pack_to_stdout)
+		fprintf(stderr, "Delta compression using %d threads.\n",
+				active_threads);
+	active_threads = 0;
+
 	/* Start work threads. */
 	for (i = 0; i < delta_search_threads; i++) {
 		if (!p[i].list_size)
-- 
1.6.2.2.404.ge96f3.dirty
