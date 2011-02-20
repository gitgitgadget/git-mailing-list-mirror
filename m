From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 2/2] git-p4: Add copy detection support
Date: Sun, 20 Feb 2011 01:18:25 +0000
Message-ID: <1298164705-5366-3-git-send-email-vitor.hda@gmail.com>
References: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 02:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqxx6-0005np-0j
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 02:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab1BTBTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 20:19:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36204 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab1BTBTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 20:19:03 -0500
Received: by wyb38 with SMTP id 38so85741wyb.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 17:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=wLzY2cAiiL3vW9t10vwINbmgyvMvwcHHK/drNiNUYRE=;
        b=ojYBc+HqRXAtBRhPB9F8XsfZ9K5gPwY4r+Kiq8cnU2CSg8EI4G8PSTZKoYj9PqUaFS
         KcDW+8jNmtaLHgY67w0s6zPlCPOe9x/PifFFrcn4kV4dcu9D6VYdl5G6XYN5dObNNKeA
         H/iyyF38oKZ4YOPcFp0Jk07y9vK1FAxPc8XAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ElQ8qJ9ljszz6qORQyWCBrtBrffkYfDzJWNXauA9WS5uM25up5b0tTXYkaj4lwXvCZ
         LHx7KbbRSmJ35PLN/UcRfBe34T9E2RshBE3ct6SPuCqhIoo/d9Q+X4FOIluEimVmWJ6y
         9/pbQzSnE6LV5r5ofcIxQ9ekORFiudoQ9yYaA=
Received: by 10.227.129.79 with SMTP id n15mr2036323wbs.134.1298164741792;
        Sat, 19 Feb 2011 17:19:01 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u9sm2909192wbg.12.2011.02.19.17.19.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 17:19:01 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298164705-5366-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167388>

Add new config options:
    git-p4.detectCopies         - Enable copy detection.
    git-p4.detectCopiesHarder   - Find copies harder.
The detectCopies option should be set to a true/false value.
The detectCopiesHarder option should be set to true/false value.
P4Submit can now process diff-tree C status and integrate files accordingly.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Acked-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b0da28a..1b1fc76 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -623,6 +623,12 @@ class P4Submit(Command):
         else:
             diffOpts = ""
 
+        if gitConfig("git-p4.detectCopies").lower() == "true":
+            diffOpts += " -C"
+
+        if gitConfig("git-p4.detectCopiesHarder").lower() == "true":
+            diffOpts += " --find-copies-harder"
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -646,6 +652,16 @@ class P4Submit(Command):
                 filesToDelete.add(path)
                 if path in filesToAdd:
                     filesToAdd.remove(path)
+            elif modifier == "C":
+                src, dest = diff['src'], diff['dst']
+                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
+                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    p4_system("edit \"%s\"" % (dest))
+                    filesToChangeExecBit[dest] = diff['dst_mode']
+                os.unlink(dest)
+                editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-- 
1.7.4.1
