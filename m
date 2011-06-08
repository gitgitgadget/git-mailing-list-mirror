From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 16/19] transport-helper: change import semantics
Date: Wed,  8 Jun 2011 20:48:47 +0200
Message-ID: <1307558930-16074-17-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpO-00087c-GU
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1FHSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57207 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1FHStw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:52 -0400
Received: by ewy4 with SMTP id 4so282684ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=EeXFV4GztKPdPXvhVF8brSUpb67p8LH7DlKKTrrtc1M=;
        b=I/M7bPa/etLvE3cvXij0JDYs6qIJ0JFK0QHCN2tAMb+j2NDLVzhfTCf000XUTAbaWp
         TkZokmKSubTPtlp/IUSxfRIIfGBwUsRemZ7LuqEU+kxgdtd/OvF2RWzjqtn9sZrkjz7y
         8NLozMDiRfBC5BGIShKYkpssz2iIWbfAUm7aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B692wK4Jg5PgLMm0YyYR5CBQCSWK3VJw57YERXnJgc5OtMor4IBdJ9gZ3vRZeOoHlc
         T66dAco6kq0TBYKKRcYyu3xazgqnnuibKol5O8g8r0eUVJ6ile27zE4UUer6GxDMxgvy
         d+GnA+qqr5wEHsZupzHJxyYnBWZ6AAlRyZ1pY=
Received: by 10.14.22.8 with SMTP id s8mr3084420ees.49.1307558991075;
        Wed, 08 Jun 2011 11:49:51 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175432>

Currently the helper must somehow guess how many import statements to
read before it starts outputting its fast-export stream. This is
because the remote helper infrastructure runs fast-import only once,
so the helper is forced to output one stream for all import commands
it will receive. The only reason this worked in the past was because
only one ref was imported at a time.

Change the semantics of the import statement such that it matches
that of the list statement. That is, 'import\n' is followed by a list
of refs that should be exported, followed by '\n'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from my original series. Replaces Peff's workaround from
  his series.

 git-remote-testgit.py     |   14 +++++++++++---
 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    7 ++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 47a30da..88bcb20 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -115,14 +115,22 @@ def do_import(repo, args):
     """Exports a fast-import stream from testgit for git to import.
     """
 
-    if len(args) != 1:
-        die("Import needs exactly one ref")
+    if args:
+        die("Import expects its ref seperately")
 
     if not repo.gitdir:
         die("Need gitdir to import")
 
+    refs = []
+
+    while True:
+        line = sys.stdin.readline()
+        if line == '\n':
+            break
+        refs.append(line.strip())
+
     repo = update_local_repo(repo)
-    repo.exporter.export_repo(repo.gitdir, args)
+    repo.exporter.export_repo(repo.gitdir, refs)
 
     print "done"
 
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index a4afe38..682f813 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -94,7 +94,7 @@ test_expect_success PYTHON_24 'fetch new branch' '
 	compare_refs public HEAD localclone FETCH_HEAD
 '
 
-test_expect_failure PYTHON_24 'fetch multiple branches' '
+test_expect_success PYTHON_24 'fetch multiple branches' '
 	(cd localclone &&
 	 git fetch
 	) &&
diff --git a/transport-helper.c b/transport-helper.c
index bb1b97f..c089928 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -404,15 +404,20 @@ static int fetch_with_import(struct transport *transport,
 	if (get_importer(transport, &fastimport))
 		die("Couldn't run fast-import");
 
+	write_constant(data->helper->in, "import\n");
+
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
 
-		strbuf_addf(&buf, "import %s\n", posn->name);
+		strbuf_addf(&buf, "%s\n", posn->name);
 		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
+
+	write_constant(data->helper->in, "\n");
+
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
 	free(fastimport.argv);
-- 
1.7.5.1.292.g728120
