From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-remote-testpy: fix patch hashing on Python 3
Date: Sun, 27 Jan 2013 14:50:56 +0000
Message-ID: <20130127145056.GP7498@serenity.lan>
References: <cover.1358686905.git.john@keeping.me.uk>
 <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan>
 <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
 <20130127141329.GN7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:51:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzTZx-0001w5-4A
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab3A0OvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 09:51:07 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:37748 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab3A0OvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 09:51:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 471D86064D7;
	Sun, 27 Jan 2013 14:51:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TtUDmIujGQGA; Sun, 27 Jan 2013 14:51:04 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2C76D6064DD;
	Sun, 27 Jan 2013 14:50:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130127141329.GN7498@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214703>

When this change was originally made (0846b0c - git-remote-testpy: hash
bytes explicitly , I didn't realised that the "hex" encoding we chose is
a "bytes to bytes" encoding so it just fails with an error on Python 3
in the same way as the original code.

It is not possible to provide a single code path that works on Python 2
and Python 3 since Python 2.x will attempt to decode the string before
encoding it, which fails for strings that are not valid in the default
encoding.  Python 3.1 introduced the "surrogateescape" error handler
which handles this correctly and permits a bytes -> unicode -> bytes
round-trip to be lossless.

At this point Python 3.0 is unsupported so we don't go out of our way to
try to support it.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sun, Jan 27, 2013 at 02:13:29PM +0000, John Keeping wrote:
> On Sun, Jan 27, 2013 at 05:44:37AM +0100, Michael Haggerty wrote:
> > So to handle all of the cases across Python versions as closely as
> > possible to the old 2.x code, it might be necessary to make the code
> > explicitly depend on the Python version number, like:
> > 
> >     hasher = _digest()
> >     if sys.hexversion < 0x03000000:
> >         pathbytes = repo.path
> >     elif sys.hexversion < 0x03010000:
> >         # If support for Python 3.0.x is desired (note: result can
> >         # be different in this case than under 2.x or 3.1+):
> >         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
> > 'backslashreplace')
> >     else
> >         pathbytes = repo.path.encode(sys.getfilesystemencoding(),
> > 'surrogateescape')
> >     hasher.update(pathbytes)
> >     repo.hash = hasher.hexdigest()

How about this?

 git-remote-testpy.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-remote-testpy.py b/git-remote-testpy.py
index c7a04ec..16b0c52 100644
--- a/git-remote-testpy.py
+++ b/git-remote-testpy.py
@@ -36,6 +36,22 @@ if sys.hexversion < 0x02000000:
     sys.stderr.write("git-remote-testgit: requires Python 2.0 or later.\n")
     sys.exit(1)
 
+
+def _encode_filepath(path):
+    """Encodes a Unicode file path to a byte string.
+
+    On Python 2 this is a no-op; on Python 3 we encode the string as
+    suggested by [1] which allows an exact round-trip from the command line
+    to the filesystem.
+
+    [1] http://docs.python.org/3/c-api/unicode.html#file-system-encoding
+
+    """
+    if sys.hexversion < 0x03000000:
+        return path
+    return path.encode('utf-8', 'surrogateescape')
+
+
 def get_repo(alias, url):
     """Returns a git repository object initialized for usage.
     """
@@ -45,7 +61,7 @@ def get_repo(alias, url):
     repo.get_head()
 
     hasher = _digest()
-    hasher.update(repo.path.encode('hex'))
+    hasher.update(_encode_filepath(repo.path))
     repo.hash = hasher.hexdigest()
 
     repo.get_base_path = lambda base: os.path.join(
-- 
1.8.1.1
