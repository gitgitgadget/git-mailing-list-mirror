From: Dave Boutcher <daveboutcher@gmail.com>
Subject: [PATCH 1/3] git-multimail: Add an option to filter on branches
Date: Wed, 22 Apr 2015 07:04:45 +0800
Message-ID: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
Cc: mhagger@alum.mit.edu, Dave Boutcher <daveboutcher@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 01:05:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhEF-0008EI-5Y
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbbDUXFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:05:15 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34499 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbbDUXFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:05:13 -0400
Received: by pdbqa5 with SMTP id qa5so255367971pdb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Gre7v3kpMzMOQ+L03OulLROrhwDVxAstkLpb608f1ZI=;
        b=Z2uxa2QKxnpPAzy86NpOishSDLwnKzWpouLao+60gbjwPqsmSkHxSBZvxXxZcyxCmY
         9z+cZ/QnZ1HXqiS4jvGCFHujf1uJeQrfD79df1CNf4bFO9oGMd7XbVWKfpzBz6NW2FW4
         UyTh4OgDgiDeFtNpn3cYJhP8MVEMpo0IqZ0K2QqpbWIjKq4swIC7lHwKvDsTykn+7vaL
         BzUP6/d7e0lKnaUK8XappEEQLhLRBuyqbjhYK3+DMsMpeOQLLUpXAgWtAO8CiR+8jCRv
         eSGE57g9gi+fYRxTYosSNHvoHK0EVE8fPtHrMnmweIbhO+vrLaRpnvGqcYnNZe/tRE9B
         Rlcw==
X-Received: by 10.70.130.198 with SMTP id og6mr32037275pdb.153.1429657512669;
        Tue, 21 Apr 2015 16:05:12 -0700 (PDT)
Received: from smtp.gmail.com ([23.27.206.118])
        by mx.google.com with ESMTPSA id je11sm3021769pbd.65.2015.04.21.16.05.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 16:05:11 -0700 (PDT)
Received: by smtp.gmail.com (Postfix, from userid 501)
	id 0117347FA065; Wed, 22 Apr 2015 07:05:04 +0800 (CST)
X-Mailer: git-send-email 2.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267567>

Add a branches option to the config.  Only changes
pushed to specified branches will generate emails. Changes to tags
will continue to generate emails.

Signed-off-by: Dave Boutcher <daveboutcher@gmail.com>
---
 git-multimail/README           |  7 +++++++
 git-multimail/git_multimail.py | 44 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/git-multimail/README b/git-multimail/README
index 51add52..a40847a 100644
--- a/git-multimail/README
+++ b/git-multimail/README
@@ -170,6 +170,13 @@ multimailhook.repoName
     for gitolite repositories, or otherwise to derive this value from
     the repository path name.
 
+multimailhook.branches
+
+    A comma separated list of branches to monitor. If not set,
+    notifications will be sent for updates to any branch.  Branch
+    names can contain regular expressions, and this configuration
+    option can be multivalued.
+
 multimailhook.mailingList
 
     The list of email addresses to which notification emails should be
diff --git a/git-multimail/git_multimail.py b/git-multimail/git_multimail.py
index 4374907..5ed253f 100755
--- a/git-multimail/git_multimail.py
+++ b/git-multimail/git_multimail.py
@@ -1548,6 +1548,12 @@ class Environment(object):
             get_reply_to_commit() is used for individual commit
             emails.
 
+        get_branches()
+
+            Return a list of branches to be handled as a list of regex
+            patterns.  If empty list, all branches are handled.  Branches
+            can contain regular expressions (such as foo/.*)
+
     They should also define the following attributes:
 
         announce_show_shortlog (bool)
@@ -1619,6 +1625,9 @@ class Environment(object):
     def get_pusher_email(self):
         return None
 
+    def get_branches(self):
+        return []
+
     def get_administrator(self):
         return 'the administrator of this repository'
 
@@ -1809,6 +1818,10 @@ class ConfigOptionsEnvironmentMixin(ConfigEnvironmentMixin):
             else:
                 return self.get_sender()
 
+    def get_branches(self):
+        branches = self.config.get_all('branches',[])
+        return [re.compile('refs/heads/'+b.strip()) for bs in branches for b in bs.split(',')]
+
     def get_reply_to_refchange(self, refchange):
         if self.__reply_to_refchange is None:
             return super(ConfigOptionsEnvironmentMixin, self).get_reply_to_refchange(refchange)
@@ -2220,8 +2233,9 @@ class Push(object):
             ])
         )
 
-    def __init__(self, changes):
+    def __init__(self, changes, environment):
         self.changes = sorted(changes, key=self._sort_key)
+        self.environment = environment
 
         # The SHA-1s of commits referred to by references unaffected
         # by this push:
@@ -2246,6 +2260,12 @@ class Push(object):
     def _sort_key(klass, change):
         return (klass.SORT_ORDER[change.__class__, change.change_type], change.refname,)
 
+    def branches_match(self, branch):
+        branches = self.environment.get_branches()
+        if not branches:
+            return [True]
+        return [x for x in [r.match(branch) for r in branches] if x]
+
     def _compute_other_ref_sha1s(self):
         """Return the GitObjects referred to by references unaffected by this push."""
 
@@ -2264,6 +2284,10 @@ class Push(object):
             )
         for line in read_git_lines(['for-each-ref', '--format=%s' % (fmt,)]):
             (sha1, type, name) = line.split(' ', 2)
+            # If we are using a branch filter, skip other branches
+            if type == 'commit' and not self.branches_match(name):
+                continue
+
             if sha1 and type == 'commit' and name not in updated_refs:
                 sha1s.add(sha1)
 
@@ -2334,6 +2358,16 @@ class Push(object):
         unhandled_sha1s = set(self.get_new_commits())
         send_date = IncrementalDateTime()
         for change in self.changes:
+            sha1s = []
+            for sha1 in reversed(list(self.get_new_commits(change))):
+                if sha1 in unhandled_sha1s:
+                    sha1s.append(sha1)
+                    unhandled_sha1s.remove(sha1)
+
+            # if we are filtering on branches, skip branches we don't care about
+            if change.refname_type == 'branch' and not self.branches_match(change.refname):
+                continue
+
             # Check if we've got anyone to send to
             if not change.recipients:
                 sys.stderr.write(
@@ -2349,12 +2383,6 @@ class Push(object):
                     change.recipients,
                     )
 
-            sha1s = []
-            for sha1 in reversed(list(self.get_new_commits(change))):
-                if sha1 in unhandled_sha1s:
-                    sha1s.append(sha1)
-                    unhandled_sha1s.remove(sha1)
-
             max_emails = change.environment.maxcommitemails
             if max_emails and len(sha1s) > max_emails:
                 sys.stderr.write(
@@ -2389,7 +2417,7 @@ def run_as_post_receive_hook(environment, mailer):
         changes.append(
             ReferenceChange.create(environment, oldrev, newrev, refname)
             )
-    push = Push(changes)
+    push = Push(changes, environment)
     push.send_emails(mailer, body_filter=environment.filter_body)
 
 
-- 
2.3.0
