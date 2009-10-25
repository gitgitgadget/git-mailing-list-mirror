From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/7] http-push: allow stderr messages to appear alongside
 helper_status ones
Date: Sun, 25 Oct 2009 23:19:32 +0800
Message-ID: <20091025231932.be9a6dfa.rctay89@gmail.com>
References: <20091025231809.15b470fa.rctay89@gmail.com>
 <20091025231651.18c75559.rctay89@gmail.com>
 <20091019105921.d58c2728.rctay89@gmail.com>
 <1255577814-14745-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N24sx-0000zx-DC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbZJYPTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752659AbZJYPTf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:19:35 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:56549 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbZJYPTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:19:33 -0400
Received: by ywh40 with SMTP id 40so7626979ywh.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=HGzqpf6Aqh7JvdOhCs6grtyFGW/5iebZiRpRqTyZH/w=;
        b=QphJODHtBpXunmORTPHl4k6uQFyjuhb9FSM6OAWaK9b9F5z5KGLaDRt67WnhXpeknn
         9FrIVw9lxINgIWyHAoN3hKPcQmRW7ifPZZEzp0ZbHSaLzc/qVr3vwVtTnzEJrrVFPc00
         xMmD8exCNvW0GtVhY48YICpCrBRwvGHEfZ3rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=NBz/3uzAX2WZlwi/O8j7rJQa3DWxQ7llj77p1LHyrz0b6VYZBx5mTbCyIkETTCv7IT
         5JQi46yCMCU40sVVp6amZrhZtR7tbTrg42Aj7FyFwmfVd4BftPMSyDeM8oFEtb/JcWAB
         LrSEq9JqtEDIJ+fTsUMGy/rB0TLGa0RHfH1k8=
Received: by 10.101.176.35 with SMTP id d35mr8236822anp.170.1256483977135;
        Sun, 25 Oct 2009 08:19:37 -0700 (PDT)
Received: from your-cukc5e3z5n (cm73.zeta152.maxonline.com.sg [116.87.152.73])
        by mx.google.com with ESMTPS id 9sm891925yxf.5.2009.10.25.08.19.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:19:36 -0700 (PDT)
In-Reply-To: <20091025231651.18c75559.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131208>

These messages notifies user over pushing progress (or the lack
thereof). It is safe for them to appear alongside status reports
('ok|error <dst>'), since the reports go to stdout, while the
notifications go to stderr.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/http-push.c b/http-push.c
index 24eec73..b97ea1f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1946,10 +1946,9 @@ int main(int argc, char **argv)

 		if (is_null_sha1(ref->peer_ref->new_sha1)) {
 			if (delete_remote_branch(ref->name, 1) == -1) {
+				error("Could not remove %s", ref->name);
 				if (helper_status)
 					printf("error %s cannot remove\n", ref->name);
-				else
-					error("Could not remove %s", ref->name);
 				rc = -4;
 			}
 			else if (helper_status)
@@ -1980,15 +1979,14 @@ int main(int argc, char **argv)
 				 * commits at the remote end and likely
 				 * we were not up to date to begin with.
 				 */
+				error("remote '%s' is not an ancestor of\n"
+				      "local '%s'.\n"
+				      "Maybe you are not up-to-date and "
+				      "need to pull first?",
+				      ref->name,
+				      ref->peer_ref->name);
 				if (helper_status)
 					printf("error %s non-fast forward\n", ref->name);
-				else
-					error("remote '%s' is not an ancestor of\n"
-						  "local '%s'.\n"
-						  "Maybe you are not up-to-date and "
-						  "need to pull first?",
-						  ref->name,
-						  ref->peer_ref->name);
 				rc = -2;
 				continue;
 			}
@@ -2011,11 +2009,10 @@ int main(int argc, char **argv)
 		/* Lock remote branch ref */
 		ref_lock = lock_remote(ref->name, LOCK_TIME);
 		if (ref_lock == NULL) {
+			fprintf(stderr, "Unable to lock remote branch %s\n",
+				ref->name);
 			if (helper_status)
 				printf("error %s lock error\n", ref->name);
-			else
-				fprintf(stderr, "Unable to lock remote branch %s\n",
-					ref->name);
 			rc = 1;
 			continue;
 		}
--
1.6.4.4
