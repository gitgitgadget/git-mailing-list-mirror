From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/8] revision: add leak_pending flag
Date: Sat, 01 Oct 2011 17:56:08 +0200
Message-ID: <4E873818.6080006@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org> <4E8607B6.2040800@lsrfire.ath.cx> <4E8731AF.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Oct 01 17:56:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA1vP-000655-OA
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 17:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab1JAP4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 11:56:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:55632 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab1JAP4X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 11:56:23 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 9AEB12F803A;
	Sat,  1 Oct 2011 17:56:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182559>

The new flag leak_pending in struct rev_info can be used to prevent
prepare_revision_walk from freeing the list of pending objects.  It
will still forget about them, so it really is leaked.  This behaviour
may look weird at first, but it can be useful if the pointer to the
list is saved before calling prepare_revision_walk.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
The next three patches are going to use this flag.

 revision.c |    3 ++-
 revision.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 2e8aa33..6d329b4 100644
--- a/revision.c
+++ b/revision.c
@@ -1974,7 +1974,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		}
 		e++;
 	}
-	free(list);
+	if (!revs->leak_pending)
+		free(list);
 
 	if (revs->no_walk)
 		return 0;
diff --git a/revision.h b/revision.h
index 4541265..366a9b4 100644
--- a/revision.h
+++ b/revision.h
@@ -97,6 +97,7 @@ struct rev_info {
 			date_mode_explicit:1,
 			preserve_subject:1;
 	unsigned int	disable_stdin:1;
+	unsigned int	leak_pending:1;
 
 	enum date_mode date_mode;
 
-- 
1.7.7
