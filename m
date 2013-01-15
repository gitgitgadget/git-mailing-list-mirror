From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH 2/8 v2] git_remote_helpers: fix input when running under
 Python 3
Date: Tue, 15 Jan 2013 19:48:09 +0000
Message-ID: <20130115194809.GU4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:48:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCV3-00036w-Et
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3AOTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 14:48:23 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:38773 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab3AOTsV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 14:48:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 830E36064D0;
	Tue, 15 Jan 2013 19:48:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHInr+yL0knU; Tue, 15 Jan 2013 19:48:19 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 9F018606506;
	Tue, 15 Jan 2013 19:48:19 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 6DC16161E266;
	Tue, 15 Jan 2013 19:48:19 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OmCgq+5SVdeG; Tue, 15 Jan 2013 19:48:19 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C7094161E20D;
	Tue, 15 Jan 2013 19:48:11 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130114094721.GQ4574@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213667>

Although 2to3 will fix most issues in Python 2 code to make it run under
Python 3, it does not handle the new strict separation between byte
strings and unicode strings.  There is one instance in
git_remote_helpers where we are caught by this, which is when reading
refs from "git for-each-ref".

While we could fix this by explicitly handling refs as byte strings,
this is merely punting the problem to users of the library since the
same problem will be encountered as soon you want to display the ref
name to a user.

Instead of doing this, explicit decode the incoming byte string into a
unicode string.  Following the lead of pygit2 (the Python bindings for
libgit2 - see [1] and [2]), use the filesystem encoding by default,
providing a way for callers to override this if necessary.

[1] https://github.com/libgit2/pygit2/blob/e34911b63e5d2266f9f72a4e3f32e27b13190feb/src/pygit2/reference.c#L261
[2] https://github.com/libgit2/pygit2/blob/e34911b63e5d2266f9f72a4e3f32e27b13190feb/include/pygit2/utils.h#L55

Signed-off-by: John Keeping <john@keeping.me.uk>
---

I think this is in fact the best way to handle this, and I hope the
above description clarified why I don't think we want to treat refs as
byte strings in Python 3.

My only remaining question is whether it would be better to set the
error mode when decoding to "replace" instead of "strict" (the default).
"strict" will cause a UnicodeError if the string cannot be decoded
whereas "replace" will use U+FFFD (the replacement character). [3]

I think it's better to use "strict" and let the user know that
something has gone wrong rather than silently change the string, but I'd
welcome other opinions.

[3] http://docs.python.org/2/library/codecs.html#codec-base-classes

 git_remote_helpers/git/importer.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
index e28cc8f..5bc16a4 100644
--- a/git_remote_helpers/git/importer.py
+++ b/git_remote_helpers/git/importer.py
@@ -1,5 +1,6 @@
 import os
 import subprocess
+import sys
 
 from git_remote_helpers.util import check_call, check_output
 
@@ -10,17 +11,26 @@ class GitImporter(object):
     This importer simply delegates to git fast-import.
     """
 
-    def __init__(self, repo):
+    def __init__(self, repo, ref_encoding=None):
         """Creates a new importer for the specified repo.
+
+        If ref_encoding is specified that refs are decoded using that
+        encoding.  Otherwise the system filesystem encoding is used.
         """
 
         self.repo = repo
+        self.ref_encoding = ref_encoding
 
     def get_refs(self, gitdir):
         """Returns a dictionary with refs.
         """
         args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
-        lines = check_output(args).strip().split('\n')
+        encoding = self.ref_encoding
+        if encoding is None:
+            encoding = sys.getfilesystemencoding()
+            if encoding is None:
+                encoding = sys.getdefaultencoding()
+        lines = check_output(args).decode(encoding).strip().split('\n')
         refs = {}
         for line in lines:
             value, name = line.split(' ')
-- 
1.8.1
