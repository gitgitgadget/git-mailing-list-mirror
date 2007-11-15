From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Extend cat-file to take multiple arguments or read input
 from stdin.
Date: Thu, 15 Nov 2007 02:22:25 -0200
Message-ID: <fhghqv$98a$1@ger.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 05:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWKl-0008IW-Jg
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbXKOE1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbXKOE1n
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:27:43 -0500
Received: from main.gmane.org ([80.91.229.2]:50006 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbXKOE1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:27:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IsWK7-0000nj-04
	for git@vger.kernel.org; Thu, 15 Nov 2007 04:27:27 +0000
Received: from c911de8c.bhz.virtua.com.br ([201.17.222.140])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 04:27:26 +0000
Received: from hanwen by c911de8c.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 04:27:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c911de8c.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.6 (X11/20070926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65053>


With this patch, cat-file can be invoked either on an arbitrary number
of objects, eg.

  git cat-file commit HEAD HEAD^^^

the object names can also be supplied on stdin, like so

  echo  -e 'HEAD\nHEAD^^^' | git cat-file commit -

With this functionality, the entire object database can be dumped with
a limited number of processes: two cat-file processes for discovering size and
type, and one cat-file process per type.

Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
---
 builtin-cat-file.c |   63 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index f132d58..57e2111 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -76,31 +76,17 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 		write_or_die(1, cp, endp - cp);
 }
 
-int cmd_cat_file(int argc, const char **argv, const char *prefix)
+
+int cat_one_file (const char *obj_name, int opt, const char *exp_type)
 {
 	unsigned char sha1[20];
-	enum object_type type;
 	void *buf;
 	unsigned long size;
-	int opt;
-	const char *exp_type, *obj_name;
-
-	git_config(git_default_config);
-	if (argc != 3)
-		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	exp_type = argv[1];
-	obj_name = argv[2];
+	enum object_type type;
 
 	if (get_sha1(obj_name, sha1))
 		die("Not a valid object name %s", obj_name);
 
-	opt = 0;
-	if ( exp_type[0] == '-' ) {
-		opt = exp_type[1];
-		if ( !opt || exp_type[2] )
-			opt = -1; /* Not a single character option */
-	}
-
 	buf = NULL;
 	switch (opt) {
 	case 't':
@@ -157,3 +143,46 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	write_or_die(1, buf, size);
 	return 0;
 }
+
+int cmd_cat_file(int argc, const char **argv, const char *prefix)
+{
+	int opt = 0;
+	const char *exp_type;
+	int all_exists = 1;
+	struct strbuf buf;
+
+	git_config(git_default_config);
+	if (argc < 3)
+		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1> ... ");
+	exp_type = argv[1];
+
+	if ( exp_type[0] == '-' ) {
+		opt = exp_type[1];
+		if ( !opt || exp_type[2] )
+			opt = -1; /* Not a single character option */
+	}
+
+	argv += 2;
+	strbuf_init(&buf, 0);
+	do {
+		const char *arg = NULL;
+		if (argv[0] == NULL)
+			break;
+		if (strcmp(argv[0], "-")) {
+			arg = *argv;
+			argv++;
+		} else {
+			if (strbuf_getline(&buf, stdin, '\n') == EOF)
+				break;
+			arg = buf.buf;
+		}
+		int not_exists_one = cat_one_file(arg, opt, exp_type);
+		if (opt == 'e')
+			all_exists = all_exists && !not_exists_one;
+		if (not_exists_one)
+			break;
+	} while (1);
+	strbuf_release(&buf);
+	return !all_exists;
+}
+
-- 
1.5.3.4


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
