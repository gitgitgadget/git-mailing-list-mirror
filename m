From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 12/15] contrib: related: add mailmap support
Date: Sat, 12 Oct 2013 02:06:19 -0500
Message-ID: <1381561584-20529-11-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNi-00059v-GU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab3JLHM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:56 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35117 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab3JLHMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:52 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so3408045obc.6
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vc0+6SMnoeVGHtTmj0BESt+L8ttckZkudYxFmYf6Uyc=;
        b=eTepHkdhTrfmpjhrCLORJcFU2GG0uZe8ZK9qhnb4ozd5r1fmMUSNuUZWcncLA8SEpt
         jWmKkUvahCdkTXJJOet/jRGK388Q8uid8z05XkJXWcCs263PbncsfyC4VQrVCOE1zNuz
         xlKtQN/dMF0N20hU8mliD4MNeppZyBLJ92+vF82rieAA9NOKQeNCZCnanPLLvt5GUsCt
         +vJMhvLbmg+PPCRxn/zqricXfFUT+HYefBBoUZJEupLQFmUtqfueDtoIIFUt6Anxapnn
         Qs9117cIN/dKK2E2X21cCot+CNQi5O8slmAguT63yeToHLtJ3l3E4rLC/+B985HsYp5v
         jqdA==
X-Received: by 10.60.65.227 with SMTP id a3mr17731272oet.13.1381561971543;
        Sat, 12 Oct 2013 00:12:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm28637744obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236002>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 37 +++++++++++++++++++++++++++++++++++++
 contrib/related/test-related.t | 14 ++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index f15e4e7..6ab74c7 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,6 +8,9 @@ $min_percent = 10
 $files = []
 $rev_args = []
 
+$mailmaps = {}
+$mailmaps_complex = {}
+
 git_dir = %x[git rev-parse --git-dir].chomp
 $base_dir = File.dirname(git_dir)
 $cur_dir = Dir.pwd
@@ -19,6 +22,29 @@ KNOWN_ROLES = {
   'Cc' => :cced,
 }
 
+def get_mailmap(filename)
+  return unless File.exists?(filename)
+  File.open(filename) do |f|
+    f.each do |line|
+      case line.gsub(/\s*#.*$/, '')
+      when /^([^<>]+)\s+<(\S+)>$/
+        $mailmaps[$2] = [ $1, nil ]
+      when /^<(\S+)>\s+<(\S+)>$/
+        $mailmaps[$2] = [ nil, $1 ]
+      when /^([^<>]+)\s+<(\S+)>\s+<(\S+)>$/
+        $mailmaps[$3] = [ $1, $2 ]
+      when /^([^<>]+)\s+<(\S+)>\s+([^<>]+)\s+<(\S+)>$/
+        $mailmaps_complex[[$3, $4]] = [ $1, $2 ]
+      end
+    end
+  end
+end
+
+get_aliases if $get_aliases
+get_mailmap(File.join($base_dir, '.mailmap'))
+mailmap_file = %x[git config mailmap.file].chomp
+get_mailmap(mailmap_file)
+
 class Person
 
   attr_reader :roles
@@ -60,6 +86,17 @@ class Persons
   end
 
   def self.get(name, email)
+
+    # fix with mailmap
+    person = [name, email]
+    new = nil
+    new = $mailmaps_complex[person] if not new and $mailmaps_complex.include?(person)
+    new = $mailmaps[email] if not new and $mailmaps.include?(email)
+    if new
+      name = new[0] if new[0]
+      email = new[1] if new[1]
+    end
+
     id = email.downcase
     person = @@index[id]
     if not person
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index a19ad32..fa8c1a7 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -80,4 +80,18 @@ test_expect_success "from single rev committish" "
 	test_cmp expected actual
 "
 
+test_expect_success "mailmap" "
+	test_when_finished 'rm -rf .mailmap' &&
+	cat > .mailmap <<-EOF &&
+	Jon McAvoy <jon@stewart.com>
+	John Poppins <john@poppins.com> <john@doe.com>
+	EOF
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Poppins <john@poppins.com> (author: 66%)
+	Jon McAvoy <jon@stewart.com> (reviewer: 33%, author: 33%)
+	EOF
+	test_cmp expected actual
+"
+
 test_done
-- 
1.8.4-fc
