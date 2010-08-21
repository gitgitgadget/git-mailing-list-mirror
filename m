From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 3/4] rev-parse: introduce get_sha1_gently
Date: Sat, 21 Aug 2010 11:43:41 +1000
Message-ID: <1282355022-17795-4-git-send-email-jon.seymour@gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 03:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omd8J-00056H-Ua
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 03:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab0HUBo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 21:44:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55456 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0HUBoX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 21:44:23 -0400
Received: by pzk26 with SMTP id 26so1463213pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=usPmjOdBS4XElemQhkeUMf7wQ916RQ2eaMZ1kpUBny4=;
        b=YZlKyTtWlwo2r5bC4mEiC7VMqxQUB0WcU1BvfXcBmGBu+nsU0nYwDxHgLycku+ihQ8
         u+90W9BBrCBgSQ15Ec1qvp+kP8RXd5j6390XN1tAQnXFw271q/GixFBcHbBILmTFsyuv
         orrIVO076AxUtoVPYwDZRzA/iHpEWkIN7n4EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=e61PyAfpL7AQdpu8epLtjkN1NFEVIxwF2GHcM08TJxlxb7+H2TZl2Todo5VohlY9x6
         BOiORhmAk/ZvFzniF8BybKiMgoUMVAw9DNxI1ONyUjStnMH5mVHXCDdLEOMXpZfa6BDz
         /u7DK6Zmz5+OBQgpRYB1+RFLg5vtiJj3tMypk=
Received: by 10.114.201.18 with SMTP id y18mr2427599waf.37.1282355062352;
        Fri, 20 Aug 2010 18:44:22 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id d38sm6038069wam.8.2010.08.20.18.44.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 18:44:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.156.gf148c
In-Reply-To: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154087>

Use of this function allows git rev-parse --verify ref@{n}
to report an error message if n >= the size of the
reference log for ref.

However, if the user has not specified --verify, get_sha1_gently
will be called again via verify_filename and the message will
be reported then, if required.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 builtin/rev-parse.c |    2 +-
 cache.h             |    1 +
 sha1_name.c         |    8 ++++++++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..dbc6a8c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -707,7 +707,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_sha1(name, sha1)) {
+		if (!get_sha1_gently(name, sha1, !verify)) {
 			if (verify)
 				revs_count++;
 			else
diff --git a/cache.h b/cache.h
index 37ef9d8..625728c 100644
--- a/cache.h
+++ b/cache.h
@@ -767,6 +767,7 @@ static inline int get_sha1_with_context(const char *str, unsigned char *sha1, st
 {
 	return get_sha1_with_context_1(str, sha1, orc, 1, NULL);
 }
+extern inline int get_sha1_gently(const char *str, unsigned char *sha1, int gently);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 6e706eb..48e7aa0 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1050,6 +1050,14 @@ int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 	return ret;
 }
 
+int get_sha1_gently(const char *name, unsigned char *sha1, int gently)
+{
+	struct object_context unused;
+	int ret;
+	ret = get_sha1_with_context_1(name, sha1, &unused, gently, NULL);
+	return ret;
+}
+
 int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			    struct object_context *oc,
 			    int gently, const char *prefix)
-- 
1.7.2.1.156.gf148c
