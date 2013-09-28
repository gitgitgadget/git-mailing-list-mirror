From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/44] ruby: request-pull: rewrite perl script
Date: Sat, 28 Sep 2013 17:03:36 -0500
Message-ID: <1380405849-13000-12-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2ik-00035n-Ga
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab3I1WKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:33 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:56602 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3I1WK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:29 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so2953521oag.26
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ci2ByE2nQ+Qb3hyA5vDECnKeKTmVYq5QBUhIwnvfRWw=;
        b=J+wTjuENuCzOpTxWUvxV1ou3N93G84riYjTAd7Qx/PkltaqWwM40aqR9zaO1slfMRf
         0nLYlI4x0QHI2T+H5scEne0BKroYNqJogZs+wVPpqYkV60sFU0BTRPhqpKaiNfDeVgg9
         YHdONaysmAfl751v+VO2yrvFV5Gi//4EqXtQgLu67YB9pL2VtpIjF3rgymeK1F3K10/F
         1Kiis8yTf1Te9ouN+BVvLTe3zIZoXXZeHjFKdKDBXV4bablJRH+9uB4fk5xnw8erqaC0
         reicSzrkOnlsHJbtI8qV6y/U/ZKHU7OAaDSM5dgNRwyGXg9jP2ESCAWncqpV6YcFL5xJ
         890g==
X-Received: by 10.182.49.166 with SMTP id v6mr12174174obn.13.1380406228793;
        Sat, 28 Sep 2013 15:10:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm19483835obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235531>

Ruby can do it just fine, no need for perl.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    I'm mostly ignoring the comment, my hope is that it would be redundant, as the
    code would be self-documenting.

 git-request-pull.rb | 65 +++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 60cf6ce..eee2e28 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -14,6 +14,35 @@ EOF
   exit 1
 end
 
+def abbr(ref)
+  if (ref =~ %r{^refs/heads/(.*)} || ref =~ %r{^refs/(tags/.*)})
+    return $1
+  end
+  return ref
+end
+
+# $head is the token given from the command line, and $tag_name, if
+# exists, is the tag we are going to show the commit information for.
+# If that tag exists at the remote and it points at the commit, use it.
+# Otherwise, if a branch with the same name as $head exists at the remote
+# and their values match, use that instead.
+#
+# Otherwise find a random ref that matches $headrev.
+
+def get_ref(url, headref, headrev, tag_name)
+  found = nil
+  IO.popen(%[git ls-remote "#{url}"]) do |out|
+    out.each do |l|
+      sha1, ref, deref = l.scan(/^(\S+)\s+(\S+?)(\^\{\})?$/).first
+      next unless sha1 == headrev
+      found = abbr(ref)
+      break if (deref && ref == "refs/tags/#{tag_name}")
+      break if ref == headref
+    end
+  end
+  return found
+end
+
 until ARGV.empty?
   case ARGV.first
   when '-p'
@@ -57,41 +86,7 @@ die "Not a valid revision: #{head}" if headrev.empty?
 merge_base = `git merge-base #{baserev} #{headrev}`.chomp
 die "No commits in common between #{base} and #{head}" unless $?.success?
 
-# $head is the token given from the command line, and $tag_name, if
-# exists, is the tag we are going to show the commit information for.
-# If that tag exists at the remote and it points at the commit, use it.
-# Otherwise, if a branch with the same name as $head exists at the remote
-# and their values match, use that instead.
-#
-# Otherwise find a random ref that matches $headrev.
-find_matching_ref='
-	sub abbr {
-		my $ref = shift;
-		if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
-			return $ref;
-		} else {
-			return $ref;
-		}
-	}
-
-	my ($found);
-	while (<STDIN>) {
-		my ($sha1, $ref, $deref) = /^(\S+)\s+(\S+?)(\^\{\})?$/;
-		next unless ($sha1 eq $ARGV[1]);
-		$found = abbr($ref);
-		if ($deref && $ref eq "refs/tags/$ARGV[2]") {
-			last;
-		}
-		if ($ref eq $ARGV[0]) {
-			last;
-		}
-	}
-	if ($found) {
-		print "$found\n";
-	}
-'
-
-ref = `git ls-remote "#{url}" | perl -e '#{find_matching_ref}' "#{headref}" "#{headrev}" "#{tag_name}"`.chomp
+ref = get_ref(url, headref, headrev, tag_name) || ''
 url = `git ls-remote --get-url "#{url}"`.chomp
 
 begin
-- 
1.8.4-fc
