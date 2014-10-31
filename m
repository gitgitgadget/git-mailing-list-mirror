From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] diff-highlight: exit when a pipe is broken
Date: Fri, 31 Oct 2014 07:04:04 -0400
Message-ID: <1414753444-68653-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 12:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkA0f-0007ny-GG
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 12:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757668AbaJaLEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 07:04:45 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:45646 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393AbaJaLEo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 07:04:44 -0400
Received: by mail-qa0-f51.google.com with SMTP id f12so5124037qad.10
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=p9CFdQhXRYAGHSswgbwwXZYakj9hNvDwlzQiI6C5S+4=;
        b=iJCtHYJ68pRfPH86L8NULIuaoA8YxHJhK0/PpbAwmIHR117sQXd0CXwQv0xWqT6tk5
         TyrJ+HYbTB5ovWi+UCNMziCnR0+Y46sI/gJ7Xhl2qZPAp98YfAmDe+SUj+rnoJVietVx
         9DbBySsoG67MawmSM4WCYz0ocY2Ni9qogRpI5wzQroRYr8j/xDbNKD/3PAcEWDUW0dwT
         LUpmxdYk88ygkTuv3gKsghuw7KqaazcIVMfD6V4IhWg9hUxEsOmAQgHcvo48oEgUD0Jh
         Wi4pImOCYNTvzuPGX9K+XX9AV4IoCfwlAqVJy+YZIt05QGsyv7A3iKFKfGTchMaX+cxY
         Uucg==
X-Received: by 10.229.173.193 with SMTP id q1mr35684998qcz.10.1414753481463;
        Fri, 31 Oct 2014 04:04:41 -0700 (PDT)
Received: from sidious.home (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id 15sm9102245qgh.31.2014.10.31.04.04.39
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 31 Oct 2014 04:04:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using diff-highlight with other tools, I have discovered that Python
ignores SIGPIPE by default.  Unfortunately, this also means that tools
attempting to launch a pager under Python--and don't realize this is
happening--means that the subprocess inherits this setting.  In this case, it
means diff-highlight will be launched with SIGPIPE being ignored.  Let's work
with those broken scripts by explicitly setting up a SIGPIPE handler and exiting
the process.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 contrib/diff-highlight/diff-highlight | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..dfcc35a 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -14,6 +14,15 @@ my @removed;
 my @added;
 my $in_hunk;
 
+# Some scripts may not realize that SIGPIPE is being ignored when launching the
+# pager--for instance scripts written in Python.  Setting $SIG{PIPE} = 'DEFAULT'
+# doesn't work in these instances, so we install our own signal handler instead.
+sub pipe_handler {
+    exit(0);
+}
+
+$SIG{PIPE} = \&pipe_handler;
+
 while (<>) {
 	if (!$in_hunk) {
 		print;
-- 
2.0.1
