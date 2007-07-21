From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] builtin-tag.c: Fix two memory leaks and minor notation changes.
Date: Sat, 21 Jul 2007 14:13:12 +0200
Message-ID: <46A1F858.7080405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 14:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICDq2-0002w1-Dc
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 14:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762354AbXGUMNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 08:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762340AbXGUMNX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 08:13:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:20125 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759344AbXGUMNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 08:13:22 -0400
Received: by ug-out-1314.google.com with SMTP id j3so778576ugf
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 05:13:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=IpsuPnBhyND6O/r6AQuEGbBw/LCaYKTdSQRvJ0GgGZzA0Q5rLgpIbGG8kt1XZ4huOyaoeBUdSaqDb22YKb0oZnYKRF4kOmotA+C7hZ5V8X6LghM4nAMVBoegZciZwxzDpb3GT0Y3P0x1QU3N2bXmwW8hU+vgYzldiunuUW9S1rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=pd3mN7x8m5EJseoTh7GGqzo+5Ucti9QM7xlCxVjMPcL//J5/sO48p4QSS27/Y6mrmQwe05BHsY2QvGnVaJAz2cTE/Lh3g1ZPDwfdK1yl3B06FKVNDq/su0ryI2xYA8E0DVqfHzoeElZoFl2dNSbuNyyJFgFY/SqNR6DFy8olO1Q=
Received: by 10.86.74.15 with SMTP id w15mr1043953fga.1185020000740;
        Sat, 21 Jul 2007 05:13:20 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id k5sm4207256nfd.2007.07.21.05.13.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jul 2007 05:13:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53158>

A repeated call to read_sha1_file was not freing memory
when the buffer was allocated but returned size was zero.

Also, now the program does not allow many -F or -m options,
which was a bug too because it was not freing the memory
allocated for any previous -F or -m options.

Tests are provided for ensuring that only one option
-F or -m is given. Also, another test is shipped here,
to check that "git tag" fails when a non-existing file
is passed to the -F option, something that git-tag.sh
allowed creating the tag with an empty message.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

  Those were commented in the responses to my previous patch:
  http://article.gmane.org/gmane.comp.version-control.git/53138

  I committed them on top of that my other patch already in "next".
  Unfortunately, I was not able to commit before the patches
  from Johannes supporting the EDITOR environment variable
  in builtin-tag.c and fixing its bug with a non-initialized buffer.

 builtin-tag.c  |   38 ++++++++++++++++++++++----------------
 t/t7004-tag.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 507f510..9231d72 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -85,14 +85,19 @@ static int show_reference(const char *refname, const unsigned char *sha1,
 		printf("%-15s ", refname);

 		sp = buf = read_sha1_file(sha1, &type, &size);
-		if (!buf || !size)
+		if (!buf)
 			return 0;
+		if (!size) {
+			free(buf);
+			return 0;
+		}
 		/* skip header */
 		while (sp + 1 < buf + size &&
 				!(sp[0] == '\n' && sp[1] == '\n'))
 			sp++;
 		/* only take up to "lines" lines, and strip the signature */
-		for (i = 0, sp += 2; i < filter->lines && sp < buf + size &&
+		for (i = 0, sp += 2;
+				i < filter->lines && sp < buf + size &&
 				prefixcmp(sp, PGP_SIGNATURE "\n");
 				i++) {
 			if (i)
@@ -133,10 +138,10 @@ static int list_tags(const char *pattern, int lines)
 	return 0;
 }

-typedef int (*func_tag)(const char *name, const char *ref,
+typedef int (*each_tag_name_fn)(const char *name, const char *ref,
 				const unsigned char *sha1);

-static int do_tag_names(const char **argv, func_tag fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 {
 	const char **p;
 	char ref[PATH_MAX];
@@ -191,7 +196,7 @@ static ssize_t do_sign(char *buffer, size_t size, size_t max)

 	if (!*signingkey) {
 		if (strlcpy(signingkey, git_committer_info(1),
-				sizeof(signingkey)) >= sizeof(signingkey))
+				sizeof(signingkey)) > sizeof(signingkey) - 1)
 			return error("committer info too long.");
 		bracket = strchr(signingkey, '>');
 		if (bracket)
@@ -254,7 +259,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	unsigned long size;

 	type = sha1_object_info(object, NULL);
-	if (type <= 0)
+	if (type <= OBJ_NONE)
 	    die("bad object type.");

 	header_len = snprintf(header_buf, sizeof(header_buf),
@@ -267,7 +272,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 			  tag,
 			  git_committer_info(1));

-	if (header_len >= sizeof(header_buf))
+	if (header_len > sizeof(header_buf) - 1)
 		die("tag header too big.");

 	if (!message) {
@@ -362,6 +367,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			i++;
 			if (i == argc)
 				die("option -m needs an argument.");
+			if (message)
+				die("only one -F or -m option is allowed.");
 			message = xstrdup(argv[i]);
 			continue;
 		}
@@ -373,6 +380,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			i++;
 			if (i == argc)
 				die("option -F needs an argument.");
+			if (message)
+				die("only one -F or -m option is allowed.");

 			if (!strcmp(argv[i], "-"))
 				fd = 0;
@@ -401,15 +410,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 				die("argument to option -u too long");
 			continue;
 		}
-		if (!strcmp(arg, "-l")) {
+		if (!strcmp(arg, "-l"))
 			return list_tags(argv[i + 1], lines);
-		}
-		if (!strcmp(arg, "-d")) {
-			return do_tag_names(argv + i + 1, delete_tag);
-		}
-		if (!strcmp(arg, "-v")) {
-			return do_tag_names(argv + i + 1, verify_tag);
-		}
+		if (!strcmp(arg, "-d"))
+			return for_each_tag_name(argv + i + 1, delete_tag);
+		if (!strcmp(arg, "-v"))
+			return for_each_tag_name(argv + i + 1, verify_tag);
 		usage(builtin_tag_usage);
 	}

@@ -427,7 +433,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (get_sha1(object_ref, object))
 		die("Failed to resolve '%s' as a valid ref.", object_ref);

-	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) >= sizeof(ref))
+	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1)
 		die("tag name too long: %.*s...", 50, tag);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid tag name.", tag);
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index a0be164..c4fa446 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -332,6 +332,33 @@ test_expect_success 'creating an annotated tag with -F - should succeed' '
 	git diff expect actual
 '

+test_expect_success \
+	'trying to create a tag with a non-existing -F file should fail' '
+	! test -f nonexistingfile &&
+	! tag_exists notag &&
+	! git-tag -F nonexistingfile notag &&
+	! tag_exists notag
+'
+
+test_expect_success \
+	'trying to create tags giving many -m or -F options should fail' '
+	echo "message file 1" >msgfile1 &&
+	echo "message file 2" >msgfile2 &&
+	! tag_exists msgtag &&
+	! git-tag -m "message 1" -m "message 2" msgtag &&
+	! tag_exists msgtag &&
+	! git-tag -F msgfile1 -F msgfile2 msgtag &&
+	! tag_exists msgtag &&
+	! git-tag -m "message 1" -F msgfile1 msgtag &&
+	! tag_exists msgtag &&
+	! git-tag -F msgfile1 -m "message 1" msgtag &&
+	! tag_exists msgtag &&
+	! git-tag -F msgfile1 -m "message 1" -F msgfile2 msgtag &&
+	! tag_exists msgtag &&
+	! git-tag -m "message 1" -F msgfile1 -m "message 2" msgtag &&
+	! tag_exists msgtag
+'
+
 # blank and empty messages:

 get_tag_header empty-annotated-tag $commit commit $time >expect
@@ -648,6 +675,14 @@ test_expect_success 'creating a signed tag with -F - should succeed' '
 	git diff expect actual
 '

+test_expect_success \
+	'trying to create a signed tag with non-existing -F file should fail' '
+	! test -f nonexistingfile &&
+	! tag_exists nosigtag &&
+	! git-tag -s -F nonexistingfile nosigtag &&
+	! tag_exists nosigtag
+'
+
 test_expect_success 'verifying a signed tag should succeed' \
 	'git-tag -v signed-tag'

-- 
1.5.0
