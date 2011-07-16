From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 18/23] transport-helper: change import semantics
Date: Sat, 16 Jul 2011 15:03:38 +0200
Message-ID: <1310821424-4750-19-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4YX-0005RE-IZ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab1GPNFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:05:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab1GPNE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:59 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Sw8448dYfyORUQaGlLCjiFvll7k+ghXhF3BPRKaYEck=;
        b=JghsBdX/bsXK/1W0Rl4MBFotVrc10H1Zp79sKq+6dyh24S/Is+jRtL8VlTSvCbxwfD
         WLULApotCVCV0mXiVf2ms4NyhG0UqCoK1UzvmyzLdq8sbNRXMmM3iTCfMQ0cQSdnAGUa
         Fd2M1Ryd+trxB5yCmNcUvcGEEnBpVdwCXGsdA=
Received: by 10.213.21.2 with SMTP id h2mr1621548ebb.90.1310821498636;
        Sat, 16 Jul 2011 06:04:58 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177267>

Currently the helper must somehow guess how many import statements to
read before it starts outputting its fast-export stream. This is
because the remote helper infrastructure runs fast-import only once,
so the helper is forced to output one stream for all import commands
it will receive. The only reason this worked in the past was because
only one ref was imported at a time.

Change the semantics of the import statement such that it matches
that of the push statement. That is, the import statement is followed
by a series of import statements that are terminated by a '\n'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  As Jonathan suggested we now follow push' example, rather than
  'list'. It makes the remote-testgit code a bit longer, but it means
  less changes to remote-helper.c.

 git-remote-testgit.py     |   16 +++++++++++++++-
 t/t5800-remote-helpers.sh |    2 +-
 transport-helper.c        |    3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 0b5928d..1ed7a56 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -120,8 +120,22 @@ def do_import(repo, args):
     if not repo.gitdir:
         die("Need gitdir to import")
 
+    ref = args[0]
+    refs = [ref]
+
+    while True:
+        line = sys.stdin.readline()
+        if line == '\n':
+            break
+        if not line.startswith('import '):
+            die("Expected import line.")
+
+        # strip of leading 'import '
+        ref = line[7:].strip()
+        refs.append(ref)
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
index a8f69b0..0c00be9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -418,6 +418,9 @@ static int fetch_with_import(struct transport *transport,
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
