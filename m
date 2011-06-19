From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 15/20] transport-helper: use the new done feature where possible
Date: Sun, 19 Jun 2011 17:18:40 +0200
Message-ID: <1308496725-22329-16-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnY-00042G-Nw
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab1FSPUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab1FSPUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:05 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981213ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Ka8CBrodYdfOFKL5/4Bg0wSwvWa+lQ0JIeJuynxq9RU=;
        b=aPlsW8wUPQ01dYJhCqtCi0EDxChKUu6aLHi+eD3Pj7bn6dMuII2kvOREv9iKC21r3S
         nWpjIFTkkgvxjh0he8obIIqewoRBnn7qQZgThgJB2/sTecMVEYwdDxucRbiXv/q2vQoJ
         N3VV0GMuoruLSkse9TDZ8ipUt3EtodyWYuDjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oeLakNy0WGv6nNR2wNfVmobpCtx1Us9SYPyDtV8wSkp411efLjkqy4kS2MXXcDsTp7
         ASVy/8QMbN0NC3X8/3PjxDXtX8/NPhSDAKPCL/TMvrWT0UrizHIxc2aq40hnRJGOV9v8
         tqcHGek7TpZ1ufIKo/mGrFRziN+6vsc1tm250=
Received: by 10.213.9.134 with SMTP id l6mr1700803ebl.20.1308496804847;
        Sun, 19 Jun 2011 08:20:04 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.20.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:20:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176016>

In other words, use fast-export --use-done-feature to add a 'done'
command at the end of streams passed to remote helpers' "import"
commands, and teach the remote helpers implementing "export" to use
the 'done' command in turn when producing their streams.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 git-remote-testgit.py |    2 ++
 transport-helper.c    |    8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 9658355..a8e47d9 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -124,6 +124,8 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, args)
 
+    print "done"
+
 
 def do_export(repo, args):
     """Imports a fast-import stream from git to testgit.
diff --git a/transport-helper.c b/transport-helper.c
index 7f3c6c6..b0361c2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -375,8 +375,9 @@ static int get_exporter(struct transport *transport,
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
@@ -412,11 +413,8 @@ static int fetch_with_import(struct transport *transport,
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
 
@@ -762,8 +760,6 @@ static int push_refs_with_export(struct transport *transport,
 	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	if (disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
