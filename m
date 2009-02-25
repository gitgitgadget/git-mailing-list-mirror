From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new
 pack
Date: Tue, 24 Feb 2009 23:15:56 -0800
Message-ID: <7vk57fc7gz.fsf@gitster.siamese.dyndns.org>
References: <49A428B7.4000003@spiralti.com>
 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
 <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 08:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcE1k-0003o3-Rv
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 08:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbZBYHQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 02:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbZBYHQG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 02:16:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58995 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322AbZBYHQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 02:16:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 34E3B1143;
	Thu, 26 Feb 2009 02:16:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D4B9113E; Thu,
 26 Feb 2009 02:15:57 -0500 (EST)
In-Reply-To: <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Tue, 24 Feb 2009 23:11:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5257723A-03D5-11DE-9E11-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111382>

This is *not* to be applied, but to document and demonstrate how I tested
the previous fix.  It disables the creation of .git/objects/pack/
directory when "git init" is run, and adds minimum workaround in the tests
that assume the directory is always created.

---
 builtin-init-db.c      |    2 +-
 t/t0000-basic.sh       |    2 +-
 t/t5300-pack-object.sh |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index d30c3fe..e5fc4c1 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -301,7 +301,7 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	safe_create_dir(sha1_dir, 1);
 	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
+/*	safe_create_dir(path, 1); */
 	strcpy(path+len, "/info");
 	safe_create_dir(path, 1);
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 70df15c..6240ca4 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -42,7 +42,7 @@ test_expect_success \
 # also it should have 2 subdirectories; no fan-out anymore, pack, and info.
 # 3 is counting "objects" itself
 find .git/objects -type d -print >full-of-directories
-test_expect_success \
+: test_expect_success \
     '.git/objects should have 3 subdirectories.' \
     'test $(wc -l < full-of-directories) = 3'
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 73d871c..e7d8daf 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -138,6 +138,7 @@ test_expect_success \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
      git init &&
+     mkdir -p .git2/objects/pack &&
      cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
 	 git diff-tree --root -p $commit &&
 	 while read object
