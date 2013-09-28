From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 20/44] ruby: request-pull: simplify tag fetching
Date: Sat, 28 Sep 2013 17:03:45 -0500
Message-ID: <1380405849-13000-21-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jF-0003UK-15
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab3I1WLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:05 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:43663 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:59 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3039382oag.10
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8RbKQ0U/Y/UjlbpDBRGBsWLYAkQqrgp7/FQGRLVjMA=;
        b=PdQEgWaJk+GMNAHOKLUI+1DKIpyv4CKR987M3DLvd+ucQbqvloiKaZQT2b/UMmzV1h
         kWN1s8Hq62xfAqhyo7wto01YBtjIR27U6aGXDh9NzGFmfrnr70IUnIltMUwJHBe022j4
         Fdf3nvoM6chnphjQG2qpNUlyOx2yJPDEe2sINaI6RQ69zfoVEDXRu/dTAoXwwBvQWS1k
         CXWjH6lWsqfqdDvD7tIJD7Ubx7PdanJhPPxdF7sjjqzwASjhPmEdzgC1TQEpC/Whutsn
         fN2XQT2SDYRwpeYMW26cZoD2iYwA2cI5exUOpALrZGc3N65v0Rgq7uTtvDaMaySpkl1+
         e3CA==
X-Received: by 10.182.117.195 with SMTP id kg3mr12397011obb.17.1380406258560;
        Sat, 28 Sep 2013 15:10:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm19542632obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235540>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    For the moment we use "str[10..-1]" to denote the equivalent of "str + 10" in
    C, even though Ruby has nicer constructs than that.

 git-request-pull.rb | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 0f85024..25dc04d 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -21,6 +21,15 @@ def read_branch_desc(name)
   return nil
 end
 
+def describe(rev)
+  for_each_ref() do |name, sha1, flags|
+    next unless name.start_with?('refs/tags/')
+    next unless peel_ref(name) == get_sha1(rev)
+    return name[10..-1]
+  end
+  return nil
+end
+
 def abbr(ref)
   if (ref =~ %r{^refs/heads/(.*)} || ref =~ %r{^refs/(tags/.*)})
     return $1
@@ -81,7 +90,7 @@ if headref.start_with?('refs/heads')
   branch_name = nil if not branch_desc
 end
 
-tag_name = `git describe --exact "#{head}^0" 2>/dev/null`.chomp
+tag_name = describe(head)
 
 baserev = `git rev-parse --verify --quiet "#{base}"^0`.chomp
 die "Not a valid revision: #{base}" if baserev.empty?
@@ -116,7 +125,7 @@ for you to fetch changes up to %H:
     puts branch_desc
   end
 
-  if not tag_name.empty?
+  if tag_name
     if ref != "tags/#{tag_name}"
       $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
       $stderr.puts "warn: appear to be at #{url}"
@@ -126,7 +135,7 @@ for you to fetch changes up to %H:
     puts
   end
 
-  if branch_name || ! tag_name.empty?
+  if branch_name || tag_name
     puts "----------------------------------------------------------------"
   end
 
-- 
1.8.4-fc
