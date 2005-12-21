From: Linus Torvalds <torvalds@osdl.org>
Subject: Make "git-send-pack" less verbose by default
Date: Tue, 20 Dec 2005 18:13:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201809210.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Dec 21 03:13:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EotTv-0006ra-MR
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 03:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVLUCN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 21:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVLUCN2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 21:13:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932257AbVLUCN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2005 21:13:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBL2D3DZ012407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Dec 2005 18:13:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBL2D20j008079;
	Tue, 20 Dec 2005 18:13:03 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.16 required=5 tests=HTML_MESSAGE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13860>


It used to make sense to have git-send-pack talk about the things it sent 
when (a) it was a new program and (b) nobody had a lot of tags and 
branches.

These days, it's just distracting to see tons of

	'refs/tags/xyz': up-to-date
	...

when updating a remote repo.

So shut it up by default, and add a "--verbose" flag for those who really 
want to see it.

Also, since this makes he case of everything being up-to-date just totally 
silent, make it say "Everything up-to-date" if no refs needed updating.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/send-pack.c b/send-pack.c
index 6ce0d9f..a41bbe5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -8,6 +8,7 @@ static const char send_pack_usage[] =
 "git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
 "  --all and explicit <head> specification are mutually exclusive.";
 static const char *exec = "git-receive-pack";
+static int verbose = 0;
 static int send_all = 0;
 static int force_update = 0;
 
@@ -206,7 +207,8 @@ static int send_pack(int in, int out, in
 		if (!ref->peer_ref)
 			continue;
 		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
-			fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			if (verbose)
+				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
 		}
 
@@ -270,6 +272,8 @@ static int send_pack(int in, int out, in
 	packet_flush(out);
 	if (new_refs)
 		pack_objects(out, remote_refs);
+	else
+		fprintf(stderr, "Everything up-to-date\n");
 	close(out);
 	return ret;
 }
@@ -301,6 +305,10 @@ int main(int argc, char **argv)
 				force_update = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--verbose")) {
+				verbose = 1;
+				continue;
+			}
 			usage(send_pack_usage);
 		}
 		if (!dest) {
