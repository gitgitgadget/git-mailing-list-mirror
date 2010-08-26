From: Csaba Henk <csaba@gluster.com>
Subject: [PATCH] bundle: detect if bundle file cannot be created
Date: Thu, 26 Aug 2010 14:53:33 +0530
Message-ID: <20100826092333.GB32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 11:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoYgU-0005k7-JJ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 11:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab0HZJXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 05:23:42 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:43550 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab0HZJXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 05:23:40 -0400
Received: by pxi10 with SMTP id 10so542985pxi.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=vZkW4aI/rOsay75CV1odGeVJUesaznr92n63axRRL4c=;
        b=QfWW0mtlFQaJZWzY2bA7p6KfKhOuPClfgJ142veRQGQiAe73WgxfT1vLUZ0AZKnrux
         eH4IECM1vaajlxoeROR2cy81TjMVUrqhVazr+EBSZaB4zlF7BKYUClFr/CLSha2ISUKW
         dnAYeSU66HyaL4qDCo7xj4pRgi/GdRr7eQHPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=dBK6SD/v2cY+i0Wki6Bml53UBLi93gTQGH87n/Zn3pArB3e8V9JIrNuNsIPQ6dB6gm
         RJuAhDepR6iH5zh42U4fVPUzbbGAzWbVHjh4HSiq7bsfIGLP8fc68l9bgqKAsxiOw5TP
         X5Nf7BZ2YfvLaS2PZ3hGV1jebz8lvGZ8pQ+SU=
Received: by 10.142.201.7 with SMTP id y7mr8017782wff.282.1282814618346;
        Thu, 26 Aug 2010 02:23:38 -0700 (PDT)
Received: from acharya.in.gluster.com ([122.181.163.210])
        by mx.google.com with ESMTPS id n2sm2700321wfl.13.2010.08.26.02.23.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 02:23:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154535>

bundle command silently died with no sign of failure if it
could not create the bundle file. (Eg.: its path resovles to a directory,
or the parent dir is sticky while file already exists and is owned
by someone else.)
---
 bundle.c          |    6 ++++--
 t/t5704-bundle.sh |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index ff97adc..3eb4ca2 100644
--- a/bundle.c
+++ b/bundle.c
@@ -372,8 +372,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 	close(rls.in);
 	if (finish_command(&rls))
 		return error ("pack-objects died");
-	if (!bundle_to_stdout)
-		commit_lock_file(&lock);
+	if (!bundle_to_stdout) {
+		if (commit_lock_file(&lock))
+			die_errno("cannot create bundle file");
+	}
 	return 0;
 }
 
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index ddc3dc5..728ccd8 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -30,6 +30,13 @@ test_expect_success 'tags can be excluded by rev-list options' '
 
 '
 
+test_expect_success 'die if bundle file cannot be created' '
+
+	mkdir adir &&
+	test_must_fail git bundle create adir --all
+
+'
+
 test_expect_failure 'bundle --stdin' '
 
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
-- 
1.7.2.2
