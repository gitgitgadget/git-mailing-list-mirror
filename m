From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH/RFC 5/7] ruby: rewrite perl script
Date: Sat, 21 Sep 2013 13:48:13 -0500
Message-ID: <1379789295-18519-6-git-send-email-felipe.contreras@gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 20:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSJk-0000bM-BV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 20:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab3IUSyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 14:54:04 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:52436 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3IUSyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 14:54:03 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so2119609obc.13
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t8/8GOG5yvAeo/pYqwbxzS181utwuOHdPlRVmTW78VA=;
        b=OAKZEimV/+DYN5dATsVj9Je8gIZ+AaQxZjl6PjMe9d2lf4t/NacU66hhJaM5ocoWkZ
         0n44k347Que8VX2hO0trXCO1ldE0cOSZ0v/CBv3YfaHP7kD3FpGO22ZPvbr4ywnIGzLf
         z+ea8Esw6ZFRxgVKoL5udn0hnnJaHtTZYFL2QpCeMV+xajE/fL0EqVUC46R2Q9O/JU2N
         ultaArnVv9FuGbAXG+toX6Y6M3mTvkHUVj4X+yflkOT3uPoE0gfKCdAut0xUlEHluwRK
         ZLS9gWbpSTsNsP8UY+ZtVjjWckWmZZZzauqdhamsU+x6NAfvYe6D/A9KoRgU36Q/NPdg
         k5eQ==
X-Received: by 10.60.63.68 with SMTP id e4mr11653265oes.23.1379789641821;
        Sat, 21 Sep 2013 11:54:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm7811699oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 11:54:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235139>

Ruby can do it just fine, no need for perl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 66 ++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index b6d0156..6a96a98 100644
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -67,39 +67,39 @@ die "No commits in common between #{base} and #{head}" unless $?.success?
 # and their values match, use that instead.
 #
 # Otherwise find a random ref that matches $headrev.
-find_matching_ref='
-  sub abbr {
-    my $ref = shift;
-    if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
-      return $ref;
-    } else {
-      return $ref;
-    }
-  }
-
-  my ($tagged, $branch, $found);
-  while (<STDIN>) {
-    my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
-    next unless ($sha1 eq $ARGV[1]);
-    $found = abbr($ref);
-    if ($deref && $ref eq "tags/$ARGV[2]") {
-      $tagged = $found;
-      last;
-    }
-    if ($ref =~ m|/\Q$ARGV[0]\E$|) {
-      $exact = $found;
-    }
-  }
-  if ($tagged) {
-    print "$tagged\n";
-  } elsif ($exact) {
-    print "$exact\n";
-  } elsif ($found) {
-    print "$found\n";
-  }
-'
-
-ref = `git ls-remote "#{url}" | perl -e '#{find_matching_ref}' "#{head}" "#{headrev}" "#{tag_name}"`.chomp
+
+def abbr(ref)
+    if (ref =~ /^refs\/heads\/(.*)/ || ref =~ /^refs\/(tags\/.*)/)
+      return $1
+    end
+    return ref
+end
+
+found = tagged = exact = nil
+IO.popen(%[git ls-remote "#{url}"]) do |out|
+  out.each do |l|
+    sha1, ref, deref = l.scan(/^(\S+)\s+(\S+?)(\^\{\})?$/).first
+    next unless sha1 == headrev
+    found = abbr(ref)
+    if (deref && ref == "tags/#{tag_name}")
+      tagged = found
+      break
+    end
+    if (ref =~ /\/#{Regexp.escape(head)}$/m)
+      exact = found
+    end
+  end
+end
+
+if tagged
+  ref = tagged
+elsif exact
+  ref = exact
+else
+  ref = found
+end
+
+ref = '' if ref == nil
 url = `git ls-remote --get-url "#{url}"`.chomp
 
 begin
-- 
1.8.4-fc
