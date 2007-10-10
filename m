From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-rev-parse --verify could be friendlier
Date: Wed, 10 Oct 2007 18:37:22 +0200
Message-ID: <vpq3awj0vul.fsf@bauges.imag.fr>
References: <20071010142417.8892.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Wed Oct 10 18:38:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfeZc-0003uk-Lg
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 18:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbXJJQhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 12:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbXJJQhw
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 12:37:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:55767 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812AbXJJQhv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 12:37:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9AGbMqe011802
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Oct 2007 18:37:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IfeYk-0002Si-5i; Wed, 10 Oct 2007 18:37:22 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IfeYk-0006ap-3S; Wed, 10 Oct 2007 18:37:22 +0200
In-Reply-To: <20071010142417.8892.qmail@science.horizon.com> (linux@horizon.com's message of "10 Oct 2007 10\:24\:17 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 10 Oct 2007 18:37:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60518>

linux@horizon.com writes:

> Something like the following would certainly help, but perhaps git-rev-parse
> could be slightly more forthcoming, too?

I think this should be fixed in git-rev-parse itself, yes.

Following is an attempt to make the message better. It still has at
least the following problems (which are already in today's git):

* Duplicate error message when the revision is ambiguous.

* No distinction between syntactically incorrect revisions
  (impossible~branchname for example), and inexisting revision
  (a34b6c, if there's no such revision).

What would be really cool is to extend this to have a fine-granularity
error number returned by get_sha1 and friends.


>From f033ba755e6bc46dcd0f5767699458bacb840587 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Wed, 10 Oct 2007 18:15:39 +0200
Subject: [PATCH] Better error message for git-rev-parse.

The existing error message is "Needed a single revision", which is
inacurate if the revision provided is syntactically incorrect or
inexistant.
---
 builtin-rev-parse.c |   20 ++++++++++++++++----
 cache.h             |    3 +++
 sha1_name.c         |    5 +----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 8d78b69..d2145f1 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -213,6 +213,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
+	const char *error_param;
+	int err_no = 0;
 
 	git_config(git_default_config);
 
@@ -249,6 +251,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[i+1];
+				error_param = def;
 				i++;
 				continue;
 			}
@@ -390,16 +393,20 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		error_param = arg;
 		/* Not a flag argument */
 		if (try_difference(arg))
 			continue;
-		if (!get_sha1(arg, sha1)) {
+		if (!(err_no = get_sha1(arg, sha1))) {
 			show_rev(NORMAL, sha1, arg);
 			continue;
 		}
-		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
-			show_rev(REVERSED, sha1, arg+1);
-			continue;
+		if (*arg == '^') {
+			error_param = arg+1;
+			if (!(err_no = get_sha1(arg+1, sha1))) {
+				show_rev(REVERSED, sha1, arg+1);
+				continue;
+			}
 		}
 		as_is = 1;
 		if (!show_file(arg))
@@ -409,6 +416,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		verify_filename(prefix, arg);
 	}
 	show_default();
+	if (verify && revs_count == 0)
+		if (err_no == SHORT_NAME_AMBIGUOUS)
+			die("%s: Ambiguous revision", error_param);
+		else
+			die("%s: No such revision", error_param);
 	if (verify && revs_count != 1)
 		die("Needed a single revision");
 	return 0;
diff --git a/cache.h b/cache.h
index e0abcd6..a537afa 100644
--- a/cache.h
+++ b/cache.h
@@ -399,6 +399,9 @@ static inline unsigned int hexval(unsigned char c)
 #define MINIMUM_ABBREV 4
 #define DEFAULT_ABBREV 7
 
+#define SHORT_NAME_NOT_FOUND (-1)
+#define SHORT_NAME_AMBIGUOUS (-2)
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index 2d727d5..5091420 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -127,9 +127,6 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 	return found;
 }
 
-#define SHORT_NAME_NOT_FOUND (-1)
-#define SHORT_NAME_AMBIGUOUS (-2)
-
 static int find_unique_short_object(int len, char *canonical,
 				    unsigned char *res, unsigned char *sha1)
 {
@@ -186,7 +183,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 
 	status = find_unique_short_object(i, canonical, res, sha1);
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %.*s is ambiguous.", len, canonical);
+		error("short SHA1 %.*s is ambiguous.", len, canonical);
 	return status;
 }
 
-- 
1.5.3.4.205.g52b6c



-- 
Matthieu
