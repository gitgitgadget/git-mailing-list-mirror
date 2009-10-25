From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/3] remote-helpers: return successfully if everything up-to-date
Date: Sun, 25 Oct 2009 13:06:19 +0100
Message-ID: <1256472380-924-3-git-send-email-drizzd@aon.at>
References: <1256472380-924-1-git-send-email-drizzd@aon.at>
 <1256472380-924-2-git-send-email-drizzd@aon.at>
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Oct 25 13:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N21sY-0002H5-RC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 13:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbZJYMHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 08:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbZJYMHK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 08:07:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58065 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbZJYMHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 08:07:10 -0400
Received: by fxm18 with SMTP id 18so11402419fxm.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+LsLXVJtH0RFVkYVAIIE5LWTibwdiAVNE/oY6F/b6zc=;
        b=abmwAspV+yASykAL/ntRkimi7wtcOYy+vfCC5agblHdhG6PYWCTV0ADeB/AoR3d3GE
         7dtxC8WoHmdRSPVSGziR1pEGM3fdYZR602kZvb/4XkgyBg3zKNecu3eWIcXPjAKzDsoo
         aeoF9M8PZ3Zqm2bneuS7M0Y7ZpuQ1KO7sxhtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=GV+2MKaYJfmmUOlgByOAciZ05dqBpU9mj5vwMDIrZ8Bc0A+N+JWZ1ldnKt2ewoH4Ql
         r8JKWhd4mEmmSdiC7sbrUc/Jt3uLnskgWlbpUkuZymms9SvpkUHVvpkdiGUffcTRc4pt
         PdBStJd3ekj9Ynd+yVV/UGmOSqjvHf3rkP6lc=
Received: by 10.204.20.143 with SMTP id f15mr90060bkb.49.1256472433642;
        Sun, 25 Oct 2009 05:07:13 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 3sm6835763fxm.13.2009.10.25.05.07.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 05:07:13 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N21sW-0001Pm-CS; Sun, 25 Oct 2009 13:07:20 +0100
X-Mailer: git-send-email 1.6.5.35.ge41a3
In-Reply-To: <1256472380-924-2-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131202>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5540-http-push.sh |    2 +-
 transport-helper.c   |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 09edd23..2ece661 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -58,7 +58,7 @@ test_expect_success 'push to remote repository with packed refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'push already up-to-date' '
+test_expect_success 'push already up-to-date' '
 	git push
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 16c6641..5078c71 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -263,6 +263,8 @@ static int push_refs(struct transport *transport,
 		strbuf_addstr(&buf, ref->name);
 		strbuf_addch(&buf, '\n');
 	}
+	if (buf.len == 0)
+		return 0;
 
 	transport->verbose = flags & TRANSPORT_PUSH_VERBOSE ? 1 : 0;
 	standard_options(transport);
-- 
1.6.5.35.ge41a3
