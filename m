From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 17/20] transport-helper: change import semantics
Date: Sun, 19 Jun 2011 17:18:42 +0200
Message-ID: <1308496725-22329-18-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJna-00042G-S3
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab1FSPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53471 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab1FSPUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:10 -0400
Received: by eyx24 with SMTP id 24so294471eyx.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=6oKAN2AgfFEpoCUDK+jCadfCK6HCGnEroyGc6an0Sh8=;
        b=qR6gXZCeaOSPmC4wezc9RCB4FQ47kIiIINgAFkspElkF7oxXR39SVTeKSym+xlA76a
         QeM7sD61H9PHJA0n+eDsFwH0JdEaKQm3gOfyU0uQ/d3Pp8J2NlX4jhLGdRjKo5HPGTc4
         a7gygXPUCWQPAFROMkOxKwWu6LnHxTr1yVRLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jytj8L4mZtSD7MnfcCIQfS+JajiV1+HIhUERv9bW/3Z7J8taPvw1BDoYihn70DqbsX
         lMo3HLlx68qw7X/hH4p/CWLeEfqBEHCqEXXn3D8SuQ9XOe3WB1Bh3swu5VZfwr8kBuSh
         BgwV/njP8RCS5Sty/xW43NZC5e2pmf6NOLPVY=
Received: by 10.213.103.205 with SMTP id l13mr410744ebo.101.1308496808939;
        Sun, 19 Jun 2011 08:20:08 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176017>

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

  Unchanged.

 git-remote-testgit.py     |   14 +++++++++++---
 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    7 ++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 854e27e..4939853 100644
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
index 12f471c..1c62001 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -98,7 +98,7 @@ test_expect_success 'fetch new branch' '
 	compare_refs public HEAD localclone FETCH_HEAD
 '
 
-test_expect_failure 'fetch multiple branches' '
+test_expect_success 'fetch multiple branches' '
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
