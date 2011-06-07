From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] git-remote-testgit: exit gracefully after push
Date: Tue, 7 Jun 2011 13:19:48 -0400
Message-ID: <20110607171947.GA22111@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzwa-0000Vk-JB
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab1FGRTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:19:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50725
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826Ab1FGRTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:19:51 -0400
Received: (qmail 16954 invoked by uid 107); 7 Jun 2011 17:19:58 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:19:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:19:48 -0400
Content-Disposition: inline
In-Reply-To: <20110607171838.GA21685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175219>

The core of the helper script is a loop reading commands.
After most commands, we want to read more, until we get an
empty command that signals we're done. The "export" command
is different, though; all of the rest of the input goes to
fast-import, and there is nothing left for us to read.  This
caused us to print a warning that we got EOF, even though it
is expected in this case.

This was just a warning, so it didn't cause any tests to
fail, but the testgit helper is supposed to act as a
reference implementation. We should try to set a good
example.

This patch lets each command handler tell the main loop
whether it should expect more commands or not; the handler
exits gracefully if no more are expected.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-remote-testgit.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..937b858 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -74,6 +74,7 @@ def do_capabilities(repo, args):
     print "refspec refs/heads/*:%s*" % repo.prefix
 
     print # end capabilities
+    return True
 
 
 def do_list(repo, args):
@@ -96,6 +97,7 @@ def do_list(repo, args):
         print "@refs/heads/master HEAD"
 
     print # end list
+    return True
 
 
 def update_local_repo(repo):
@@ -123,6 +125,7 @@ def do_import(repo, args):
 
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir)
+    return True
 
 
 def do_export(repo, args):
@@ -148,6 +151,7 @@ def do_export(repo, args):
     update_local_repo(repo)
     repo.importer.do_import(repo.gitdir)
     repo.non_local.push(repo.gitdir)
+    return False
 
 
 def do_gitdir(repo, args):
@@ -158,6 +162,7 @@ def do_gitdir(repo, args):
         die("gitdir needs an argument")
 
     repo.gitdir = ' '.join(args)
+    return True
 
 
 COMMANDS = {
@@ -203,7 +208,8 @@ def read_one_line(repo):
         die("Unknown command, %s", cmd)
 
     func = COMMANDS[cmd]
-    func(repo, cmdline)
+    if not func(repo, cmdline):
+	    return False
     sys.stdout.flush()
 
     return True
-- 
1.7.6.rc0.35.gc40cb
