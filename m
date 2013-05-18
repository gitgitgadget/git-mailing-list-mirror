From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 09/15] contrib: related: add mailmap support
Date: Sat, 18 May 2013 06:46:49 -0500
Message-ID: <1368877615-9563-10-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdfdK-0007ET-20
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab3ERLtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:49:00 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61094 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575Ab3ERLs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:57 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so6038407oag.41
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4b4Va8aKvH+fU61EoVcvbH7uXXj+DuJVr8tGrc0PMso=;
        b=ToUBaYcvOzHrkby9UXCMl2AwuZl31O5dZs86xtNWaOjz2vUgBw5xLWIVe0NceQ5+3g
         a4f+x7mKDVyT0VX7rVl7Cpbl1jlKN/OflkEzC0FIlFdC+sgt+PEUGgC5wt5Vpk/g6nVN
         cW2U5eJHJWMxbqg1DXvhAMk9l6Py+vGF4QcP97BeXwDjOot5931ZWST+kheQ+oyIvQO9
         dRox9piO2HcAsD6EW6vtokrSrZBccSjPQsfRNDM4HI8G0n/DD6nhneMVvfpX/jVxS/O0
         cQ47WGaEgTe6J8ZCIV3vD/QiLz4h8A/0cIZAYQt11d9Cq4TASfeI/XpsRXcJeHCxdf5b
         2Y+w==
X-Received: by 10.182.110.169 with SMTP id ib9mr22369519obb.13.1368877736716;
        Sat, 18 May 2013 04:48:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm11187041obb.14.2013.05.18.04.48.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224782>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 9194777..3b11930 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -8,6 +8,9 @@ require 'optparse'
 $since = '5-years-ago'
 $min_percent = 10
 
+$mailmaps = {}
+$mailmaps_complex = {}
+
 begin
   OptionParser.new do |opts|
     opts.program_name = 'git related'
@@ -23,6 +26,29 @@ begin
 rescue OptionParser::InvalidOption
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
+get_aliases if $get_aliases
+get_mailmap('.mailmap')
+mailmap_file = %x[git config mailmap.file].chomp
+get_mailmap(mailmap_file)
+
 KNOWN_ROLES = {
   'Signed-off' => :signer,
   'Reviewed' => :reviewer,
@@ -70,6 +96,17 @@ class Persons
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
-- 
1.8.3.rc2.542.g24820ba
