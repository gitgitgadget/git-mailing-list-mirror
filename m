From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 14/19] transport-helper: use the new done feature where possible
Date: Wed,  8 Jun 2011 20:48:45 +0200
Message-ID: <1307558930-16074-15-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:51:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNqV-0000Sp-OY
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab1FHSus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:50:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46131 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab1FHSts (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:48 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so282597ewy.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=7fzvEqRtScbVwGPvoYOk3NfeTQ1otmLkbSQ36NynTy4=;
        b=HUHlsrXHF6gfTbPEq/PCYMjlK7IVtKcXbs3nJHC8l6tM9fo4+OR0Zql7AqI+yybSd7
         JDXsUOAO6YSiUzuMujTCjmxH4GbpFlvhyw7Y1GpMQMzF1Pg4MzAaRjmP/6fQGLIjonNh
         Wfgy75SUYdVKuVYafqX+gw3m/csPaYDZRAJSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ea6Tvt2lHGmYhfcH0fUjbXixY1w8rhbvu3CyOylPyFIDzPT8i7aMWvmt0yBOIJpgqj
         zI4zz8GSVaiQpo5StVB7WFmQ1OOPKY0eNnyAVPZddoFp6NSnHW3drRK1HXH5ifjAROsX
         42LlMmw+fSszv2dKFUzZsiOkuCmmyUFnEeVrU=
Received: by 10.213.108.147 with SMTP id f19mr2163121ebp.9.1307558988108;
        Wed, 08 Jun 2011 11:49:48 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175438>

In other words, use fast-export --use-done-feature to add a 'done'
command at the end of streams passed to remote helpers' "import"
commands, and teach the remote helpers implementing "export" to use
the 'done' command in turn when producing their streams.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged from my original series.

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
