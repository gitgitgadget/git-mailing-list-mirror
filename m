From: Mark Drago <markdrago@gmail.com>
Subject: [PATCH] hg-to-git: handle an empty dir in hg by combining git commits
Date: Sat, 01 Dec 2007 12:59:23 -0500
Message-ID: <4751A0FB.6090705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stelian@popies.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 01 18:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyWcr-0000JO-63
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 18:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbXLAR7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 12:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbXLAR7R
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 12:59:17 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:42083 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbXLAR7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 12:59:16 -0500
Received: by py-out-1112.google.com with SMTP id u77so5132349pyb
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 09:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=NrKww/AOWZLlmLXqT8IPVFHeXyrWWImnP4G0S9Vkc8k=;
        b=LimanhsVpQveDoDLCzjkuq/PKKlkSQJB33oySf++0b/IZ4+6QM8WkUGJdLpEF9BUU+rKlaqy7PeSv8yj6yuOC83vKIpgZ1jzo4Dk1kU7ozlTrPPfvfkSf04bqo9ck56iM3s8MNK7CCwJ6pGOxLmrS606/I8zf7OlXzVZsbdxfjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=qHZNh1kvU6yO9LTg7SGdrsPz/uHej9oGxrtKIG2uI6VilX8dqqqfWA3XFrg5DZJYaEuoeFEP+CQlKASDH4FJUvj55PQ2PAhCFEjr5pjZcce24f9ROs3pQGtCDG+oB74IuQ3UjLhMwE6/v2BP7BHqPpdHTK24sntR53m0zWuLKkU=
Received: by 10.65.51.4 with SMTP id d4mr7328455qbk.1196531955428;
        Sat, 01 Dec 2007 09:59:15 -0800 (PST)
Received: from ?192.168.1.5? ( [24.189.168.60])
        by mx.google.com with ESMTPS id q18sm5760448qbq.2007.12.01.09.59.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Dec 2007 09:59:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66730>

I had a subversion repository which was then converted to hg and now is moving
in to git.  The first commit in the svn repo was just the creation of the empty
directory.  This made its way in to the hg repository fine, but converting from
hg to git would cause an error.  The problem was that hg-to-git.py tries to
commit the change, git-commit fails, and then hg-to-git.py tries to checkout
the new revision and that fails (b/c it was not created).  This may have only
caused an error because it was the first commit in the repository.  If an empty
directory was added in the middle of the repo somewhere things might have
worked out fine.

This patch will detect that there are no changes to commit (using git-status),
and will not perform the commit, but will instead combine the log messages of
that (non-)commit with the next commit.

Signed-off-by: Mark Drago <markdrago@gmail.com>
---
 contrib/hg-to-git/hg-to-git.py |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 6bff49b..06e1b41 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -139,6 +139,7 @@ if not hgvers.has_key("0"):
     os.system('git-init-db')
 
 # loop through every hg changeset
+previous_comment = None
 for cset in range(int(tip) + 1):
 
     # incremental, already seen
@@ -159,6 +160,8 @@ for cset in range(int(tip) + 1):
 
     (fdcomment, filecomment) = tempfile.mkstemp()
     csetcomment = os.popen('hg log -r %d -v | grep -v ^changeset: | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag: | grep -v ^branch:' % cset).read().strip()
+    if (previous_comment):
+	csetcomment += previous_comment
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
@@ -181,8 +184,8 @@ for cset in range(int(tip) + 1):
         print 'tag:', tag
     print '-----------------------------------------'
 
-    # checkout the parent if necessary
-    if cset != 0:
+    # checkout the parent if there is a repo to checkout from
+    if hgvers.has_key("0"):
         if hgbranch[str(cset)] == "branch-" + str(cset):
             print 'creating new branch', hgbranch[str(cset)]
             os.system('git-checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
@@ -210,6 +213,14 @@ for cset in range(int(tip) + 1):
     # delete removed files
     os.system('git-ls-files -x .hg --deleted | git-update-index --remove --stdin')
 
+    # is there something that git will commit (maybe just empty dir was added)
+    stat = os.system('git-status -a')
+    if (stat != 0):
+	print "No changes git notices, will combine log with next commit (maybe empty dir?)"
+	previous_comment = "\n\n--- hg-to-git merged commit ---\n\n" + csetcomment
+	continue
+    previous_comment = None
+
     # commit
     os.system(getgitenv(user, date) + 'git-commit -a -F %s' % filecomment)
     os.unlink(filecomment)
-- 
1.5.2.4
