From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH 1/2] hash-object: support --stdin-paths with --no-filters
Date: Fri, 12 Feb 2010 18:52:34 +0100
Message-ID: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>
Cc: johannes.schindelin@gmx.de, normalperson@yhbt.net,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 18:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfzi2-0007N7-7a
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319Ab0BLRxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:53:37 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:50261 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab0BLRxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:53:36 -0500
Received: by ewy28 with SMTP id 28so1639793ewy.28
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 09:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=IfOFzGKWPOd9CCxwo4rDLeyQzq1p1UOnDCXPCRWOYr8=;
        b=qnZg28HubbCl9gWhuNdGla6Vsz1rn1Lu/EpJI4kRq1pWJPBdHD28iUCLonMi88AX4z
         1aDFinyAT4RBU3unjYqZyjgvrVvrShQhzfHyN6Le9cfD+KxexXJNg2B3jEiUnR2H96gT
         DbyUBD/0kaGnxWLl0CwOyYNGU9pASDVrs3u9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PRbLqA1a0JMW2oBm1GwlTruN9F/y4AGl/UvEL1EMH78CUNKbv39uqT25+Zs7qlrSLP
         0Mp9ZMtEfIFySybDyIFGHhpWWpp8xPoB843uI6aAH9DqbZQU79+WCTqqCOw6LcEttwmD
         gmoXm65o7CRD7S8EUGYADUd5TNnKzTwJYYM+s=
Received: by 10.213.76.65 with SMTP id b1mr1229378ebk.49.1265997214785;
        Fri, 12 Feb 2010 09:53:34 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 15sm2472259ewy.12.2010.02.12.09.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Feb 2010 09:53:34 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139734>

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-hash-object.c  |    8 ++++----
 t/t1007-hash-object.sh |    4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin-hash-object.c b/builtin-hash-object.c
index 6a5f5b5..080af1a 100644
--- a/builtin-hash-object.c
+++ b/builtin-hash-object.c
@@ -33,6 +33,8 @@ static void hash_object(const char *path, const char *type, int write_object,
 	hash_fd(fd, type, write_object, vpath);
 }
 
+static int no_filters;
+
 static void hash_stdin_paths(const char *type, int write_objects)
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
@@ -44,7 +46,8 @@ static void hash_stdin_paths(const char *type, int write_objects)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		hash_object(buf.buf, type, write_objects, buf.buf);
+		hash_object(buf.buf, type, write_objects,
+		    no_filters ? NULL : buf.buf);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
@@ -60,7 +63,6 @@ static const char *type;
 static int write_object;
 static int hashstdin;
 static int stdin_paths;
-static int no_filters;
 static const char *vpath;
 
 static const struct option hash_object_options[] = {
@@ -100,8 +102,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 			errstr = "Can't specify files with --stdin-paths";
 		else if (vpath)
 			errstr = "Can't use --stdin-paths with --path";
-		else if (no_filters)
-			errstr = "Can't use --stdin-paths with --no-filters";
 	}
 	else {
 		if (hashstdin > 1)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index fd98e44..1509fe3 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -65,10 +65,6 @@ test_expect_success "Can't use --path with --stdin-paths" '
 	echo example | test_must_fail git hash-object --stdin-paths --path=foo
 '
 
-test_expect_success "Can't use --stdin-paths with --no-filters" '
-	echo example | test_must_fail git hash-object --stdin-paths --no-filters
-'
-
 test_expect_success "Can't use --path with --no-filters" '
 	test_must_fail git hash-object --no-filters --path=foo
 '
-- 
1.7.0.rc2
