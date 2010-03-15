From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 17:03:19 +0100
Message-ID: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 17:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrCls-0003jn-PP
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 17:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286Ab0COQDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 12:03:52 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:47541 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965216Ab0COQDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 12:03:51 -0400
Received: by ewy8 with SMTP id 8so1145068ewy.28
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=KMrh+va3IGJa47Pd8rlHbANaab/M1W9Kx4eejfT2x/A=;
        b=vUz1wiEHHudRpAgfYTTkB2HFuZz2Ff2HrZuBi0Mal3/UC++i98BYZeVV5pMAkzSMWz
         ljf9PAvMjBKzKQPb6pjHLDSjyVl79tIsajqVhoOyHPoHzupaRVVxB6rXnbouwUjg0KH4
         c7b0VFmPZw5LTe6dViYYKFb90JNSzW0ISr2T8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=oVp6g9wGeKimCAJ+Ks0H6KTK98wxUq5KX2ux1FbkVCs3nZakbcLfcMYu7ffkOFfAfV
         AkIE+wZ5e3Hq7UdVUldv2rVhRIfa4f8Jv5rSCM2Kn9U8BW5P/thVRi1Gkcaam6RTXrUX
         Ijc6TG5ZBzua3thLPaMA30zWFkXALtJC6DlAk=
Received: by 10.213.102.68 with SMTP id f4mr2246286ebo.61.1268669030353;
        Mon, 15 Mar 2010 09:03:50 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 16sm2681429ewy.15.2010.03.15.09.03.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 09:03:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.rc2.2.g0772d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142218>

Switch to parse-options API while we're at it.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I sometimes find it useful to look at the commit-subject together with
the SHA-1s. Using --abbrev increases the chance that the lines fits on
an 80 character wide terminal, making the output easier to read.

 builtin/log.c |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b70d0f7..020d618 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1286,8 +1286,11 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 	return -1;
 }
 
-static const char cherry_usage[] =
-"git cherry [-v] [<upstream> [<head> [<limit>]]]";
+static const char * const cherry_usage[] = {
+	"git cherry [-v] [<upstream> [<head> [<limit>]]]",
+	NULL
+};
+
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1298,26 +1301,26 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *upstream;
 	const char *head = "HEAD";
 	const char *limit = NULL;
-	int verbose = 0;
+	int verbose = 0, abbrev = 40;
 
-	if (argc > 1 && !strcmp(argv[1], "-v")) {
-		verbose = 1;
-		argc--;
-		argv++;
-	}
+	struct option options[] = {
+		OPT__ABBREV(&abbrev),
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
 
-	if (argc > 1 && !strcmp(argv[1], "-h"))
-		usage(cherry_usage);
+	argc = parse_options(argc, argv, prefix, options, cherry_usage,
+	    PARSE_OPT_KEEP_UNKNOWN);
 
 	switch (argc) {
-	case 4:
-		limit = argv[3];
-		/* FALLTHROUGH */
 	case 3:
-		head = argv[2];
+		limit = argv[2];
 		/* FALLTHROUGH */
 	case 2:
-		upstream = argv[1];
+		head = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		upstream = argv[0];
 		break;
 	default:
 		current_branch = branch_get(NULL);
@@ -1327,7 +1330,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, "Could not find a tracked"
 					" remote branch, please"
 					" specify <upstream> manually.\n");
-			usage(cherry_usage);
+			usage_with_options(cherry_usage, options);
 		}
 
 		upstream = current_branch->merge[0]->dst;
@@ -1380,12 +1383,13 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 					    &buf, &ctx);
 			printf("%c %s %s\n", sign,
-			       sha1_to_hex(commit->object.sha1), buf.buf);
+			       find_unique_abbrev(commit->object.sha1, abbrev),
+			       buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
 			printf("%c %s\n", sign,
-			       sha1_to_hex(commit->object.sha1));
+			       find_unique_abbrev(commit->object.sha1, abbrev));
 		}
 
 		list = list->next;
-- 
1.7.0.2.416.g84492
