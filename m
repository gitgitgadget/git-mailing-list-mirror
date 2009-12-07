From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Detailed diagnostic when parsing an object name fails.
Date: Mon, 07 Dec 2009 14:46:14 +0100
Message-ID: <vpqvdgizyl5.fsf@bauges.imag.fr>
References: <1259603421-10055-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtywbkc05.fsf@alter.siamese.dyndns.org>
	<vpqiqcrd93l.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 14:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHdxr-0003vU-5T
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 14:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935091AbZLGNtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 08:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935089AbZLGNtK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 08:49:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:51599 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935028AbZLGNtD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 08:49:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nB7DkEKj020525
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Dec 2009 14:46:14 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NHduo-0001Sd-BF; Mon, 07 Dec 2009 14:46:14 +0100
In-Reply-To: <vpqiqcrd93l.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon\, 30 Nov 2009 21\:57\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 Dec 2009 14:46:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134757>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Perhaps the second step would be to teach the machinery to understand a
>> syntax like "<tree-ish>:./<path>" and have it prefix the path to the
>> current subdirectory from the root of the work tree, and with such an
>> enhancement, the suggestion given by this patch would probably change to
>> "Did you mean 'HEAD:./test-lib.sh'?", but that would be a separate
>> topic.
>
> Exactly. I think this HEAD:./relative-path syntax has been discussed
> here already, but I don't remember the outcome of the discussion. If
> it's ever implemented, my patch, modified as you suggest will help
> users to discover the feature ;-).

I gave it a try, and it seems it's not as easy to implement as it
seems.

The main task is to teach get_sha1_with_mode_1(..., prefix, ...) to
notice a ./ in "HEAD:./filename", and to replace it with prefix, which
is easy. The problem is to get "prefix" reliably. Since
get_sha1_with_mode_1 is called by get_sha1, which doesn't know about
prefix, and which is called from at least 92 places in the code, this
would require changing all these calls to add the "prefix" argument
(and to find out where to get this prefix from).

So, I guess I'll give up :-(. (unless someone either show a great
motivation for the feature, or a magic formula to make the patch
short)

FYI, here's the toy patch I started (works for "git show HEAD:./file",
but not for "git rev-parse HEAD:./file" for example):

diff --git a/cache.h b/cache.h
index c122bfa..a44f06f 100644
--- a/cache.h
+++ b/cache.h
@@ -708,10 +708,10 @@ static inline unsigned int hexval(unsigned char c)
 #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
-extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
-static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
+extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, const char *prefix, int gently);
+static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode, const char *prefix)
 {
-	return get_sha1_with_mode_1(str, sha1, mode, 1, NULL);
+	return get_sha1_with_mode_1(str, sha1, mode, prefix, 1);
 }
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
diff --git a/revision.c b/revision.c
index 25fa14d..19ddb21 100644
--- a/revision.c
+++ b/revision.c
@@ -944,7 +944,7 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		local_flags = UNINTERESTING;
 		arg++;
 	}
-	if (get_sha1_with_mode(arg, sha1, &mode))
+	if (get_sha1_with_mode(arg, sha1, &mode, revs->prefix))
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
@@ -1419,7 +1419,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(revs->def, sha1, &mode))
+		if (get_sha1_with_mode(revs->def, sha1, &mode, revs->prefix))
 			die("bad default revision '%s'", revs->def);
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, mode);
diff --git a/setup.c b/setup.c
index 5792eb7..60c1e08 100644
--- a/setup.c
+++ b/setup.c
@@ -79,7 +79,7 @@ static void NORETURN die_verify_filename(const char *prefix, const char *arg)
 	unsigned char sha1[20];
 	unsigned mode;
 	/* try a detailed diagnostic ... */
-	get_sha1_with_mode_1(arg, sha1, &mode, 0, prefix);
+	get_sha1_with_mode_1(arg, sha1, &mode, prefix, 0);
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
 	    "Use '--' to separate paths from revisions", arg);
diff --git a/sha1_name.c b/sha1_name.c
index ca8f9db..330d3fe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -801,7 +801,7 @@ release_return:
 int get_sha1(const char *name, unsigned char *sha1)
 {
 	unsigned unused;
-	return get_sha1_with_mode(name, sha1, &unused);
+	return get_sha1_with_mode(name, sha1, &unused, NULL);
 }
 
 /* Must be called only when object_name:filename doesn't exist. */
@@ -893,7 +893,7 @@ static void diagnose_invalid_index_path(int stage,
 }
 
 
-int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, int gently, const char *prefix)
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode, const char *prefix, int gently)
 {
 	int ret, bracket_depth;
 	int namelen = strlen(name);
@@ -961,11 +961,26 @@ int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 		}
 		if (!get_sha1_1(name, cp-name, tree_sha1)) {
 			const char *filename = cp+1;
-			ret = get_tree_entry(tree_sha1, filename, sha1, mode);
-			if (!gently) {
-				diagnose_invalid_sha1_path(prefix, filename,
-							   tree_sha1, object_name);
-				free(object_name);
+			if (filename[0] == '.' && filename[1] == '/') {
+				if (!prefix)
+					prefix = "";
+				char *absfilename = xmalloc((strlen(filename) - 2)
+							    + strlen(prefix) + 1);
+				strcpy(absfilename, prefix);
+				strcat(absfilename, filename+2);
+				ret = get_tree_entry(tree_sha1, absfilename, sha1, mode);
+				if (!gently) {
+					diagnose_invalid_sha1_path(prefix, absfilename,
+								   tree_sha1, object_name);
+					free(object_name);
+				}
+			} else {
+				ret = get_tree_entry(tree_sha1, filename, sha1, mode);
+				if (!gently) {
+					diagnose_invalid_sha1_path(prefix, filename,
+								   tree_sha1, object_name);
+					free(object_name);
+				}
 			}
 			return ret;
 		} else {


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
