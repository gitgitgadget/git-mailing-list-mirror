From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 05/13] transport-helper: use the new done feature to properly do imports
Date: Sat, 28 Aug 2010 22:45:32 -0500
Message-ID: <1283053540-27042-6-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYqn-0006e4-VD
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab0H2Dqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0H2DqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:18 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=X+Ivfa3wM8gLieiW4dbDGk3T5LfetUK0t2eWKzd8j6c=;
        b=sRpDs/0Yo3FaYPJ4b9Sl4UkDmciTcCnhoUCz+BKCqxeZREy6Ik0UP9rdD5FuWtqfNX
         Ru84dGL4GiFM8dKtonwRyad5YMPkYS5TRnyESGUCcVcZXdwBmYahWNEB7CwVK85SKpoj
         zxgzlaTFjcyvliElDaSZgngm3VRp5xefpUUGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XX+665+tmpcffu5zYRtyCUap1YONq72VGb+ZGqf2lYnRJrcEjrhqdU4P61HWejapwd
         MxiHnBPzyBVsO6o/PZy39fz5AqWTqe0w8M831QVuM3k3nMhMWYEsilERocnQ/t0FIKH1
         lPY9YVmUZmeH/ieH0Oo0wuPrMfuUfOXfEZL/o=
Received: by 10.231.34.70 with SMTP id k6mr3328695ibd.25.1283053578632;
        Sat, 28 Aug 2010 20:46:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154668>

Previously, the helper code would disconnect the helper before
starting fast-import. This was needed because there was no way to signal
that the helper was done other than to close stdout (which it would
do after importing iff the helper noticed it had been disconnected).

Instead, request that the fast-export uses the 'done' command to
signal when it is done exporting, so that we can disconnect the
helper at a time of our choosing.
---

  I really like what this does for the sanity of the import
  implementation, it makes it much more like a regular (re-entrant)
  command, rather than the "sorry, you're done now" way it is now.

 git-remote-testgit.py |    2 ++
 transport-helper.c    |    8 ++------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..612cb5a 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -124,6 +124,8 @@ def do_import(repo, args):
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir)
 
+    print "done"
+
 
 def do_export(repo, args):
     """Imports a fast-import stream from git to testgit.
diff --git a/transport-helper.c b/transport-helper.c
index 4a2826d..5647595 100644
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
-	if(disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
-
 	free(fastimport.argv);
 	fastimport.argv = NULL;
 
@@ -758,8 +756,6 @@ static int push_refs_with_export(struct transport *transport,
 	data->no_disconnect_req = 1;
 	if(finish_command(&exporter))
 		die("Error while running fast-export");
-	if(disconnect_helper(transport))
-		die("Error while disconnecting helper");
 	return 0;
 }
 
-- 
1.7.2.1.240.g6a95c3
