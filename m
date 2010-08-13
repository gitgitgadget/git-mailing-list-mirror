From: Daniel Johnson <computerdruid@gmail.com>
Subject: [RFC/PATCHv2] t5525: test the tagopt variable and that it can be overridden
Date: Fri, 13 Aug 2010 17:27:32 -0400
Message-ID: <1281734852-21413-1-git-send-email-ComputerDruid@gmail.com>
References: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com>
Cc: Daniel Johnson <ComputerDruid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:29:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1oJ-0005nb-Mv
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661Ab0HMV3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 17:29:02 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37096 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab0HMV3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 17:29:00 -0400
Received: by qyk9 with SMTP id 9so1282736qyk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=yShjIIqKc4mpUtL0rUEnlSpGzz6INTWBx26iyjBQXOA=;
        b=KeJwkqjq4fwteiiCmyr2/rnsivmPB4gkoiTyxV4hTaEiKTf9sFM7g49eCmd5OaR/iU
         rkUifzaUinX7OGwiv1L8FjOu0dtmzbTk1tEr9efpMOKjgWyr5SgU+nIohg0EShxmQd3w
         XBCFlRBhf/gYez55e7RdLEFJuSY/BnPUYS0p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rAE7vOATUvkfdxw033q8v7iYwh3ylogI/PUctCrJbalVPoCyXuXfd00wckw1+kTpiT
         +ZvINnZ6XjWG+j3iBNzVGNlb7P/ni1eIxVUdnCDvuo2dO67QcQXvMk7zxP46Kn/biXx5
         p4KurzFrEV+rnKPrBzqWeZG0vIIfJl+04T9cg=
Received: by 10.229.229.18 with SMTP id jg18mr377858qcb.156.1281734939544;
        Fri, 13 Aug 2010 14:28:59 -0700 (PDT)
Received: from ComputerDruid@gmail.com (pool-71-163-16-224.bltmmd.fios.verizon.net [71.163.16.224])
        by mx.google.com with ESMTPS id q8sm3951303qcs.24.2010.08.13.14.28.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 14:28:58 -0700 (PDT)
Received: by ComputerDruid@gmail.com (sSMTP sendmail emulation); Fri, 13 Aug 2010 17:29:10 -0400
X-Mailer: git-send-email 1.7.2
In-Reply-To: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153510>

---
>> @@ -0,0 +1,44 @@
>> +
>> +#!/bin/sh
>
> Is that an empty line before the test begins? The shebang should be on
> the first line.
Embarrassing. That's what I get for using yank/put and not paying closer
attention. The rest is fixed too.

 t/t5525-fetch-tagopt.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)
 create mode 100755 t/t5525-fetch-tagopt.sh

diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
new file mode 100755
index 0000000..4fbf7a1
--- /dev/null
+++ b/t/t5525-fetch-tagopt.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
+
+. ./test-lib.sh
+
+setup_clone () {
+	git clone --mirror . $1 &&
+	git remote add remote_$1 $1 &&
+	(cd $1 &&
+	git tag tag_$1)
+}
+
+test_expect_success setup '
+	test_commit test &&
+	setup_clone one &&
+	git config remote.remote_one.tagopt --no-tags &&
+	setup_clone two &&
+	git config remote.remote_two.tagopt --tags
+	'
+
+test_expect_success "fetch with tagopt=--no-tags does not get tag" '
+	git fetch remote_one &&
+	test_must_fail git show-ref tag_one
+	'
+
+test_expect_success "fetch --tags with tagopt=--no-tags gets tag" '
+	git fetch --tags remote_one &&
+	git show-ref tag_one
+	'
+
+test_expect_success "fetch --no-tags with tagopt=--tags does not get tag" '
+	git fetch --no-tags remote_two &&
+	test_must_fail git show-ref tag_two
+	'
+
+test_expect_success "fetch with tagopt=--tags gets tag" '
+	git fetch remote_two &&
+	git show-ref tag_two
+	'
+test_done
-- 
1.7.2
