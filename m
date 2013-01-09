From: Max Horn <max@quendi.de>
Subject: [PATCH] remote-hg: store converted URL
Date: Wed,  9 Jan 2013 20:43:38 +0100
Message-ID: <1357760618-81222-1-git-send-email-max@quendi.de>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 20:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1ZQ-0007T8-AF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab3AITn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:43:56 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:50138 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932231Ab3AITnz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 14:43:55 -0500
Received: from [89.204.137.244] (helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1Tt1Z3-0004uI-KY; Wed, 09 Jan 2013 20:43:54 +0100
X-Mailer: git-send-email 1.8.0.1.525.gaaf5ad5
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1357760635;5be7ffbe;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213087>

From: Felipe Contreras <felipe.contreras@gmail.com>

Mercurial might convert the URL to something more appropriate, like an
absolute path. Lets store that instead of the original URL, which won't
work from a different working directory if it's relative.

Suggested-by: Max Horn <max@quendi.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Max Horn <max@quendi.de>
---
For a discussion of the problem, see also
  http://article.gmane.org/gmane.comp.version-control.git/210250
While I am not quite happy with using "git config" to solve it, there
doesn't seem to be a better way right now.

 contrib/remote-helpers/git-remote-hg | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c700600..7c74d8b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -720,6 +720,14 @@ def do_export(parser):
     if peer:
         parser.repo.push(peer, force=False)
 
+def fix_path(alias, repo, orig_url):
+    repo_url = util.url(repo.url())
+    url = util.url(orig_url)
+    if str(url) == str(repo_url):
+        return
+    cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % repo_url]
+    subprocess.call(cmd)
+
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
@@ -766,6 +774,9 @@ def main(args):
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
 
+    if not is_tmp:
+        fix_path(alias, peer or repo, url)
+
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
-- 
1.8.0.1.525.gaaf5ad5
