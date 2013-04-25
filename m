From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/11] contrib: related: add support for mailmap
Date: Thu, 25 Apr 2013 14:59:43 -0500
Message-ID: <1366919983-27521-12-git-send-email-felipe.contreras@gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 22:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSMR-0004FC-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538Ab3DYUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:01:39 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:45261 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab3DYUBi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:01:38 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so2868185obb.28
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FeRu+29CHTGLdl3qcLvQy/KaLyFoxjspNb5T4XHuB98=;
        b=MWxVw8Kg1wuHBZUUi3Uqkg5daQ3JeB92kfM+FUIMz3I9gUsodtUEoGEOSYosg4ez8h
         Zr+tiT1RjvPLs47lqHW4cfQBLsmMcKlbVR1+E2wERNfFD1hQpMM5X+rE7aKYx0QnjNvi
         BNUhoYAugTGm5/3M5f4mJZhNHjLbC5NIfWKgVQKCQsu3SfMht/ulNIpcK5Qz1B9hHRM+
         EncdnWM1ZRlFdDwjfnqQk1ARUPYkIW9jJwt0pyadGNEB4wrpCCi+IqJ91z5NAwYk32XL
         pzU4PXhMlXofPXPhqKfGl2f4bpRB+JCsO/wjXZ1FGTPCXbEmWZP265ntW2R9AlmSlxVL
         EtLw==
X-Received: by 10.182.80.201 with SMTP id t9mr16009395obx.52.1366920097593;
        Thu, 25 Apr 2013 13:01:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a3sm4947717oee.8.2013.04.25.13.01.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 13:01:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222439>

This seems to be the way git tools do it.

Suggested-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index f85e924..be263e2 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -7,6 +7,8 @@ $min_percent = 5
 $show_commits = false
 $files = []
 $rev_args = []
+$mailmaps = {}
+$mailmaps_complex = {}
 
 begin
   OptionParser.new do |opts|
@@ -27,6 +29,39 @@ rescue OptionParser::InvalidOption => e
   $rev_args += e.args
 end
 
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
+def mailmap_fix(person)
+  new = nil
+  name, email = person
+  new = $mailmaps_complex[person] if not new and $mailmaps_complex.include?(person)
+  new = $mailmaps[email] if not new and $mailmaps.include?(email)
+  return if not new
+  person[0] = new[0] if new[0]
+  person[1] = new[1] if new[1]
+end
+
+get_aliases if $get_aliases
+get_mailmap('.mailmap')
+mailmap_file = %x[git config mailmap.file].chomp
+get_mailmap(mailmap_file)
+
 KNOWN_ROLES = {
   'Signed-off' => :signer,
   'Reviewed' => :reviewer,
@@ -65,6 +100,7 @@ class Commit
       end
     end
     @roles = roles.map do |person, roles|
+      mailmap_fix(person)
       [person, roles]
     end
   end
-- 
1.8.2.1
