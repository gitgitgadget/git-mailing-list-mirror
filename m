From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 05/15] contrib: related: parse committish like format-patch
Date: Sat, 12 Oct 2013 02:06:24 -0500
Message-ID: <1381561584-20529-16-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtO0-0005PR-GV
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab3JLHNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:10 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:55750 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab3JLHNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:04 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so3177139oag.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xn76OsMIYUWEz1S0mAKWZ7vCfzh50opB1VITkILJ4k4=;
        b=kdgnTuVdKRR4oHCz767Wefw68VBnSCDRe7hKG+lnsmptsOzI0BgVCvFae89ovwryQg
         jBuOKXX7758RaqpuS26b8Tf85zhWNhXDrzWiWDOadzgjR8eo7PIyLB5ba3sPGVuMBkBd
         alTmCO/eFATt/O7gLDKMR578gxWPOGvl4E08jOc46qnCEDzqPf/pbIomr7rlGmuOA0po
         bbQWWxz1uKIO2PtH0C4TqipCnCqSR7bQcrjj/TSuLwarn0xu2WG0mufls10yuQvmP238
         Jxm7mB2v+VMJn75jId/6FWX0yPQ0pyNYIt/4UoQtyrSTVQf5OAOKlsUmG6+XrGQq+R6t
         ds0Q==
X-Received: by 10.60.93.67 with SMTP id cs3mr17894566oeb.12.1381561983851;
        Sat, 12 Oct 2013 00:13:03 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101359172oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236007>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    | 15 +++++++++++++++
 contrib/related/test-related.t | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 4f78304..80e1f17 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -108,6 +108,21 @@ class Commits
   end
 
   def from_rev_args(args)
+    revs = []
+
+    File.popen(%w[git rev-parse --revs-only --default HEAD --symbolic] + args).each do |rev|
+      revs << rev.chomp
+    end
+
+    case revs.size
+    when 1
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
+    else
+      args = revs
+    end
+
     File.popen(%w[git rev-list --reverse] + args) do |p|
       p.each do |e|
         id = e.chomp
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index b623d69..39b4fe9 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -74,4 +74,14 @@ test_expect_success "from committish" "
 	test_cmp expected actual
 "
 
+test_expect_success "from single rev committish" "
+	git related -1 master | sort > actual &&
+	cat > expected <<-EOF &&
+	John Doe <john@doe.com>
+	John Poppins <john@doe.com>
+	Jon Stewart <jon@stewart.com>
+	EOF
+	test_cmp expected actual
+"
+
 test_done
-- 
1.8.4-fc
