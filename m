From: Brian Ewins <brian.ewins@gmail.com>
Subject: [PATCH v2 1/2] Add a --dry-run option to git-send-pack.
Date: Thu, 11 Oct 2007 20:32:26 +0100
Message-ID: <119213114734-git-send-email-Brian.Ewins@gmail.com>
References: <8c5c35580710110057r29c1fe0w7f9e2825fa33@mail.gmail.com>
Cc: hjemli@gmail.com, gitster@pobox.com,
	Brian Ewins <Brian.Ewins@gmail.com>,
	Brian Ewins <brian.ewins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 21:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3lr-00076d-TR
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 21:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbXJKTc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 15:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756948AbXJKTcZ
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 15:32:25 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:7608 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbXJKTcX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 15:32:23 -0400
Received: by hu-out-0506.google.com with SMTP id 19so333719hue
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:message-id:from;
        bh=7XqQj8Zz/X+J5KgNLnfXagRQMTeCCnbHHt/lahQXdt4=;
        b=azsblqOE5KTmaQn1RoJOBnHhfXQ4LhNl6sqWWwXQlgqChf1IAzkyFKoWeev28soCplbTjGD4s1DOFBil5e/RqaLvRRbVvwxfhgvzw6OhwReCl2X+8aSSnwE/1E22MrSjU8ZLTUASACI3uWCxvJOsPVKEv65IbnKr+3cF2Qvnd/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=uNG9ZIkn01ng74MbXbUluxEvbA8Q6cXS5GaoeAKyvAHV5OkQoQeMdj6RiDfbyo77Rylu4FG/MIiWXJODR0Xr64CKGtzoa3lGbrDNVGc4tgleAI8vJoBuxZidUAt446rwgHr+22WfW3QFaBV1k+o84b6MFJb19XDZLorncNZs08M=
Received: by 10.78.200.20 with SMTP id x20mr1787718huf.1192131140848;
        Thu, 11 Oct 2007 12:32:20 -0700 (PDT)
Received: from localhost ( [86.0.198.221])
        by mx.google.com with ESMTPS id f8sm2632943nfh.2007.10.11.12.32.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2007 12:32:19 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <8c5c35580710110057r29c1fe0w7f9e2825fa33@mail.gmail.com>
Message-Id: <16913589bee1374245d8b8f7333ab3984b56ffcb.1192130892.git.Brian.Ewins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Implement support for --dry-run, so that it can be used
in calls from git-push. With this flag set, git-send-pack
will not send any updates to the server.

Signed-off-by: Brian Ewins <brian.ewins@gmail.com>
---
 Documentation/git-send-pack.txt |    5 ++++-
 send-pack.c                     |   31 +++++++++++++++++++------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 3271e88..2fa01d4 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,7 +8,7 @@ git-send-pack - Push objects over git protocol to another repository
 
 SYNOPSIS
 --------
-'git-send-pack' [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git-send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,9 @@ OPTIONS
 	Instead of explicitly specifying which refs to update,
 	update all heads that locally exist.
 
+\--dry-run::
+	Do everything except actually send the updates.
+
 \--force::
 	Usually, the command refuses to update a remote ref that
 	is not an ancestor of the local ref used to overwrite it.
diff --git a/send-pack.c b/send-pack.c
index f74e66a..16ed51f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -7,13 +7,14 @@
 #include "remote.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 static const char *receivepack = "git-receive-pack";
 static int verbose;
 static int send_all;
 static int force_update;
 static int use_thin_pack;
+static int dry_run;
 
 /*
  * Make a pack stream and spit it out into file descriptor fd
@@ -282,16 +283,18 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 
-		if (ask_for_status_report) {
-			packet_write(out, "%s %s %s%c%s",
-				     old_hex, new_hex, ref->name, 0,
-				     "report-status");
-			ask_for_status_report = 0;
-			expect_status_report = 1;
+		if (!dry_run) {
+			if (ask_for_status_report) {
+				packet_write(out, "%s %s %s%c%s",
+					old_hex, new_hex, ref->name, 0,
+					"report-status");
+				ask_for_status_report = 0;
+				expect_status_report = 1;
+			}
+			else
+				packet_write(out, "%s %s %s",
+					old_hex, new_hex, ref->name);
 		}
-		else
-			packet_write(out, "%s %s %s",
-				     old_hex, new_hex, ref->name);
 		if (will_delete_ref)
 			fprintf(stderr, "deleting '%s'\n", ref->name);
 		else {
@@ -302,7 +305,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
-		if (remote) {
+		if (remote && !dry_run) {
 			struct refspec rs;
 			rs.src = ref->name;
 			rs.dst = NULL;
@@ -321,7 +324,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	}
 
 	packet_flush(out);
-	if (new_refs)
+	if (new_refs && !dry_run)
 		ret = pack_objects(out, remote_refs);
 	close(out);
 
@@ -390,6 +393,10 @@ int main(int argc, char **argv)
 				send_all = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--dry-run")) {
+				dry_run = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--force")) {
 				force_update = 1;
 				continue;
-- 
1.5.2.5
