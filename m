From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 14/15] contrib: related: add option to show commits
Date: Sat, 12 Oct 2013 02:06:09 -0500
Message-ID: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNK-0004uk-Oe
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab3JLHM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:28 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:34395 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab3JLHM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:26 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so3067115oag.23
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dv73BQabrEEVS6sYKuS7TSUKHZiZk7V6+bdzH/8NpR0=;
        b=vl0eLVwR8tPJFfgenNBzEvLG6pi1ss8dpHzkg6tsHMQNGMDGkcE7ErMaDv25qZ/ygj
         FBaMgmZrlgfomfQyhciGTV3Rc3Z8b6aaNqx/+dkBIf4V30fGfjP9KORsqBvcLZgbygTz
         zrKE90Zi72jtb4NnYoFQR2fWBSR3bB1L6ubuUgLmYl6pDHfB5FwhXQc5pjPsMANE6AFh
         wgjsxIs5ZAubeMEhU6r92NQtpQlC0m4km4NKMIVwg7eszvtfDRDRVB0KnLIzYSj0KYKp
         WRblrJiVDMDHn6/6JAxnHgXHRrywEdKKpPucOBLliXjKfrPKRl/rI/C81p+FZWDRXm3U
         SUmA==
X-Received: by 10.60.80.8 with SMTP id n8mr17665121oex.33.1381561945681;
        Sat, 12 Oct 2013 00:12:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm101382909oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235992>

Instead of showing the authors and signers, show the commits themselves.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 23 +++++++++++++++++++++++
 contrib/related/test-related.t | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index d6b44c7..b9c8619 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -7,6 +7,7 @@ $since = '5-years-ago'
 $min_percent = 10
 $files = []
 $rev_args = []
+$show_commits = false
 
 $mailmaps = {}
 $mailmaps_complex = {}
@@ -128,6 +129,10 @@ opts.on('d', 'since', 'How far back to search for relevant commits') do |v|
   $since = v
 end
 
+opts.on('c', 'commits', 'List commits instead of persons') do |v|
+  $show_commits = v
+end
+
 opts.parse
 
 class Person
@@ -238,6 +243,10 @@ class Commits
     @items.each(&block)
   end
 
+  def list
+    @items.keys
+  end
+
   def import
     return if @items.empty?
     File.popen(%w[git cat-file --batch], 'r+') do |p|
@@ -339,6 +348,20 @@ else
 end
 commits.import
 
+if $show_commits
+  cmd = nil
+  case $show_commits
+  when 'raw'
+    puts commits.list
+  when 'full'
+    cmd = %w[git log --patch --no-walk]
+  else
+    cmd = %w[git log --oneline --no-walk]
+  end
+  system(*cmd + commits.list) if cmd
+  exit 0
+end
+
 persons = Persons.new
 
 persons.sort.reverse.each do |person|
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index fa8c1a7..f357e30 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -94,4 +94,14 @@ test_expect_success "mailmap" "
 	test_cmp expected actual
 "
 
+test_expect_success "commits" "
+	git related -craw -1 master | git log --format='%s' --no-walk --stdin > actual &&
+	cat > expected <<-EOF &&
+	four
+	three
+	one
+	EOF
+	test_cmp expected actual
+"
+
 test_done
-- 
1.8.4-fc
