From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: remove remote locks on exit signals
Date: Thu, 22 May 2008 21:55:46 +0200
Message-ID: <20080522195546.GA29911@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 21:58:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzGuJ-0008Ii-4O
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 21:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYEVTzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbYEVTzw
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 15:55:52 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:57919 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbYEVTzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 15:55:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so229219fkq.5
        for <git@vger.kernel.org>; Thu, 22 May 2008 12:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        bh=FDnwRSgWbC5trWiw6tNC8ONe4dLtHXRHK/qLVBHVN0M=;
        b=KV4BrsWOTv2YJ+vr/yPRAZaPwqEA0x14E55O1TtwGdCZVAtbRGmaURnhq4Fjoiiji6kH1YcpIe1FHFXivp2qfDzNw9clZANnk6vnxA0ErbW2VfkEbRrEyAWKyLuF64g7djKaWizSzIDOwxdv5vhqG/DRiHdlCcjcrdVmNqZOwNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=W26Lj2tad7p/gljAHw1/2v6lK6h0lJrDZuX/H57DfWEiQhJGX86lalwBnFYUG93gLE5/HPMDzqOSg+3a26hiJ2U2PBUafI/BPb7q7uFdQvNOZv+ghgFnXd4GbywKAxTy+92M9DhyOOdlc3ijIw/KOtB6e8tJJTHMxntaq1lfVXw=
Received: by 10.125.69.4 with SMTP id w4mr295650mkk.18.1211486149188;
        Thu, 22 May 2008 12:55:49 -0700 (PDT)
Received: from darc.dyndns.org ( [91.113.45.77])
        by mx.google.com with ESMTPS id d4sm3988105fga.4.2008.05.22.12.55.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 May 2008 12:55:48 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JzGt8-00030X-Pf
	for git@vger.kernel.org; Thu, 22 May 2008 21:55:46 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82649>

If locks are not cleaned up the repository is inaccessible for 10 minutes.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Hi,

To test this I created a large file, added it, commited, pushed, waited one
second and pressed Ctrl+C. If this method is acceptable for the regression
tests, or if you have a better idea, let me know. I will write up a script.

Regards,
Clemens

---
 http-push.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b23038..b1f5302 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1349,6 +1349,24 @@ static int unlock_remote(struct remote_lock *lock)
 	return rc;
 }
 
+static void remove_locks(void)
+{
+	struct remote_lock *lock = remote->locks;
+	
+	fprintf(stderr, "Removing remote locks...\n");
+	while (lock) {
+		unlock_remote(lock);
+		lock = lock->next;
+	}
+}
+
+static void remove_locks_on_signal(int signo)
+{
+	remove_locks();
+	signal(SIGINT, SIG_DFL);
+	raise(signo);
+}
+
 static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
@@ -2255,6 +2273,8 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
+	signal(SIGINT, remove_locks_on_signal);
+
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
 	remote->has_info_refs = remote_exists("info/refs");
-- 
1.5.5.1.1.g95a6
