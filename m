Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A782E202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdJCQdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 12:33:40 -0400
Received: from mail.cvg.de ([193.158.56.148]:49614 "EHLO mail.cvg.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdJCQdj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 12:33:39 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Oct 2017 12:33:34 EDT
Received: from mail-mta-0.intern.sigma-chemnitz.de (mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
        by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id v93GOCcM014078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 3 Oct 2017 18:24:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
        s=v2012061000; t=1507047853;
        bh=agv7vfWgGVbo+PfUQPK/E939aiEIrbRoOUFQEer2lm8=;
        h=From:To:Cc:Subject:Date:Message-Id:Sender;
        b=CWlajQBSJ5yBp3r7dEHGkxiw9y/7Q1bY76j1u0eG45pefaJBhKIOk1POGftFOXYgm
         dn96cQpLsc2OGxkDEQj5CQal05sQ6zU5LiqxOppHoEovs5yOzBFJYjiEnw59bWxQAI
         Hzfav168FsVg2599WLxqiQ8kRzyJ7kBpAT/OGcRs=
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
        by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id v93GNx4M012626
        for <git@vger.kernel.org> from enrico.scholz@sigma-chemnitz.de; Tue, 3 Oct 2017 18:24:00 +0200
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by reddoxx.intern.sigma-chemnitz.de
        (Reddoxx engine) with SMTP id 637ABE88690; Tue, 3 Oct 2017 18:18:28 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
        by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id v93GNwdU012623
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Oct 2017 18:23:58 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.87)
        (envelope-from <ensc@sigma-chemnitz.de>)
        id 1dzPzC-0006cd-AR; Tue, 03 Oct 2017 18:23:58 +0200
From:   Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To:     git@vger.kernel.org
Cc:     Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] emacs: work with remote filesystems
Date:   Tue,  3 Oct 2017 18:23:48 +0200
Message-Id: <20171003162348.25376-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.9.5
X-DSPAM-Result: Innocent
X-DSPAM-Probability: 0
X-DSPAM-Confidence: 0.99
X-Scanned-By: MIMEDefang 2.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With this patch, it is possible to work on remote filesystems which
were made accessible by tramp.

For example, 'M-x git-status /remote-host:/repository' will show the
status of /repository on 'remote-host' and usual operations like add
or commit are supported there.

First part of the is patch is trivial and replaces 'call-process' with
the network transparent 'process-file'.

The second one is more extensive and implements a tramp wrapper for
'call-process-region'.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 contrib/emacs/git.el | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5ffc506..3d9d691 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -190,8 +190,8 @@ if there is already one that displays the same directory."
   (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))
 
 (defun git-call-process (buffer &rest args)
-  "Wrapper for call-process that sets environment strings."
-  (apply #'call-process "git" nil buffer nil args))
+  "Wrapper for process-file that sets environment strings."
+  (apply #'process-file "git" nil buffer nil args))
 
 (defun git-call-process-display-error (&rest args)
   "Wrapper for call-process that displays error messages."
@@ -221,14 +221,34 @@ the process output as a string, or nil if the git command failed."
       (display-message-or-buffer (current-buffer))
       nil)))
 
+(defun git-tramp-call-process-region (start end program
+                                            &optional delete buffer display
+                                            &rest args)
+  "call-process-region variant for tramp"
+  (let ((tmpfile (tramp-compat-make-temp-file "")))
+    (unwind-protect
+        (progn
+          (write-region start end tmpfile)
+          (when delete (delete-region start end))
+          (apply #'process-file program tmpfile buffer display args))
+      (delete-file tmpfile))))
+
 (defun git-run-process-region (buffer start end program args)
   "Run a git process with a buffer region as input."
-  (let ((output-buffer (current-buffer))
-        (dir default-directory))
+  (let ((dir default-directory)
+        (fh (find-file-name-handler default-directory 'call-process-region))
+        (fnargs (apply 'list start end program
+                       nil (list (current-buffer) t) nil args)))
     (with-current-buffer buffer
       (cd dir)
-      (apply #'call-process-region start end program
-             nil (list output-buffer t) nil args))))
+      (case fh
+        ;; special handling for tramp
+        (tramp-file-name-handler
+         (apply #'git-tramp-call-process-region fnargs))
+        ;; the default (local-file) handler
+        ((nil) (apply #'call-process-region fnargs))
+        ;; else, when there is a handler, call it
+        (t (apply fh #'call-process-region fnargs))))))
 
 (defun git-run-command-buffer (buffer-name &rest args)
   "Run a git command, sending the output to a buffer named BUFFER-NAME."
-- 
2.9.5

