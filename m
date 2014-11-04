From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH v2] diff-highlight: exit when a pipe is broken
Date: Tue,  4 Nov 2014 15:01:12 -0500
Message-ID: <1415131272-89441-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 21:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlkId-0008Py-5K
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 21:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbaKDUBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 15:01:51 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:34827 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKDUBu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 15:01:50 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so2136472qap.28
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 12:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=J8l/oCEkxDqctIQoGRVf7vfhxXLTuXftycewhl47CyA=;
        b=c06eAuGVV1eHNrjXdMtkG7mojxHeajWlqdyZluzxHkIN7+jYn5vYP3ZHzC9KG35nyH
         PkqnqKUhXIn2XPeJRclj0PhXA+l/PCxyU7J9M1SaYWmNau8eQ6yvgmQNOosvyg/HUDQk
         w/6L6duIhiWLkQgD43Z5rWrZSBRK1FGVOFsU+TKkenbKj1aw6KisVyoe9FJ3Fx8qOaas
         A44FgYPWcYFc9mdHSWN7ca9DStHfCB6Zx9YtjR2Ppgwc6a7bEGODr5q1/a1+zGgNdUl7
         my3puYTCxtX7v0Our4DJAxs8fvgFmcQowlJrqa5Htyjh33IduhmL+lWSQzhZ54dLlE1A
         SEuA==
X-Received: by 10.140.90.111 with SMTP id w102mr31141739qgd.88.1415131310046;
        Tue, 04 Nov 2014 12:01:50 -0800 (PST)
Received: from sidious.home (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id r4sm1203456qan.31.2014.11.04.12.01.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 04 Nov 2014 12:01:48 -0800 (PST)
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
with those broken scripts by restoring the default SIGPIPE handler.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
Incorporates feedback from Jeff King and now we just restore the default signal
handler using the correct case of 'DEFAULT'.

 contrib/diff-highlight/diff-highlight | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..69a652e 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -14,6 +14,10 @@ my @removed;
 my @added;
 my $in_hunk;
 
+# Some scripts may not realize that SIGPIPE is being ignored when launching the
+# pager--for instance scripts written in Python.
+$SIG{PIPE} = 'DEFAULT';
+
 while (<>) {
 	if (!$in_hunk) {
 		print;
-- 
2.0.1
