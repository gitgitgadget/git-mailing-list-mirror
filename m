X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: filemode=false somewhat broken
Date: Wed, 22 Nov 2006 21:02:20 +0100
Message-ID: <17764.44236.473000.729015@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 20:03:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32097>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmyIw-00063T-Lf for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756790AbWKVUCm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbWKVUCm
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:02:42 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:9682 "EHLO
 meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1756790AbWKVUCl (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 15:02:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 meriadoc.bmiag.de (Postfix) with ESMTP id 6A55F3AF3C for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:37 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1]) by localhost (meriadoc
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 19786-05 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:37 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de
 [10.131.2.1]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) by meriadoc.bmiag.de (Postfix) with
 ESMTP id 40D043AF3B for <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:37
 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id C33EC3AE06 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:36 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1]) by localhost (eorl
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 18495-07 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:31 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5]) by
 eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 807F63AE05 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 21:02:29 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Commit fd28b34afd9bbd58297a25edced3f504c9a5487a tried to ignore the
executable bit if filemode=false, but instead forced all files to be
regular with 644 permission bits nuking symlink support. The attached
diff works better for me, but note that I'm completely posix agnostic.

Unfortunately there still seems to be another problem somewhere: files
merged by octopus (wanted to try one, too, after the recent
discussions on the list:-) lose the x bits in the process. But as
usual I'm not smart enough to find the problem:-(

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 7f9c638..f4b4bc4 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -112,13 +112,13 @@ static int add_file_to_cache(const char
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	if (!trust_executable_bit) {
 		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise force to 644.
+		 * from it, otherwise use mask 666.
 		 */
 		int pos = cache_name_pos(path, namelen);
 		if (0 <= pos)
 			ce->ce_mode = active_cache[pos]->ce_mode;
 		else
-			ce->ce_mode = create_ce_mode(S_IFREG | 0644);
+			ce->ce_mode = create_ce_mode((S_IFMT | 0666) & st.st_mode);
 	}
 
 	if (index_path(ce->sha1, path, &st, !info_only))
diff --git a/read-cache.c b/read-cache.c
index 97c3867..6cbbecf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -347,13 +347,13 @@ int add_file_to_index(const char *path,
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	if (!trust_executable_bit) {
 		/* If there is an existing entry, pick the mode bits
-		 * from it, otherwise force to 644.
+		 * from it, otherwise use mask 666.
 		 */
 		int pos = cache_name_pos(path, namelen);
 		if (pos >= 0)
 			ce->ce_mode = active_cache[pos]->ce_mode;
 		else
-			ce->ce_mode = create_ce_mode(S_IFREG | 0644);
+			ce->ce_mode = create_ce_mode((S_IFMT | 0666) & st.st_mode);
 	}
 
 	if (index_path(ce->sha1, path, &st, 1))
-- 
1.4.4.g540c

