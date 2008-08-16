From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [PATCH] Make push more verbosive about illegal combination of options
Date: Sat, 16 Aug 2008 19:58:32 +0200
Message-ID: <1218909512-13083-1-git-send-email-marek.zawirski@gmail.com>
Cc: gitster@pobox.com, Marek Zawirski <marek.zawirski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 19:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUQ43-00043p-4C
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 19:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYHPR6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 13:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYHPR6j
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 13:58:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:59447 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbYHPR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 13:58:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1223265fgg.17
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E4CHcxYZ+UBfHH9DgmVCcOmJc2YqkTlxJ8WfLN5JCvQ=;
        b=gl38Q4joH/SXoTaTmNDTtAIwGSVtoRh+D1iOVThEPcxr8T9DYIkYBmb7uPdXxeMS5o
         wDv1splDIywwt3AQzv+IDc7D67KLwHXU1qQlzct7Gfv0M20U91He85rVmYL0XJdQIoRP
         wCw7t9z/bfdmCzY5BK0QzZRKPTg8K9nDztPlc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=d9z1hDtwrZuDOSQQoCGdfREg98qdq1ID+Wsi7yqO9gzNjP6uA94/b2s9xznkeg/Gx3
         ts2YsGNiQGtU7/xiau46rN5hsmr0XOebetino8I872mZnMKQ06PfkQ8Yo8PeArzqjAuQ
         zYGtvasor5H8kf19a2klr3KzszqPSuXlZJQMo=
Received: by 10.86.82.6 with SMTP id f6mr3141145fgb.38.1218909516295;
        Sat, 16 Aug 2008 10:58:36 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l19sm558251fgb.7.2008.08.16.10.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 10:58:35 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92551>

It may be unclear that --all (or even --mirror?) and --tags or explicit
refspecs are illegal combinations for git push.

Git was silently failing for these cases, while we can complaint more
properly about it.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
I forgot about this one, it was reported long time ago:
http://thread.gmane.org/gmane.comp.version-control.git/85229

It seems that it may be really unclear what's going on with git failing on
$ git push --tags --all
and similar, as it is implementation related perhaps.

If it's not allowed, let's just inform, hm?

 builtin-push.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index c1ed68d..cc6666f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -59,8 +59,17 @@ static int do_push(const char *repo, int flags)
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) && refspec)
-		return -1;
+	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
+		if (!strcmp(*refspec, "refs/tags/*"))
+			return error("--all and --tags are incompatible");
+		return error("--all can't be combined with refspecs");
+	}
+
+	if ((flags & TRANSPORT_PUSH_MIRROR) && refspec) {
+		if (!strcmp(*refspec, "refs/tags/*"))
+			return error("--mirror and --tags are incompatible");
+		return error("--mirror can't be combined with refspecs");
+	}
 
 	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
 				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-- 
1.5.6.3
