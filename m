From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a HOWTO for setting up a standalone git daemon
Date: Tue, 20 Mar 2007 03:29:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703200329350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 20 03:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTU7F-0001Td-Oc
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 03:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbXCTC36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 22:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965796AbXCTC36
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 22:29:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:55272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965804AbXCTC35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 22:29:57 -0400
Received: (qmail invoked by alias); 20 Mar 2007 02:29:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 20 Mar 2007 03:29:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TjWxzU+RTWc/0tpecUm4+uy7yaGbAi26K9OiNgJ
	DXoaje6v11IvV5
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42692>


Setting up a git-daemon came up the other day on IRC, and it is slightly
non trivial for the uninitiated.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/howto/use-git-daemon.txt |   52 ++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/howto/use-git-daemon.txt

diff --git a/Documentation/howto/use-git-daemon.txt b/Documentation/howto/use-git-daemon.txt
new file mode 100644
index 0000000..1a1eb24
--- /dev/null
+++ b/Documentation/howto/use-git-daemon.txt
@@ -0,0 +1,52 @@
+How to use git-daemon
+
+Git can be run in inetd mode and in stand alone mode. But all you want is
+let a coworker pull from you, and therefore need to set up a git server
+real quick, right?
+
+Note that git-daemon is not really chatty at the moment, especially when
+things do not go according to plan (e.g. a socket could not be bound).
+
+Another word of warning: if you run
+
+	$ git ls-remote git://127.0.0.1/rule-the-world.git
+
+and you see a message like
+
+	fatal: The remote end hung up unexpectedly
+
+it only means that _something_ went wrong. To find out _what_ went wrong,
+you have to ask the server. (Git refuses to be more precise for your
+security only. Take off your shoes now. You have any coins in your pockets?
+Sorry, not allowed -- who knows what you planned to do with them?)
+
+With these two caveats, let's see an example:
+
+	$ git daemon --reuseaddr --verbose --base-path=/home/gitte/git \
+	  --export-all -- /home/gitte/git/rule-the-world.git
+
+(Of course, unless your user name is `gitte` _and_ your repository is in
+~/rule-the-world.git, you have to adjust the paths. If your repository is
+not bare, be aware that you have to type the path to the .git directory!)
+
+This invocation tries to reuse the address if it is already taken
+(this can save you some debugging, because otherwise killing and restarting
+git-daemon could just silently fail to bind to a socket).
+
+Also, it is (relatively) verbose when somebody actually connects to it.
+It also sets the base path, which means that all the projects which can be
+accessed using this daemon have to reside in or under that path.
+
+The option `--export-all` just means that you _don't_ have to create a
+file named `git-daemon-export-ok` in each exported repository. (Otherwise,
+git-daemon would complain loudly, and refuse to cooperate.)
+
+Last of all, the repository which should be exported is specified. It is
+a good practice to put the paths after a "--" separator.
+
+Now, test your daemon with
+
+	$ git ls-remote git://127.0.0.1/rule-the-world.git
+
+If this does not work, find out why, and submit a patch to this document.
+
-- 
1.5.1.rc1.2288.g29e7
