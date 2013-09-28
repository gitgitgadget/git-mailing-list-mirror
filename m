From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 40/44] ruby: request-pull: use native diff_tree stuff
Date: Sat, 28 Sep 2013 17:04:05 -0500
Message-ID: <1380405849-13000-41-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2kA-0004Ck-HL
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab3I1WMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:03 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53561 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3I1WMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:12:00 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so4200320obb.3
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/K794s74ZUxYdnYX95CVavgbxlZsDmD3IASUZnnq2rI=;
        b=NgTldEyqtmRy3H/b6bYuH+9ZkoRuLGn8lr3FEKPmhz2CkUs9QdwWR1Frny87+knCR6
         w66XVWAZypA4Qvb77NUNYz8XbSpFWWcZP/utFFn/Pu2faPWbCebuFSnhtfQgWHdENEYp
         gamHDsOMRiaQr1rORnTPd7ESuMx9OyHDKgxLa+PuxPQR9o9G4hv0BaMIAAvDjt+sc3ZT
         qrQfP1QFttga+HwpJljg0nNMhn7L3fEh7C75cz9h2rFtFLzGM2A4jNSl1Urz/BE1iIHR
         D1u+/ISO1SgoEMwRR8lruiBk9nSch5cHB0DZhL82Kuh11r9nXtzCaHZDlNiz7v69otWS
         9Ftw==
X-Received: by 10.60.93.67 with SMTP id cs3mr12438929oeb.12.1380406320244;
        Sat, 28 Sep 2013 15:12:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm19527689obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235560>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    We finally got rid of all the system() calls, and thus all the forks.

 git-request-pull.rb | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 0db64c3..e884d0d 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -4,7 +4,7 @@ require 'date'
 
 ENV['GIT_PAGER'] =
 
-patch = ''
+patch = nil
 
 def usage
   puts <<EOF
@@ -84,6 +84,19 @@ def show_shortlog(base, head)
   shortlog(rev.to_a)
 end
 
+def show_diff(patch, base, head)
+  rev = Git::RevInfo.setup(nil, ['^' + sha1_to_hex(base), sha1_to_hex(head)], nil)
+  rev.diffopt.stat_width = -1
+  rev.diffopt.stat_graph_width = -1
+  rev.diffopt.output_format = patch ? DIFF_FORMAT_PATCH : DIFF_FORMAT_DIFFSTAT
+  rev.diffopt.output_format |= DIFF_FORMAT_SUMMARY
+  rev.diffopt.detect_rename = DIFF_DETECT_RENAME
+  rev.diffopt.flags |= DIFF_OPT_RECURSIVE
+
+  diff_tree_sha1(base, head, "", rev.diffopt)
+  log_tree_diff_flush(rev)
+end
+
 until ARGV.empty?
   case ARGV.first
   when '-p'
@@ -180,7 +193,7 @@ for you to fetch changes up to %s:
   end
 
   show_shortlog(base, head)
-  run(%[git diff -M --stat --summary #{patch} ^#{merge_base_commit} #{head}])
+  show_diff(patch, merge_base_id, head_id)
 
   if ! ref
     $stderr.puts "warn: No branch of #{url} is at:"
-- 
1.8.4-fc
