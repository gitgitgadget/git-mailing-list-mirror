From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/13] remote-hg: make sure fake bookmarks are updated
Date: Tue,  2 Apr 2013 13:02:54 -0600
Message-ID: <1364929382-1399-6-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vl-0006yp-1H
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762099Ab3DBTES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:18 -0400
Received: from mail-gh0-f181.google.com ([209.85.160.181]:39956 "EHLO
	mail-gh0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761359Ab3DBTEP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:15 -0400
Received: by mail-gh0-f181.google.com with SMTP id 3so114913ghz.40
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q7cXChdLqQBV+uHWfeQoDVRfx9+Kgf8Egx19nvPX5zs=;
        b=DBlXlxQGaFumEJLhjoTxfq7zoMt4Bw1elo7TavZK2wYuwLgzgbd1MkEV3qjxChKUcU
         OpEqXXnQaDUXID66f3Udd5NLX0OMEWz0Um6BQO6cE0MJs4hh1374yb+hnLsxMVbYjSnl
         V9A9Y86REHHjhLO/gv8EXXdnN2hAfv8NpLSn9GB2tWB5rKGtnPatevzNmHEz9NSCwhuK
         rwm3fZw3sggPgHbL7u+qLWXi3PSrWmTZ2//pZmgZB6NqZGUdhroBAQEYJFfHUCJeLdOt
         q2kWLbgbtQBFLVDNzjIVAkeBPAMEOwyeZOQh+SA05UIJwy7rkkaNUS1ZvBvFZ7YI7ZP1
         njQw==
X-Received: by 10.236.141.140 with SMTP id g12mr15734267yhj.13.1364929454180;
        Tue, 02 Apr 2013 12:04:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id o31sm4798733yhh.21.2013.04.02.12.04.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219838>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg     | 7 +++++++
 contrib/remote-helpers/test-hg-bidi.sh   | 1 +
 contrib/remote-helpers/test-hg-hg-git.sh | 1 +
 3 files changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6a1a47..b200e60 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -709,9 +709,16 @@ def do_export(parser):
                 old = bmarks[bmark].hex()
             else:
                 old = ''
+
+            if bmark == 'master' and 'master' not in parser.repo._bookmarks:
+                # fake bookmark
+                print "ok %s" % ref
+                continue
+
             if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
                 print "error %s" % ref
                 continue
+
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 1d61982..fe38e49 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -30,6 +30,7 @@ git_clone () {
 hg_clone () {
 	(
 	hg init $2 &&
+	hg -R $2 bookmark -i master &&
 	cd $1 &&
 	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
 	) &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 3f253b7..e116cb0 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -35,6 +35,7 @@ git_clone_git () {
 hg_clone_git () {
 	(
 	hg init $2 &&
+	hg -R $2 bookmark -i master &&
 	cd $1 &&
 	git push -q "hg::$PWD/../$2" 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
 	) &&
-- 
1.8.2
