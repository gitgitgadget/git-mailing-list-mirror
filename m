From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [[RFC memory leak, v.2]] Minor memory leak fix
Date: Tue, 11 Mar 2014 13:36:11 +0100
Message-ID: <1394541371-2960-1-git-send-email-iveqy@iveqy.com>
References: <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
Cc: git@vger.kernel.org, iveqy@iveqy.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 11 13:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNLs6-0006cr-NW
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 13:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbaCKMdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 08:33:22 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33959 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbaCKMdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 08:33:21 -0400
Received: by mail-lb0-f177.google.com with SMTP id z11so5546631lbi.36
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 05:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U4QWaGerEKJ1JrpHRr6bpHkiqnKKi9Rvj9xUTgzXcho=;
        b=KummW8WjYW5VpFHg8R4jKeDHaYBAomMLlRpxDollpkRkuHQa3SJaYDZhAL4NdCVqg+
         QL9YfeV9TKp1s6rpCyml34fMTbiRFggjee1sqKtym9KWRzjoy/acwn0bU7ZyfPC/Nt4/
         2RqjLpuC7AG44yPcRuk71TVnCRzirdtYmNLL7WcJq34+K1QZFwnT6jc0Lkhc/qG+E7m7
         0cas2jNwqu/cr5tiqbVojCJoCPFfS8UQCC4zApdL0FZEok7og/w5N6zZ7koigv9EnRDh
         us2yIiBwCFXqzaR+vBpUi8kR2MAW3KmUHo7vSYFwJaCZ12PavvAcUsslG7LGuutlNq6O
         +r4w==
X-Received: by 10.112.131.34 with SMTP id oj2mr1620852lbb.43.1394541200496;
        Tue, 11 Mar 2014 05:33:20 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id f9sm33447606laa.8.2014.03.11.05.33.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 05:33:19 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1WNLur-0000mL-4P; Tue, 11 Mar 2014 13:36:17 +0100
X-Mailer: git-send-email 1.8.3.1.490.g39d9b24.dirty
In-Reply-To: <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243860>

Strbuf needs to be released even if it's locally declared.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 archive.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index 346f3b2..dfc557d 100644
--- a/archive.c
+++ b/archive.c
@@ -113,6 +113,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
 	int err;
+	int to_ret = 0;
 
 	args->convert = 0;
 	strbuf_reset(&path);
@@ -127,22 +128,25 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	setup_archive_check(check);
 	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
-			return 0;
+			goto cleanup;
 		args->convert = ATTR_TRUE(check[1].value);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err = write_entry(args, sha1, path.buf, path.len, mode);
-		if (err)
-			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		to_ret = write_entry(args, sha1, path.buf, path.len, mode);
+		if (!to_ret)
+			to_ret = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		goto cleanup;
 	}
 
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	return write_entry(args, sha1, path.buf, path.len, mode);
+	to_ret = write_entry(args, sha1, path.buf, path.len, mode);
+cleanup:
+	strbuf_release(&path);
+	return to_ret;
 }
 
 int write_archive_entries(struct archiver_args *args,
-- 
1.8.3.1.490.g39d9b24.dirty
