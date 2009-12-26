From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 2/2] Smart-http: check if repository is OK to export before serving it
Date: Sat, 26 Dec 2009 18:29:13 -0500
Message-ID: <1261870153-57572-2-git-send-email-tarmigan+git@gmail.com>
References: <7vk4w963np.fsf@alter.siamese.dyndns.org>
 <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com>
Cc: spearce@spearce.org, git@vger.kernel.org, rctay89@gmail.com,
	drizzd@aon.at, warthog9@kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 00:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOg5I-0004C1-Vz
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 00:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZLZX3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbZLZX3v
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 18:29:51 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:33163 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbZLZX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 18:29:51 -0500
Received: by mail-qy0-f192.google.com with SMTP id 30so4402376qyk.33
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Z8+NVyBQ8mLN3rYkJzpJ0VGJsvV5K7ejaXRKFEt8f+E=;
        b=W34yUrvXB0TpsLH6dhH/YhIKN85vcpKDPRYm8tj7TqnTgx8VrmM9N3rvCiwZBUWX3r
         MF7EgcbbXmKx7+jvx3sfWpE93DaRdRLVEDrIgGRRzbOsFPn7aVKFD4lKxOYkX130jXB4
         LgW8uUhieW/nqXkoZ0WKpxQhGmKdzaCC1pMvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=fd/Gm6JVjl91+bFD1sv6fiSPiozRUz/+zHnAJLqhb2qAfTwBYcHKNcIr0Q8g7zS+dZ
         XYXAcLh0w6DKQ3heRX5cDcZMy3ffYGWDjtpsbk4Uxi2DpHySvbMcRYqfp26Oa3r+guoF
         Wn4bfXSkVp+c/n/heSo6MID7vO5RyaVfQh5yM=
Received: by 10.224.104.132 with SMTP id p4mr6859760qao.256.1261870190682;
        Sat, 26 Dec 2009 15:29:50 -0800 (PST)
Received: from localhost.localdomain (c-69-141-159-197.hsd1.nj.comcast.net [69.141.159.197])
        by mx.google.com with ESMTPS id 22sm9238679qyk.2.2009.12.26.15.29.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Dec 2009 15:29:49 -0800 (PST)
X-Mailer: git-send-email 1.6.6.2.g5daf2
In-Reply-To: <1261870153-57572-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135695>

Similar to how git-daemon checks whether a repository is OK to be
exported, smart-http should also check.  This check can be satisfied
in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
may be set to export all repositories, or the individual repository
may have the file git-daemon-export-ok.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 http-backend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f729488..345c12b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -648,6 +648,9 @@ int main(int argc, char **argv)
 	setup_path();
 	if (!enter_repo(dir, 0))
 		not_found("Not a git repository: '%s'", dir);
+	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
+	    access("git-daemon-export-ok", F_OK) )
+		not_found("Repository not exported: '%s'", dir);
 
 	git_config(http_config, NULL);
 	cmd->imp(cmd_arg);
-- 
1.6.6.2.g5daf2
