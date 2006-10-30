X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/2] git push: add verbose flag and allow overriding of
 default target repository
Date: Mon, 30 Oct 2006 08:28:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610300825470.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 30 Oct 2006 16:36:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30503>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gea0e-00067y-W8 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 17:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932135AbWJ3Q3J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 11:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWJ3Q3J
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 11:29:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40106 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S932135AbWJ3Q3I (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 11:29:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9UGT0Po007034
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 30
 Oct 2006 08:29:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9UGSx1n026257; Mon, 30 Oct
 2006 08:28:59 -0800
To: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org


This adds a command line flag "-v" to enable a more verbose mode, and 
"--repo=" to override the default target repository for "git push" (which 
otherwise always defaults to "origin").

This, together with the patch to allow dashes in config variable names, 
allows me to do

	[alias]
		push-all = push -v --repo=all

in my user-global config file, and then I can (for any project I maintain) 
add to the project-local config file

	[remote "all"]
		url=one.target.repo:/directory
		url=another.target:/pub/somewhere/else

and now "git push-all" just updates all the target repositories, and shows 
me what it does - regardless of which repo I am in.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

Maybe this is just useful to me? I dunno. I have long had a per-repository 
"push-all" script that I have in the root directory of the repos I 
maintain, but this is much more practical. With this, I can do things like

	git push-all --tags

and it will push all the new tags to all the public repositories I 
maintain for that particular repository.

Special Linus-only behaviour? Maybe. On the other hand, I think this is a 
pretty clean patch regardless.

diff --git a/builtin-push.c b/builtin-push.c
index f5150ed..3151fb7 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 
 static const char push_usage[] = "git-push [--all] [--tags] [-f | --force] <repository> [<refspec>...]";
 
-static int all, tags, force, thin = 1;
+static int all, tags, force, thin = 1, verbose;
 static const char *execute;
 
 #define BUF_SIZE (2084)
@@ -248,6 +248,8 @@ static int do_push(const char *repo)
 		while (dest_refspec_nr--)
 			argv[dest_argc++] = *dest_refspec++;
 		argv[dest_argc] = NULL;
+		if (verbose)
+			fprintf(stderr, "Pushing to %s\n", dest);
 		err = run_command_v(argc, argv);
 		if (!err)
 			continue;
@@ -281,6 +283,14 @@ int cmd_push(int argc, const char **argv
 			i++;
 			break;
 		}
+		if (!strcmp(arg, "-v")) {
+			verbose=1;
+			continue;
+		}
+		if (!strncmp(arg, "--repo=", 7)) {
+			repo = arg+7;
+			continue;
+		}
 		if (!strcmp(arg, "--all")) {
 			all = 1;
