From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: What's in git.git (Mar 2009, #02; Thu, 05)
Date: Sat, 07 Mar 2009 20:14:12 +0100
Message-ID: <49B2C784.90800@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, carlos.duclos@nokia.com
X-From: git-owner@vger.kernel.org Sat Mar 07 20:15:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg1zx-0007jA-9c
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbZCGTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbZCGTOU
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:14:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:40855 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZCGTOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 14:14:19 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 112E02F8057;
	Sat,  7 Mar 2009 20:14:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112564>

Junio C Hamano schrieb:
> * The 'master' branch has these since v1.6.2 in addition to the above.
> 
> Carlos Manuel Duclos Vergara (1):
>   git-archive: add --output=<file> to send output to a file

It just hit me that this is option can be used for a DoS attack (or
perhaps worse) when used in connection with --remote.  We need to apply
it on the client side instead of sending it to the remote end.  And
git-upload-archive needs to filter it out.  Ugh.

Here's a quick and dirty patch to do the latter.

---
 archive.c |   14 +++++++++-----
 archive.h |    2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/archive.c b/archive.c
index c6aea83..c7534d7 100644
--- a/archive.c
+++ b/archive.c
@@ -260,7 +260,8 @@ static void create_output_file(const char *output_file)
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
 
 static int parse_archive_args(int argc, const char **argv,
-		const struct archiver **ar, struct archiver_args *args)
+			      const struct archiver **ar,
+			      struct archiver_args *args, int local)
 {
 	const char *format = "tar";
 	const char *base = NULL;
@@ -310,8 +311,11 @@ static int parse_archive_args(int argc, const char **argv,
 	if (!base)
 		base = "";
 
-	if (output)
+	if (output) {
+		if (!local)
+			die("Unexpected option --output");
 		create_output_file(output);
+	}
 
 	if (list) {
 		for (i = 0; i < ARRAY_SIZE(archivers); i++)
@@ -343,13 +347,13 @@ static int parse_archive_args(int argc, const char **argv,
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
-		int setup_prefix)
+		int local)
 {
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
 
-	argc = parse_archive_args(argc, argv, &ar, &args);
-	if (setup_prefix && prefix == NULL)
+	argc = parse_archive_args(argc, argv, &ar, &args, local);
+	if (local && prefix == NULL)
 		prefix = setup_git_directory();
 
 	parse_treeish_arg(argv, &args, prefix);
diff --git a/archive.h b/archive.h
index 0b15b35..f6c3c89 100644
--- a/archive.h
+++ b/archive.h
@@ -24,6 +24,6 @@ extern int write_tar_archive(struct archiver_args *);
 extern int write_zip_archive(struct archiver_args *);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
+extern int write_archive(int argc, const char **argv, const char *prefix, int local);
 
 #endif	/* ARCHIVE_H */
-- 
1.6.2
