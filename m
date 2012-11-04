From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] Add new remote-bzr transport helper
Date: Sun,  4 Nov 2012 03:22:01 +0100
Message-ID: <1351995723-20396-2-git-send-email-felipe.contreras@gmail.com>
References: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpr5-0000bs-NP
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab2KDCWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:22:19 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45078 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab2KDCWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:22:17 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1658012bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2vyZtwe2tQHUBke5QvMA3py0cEjc7SWLfgXaqx0NXcg=;
        b=0QMZUwmHMLc9//O2vZy2pQjB3oQdmAxU5ohKsnNKA1Ur2fO3w9V7rslGhqrSFRAThS
         6EzJ7jdjDpF7ox/C5a1F+vATZmvNslXJArkHWmDLG0lsrTuCHZ+efFN+F6AHkXrsIDIE
         vWCbvNngaeF+vS1nF0tUp+sXcLsQSEgLsuedvSKOUal4Y08MmT+UYgxPAojQNAz42JAy
         YlqRMyRjXTLcr+kdDlNeuGfEG2Da/h2pInBPyNC3sCLBVKYddcT5CKiKIfmQfdKJw+xD
         7wZ5/Cf5O1Bt1+7zlZvQg9IGvlfljjQXppz9O2T7nNQ6BTNB7Ou/V6cIq8S3NTDAVo2y
         5bsg==
Received: by 10.204.157.145 with SMTP id b17mr1405093bkx.68.1351995735986;
        Sat, 03 Nov 2012 19:22:15 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e13sm7947465bkw.12.2012.11.03.19.22.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:22:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209006>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 187 ++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100755 contrib/remote-helpers/git-remote-bzr

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
new file mode 100755
index 0000000..76a609a
--- /dev/null
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -0,0 +1,187 @@
+#!/usr/bin/env python
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+# Just copy to your ~/bin, or anywhere in your $PATH.
+# Then you can clone with:
+# git clone bzr::/path/to/mercurial/repo/
+#
+# You need to have bzr-fastimport installed:
+# http://wiki.bazaar.canonical.com/BzrFastImport
+#
+# You might also need to find this line bzr-fastimport's
+# code, and modify it:
+#
+# self._use_known_graph = False
+
+import sys
+
+import bzrlib
+bzrlib.initialize()
+
+import bzrlib.plugin
+bzrlib.plugin.load_plugins()
+
+import bzrlib.revisionspec
+
+from bzrlib.plugins.fastimport import exporter as bzr_exporter
+
+import sys
+import os
+import json
+
+def die(msg, *args):
+    sys.stderr.write('ERROR: %s\n' % (msg % args))
+    sys.exit(1)
+
+def warn(msg, *args):
+    sys.stderr.write('WARNING: %s\n' % (msg % args))
+
+class Marks:
+
+    def __init__(self, path):
+        self.path = path
+        self.tips = {}
+        self.load()
+
+    def load(self):
+        if not os.path.exists(self.path):
+            return
+
+        tmp = json.load(open(self.path))
+        self.tips = tmp['tips']
+
+    def dict(self):
+        return { 'tips': self.tips }
+
+    def store(self):
+        json.dump(self.dict(), open(self.path, 'w'))
+
+    def __str__(self):
+        return str(self.dict())
+
+    def get_tip(self, branch):
+        return self.tips.get(branch, '1')
+
+    def set_tip(self, branch, tip):
+        self.tips[branch] = tip
+
+class Parser:
+
+    def __init__(self, repo):
+        self.repo = repo
+        self.line = self.get_line()
+
+    def get_line(self):
+        return sys.stdin.readline().strip()
+
+    def __getitem__(self, i):
+        return self.line.split()[i]
+
+    def check(self, word):
+        return self.line.startswith(word)
+
+    def each_block(self, separator):
+        while self.line != separator:
+            yield self.line
+            self.line = self.get_line()
+
+    def __iter__(self):
+        return self.each_block('')
+
+    def next(self):
+        self.line = self.get_line()
+        if self.line == 'done':
+            self.line = None
+
+def export_branch(branch, name):
+    global prefix, dirname
+
+    marks_path = os.path.join(dirname, 'marks-bzr')
+    ref = '%s/heads/%s' % (prefix, name)
+    tip = marks.get_tip(name)
+    start = "before:%s" % tip
+    rev1 = bzrlib.revisionspec.RevisionSpec.from_string(start)
+    rev2 = bzrlib.revisionspec.RevisionSpec.from_string(None)
+
+    exporter = bzr_exporter.BzrFastExporter(branch,
+        outf=sys.stdout, ref=ref,
+        checkpoint=None,
+        import_marks_file=marks_path,
+        export_marks_file=marks_path,
+        revision=[rev1, rev2],
+        verbose=None, plain_format=True,
+        rewrite_tags=False)
+    exporter.run()
+
+    marks.set_tip(name, branch.last_revision())
+
+def do_import(parser):
+    global dirname
+
+    branch = parser.repo
+    path = os.path.join(dirname, 'marks-git')
+
+    print "feature done"
+    if os.path.exists(path):
+        print "feature import-marks=%s" % path
+    print "feature export-marks=%s" % path
+    sys.stdout.flush()
+
+    while parser.check('import'):
+        ref = parser[1]
+        if ref.startswith('refs/heads/'):
+            name = ref[len('refs/heads/'):]
+            export_branch(branch, name)
+        parser.next()
+
+    print 'done'
+
+    sys.stdout.flush()
+
+def do_capabilities(parser):
+    print "import"
+    print "refspec refs/heads/*:%s/heads/*" % prefix
+    print
+
+def do_list(parser):
+    print "? refs/heads/%s" % 'master'
+    print "@refs/heads/%s HEAD" % 'master'
+    print
+
+def main(args):
+    global marks, prefix, dirname
+
+    alias = args[1]
+    url = args[2]
+
+    d = bzrlib.controldir.ControlDir.open(url)
+    repo = d.open_branch()
+
+    prefix = 'refs/bzr/%s' % alias
+
+    gitdir = os.environ['GIT_DIR']
+    dirname = os.path.join(gitdir, 'bzr', alias)
+
+    if not os.path.exists(dirname):
+        os.makedirs(dirname)
+
+    marks_path = os.path.join(dirname, 'marks-int')
+    marks = Marks(marks_path)
+
+    parser = Parser(repo)
+    for line in parser:
+        if parser.check('capabilities'):
+            do_capabilities(parser)
+        elif parser.check('list'):
+            do_list(parser)
+        elif parser.check('import'):
+            do_import(parser)
+        else:
+            die('unhandled command: %s' % line)
+        sys.stdout.flush()
+
+    marks.store()
+
+sys.exit(main(sys.argv))
-- 
1.8.0
