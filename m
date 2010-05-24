From: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@gmail.com>
Subject: [PATCH 1/2] Repository.rev_parse: support commits, trees, and blobs
Date: Mon, 24 May 2010 20:52:19 +0200
Message-ID: <20100524185219.30884.66896.stgit@sambuntu>
References: <20100524184908.30884.65042.stgit@sambuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 20:52:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGclT-0006Nj-48
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab0EXSwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 14:52:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45381 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab0EXSwY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 14:52:24 -0400
Received: by mail-wy0-f174.google.com with SMTP id 29so1784268wyb.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=LLL8FlQosJOD2wvmduDScDSSQv+qqphoydl40GMZvew=;
        b=BiylY64tIKyLGwi7VUtVszQ4aWX8bh5v3uTVfwic6FIn16fXGRjcnIaiN5rjkohP2y
         fGUJeqzkC+92hDzVZlWtJR54w36JLihgg4F4IEPFDj9zvg5TgHxFEEqKWiwL1yhn8fRI
         z9yvSE7vJgZF2vxG+RMSYSVG/tgQrtN1ZmI+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=eKnffU9d7rX4SlrpOdKZx1KPP+zqgs71lAjwRKpbAwL2NHYlU6OZYm4VbxZntHmtHl
         +sZXOnALZwb/26EagwLb+WBOXu8AjQEs5G3/pWayxX7C8ekNha0Ou3Fmq2sLh5T6z9nl
         UYpFVbr3aLSpGjC5vIPNNe+2MZHsFAP8g8TLQ=
Received: by 10.216.89.12 with SMTP id b12mr3905468wef.33.1274727143883;
        Mon, 24 May 2010 11:52:23 -0700 (PDT)
Received: from [127.0.1.1] (c-97d7e255.66-15-64736c12.cust.bredbandsbolaget.se [85.226.215.151])
        by mx.google.com with ESMTPS id 16sm2024893ewy.15.2010.05.24.11.52.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 11:52:23 -0700 (PDT)
In-Reply-To: <20100524184908.30884.65042.stgit@sambuntu>
User-Agent: StGit/0.15-96-g5d79
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147642>


---
 stgit/lib/git.py |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 65d2a6c..899c1a2 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -581,13 +581,15 @@ class Repository(RunWithEnv):
     refs = property(lambda self: self.__refs)
     def cat_object(self, sha1):
         return self.run(['git', 'cat-file', '-p', sha1]).raw_output()
-    def rev_parse(self, rev, discard_stderr = False):
+    def rev_parse(self, rev, discard_stderr = False, object_type = 'commit'):
+        assert object_type in ('commit', 'tree', 'blob')
+        getter = getattr(self, 'get_' + object_type)
         try:
-            return self.get_commit(self.run(
-                    ['git', 'rev-parse', '%s^{commit}' % rev]
+            return getter(self.run(
+                    ['git', 'rev-parse', '%s^{%s}' % (rev, object_type)]
                     ).discard_stderr(discard_stderr).output_one_line())
         except run.RunException:
-            raise RepositoryException('%s: No such revision' % rev)
+            raise RepositoryException('%s: No such %s' % (rev, object_type))
     def get_blob(self, sha1):
         return self.__blobs[sha1]
     def get_tree(self, sha1):
