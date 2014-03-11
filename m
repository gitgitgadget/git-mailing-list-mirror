From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC memory leak?] Minor memory leak fix
Date: Tue, 11 Mar 2014 11:45:06 +0100
Message-ID: <1394534706-28987-1-git-send-email-iveqy@iveqy.com>
Cc: iveqy@iveqy.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 11:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNK8b-0002wM-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 11:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbaCKKmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 06:42:15 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:37440 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbaCKKmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 06:42:13 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so5394568lab.7
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=O8x56D31z/8FHZ8dYsXnoFDkE5TzDJVDW3sNHJw01kM=;
        b=jY4iLDlloHExCxnV2P8d7e9G6hr0rQ6pKrPraVN1hc5mVx2QwA3Ka+bbKt7nEnCvQp
         fTL660AZ4QfIEsJhVR24ihG4f9qQeadY5C65mPvSsgT4JQqjWO7V8I8ovTAmmY808c3q
         03RUMFiWx5qnDlXv0GbUGBrNUyo9yV1cPMvASysMPrjTz4UvQH6Ei4u6024ivnfaeT24
         6rLNzscL/zOAOXZHh4URuthZNNC1hjx4VR1w0U8AqENzCMKISayGNV15URgcGyKOazaW
         Wn9KvQZ+5jEKi7YJ1epHpD9/UkV3y7hV7bdkpEPSqpZ2b9U/j1qJyh8YZOpqMqIFdHRc
         H1ig==
X-Received: by 10.112.221.227 with SMTP id qh3mr700887lbc.55.1394534531545;
        Tue, 11 Mar 2014 03:42:11 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id qx7sm24731195lbb.9.2014.03.11.03.42.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 03:42:10 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1WNKBH-0007Y7-H3; Tue, 11 Mar 2014 11:45:07 +0100
X-Mailer: git-send-email 1.8.3.1.490.g39d9b24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243853>

Strbuf needs to be released even if it's locally declared.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 archive.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index 346f3b2..d6d56e6 100644
--- a/archive.c
+++ b/archive.c
@@ -113,6 +113,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct git_attr_check check[2];
 	const char *path_without_prefix;
 	int err;
+	int to_ret = 0;
 
 	args->convert = 0;
 	strbuf_reset(&path);
@@ -126,8 +127,10 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 
 	setup_archive_check(check);
 	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
-		if (ATTR_TRUE(check[0].value))
-			return 0;
+		if (ATTR_TRUE(check[0].value)) {
+			to_ret = 0;
+			goto cleanup;
+		}
 		args->convert = ATTR_TRUE(check[1].value);
 	}
 
@@ -135,14 +138,20 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err = write_entry(args, sha1, path.buf, path.len, mode);
-		if (err)
-			return err;
-		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
+		if (err) {
+			to_ret = err;
+			goto cleanup;
+		}
+		to_ret = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
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
