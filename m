From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: remove remote locks on exit signals
Date: Sun, 25 May 2008 20:27:44 +0200
Message-ID: <20080525182744.GB17806@localhost>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 25 20:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0KxU-0004wX-Uy
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 20:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbYEYS1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbYEYS1u
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 14:27:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:10106 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbYEYS1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 14:27:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1018692fgg.17
        for <git@vger.kernel.org>; Sun, 25 May 2008 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=Sg/0/pVEY6V1lBGWHMbqOlmjrSFA4FrvliLOyJy2xmQ=;
        b=l1X3Bk5B2VZMLfGBvvMNz3HK+jRYFq3jCkyXCv0HFNPDrWSYozLNjXgsuYO7VtJqHsrv6MIw8BMPELYVMrnqY90FoORbHYXaGo1seHCFb3UzbpzrGwtk+VHfZSG3qO5rBSL9HgpwjAFpJIjHnkYsr+Zou+jQpWbBu80yNfUn6YA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dU1g9X3gQvZ3tXG9rSTpPe1rNeOc4jg6tIZi5u3wV0VeEdJQ0r2oc3jRrykC5P55TtvqPML7U9sXK22EzbuIixf5igipJLe2y266tbfdnp2qceUSoELwPjWfTbQPTuo3D9uvvGx674kEbe0kszcDOu1oeUlX9drqR4VXIw/uzBc=
Received: by 10.86.52.6 with SMTP id z6mr533718fgz.18.1211740067801;
        Sun, 25 May 2008 11:27:47 -0700 (PDT)
Received: from darc.dyndns.org ( [84.154.74.129])
        by mx.google.com with ESMTPS id f31sm17894885fkf.5.2008.05.25.11.27.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 May 2008 11:27:47 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1K0Kwa-0001Yh-3M; Sun, 25 May 2008 20:27:44 +0200
Content-Disposition: inline
In-Reply-To: <20080523221723.GA4366@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82872>

If locks are not cleaned up the repository is inaccessible for 10 minutes.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 http-push.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5b23038..b44768e 100644
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
+	signal(signo, SIG_DFL);
+	raise(signo);
+}
+
 static void remote_ls(const char *path, int flags,
 		      void (*userFunc)(struct remote_ls_ctx *ls),
 		      void *userData);
@@ -2255,6 +2273,10 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
+	signal(SIGINT, remove_locks_on_signal);
+	signal(SIGHUP, remove_locks_on_signal);
+	signal(SIGQUIT, remove_locks_on_signal);
+
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
 	remote->has_info_refs = remote_exists("info/refs");
-- 
1.5.5.1
