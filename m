From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sat, 26 Jan 2013 17:51:58 +0000
Message-ID: <20130126175158.GK7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 18:52:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz9vi-00074G-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 18:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab3AZRwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 12:52:09 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:49606 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3AZRwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 12:52:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 291FC606528;
	Sat, 26 Jan 2013 17:52:07 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gb6d1BwcNJLA; Sat, 26 Jan 2013 17:52:06 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 7ED24606507;
	Sat, 26 Jan 2013 17:52:06 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 70DF8161E541;
	Sat, 26 Jan 2013 17:52:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1mw86RvRwAl4; Sat, 26 Jan 2013 17:52:06 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 04509161E114;
	Sat, 26 Jan 2013 17:52:01 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214629>

Under Python 3 'hasher.update(...)' must take a byte string and not a
unicode string.  Explicitly encode the argument to this method as UTF-8
bytes.  This is safe since we are encoding a Python Unicode string to a
Unicode encoding.

This changes the directory used by git-remote-testpy for its git mirror
of the remote repository, but this tool should not have any serious
users as it is used primarily to test the Python remote helper
framework.

The use of encode() moves the required Python version forward to 2.0.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Junio, can you replace the queued 0846b0c (git-remote-testpy: hash bytes
explicitly) with this?

I hadn't realised that the "hex" encoding we chose before is a "bytes to
bytes" encoding so it just fails with an error on Python 3 in the same
way as the original code.

Since we want to convert a Unicode string to bytes I think UTF-8 really
is the best option here.

 git-remote-testpy.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index d94a66a..f8dc196 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -31,9 +31,9 @@ from git_remote_helpers.git.exporter import GitExporter
 from git_remote_helpers.git.importer import GitImporter
 from git_remote_helpers.git.non_local import NonLocalGit
 
-if sys.hexversion < 0x01050200:
-    # os.makedirs() is the limiter
-    sys.stderr.write("git-remote-testgit: requires Python 1.5.2 or later.\n")
+if sys.hexversion < 0x02000000:
+    # string.encode() is the limiter
+    sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
     sys.exit(1)
 
 def get_repo(alias, url):
@@ -45,7 +45,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path)
+    hasher.update(repo.path.encode('utf-8'))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.1
