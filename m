From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 1/3] t1514: Add tests of shortening refnames in strict/loose mode
Date: Tue,  7 May 2013 20:54:14 +0200
Message-ID: <1367952856-30729-1-git-send-email-johan@herland.net>
References: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
Cc: git@vger.kernel.org, bert.wesarg@googlemail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 07 20:54:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZn1x-00014z-8m
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242Ab3EGSyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:54:23 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:33814 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab3EGSyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:54:23 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so500984eek.10
        for <git@vger.kernel.org>; Tue, 07 May 2013 11:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XrOO/lNLBQCp1ZSbFu/1OAXB0pAPDOzgdPxRxogJa7g=;
        b=HxEZKeI0EHXogQgDwDgLmh242sO+3dqemIsCPAe/bORkURMV/OwNXXgRmytqOR7AZA
         mP5SsLr9JKq8q2Xo68CyH8Hqlq7BwQ9PLPoolg3vxEVOiUORwrMKvkNnv/yih61k0DqF
         1ruBYiD2GZKLe23M+EsU5XSfqvqUNkkX3y5WN+yydU43xBvVsc+kgYbnl6sfTAdlpcEE
         Pw1EJFo3eohr2HL00FLRWNKmzH/bM9DT2EuyGwAVnSXwzZBVShCdWli/xmMl2/zb4DMC
         KUPet1HzhtkPOgdENDCxbmNsl8seYtveuARzDXUzvXCirhQT6gs7Y74L9CIRn8vfxMcR
         aD1w==
X-Received: by 10.14.105.1 with SMTP id j1mr8232328eeg.6.1367952860498;
        Tue, 07 May 2013 11:54:20 -0700 (PDT)
Received: from localhost.localdomain (p57A0A708.dip0.t-ipconnect.de. [87.160.167.8])
        by mx.google.com with ESMTPSA id l6sm41084484eem.9.2013.05.07.11.54.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 May 2013 11:54:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223594>

These tests verify the correct behavior of "git rev-parse --abbrev-ref"
in both "strict" and "loose" modes. Really, it tests the correct behavior
of refs.c:shorten_unambiguous_ref() with its 'strict' argument set to
either true of false.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t1514-rev-parse-shorten_unambiguous_ref.sh | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100755 t/t1514-rev-parse-shorten_unambiguous_ref.sh

diff --git a/t/t1514-rev-parse-shorten_unambiguous_ref.sh b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
new file mode 100755
index 0000000..41e0162
--- /dev/null
+++ b/t/t1514-rev-parse-shorten_unambiguous_ref.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='short refname disambiguation
+
+Create refs that share the same name, and make sure
+"git rev-parse --abbrev-ref" can present them all with as short a name
+as possible, while still being unambiguous.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit master_a &&
+	git remote add origin . &&
+	git fetch origin &&
+	test_commit master_b &&
+	git branch origin/master &&
+	test_commit master_c &&
+	git tag master &&
+	test_commit master_d &&
+	git update-ref refs/master master_d &&
+	test_commit master_e
+	test_commit master_f
+'
+
+cat > expect.show-ref << EOF
+$(git rev-parse master_f) refs/heads/master
+$(git rev-parse master_b) refs/heads/origin/master
+$(git rev-parse master_d) refs/master
+$(git rev-parse master_a) refs/remotes/origin/master
+$(git rev-parse master_c) refs/tags/master
+$(git rev-parse master_a) refs/tags/master_a
+$(git rev-parse master_b) refs/tags/master_b
+$(git rev-parse master_c) refs/tags/master_c
+$(git rev-parse master_d) refs/tags/master_d
+$(git rev-parse master_e) refs/tags/master_e
+$(git rev-parse master_f) refs/tags/master_f
+EOF
+
+test_expect_success 'we have the expected ref layout' '
+	git show-ref > actual.show-ref &&
+	test_cmp expect.show-ref actual.show-ref
+'
+
+test_shortname () {
+	refname=$1
+	mode=$2
+	expect_shortname=$3
+	expect_tag=$4
+	echo "$expect_shortname" > expect.shortname &&
+	actual_shortname="$(git rev-parse --abbrev-ref="$mode" "$refname")" &&
+	echo "$actual_shortname" > actual.shortname &&
+	test_cmp expect.shortname actual.shortname &&
+	git rev-parse --verify "$expect_tag" > expect.sha1 &&
+	git rev-parse --verify "$actual_shortname" > actual.sha1 &&
+	test_cmp expect.sha1 actual.sha1
+}
+
+test_expect_success 'shortening refnames in strict mode' '
+	test_shortname refs/heads/master strict heads/master master_f &&
+	test_shortname refs/heads/origin/master strict heads/origin/master master_b &&
+	test_shortname refs/master strict refs/master master_d &&
+	test_shortname refs/remotes/origin/master strict remotes/origin/master master_a &&
+	test_shortname refs/tags/master strict tags/master master_c
+'
+
+test_expect_success 'shortening refnames in loose mode' '
+	test_shortname refs/heads/master loose heads/master master_f &&
+	test_shortname refs/heads/origin/master loose origin/master master_b &&
+	test_shortname refs/master loose master master_d &&
+	test_shortname refs/remotes/origin/master loose remotes/origin/master master_a &&
+	test_shortname refs/tags/master loose tags/master master_c
+'
+
+test_done
-- 
1.8.1.3.704.g33f7d4f
