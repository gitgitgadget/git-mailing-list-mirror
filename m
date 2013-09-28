From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 27/44] ruby: request-pull: use native remote and transport
Date: Sat, 28 Sep 2013 17:03:52 -0500
Message-ID: <1380405849-13000-28-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jW-0003iY-J0
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab3I1WLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:21 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39068 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279Ab3I1WLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:18 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so4176318obc.16
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PLvBOoS1A5P0y1TCsYiTRhiYGqXdNKzqm/Xp41WoZug=;
        b=M+frCYLso007m4C3WoiehwDHf1l4aioS9uvbpu/lkl/7HYWmpsoXNIfICXRILzzN8f
         IwAKS9ZqaUZOeJpiXziG2gCp4mzWA1uHk4cToi+EWna/uJHidRz3O5a8DbNCXs5JlbmA
         8icDuHrUz+hpGYkMW5BEE6/2HMls/LsOJMwxFDoPy42zfAPwySH/3H2QgsjvNcpkAfEb
         jifY6VkuaHc79kMyr92wYqMVjucrer7LZWHxJtV4T9I6Jaq5iqp0sFPSuE7a4dT/Gnpx
         t2t4pz5FTkxdi8J9oPg/kZvsnWfO1bCrnhL0C81Bmj+/5oLhNZwRvrmJZZSkVtBl1JoU
         YlwA==
X-Received: by 10.182.130.131 with SMTP id oe3mr12438876obb.34.1380406278050;
        Sat, 28 Sep 2013 15:11:18 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm19472586obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235547>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 79a26dc..869f160 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -45,16 +45,15 @@ end
 #
 # Otherwise find a random ref that matches $head_id.
 
-def get_ref(url, head_ref, head_id, tag_name)
+def get_ref(transport, head_ref, head_id, tag_name)
   found = nil
-  IO.popen(%[git ls-remote "#{url}"]) do |out|
-    out.each do |l|
-      sha1, ref, deref = l.scan(/^(\S+)\s+(\S+?)(\^\{\})?$/).first
-      next unless sha1 == head_id
-      found = abbr(ref)
-      break if (deref && ref == "refs/tags/#{tag_name}")
-      break if ref == head_ref
-    end
+  transport.get_remote_refs().each do |e|
+    sha1 = e.old_sha1
+    next unless sha1 == head_id
+    ref, deref = e.name.scan(/^(\S+?)(\^\{\})?$/).first
+    found = abbr(ref)
+    break if (deref && ref == "refs/tags/#{tag_name}")
+    break if ref == head_ref
   end
   return found
 end
@@ -106,8 +105,11 @@ die "No commits in common between #{base} and #{head}" unless merge_bases
 
 merge_base = sha1_to_hex(merge_bases.first.sha1)
 
-ref = get_ref(url, head_ref != "HEAD" ? head_ref : nil, head_commit.to_s, tag_name)
-url = `git ls-remote --get-url "#{url}"`.chomp
+remote = remote_get(url)
+transport = transport_get(remote, nil)
+
+ref = get_ref(transport, head_ref != "HEAD" ? head_ref : nil, head_id, tag_name)
+url = remote.url.first
 
 begin
   run(%[git show -s --format='The following changes since commit %H:
-- 
1.8.4-fc
