From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 16/23] transport-helper: use the new done feature where possible
Date: Sat, 16 Jul 2011 15:03:36 +0200
Message-ID: <1310821424-4750-17-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4e0-0007wF-Ia
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab1GPNKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:10:52 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:62961 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab1GPNKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:10:51 -0400
Received: by eye22 with SMTP id 22so585193eye.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5B9dyiUIfJkXskHvhxU3OG761TT3Eudrfdpkkbo+/0Y=;
        b=HDcXZwxk0/G0Icez6mBTNkIGqm8umL4Bzv6vqVHRQqo/vsr2zvZBYP4ThaKRVmltAC
         ekP7tl5eDyj6BLGoCHGw2yEcR3E+MXNzBeiuYsvja0T+zgMEV4yiXk1cNe/okDSySZJM
         0FhnCGk/lngxj1vlzEJwLMRAeho/vdK+ccPrs=
Received: by 10.14.29.3 with SMTP id h3mr1655275eea.234.1310821494384;
        Sat, 16 Jul 2011 06:04:54 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177274>

In other words, use fast-export --use-done-feature to add a 'done'
command at the end of streams passed to remote helpers' "import"
commands, and teach the remote helpers implementing "export" to use
the 'done' command in turn when producing their streams.

The trailing \n in the protocol signals the helper that the
connection is about to close, allowing it to do whatever cleanup
neccesary.

Previously, the connection would already be closed by the
time the trailing \n was to be written. Now that the remote-helper
protocol uses the new done command in its fast-import streams, this
is no longer the case and we can safely write the trailing \n.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  This is a squash of "18/20 transport-helper: export is no longer
  always the last command" which added the no_disconnect_req.

 git-remote-testgit.py |    2 ++
 transport-helper.c    |    9 ++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index cdbc494..af4d040 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -123,6 +123,8 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, args)
 
+    print "done"
+
 
 def do_export(repo, args):
     """Imports a fast-import stream from git to testgit.
diff --git a/transport-helper.c b/transport-helper.c
index e02f4a3..4c0d861 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -380,8 +380,9 @@ static int get_exporter(struct transport *transport,
 	/* we need to duplicate helper->in because we want to use it after
 	 * fastexport is done with it. */
 	fastexport->out = dup(helper->in);
-	fastexport->argv = xcalloc(4 + revlist_args->nr, sizeof(*fastexport->argv));
+	fastexport->argv = xcalloc(5 + revlist_args->nr, sizeof(*fastexport->argv));
 	fastexport->argv[argc++] = "fast-export";
+	fastexport->argv[argc++] = "--use-done-feature";
 	if (export_marks)
 		fastexport->argv[argc++] = export_marks;
 	if (import_marks)
@@ -417,11 +418,8 @@ static int fetch_with_import(struct transport *transport,
 		sendline(data, &buf);
 		strbuf_reset(&buf);
 	}
-	if (disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
@@ -764,11 +762,8 @@ static int push_refs_with_export(struct transport *transport,
 			 export_marks, import_marks, &revlist_args))
 		die("Couldn't run fast-export");
 
-	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	if (disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
