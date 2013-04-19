From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Fri, 19 Apr 2013 15:23:37 +0530
Message-ID: <1366365217-17674-1-git-send-email-artagnon@gmail.com>
References: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 11:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT7zN-0005w8-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 11:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967994Ab3DSJwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 05:52:13 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33376 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967950Ab3DSJwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 05:52:12 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so2191626pad.31
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7G8pLVYfiLpm1rLTnNFFgsIztBWOjRjA9LDBrgu1AEA=;
        b=UwttwLy4Wd6LIVBnAdrIHezauxQcklOZU91pPGThwog6q2/4djcBrpgYzrAuO7Y8sg
         Fvn1GaBjk6IIo7yABSVqx+eSp6Y71C+fEHstVt0JonNuMo5nmBqboo3RyanQkReL66IA
         rykAwi42SjoDNAxmb2mbWgjVlcl8p8SGuITsElvgt+2c3XDyribPf+ulZcX4cSoM2QK3
         QKeDup8B8sj+cHaVYUYV20sXfGvujVIPARqUd5QPekSc8LFvTRbaz56DEshxU4cFAfgS
         tqFcSApMehKMBo9Dyne6WEgRn1DRX+TIh2l2YWTrzHaj7v7YAtZJOJnY11oYYlNYi5k2
         Htiw==
X-Received: by 10.68.17.39 with SMTP id l7mr18505278pbd.18.1366365131808;
        Fri, 19 Apr 2013 02:52:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id iy2sm12869145pbb.31.2013.04.19.02.52.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 02:52:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.423.g9a53c75.dirty
In-Reply-To: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221753>

John Keeping wrote:
> Changes since v2:
>     - Rewrite commit message
>     - Add a new test for 'prefix ignored with HEAD:top'
>     - Use '<<-\EOF' where appropriate in t1513

Thanks for the re-roll.

In the previous iteration, I wasn't sure this was the right approach
because I thought it would be better to pass RUN_SETUP and let
run_builtin_command() take care of the prefix-setting.  Unfortunately,
as 5410a02 (git-rev-parse --parseopt, 2007-11-06) indicates, we have
to run setup_git_directory() in cmd_rev_parse() after parsing
--parseopt, as 'git rev-parse --parseopt' can be run outside a git
repository.  You might want to include this note in your commit
message for the benefit of other readers.

Other than that, I just have one small suggestion: it's possible to
avoid passing output_prefix around, and simplify show_file() a bit if
we acknowledge that printing "--" is not the same as printing a file
(although the condition is the same).  Would you like to squash this
in?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
-- 8< --
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index de894c7..7e69b3f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -29,6 +29,7 @@ static int abbrev;
 static int abbrev_ref;
 static int abbrev_ref_strict;
 static int output_sq;
+static int output_prefix;
 
 /*
  * Some arguments are relevant "revision" arguments,
@@ -212,15 +213,13 @@ static void show_datestring(const char *flag, const char *datestr)
 	show(buffer);
 }
 
-static int show_file(const char *arg, int output_prefix)
+static int show_file(const char *arg)
 {
 	show_default();
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
 		if (output_prefix) {
 			const char *prefix = startup_info->prefix;
-			show(prefix_filename(prefix,
-					     prefix ? strlen(prefix) : 0,
-					     arg));
+			show(prefix_filename(prefix, strlen(prefix), arg));
 		} else
 			show(arg);
 		return 1;
@@ -228,6 +227,16 @@ static int show_file(const char *arg, int output_prefix)
 	return 0;
 }
 
+static int show_dashdash()
+{
+	show_default();
+	if ((filter & (DO_NONFLAGS | DO_NOREV)) == (DO_NONFLAGS | DO_NOREV)) {
+		show("--");
+		return 1;
+	}
+	return 0;
+}
+
 static int try_difference(const char *arg)
 {
 	char *dotdot;
@@ -476,7 +485,6 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
-	int output_prefix = 0;
 	unsigned char sha1[20];
 	const char *name = NULL;
 
@@ -510,7 +518,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (as_is) {
-			if (show_file(arg, output_prefix) && as_is < 2)
+			if (show_file(arg) && as_is < 2)
 				verify_filename(prefix, arg, 0);
 			continue;
 		}
@@ -534,7 +542,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				as_is = 2;
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
-					show_file(arg, 0);
+					show_dashdash();
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
@@ -543,7 +551,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--prefix")) {
-				prefix = argv[i+1];
+				prefix = argv[i + 1];
 				startup_info->prefix = prefix;
 				output_prefix = 1;
 				i++;
@@ -768,7 +776,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		if (verify)
 			die_no_single_rev(quiet);
 		as_is = 1;
-		if (!show_file(arg, output_prefix))
+		if (!show_file(arg))
 			continue;
 		verify_filename(prefix, arg, 1);
 	}
