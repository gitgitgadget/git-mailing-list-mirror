From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 24/44] ruby: request-pull: use get_merge_bases()
Date: Sat, 28 Sep 2013 17:03:49 -0500
Message-ID: <1380405849-13000-25-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2jX-0003iY-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab3I1WLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:11:25 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:36476 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab3I1WLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:11:10 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3010460oag.20
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/rQeQTtATzgcs6Qvg96IPtXLeNU607TAJdRSTsS0qTg=;
        b=KSMuNHFi/BNcoaPo2GexUlp7DER/E7yDp5q6CIzpRZ/KnACsACJX7+M4gqYd/mjdH5
         jW71wMjcCCk4Qjh0j2YJcYDLRZW09XZAkZscljJ1bsP3FvjblX+TsS66gVABbfSgK34H
         3ZZm6aVh3y1ETNQPCXRLsZim/XnjwN+XageiY/a1dg5DtKbYv+lsPtOUoPF9ZxRzyV+2
         QmIOLn6eqx/FSmFo1/nvrCXloPmGuPgJ2fT7zv8cZte9+MgqHPU+mIumdkkxDMVXwzmZ
         KeB2Bi2yhE52gYH6HPaVBEr/YWo7hqVw2pT1/iEroyzynTee09vWGFT50IpXOmjHirxK
         mxCg==
X-Received: by 10.182.104.130 with SMTP id ge2mr12350673obb.6.1380406269739;
        Sat, 28 Sep 2013 15:11:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm25478113oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:11:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235545>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Notes:
    Now headrev and baserev become Git::Commit objects, fortunately
    'puts("#{commit}")' or 'printf("%s\n", commit) convert the commit to a String
    (commit.to_s()), which is the hex sha1, so the rest of the script doesn't need
    to be changed.

 git-request-pull.rb | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 9267147..be4947d 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -98,13 +98,15 @@ die "Not a valid revision: #{base}" unless baserev
 headrev = get_sha1("#{head}^0")
 die "Not a valid revision: #{head}" unless headrev
 
-baserev = sha1_to_hex(baserev)
-headrev = sha1_to_hex(headrev)
+baserev = Git::Commit.get(baserev)
+headrev = Git::Commit.get(headrev)
 
-merge_base = `git merge-base #{baserev} #{headrev}`.chomp
-die "No commits in common between #{base} and #{head}" unless $?.success?
+merge_bases = get_merge_bases([baserev, headrev], 0);
+die "No commits in common between #{base} and #{head}" unless merge_bases
 
-ref = get_ref(url, headref != "HEAD" ? headref : nil, headrev, tag_name)
+merge_base = sha1_to_hex(merge_bases.first.sha1)
+
+ref = get_ref(url, headref != "HEAD" ? headref : nil, headrev.to_s, tag_name)
 url = `git ls-remote --get-url "#{url}"`.chomp
 
 begin
-- 
1.8.4-fc
