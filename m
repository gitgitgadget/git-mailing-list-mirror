From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make builtin-tag.c use parse_options.
Date: Fri, 09 Nov 2007 14:42:56 +0100
Message-ID: <473463E0.7000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 14:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqU91-0007mT-JB
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759501AbXKINnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759830AbXKINnR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:43:17 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:18385 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758614AbXKINnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:43:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so469319rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=L3MKALJ4J28ODTdgURkGEFT99QKBkU+noaIIap+OQTQ=;
        b=t/X4DU+vvYGFDnYrtmeyiwgP9YV/TFRry2Ja4gqx/LU3QMgAao6IYg4mH/T9J+z0PAXh+a6ZTxY5DzPBax+E5FnGRMjiGYlqn+DXLBvo1I67azhdz599VDfnGaGqtURNr6T2OxJJCVfPZndHHrSU4wVHSkNLrd5Xf3Ly5iY8BMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ZZihEcs3fBbtNtYuJGQInI9E7FvnFcwfqsAffm/D+N76DitLrFCJZC0TjvSLrWa5M9KFccvWrx9+5dMtBVrrgBBXgXbv2TJ804YWimOgrYysjxgQ0sc0tp+3t3vz0m69V7ctle7wG3alocQ5h3/H0kFfQgwMozGtu+aW1tdv/nk=
Received: by 10.141.51.15 with SMTP id d15mr950341rvk.1194615795857;
        Fri, 09 Nov 2007 05:43:15 -0800 (PST)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id c4sm294273nfi.2007.11.09.05.43.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Nov 2007 05:43:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64180>

Also, this removes those tests ensuring that repeated
-m options don't allocate memory more than once, because now
this is done after parsing options, using the last one
when more are given. The same for -F.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

    Applied to "next".
    Comments welcomed.

 builtin-tag.c  |  141 ++++++++++++++++++++++++--------------------------------
 t/t7004-tag.sh |    8 +---
 2 files changed, 61 insertions(+), 88 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 66e5a58..5af1950 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -11,9 +11,15 @@
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
-
-static const char builtin_tag_usage[] =
-  "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]";
+#include "parse-options.h"
+
+static const char * const git_tag_usage[] = {
+	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
+	"git-tag -d <tagname>...",
+	"git-tag [-n [<num>]] -l [<pattern>]",
+	"git-tag -v <tagname>...",
+	NULL
+};

 static char signingkey[1000];

@@ -308,101 +314,74 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf;
 	unsigned char object[20], prev[20];
-	int annotate = 0, sign = 0, force = 0, lines = 0, message = 0;
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
-	int i;
 	struct ref_lock *lock;

+	int annotate = 0, sign = 0, force = 0, lines = 0,
+					delete = 0, verify = 0;
+	char *list = NULL, *msg = NULL, *msgfile = NULL, *keyid = NULL;
+	const char *no_pattern = "NO_PATTERN";
+	struct option options[] = {
+		{ OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
+			PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },
+		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
+				"print n lines of each tag message",
+				PARSE_OPT_OPTARG, NULL, 1 },
+		OPT_BOOLEAN('d', NULL, &delete, "delete tags"),
+		OPT_BOOLEAN('v', NULL, &verify, "verify tags"),
+
+		OPT_GROUP("Tag creation options"),
+		OPT_BOOLEAN('a', NULL, &annotate,
+					"annotated tag, needs a message"),
+		OPT_STRING('m', NULL, &msg, "msg", "message for the tag"),
+		OPT_STRING('F', NULL, &msgfile, "file", "message in a file"),
+		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
+		OPT_STRING('u', NULL, &keyid, "key-id",
+					"use another key to sign the tag"),
+		OPT_BOOLEAN('f', NULL, &force, "replace the tag if exists"),
+		OPT_END()
+	};
+
 	git_config(git_tag_config);
-	strbuf_init(&buf, 0);

-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, options, git_tag_usage, 0);

-		if (arg[0] != '-')
-			break;
-		if (!strcmp(arg, "-a")) {
-			annotate = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-s")) {
-			annotate = 1;
-			sign = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f")) {
-			force = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-n")) {
-			if (i + 1 == argc || *argv[i + 1] == '-')
-				/* no argument */
-				lines = 1;
-			else
-				lines = isdigit(*argv[++i]) ?
-					atoi(argv[i]) : 1;
-			continue;
-		}
-		if (!strcmp(arg, "-m")) {
-			annotate = 1;
-			i++;
-			if (i == argc)
-				die("option -m needs an argument.");
-			if (message)
-				die("only one -F or -m option is allowed.");
-			strbuf_addstr(&buf, argv[i]);
-			message = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-F")) {
-			annotate = 1;
-			i++;
-			if (i == argc)
-				die("option -F needs an argument.");
-			if (message)
-				die("only one -F or -m option is allowed.");
-
-			if (!strcmp(argv[i], "-")) {
+	if (list)
+		return list_tags(list == no_pattern ? NULL : list, lines);
+	if (delete)
+		return for_each_tag_name(argv, delete_tag);
+	if (verify)
+		return for_each_tag_name(argv, verify_tag);
+
+	strbuf_init(&buf, 0);
+	if (msg || msgfile) {
+		if (msg && msgfile)
+			die("only one -F or -m option is allowed.");
+		annotate = 1;
+		if (msg)
+			strbuf_addstr(&buf, msg);
+		else {
+			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
-					die("cannot read %s", argv[i]);
+					die("cannot read %s", msgfile);
 			} else {
-				if (strbuf_read_file(&buf, argv[i], 1024) < 0)
+				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
 					die("could not open or read '%s': %s",
-						argv[i], strerror(errno));
+						msgfile, strerror(errno));
 			}
-			message = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u")) {
-			annotate = 1;
-			sign = 1;
-			i++;
-			if (i == argc)
-				die("option -u needs an argument.");
-			if (strlcpy(signingkey, argv[i], sizeof(signingkey))
-							>= sizeof(signingkey))
-				die("argument to option -u too long");
-			continue;
 		}
-		if (!strcmp(arg, "-l"))
-			return list_tags(argv[i + 1], lines);
-		if (!strcmp(arg, "-d"))
-			return for_each_tag_name(argv + i + 1, delete_tag);
-		if (!strcmp(arg, "-v"))
-			return for_each_tag_name(argv + i + 1, verify_tag);
-		usage(builtin_tag_usage);
 	}

-	if (i == argc) {
+	if (argc == 0) {
 		if (annotate)
-			usage(builtin_tag_usage);
+			usage_with_options(git_tag_usage, options);
 		return list_tags(NULL, lines);
 	}
-	tag = argv[i++];
+	tag = argv[0];

-	object_ref = i < argc ? argv[i] : "HEAD";
-	if (i + 1 < argc)
+	object_ref = argc == 2 ? argv[1] : "HEAD";
+	if (argc > 2)
 		die("too many params");

 	if (get_sha1(object_ref, object))
@@ -419,7 +398,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die("tag '%s' already exists", tag);

 	if (annotate)
-		create_tag(object, tag, &buf, message, sign, object);
+		create_tag(object, tag, &buf, msg || msgfile, sign, object);

 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0d07bc3..4b09d28 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -339,20 +339,14 @@ test_expect_success \
 '

 test_expect_success \
-	'trying to create tags giving many -m or -F options should fail' '
+	'trying to create tags giving both -m or -F options should fail' '
 	echo "message file 1" >msgfile1 &&
 	echo "message file 2" >msgfile2 &&
 	! tag_exists msgtag &&
-	! git-tag -m "message 1" -m "message 2" msgtag &&
-	! tag_exists msgtag &&
-	! git-tag -F msgfile1 -F msgfile2 msgtag &&
-	! tag_exists msgtag &&
 	! git-tag -m "message 1" -F msgfile1 msgtag &&
 	! tag_exists msgtag &&
 	! git-tag -F msgfile1 -m "message 1" msgtag &&
 	! tag_exists msgtag &&
-	! git-tag -F msgfile1 -m "message 1" -F msgfile2 msgtag &&
-	! tag_exists msgtag &&
 	! git-tag -m "message 1" -F msgfile1 -m "message 2" msgtag &&
 	! tag_exists msgtag
 '
-- 
1.5.3.4
