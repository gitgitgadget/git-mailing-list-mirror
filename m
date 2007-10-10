From: Brian Ewins <brian.ewins@gmail.com>
Subject: [PATCH 1/2] Add a --dry-run option to git-send-pack.
Date: Thu, 11 Oct 2007 00:34:43 +0100
Message-ID: <0D259CA7-819C-4479-BBC6-232790C055D2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 01:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifl4m-0007DR-AX
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbXJJXek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756916AbXJJXej
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:34:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:1422 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901AbXJJXei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:34:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so370749ugc
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        bh=+yTJyD8M/qIWhRADoSlt0C6kv/rdOwwzGAwVQpp9gfI=;
        b=fzEOHi7kmsQJXPHppjaBaVxGqaKHdowjhY3xEwsCTkeNf7P5GY9wkYM9JsXu9iv2sEbQWbZcWuTXXsBup6hFaFd46BKVW0znwIA8Ijpw5sGgO/T6JGJCgPz4NVvXJd8D3y3nbu7zDQfh43U2seh+r7If/mARECIDLCFc0oUjwJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:subject:date:to:x-mailer:from;
        b=eHbJdROVbKd4UYbsfilM80GRBqW9wVNnHKKZu81qY1gCsHYLG4MDUKUvBC76UZuvHBH8EsmQYsks60frj37UxnrJS8olnmLBS6wHeqy5a31Xd7dq3VzsG3R8l8w/Xu1liJDo+g1rCA2zvZ6XlUREwciFZgKfzNkoLqnPq+rgmNI=
Received: by 10.66.238.16 with SMTP id l16mr595757ugh.1192059276511;
        Wed, 10 Oct 2007 16:34:36 -0700 (PDT)
Received: from ?10.0.1.2? ( [86.0.198.221])
        by mx.google.com with ESMTPS id w28sm1729606uge.2007.10.10.16.34.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2007 16:34:35 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60567>

Signed-off-by: Brian Ewins <brian.ewins@gmail.com>
---
  Documentation/git-send-pack.txt |    5 ++++-
  send-pack.c                     |   31 +++++++++++++++++++------------
  2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send- 
pack.txt
index 3271e88..9e2783c 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -8,7 +8,7 @@ git-send-pack - Push objects over git protocol to  
another repository

  SYNOPSIS
  --------
-'git-send-pack' [--all] [--force] [--receive-pack=<git-receive- 
pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]
+'git-send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git- 
receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]

  DESCRIPTION
  -----------
@@ -34,6 +34,9 @@ OPTIONS
  	Instead of explicitly specifying which refs to update,
  	update all heads that locally exist.

+\--dry-run::
+	Show what would have been updated, but do not send any updates.
+
  \--force::
  	Usually, the command refuses to update a remote ref that
  	is not an ancestor of the local ref used to overwrite it.
diff --git a/send-pack.c b/send-pack.c
index f74e66a..e8bef4f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -7,13 +7,14 @@
  #include "remote.h"

  static const char send_pack_usage[] =
-"git-send-pack [--all] [--force] [--receive-pack=<git-receive-pack>]  
[--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git- 
receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
  "  --all and explicit <ref> specification are mutually exclusive.";
  static const char *receivepack = "git-receive-pack";
  static int verbose;
  static int send_all;
  static int force_update;
  static int use_thin_pack;
+static int dry_run;

  /*
   * Make a pack stream and spit it out into file descriptor fd
@@ -282,16 +283,18 @@ static int send_pack(int in, int out, struct  
remote *remote, int nr_refspec, cha
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
+				     	old_hex, new_hex, ref->name, 0,
+						"report-status");
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
@@ -302,7 +305,7 @@ static int send_pack(int in, int out, struct  
remote *remote, int nr_refspec, cha
  			fprintf(stderr, "\n  from %s\n  to   %s\n",
  				old_hex, new_hex);
  		}
-		if (remote) {
+		if (remote && !dry_run) {
  			struct refspec rs;
  			rs.src = ref->name;
  			rs.dst = NULL;
@@ -321,7 +324,7 @@ static int send_pack(int in, int out, struct  
remote *remote, int nr_refspec, cha
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
