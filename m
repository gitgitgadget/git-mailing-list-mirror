From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 09/17] Emacs mode: Improve the output buffer state
Date: Fri, 14 Dec 2007 11:58:12 +0100
Message-ID: <20071214105800.18066.28256.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Fo-0001Hm-25
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765903AbXLNK55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765866AbXLNK54
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:57:56 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51836 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765725AbXLNK5z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:57:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9A7C7200A238;
	Fri, 14 Dec 2007 11:57:54 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-56; Fri, 14 Dec 2007 11:57:54 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 575A5200A1E8;
	Fri, 14 Dec 2007 11:57:54 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id BF4467B406D;
	Fri, 14 Dec 2007 11:58:12 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68287>

Make the output buffer have the correct default-directory, and make it
read-only and unmodified.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index ed2fc37..82f0d38 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -41,13 +41,20 @@ Argument DIR is the repository path."
=20
 (defmacro stgit-capture-output (name &rest body)
   "Capture StGit output and show it in a window at the end"
-  `(let ((output-buf (get-buffer-create ,(or name "*StGit output*"))))
+  `(let ((output-buf (get-buffer-create ,(or name "*StGit output*")))
+         (stgit-dir default-directory)
+         (inhibit-read-only t))
      (with-current-buffer output-buf
-       (erase-buffer))
+       (erase-buffer)
+       (setq default-directory stgit-dir)
+       (setq buffer-read-only t))
      (let ((standard-output output-buf))
        ,@body)
-     (if (with-current-buffer output-buf (< (point-min) (point-max)))
-         (display-buffer output-buf t))))
+     (with-current-buffer output-buf
+       (set-buffer-modified-p nil)
+       (setq buffer-read-only t)
+       (if (< (point-min) (point-max))
+           (display-buffer output-buf t)))))
 (put 'stgit-capture-output 'lisp-indent-function 1)
=20
 (defun stgit-run (&rest args)
