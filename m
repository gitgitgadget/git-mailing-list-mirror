From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] contrib/emacs/vc-git.el: support vc-version-other-window
Date: Fri, 26 Jan 2007 11:57:50 +0100
Message-ID: <87y7nqukb5.fsf@wine.dyndns.org>
References: <20070125234352.340DACB9F4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Jan 26 11:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAOmN-0007Hc-6s
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 11:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAZK54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 05:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbXAZK54
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 05:57:56 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:57336 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXAZK5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 05:57:55 -0500
Received: from adsl-89-217-155-103.adslplus.ch ([89.217.155.103] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HAOmH-0007l0-AJ; Fri, 26 Jan 2007 04:57:54 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id CFBCD4FB65; Fri, 26 Jan 2007 11:57:50 +0100 (CET)
In-Reply-To: <20070125234352.340DACB9F4@localhost.localdomain> (Sam Vilain's message of "Fri\, 26 Jan 2007 12\:41\:23 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37837>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Currently, the vc-git-checkout function uses `git checkout' to fetch a
> file from the git repository to the working copy.  However, it is
> completely ignoring the input argument that specifies the destination
> file.  `git-checkout' does not support specifying this, so we have to
> use `git-cat-file', capture the output in a buffer and then save it.

This looks good, though the code can be made simpler by using
with-temp-file to create the file. Also you need to avoid charset
conversions when reading and writing, and you should use ls-files -z
to avoid problems with strange file names.

I'd suggest something like this:


>From b37cff5399dd94abe3d4e9778cdbf5cee53d46c0 Mon Sep 17 00:00:00 2001
From: Alexandre Julliard <julliard@winehq.org>
Date: Fri, 26 Jan 2007 11:39:55 +0100
Subject: [PATCH] vc-git.el: Take into account the destination name in vc-checkout.

This is necessary for vc-version-other-window. Based on a patch by Sam
Vilain <sam.vilain@catalyst.net.nz>.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/vc-git.el |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 3eb4bd1..e456ab9 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -120,7 +120,16 @@
     (vc-git--run-command file "commit" "-m" comment "--only" "--")))
 
 (defun vc-git-checkout (file &optional editable rev destfile)
-  (vc-git--run-command file "checkout" (or rev "HEAD")))
+  (if destfile
+      (let ((fullname (substring
+                       (vc-git--run-command-string file "ls-files" "-z" "--full-name" "--")
+                       0 -1))
+            (coding-system-for-read 'no-conversion)
+            (coding-system-for-write 'no-conversion))
+        (with-temp-file destfile
+          (eq 0 (call-process "git" nil t nil "cat-file" "blob"
+                              (concat (or rev "HEAD") ":" fullname)))))
+    (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
 (defun vc-git-annotate-command (file buf &optional rev)
   ; FIXME: rev is ignored
-- 
1.5.0.rc2.gc651



-- 
Alexandre Julliard
julliard@winehq.org
