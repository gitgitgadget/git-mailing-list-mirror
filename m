From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 07/13] transport-helper: change import semantics
Date: Sat, 28 Aug 2010 22:45:34 -0500
Message-ID: <1283053540-27042-8-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrN-0006pV-I1
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab0H2Dqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0H2Dqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:43 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4PSjrHq1XyG/CRsFxihaDYOfQ+tuC4vJ+jagsGq1EyY=;
        b=oaFuZH4r8/YKls2oE8qA26fFanFSOYW2yKEKsrjut/NIv1LXtA/wq4XpG7ob8pLHWW
         d0bDlrFZP5uFZfOqlttA8I8OdlX//bSaBofUEnOoPPnrqRf0rudBQVqg2bpGwGfi+yr+
         lOIjERxs5Y3bccCvdxw8yOBt5BZdw1nAKkm/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i2+VJrTeB1HpcMw+AfZxbCzYWQOinKYUiB/n51lrL/ouHbKan0ZxQdgN34pH/ucSmN
         8IyHkyZRTTgfLTIGmp/Rt5RVD/7b5B7n0u1IY/YgSaa9RaV83e+Vt7uUkI3kX/w83BWT
         OSHM6p/WcatWOr2qW/uC8HiYP82k7WYxrhtYQ=
Received: by 10.231.19.74 with SMTP id z10mr3236303iba.120.1283053603144;
        Sat, 28 Aug 2010 20:46:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154674>

Currently the helper must somehow guess how many import statements to
read before it starts outputting its fast-export stream. This is
because the remote helper infrastructure runs fast-import only once,
so the helper is forced to output one stream for all import commands
it will receive. The only reason this worked in the past was because
only one ref was imported at a time.

Change the semantics of the import statement such that it matches
that of the list statement. That is, 'import\n' is followed by a list
of refs that should be exported, followed by '\n'.
---

  This changes the protcol a bit, but I don't think we have many
  users of the 'import' command yet, and if we do I would assume
  they're paying attention to development in the remote helper space.

 git-remote-testgit.py |   12 ++++++++++--
 transport-helper.c    |    7 ++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 342a05d..50341ce 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -115,12 +115,20 @@ def do_import(repo, args):
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
     repo.exporter.export_repo(repo.gitdir)
 
diff --git a/transport-helper.c b/transport-helper.c
index ecaea25..13ebb3b 100644
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
1.7.2.1.240.g6a95c3
