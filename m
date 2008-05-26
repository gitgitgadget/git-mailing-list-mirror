From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 14:20:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261419440.30431@racer>
References: <alpine.DEB.1.00.0805261344420.30431@racer> <200805261509.49841.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stelian Pop <stelian@popies.net>,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 26 15:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0cdx-0001oq-6Y
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 15:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbYEZNUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 09:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbYEZNUu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 09:20:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:42569 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751770AbYEZNUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 09:20:49 -0400
Received: (qmail invoked by alias); 26 May 2008 13:20:47 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp027) with SMTP; 26 May 2008 15:20:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196WHRsGpp6xDTbt29ktCCYy8jnpHY/qJ43WxGRUi
	uylS8WU8jKBJ5A
X-X-Sender: gene099@racer
In-Reply-To: <200805261509.49841.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82932>


This patch adds an option to make hg-to-git quiet by default.  Note:
it only suppresses those messages that would be printed when everything
was up-to-date.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 26 May 2008, Johan Herland wrote:

	> 	verbose = false

	Pieter on IRC just pointed out that it should be capitalized.

 contrib/hg-to-git/hg-to-git.py |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index d72ffbb..f68ef72 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -46,6 +46,7 @@ options:
                          for incrementals
     -n, --nrepack=INT:   number of changesets that will trigger
                          a repack (default=0, -1 to deactivate)
+    -v, --verbose:       be verbose
 
 required:
     hgprj:  name of the HG project to import (directory)
@@ -75,15 +76,18 @@ def getgitenv(user, date):
 
 state = ''
 opt_nrepack = 0
+verbose = False
 
 try:
-    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:', ['gitstate=', 'tempdir=', 'nrepack='])
+    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:v', ['gitstate=', 'tempdir=', 'nrepack=', 'verbose'])
     for o, a in opts:
         if o in ('-s', '--gitstate'):
             state = a
             state = os.path.abspath(state)
         if o in ('-n', '--nrepack'):
             opt_nrepack = int(a)
+        if o in ('-v', '--verbose'):
+            verbose = True
     if len(args) != 1:
         raise('params')
 except:
@@ -95,17 +99,20 @@ os.chdir(hgprj)
 
 if state:
     if os.path.exists(state):
-        print 'State does exist, reading'
+        if verbose:
+            print 'State does exist, reading'
         f = open(state, 'r')
         hgvers = pickle.load(f)
     else:
         print 'State does not exist, first run'
 
 tip = os.popen('hg tip --template "{rev}"').read()
-print 'tip is', tip
+if verbose:
+    print 'tip is', tip
 
 # Calculate the branches
-print 'analysing the branches...'
+if verbose:
+    print 'analysing the branches...'
 hgchildren["0"] = ()
 hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
@@ -232,7 +239,8 @@ if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
 
 # write the state for incrementals
 if state:
-    print 'Writing state'
+    if verbose:
+        print 'Writing state'
     f = open(state, 'w')
     pickle.dump(hgvers, f)
 
-- 
1.5.5.GIT
