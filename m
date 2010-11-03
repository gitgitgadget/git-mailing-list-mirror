From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 06/16] mingw: support waitpid with pid > 0 and WNOHANG
Date: Wed,  3 Nov 2010 17:31:24 +0100
Message-ID: <1288801894-1168-7-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgFp-0001tf-CN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab0KCQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0KCQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3zXfjFD9cJpmsPLmOg24EA+1rMys7lkUJEDDgUh+870=;
        b=GUtOCYCtPXmrtMmiwERyVUICVcvNSh7HYcYpYL3RvnHJ61s0gfmXRP+0cqmLV2wB+y
         GTi5w7ig+MRiI38ygxgDS0stWwbvq/TDmi51BMkXdCqvZQQINamla3RHvNi7DZJvp/5F
         DghtOWJYa9t1nAZoSim4QRJApIDhn/nVwxDeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KEOXvXnY9h8bxegMHenlJRy6m8oiYNK0ZC09Sxg0q0KvGhXMXgQ2ATH1cCksa+ZObx
         S1qw2aVdutdkFaAlSdIwwmdkRoGlIfTglzYciFuIlS6uFpyPTBPi6w/vaeLG6e7kQxS8
         OE1gjpT/VBfT/1MxSorC+Kf866Ww3w9MK9ooc=
Received: by 10.213.27.132 with SMTP id i4mr701504ebc.43.1288801919330;
        Wed, 03 Nov 2010 09:31:59 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id v51sm6712387eeh.4.2010.11.03.09.31.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:31:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160610>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c |    6 ++++++
 compat/mingw.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e2e3c54..2e7c644 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1550,6 +1550,12 @@ pid_t waitpid(pid_t pid, int *status, unsigned options)
 		return -1;
 	}
 
+	if (pid > 0 && options & WNOHANG) {
+		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
+			return 0;
+		options &= ~WNOHANG;
+	}
+
 	if (options == 0) {
 		int i;
 		if (WaitForSingleObject(h, INFINITE) != WAIT_OBJECT_0) {
diff --git a/compat/mingw.h b/compat/mingw.h
index 7c4eeea..379d7bf 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -140,6 +140,7 @@ static inline int mingw_unlink(const char *pathname)
 }
 #define unlink mingw_unlink
 
+#define WNOHANG 1
 pid_t waitpid(pid_t pid, int *status, unsigned options);
 
 #ifndef NO_OPENSSL
-- 
1.7.3.2.161.gd6e00
