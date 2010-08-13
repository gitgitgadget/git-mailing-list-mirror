From: Daniel Johnson <computerdruid@gmail.com>
Subject: [RFC/PATCH] t5525: test the tagopt variable and that it can be overridden
Date: Fri, 13 Aug 2010 16:13:30 -0400
Message-ID: <1281730410-20009-1-git-send-email-ComputerDruid@gmail.com>
References: <7v8w4bmhmc.fsf@alter.siamese.dyndns.org>
Cc: Daniel Johnson <ComputerDruid@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 22:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok0eC-0002wj-Bl
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0HMUOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 16:14:31 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51307 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0HMUOa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:14:30 -0400
Received: by qyk29 with SMTP id 29so52722qyk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ds+PsA6x2jZCoWqMIBYZXfaUCeZy52i5DLWAQkHZz3k=;
        b=tjpFOqzR9974RSoEzPmDfjkFkBKkJlp2H4t9ksYzK7RK/HJWeOKjOPcIkobRc7tM8w
         kA0F+SFoxmT9yQ2c+LU9b8EaWiL8giQXNKlMbGfZRrcBSpH58CM2vy2P/voFDAQbVQL3
         w0SrkUpEA0IhWKiTl9fyGRBQwUaaWK1dOK6AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PJthQuaC6L86C1AVdGyws+rBslyR3ig7We5rs340vq8EyYLateZ7lZ8DIR5jAn3jJW
         VdkQ7uxc+sXmXbqPIIfVkQnyeyMvu+h9SuGbXR0+sgxhfTgAohdur50XvG5UPgakpzBi
         zqvcMAK5Gk286blnoeREzx5klCpojDo7Qs3Gc=
Received: by 10.224.65.138 with SMTP id j10mr1383042qai.147.1281730467807;
        Fri, 13 Aug 2010 13:14:27 -0700 (PDT)
Received: from ComputerDruid@gmail.com (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id r38sm3849640qcs.38.2010.08.13.13.14.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:14:26 -0700 (PDT)
Received: by ComputerDruid@gmail.com (sSMTP sendmail emulation); Fri, 13 Aug 2010 16:14:38 -0400
X-Mailer: git-send-email 1.7.2
In-Reply-To: <7v8w4bmhmc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153490>

---
> The current behaviour seems to me a bug introduced while git-fetch was
> rewritten in C (the original found in contrib/examples reads from the
> config only when no --tags/--no-tags option is given from the command
> line).
>
> Is this something we can protect with a test script from future breakages?
This should test that behavior. I'd appreciate feedback on how to improve this
test. I'm not sure if this is the right name/number either.

 t/t5525-fetch-tagopt.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100755 t/t5525-fetch-tagopt.sh

diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
new file mode 100755
index 0000000..17bd407
--- /dev/null
+++ b/t/t5525-fetch-tagopt.sh
@@ -0,0 +1,44 @@
+
+#!/bin/sh
+
+test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
+
+. ./test-lib.sh
+
+setup_clone () {
+	(git clone --mirror . $1 &&
+	git remote add remote_$1 $1 &&
+	cd $1 &&
+	git tag tag_$1)
+}
+
+test_expect_success setup '
+	echo >file original &&
+	git add file &&
+	git commit -a -m original &&
+	setup_clone one &&
+	git config remote.remote_one.tagopt --no-tags &&
+	setup_clone two &&
+	git config remote.remote_two.tagopt --tags
+	'
+
+test_expect_success "fetch with tagopt=--no-tags does not get tag" '
+	git fetch remote_one &&
+	! (git show-ref tag_one)
+	'
+
+test_expect_success "fetch --tags with tagopt=--no-tags gets tag" '
+	git fetch --tags remote_one &&
+	(git show-ref tag_one)
+	'
+
+test_expect_success "fetch --no-tags with tagopt=--tags does not get tag" '
+	git fetch --no-tags remote_two &&
+	! (git show-ref tag_two)
+	'
+
+test_expect_success "fetch with tagopt=--tags gets tag" '
+	git fetch remote_two &&
+	(git show-ref tag_two)
+	'
+test_done
-- 
1.7.2
