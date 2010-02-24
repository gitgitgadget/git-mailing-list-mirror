From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Wed, 24 Feb 2010 23:15:54 +0800
Message-ID: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 16:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkIye-0000Zf-3Q
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 16:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214Ab0BXPQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 10:16:35 -0500
Received: from mail-pz0-f174.google.com ([209.85.222.174]:38276 "EHLO
	mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab0BXPQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 10:16:34 -0500
Received: by pzk4 with SMTP id 4so733251pzk.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 07:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=OwhgefQab+tOf2oYRVIG5bYW/QUUUTqGI/l3/fHuDIY=;
        b=Z6nG5+bXYz+U/rVdWESgSsDgQcY4jH8l6WMIGJsrrUwTurGwKDf5a4BEtB25BQACSq
         umd9NNZEG35+/5oNs7ujVDZ8dVo5+e1QmI7AAW3Uw5Q2MgD2z1HrVJ2Q35gL+aTLFwRy
         mgbb8xcKDYI39wTUE4yjkM+tO75Ejv+LjCE/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kTh70ATfw3qB+3GociEiwHCdshkt+CWf8rwQXjMnqYr24Zesl2DnCeXVT4bBTg7G2z
         l9EzYOkvs9HRZtEZkeVxfnWoQaGr7weIxSqLz72tqXJtt+aUIHr7lu0CS5yfNZft3c0E
         UJ9kKxyiavuG8t1UtAi5c2+uQh2KJOQh/91fE=
Received: by 10.141.214.22 with SMTP id r22mr3968959rvq.165.1267024593331;
        Wed, 24 Feb 2010 07:16:33 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 20sm912265pzk.15.2010.02.24.07.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 07:16:32 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140947>

If GIT_ASKPASS is not set and SSH_ASKPASS set, GIT_ASKPASS will
use SSH_ASKPASS. If GIT_ASKPASS set and SSH_ASKPASS is not set,
SSH_ASKPASS will use GIT_ASKPASS.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 90c6daf..39e1eba 100644
--- a/git.c
+++ b/git.c
@@ -54,6 +54,11 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	int handled = 0;
 
+	if (getenv("GIT_ASKPASS") && !getenv("SSH_ASKPASS"))
+		setenv("SSH_ASKPASS", getenv("GIT_ASKPASS"), 1);
+	if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
+		setenv("GIT_ASKPASS", getenv("SSH_ASKPASS"), 1);
+
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
 		if (cmd[0] != '-')
-- 
1.7.0.85.g37fda.dirty
