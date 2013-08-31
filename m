From: Max Kirillov <max@max630.net>
Subject: [PATCH] remote-hg: skip ill-formed references
Date: Sat, 31 Aug 2013 04:15:42 +0300
Message-ID: <20130831011542.GA10486@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 03:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFZnH-0006YW-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 03:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab3HaBPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 21:15:48 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:42478
	"EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752551Ab3HaBPs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 21:15:48 -0400
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa08-10.prod.phx3.secureserver.net with 
	id KDFf1m00U4CavkR01DFlE5; Fri, 30 Aug 2013 18:15:47 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233489>

References which fail check_refname_format() cause the whole
import to fail. This might be undesirable if the references
are not important.

A better solution would be to provide some mapping, either
by some reversible encoding, or by generating and storing
the associations locally.

But this is already going to allow working with many
existing repositories.
---
If there is no smarter solution ongoing maybe this could be
useful.
 contrib/remote-helpers/git-remote-hg | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..e32003b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -591,6 +591,17 @@ def list_head(repo, cur):
     print "@refs/heads/%s HEAD" % head
     g_head = (head, node)
 
+def print_list_entry_if_valid(ref):
+    # same checks as in check_refname_format() in refs.c
+    if ref.startswith('.') or ref.find('/.') != -1 or \
+            ref.find('..') != -1 or \
+            any([(c <= ' ' or c in '~^:\\\177') for c in ref]) or \
+            ref.endswith('/') or \
+            ref.endswith('.lock'):
+        warn("Ill-named reference '%s' skipped" % ref)
+    else:
+        print "? %s" % ref
+
 def do_list(parser):
     global branches, bmarks, track_branches
 
@@ -611,15 +622,15 @@ def do_list(parser):
 
     if track_branches:
         for branch in branches:
-            print "? refs/heads/branches/%s" % gitref(branch)
+            print_list_entry_if_valid("refs/heads/branches/%s" % gitref(branch))
 
     for bmark in bmarks:
-        print "? refs/heads/%s" % gitref(bmark)
+        print_list_entry_if_valid("refs/heads/%s" % gitref(bmark))
 
     for tag, node in repo.tagslist():
         if tag == 'tip':
             continue
-        print "? refs/tags/%s" % gitref(tag)
+        print_list_entry_if_valid("refs/tags/%s" % gitref(tag))
 
     print
 
-- 
1.8.4.rc3.902.g80a4b9e
