From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Wed, 04 Sep 2013 22:01:50 +0200
Message-ID: <522791AE.8070103@web.de>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net> <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net> <xmqqob89r8bc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJH7-0003pV-PY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab3IDUB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:01:58 -0400
Received: from mout.web.de ([212.227.15.4]:51012 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620Ab3IDUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:01:57 -0400
Received: from [192.168.178.41] ([91.3.170.120]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M73o5-1WB33M3MN3-00wpPm for <git@vger.kernel.org>;
 Wed, 04 Sep 2013 22:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqob89r8bc.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:8jkcMeu+LiZO7ivQkHYL678oJWWOKnC3NCsQ6ZNewVYANoQK/hG
 yTA5U9QS/1trXgQwVwMupXcYNjhwuIEQ4gl0hyce7Ayc+CULPuwq2aEsCG2HXtrF/jiO62w
 JFLOvyLlzP6+vbSKL/xtHXZzY/TsfS9kW0iLzW0Lfy/hcyB/NqibFtihTVATOJU0ahRo2ck
 QUYuwoFx1kpnkDVYVnXSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233869>

Am 03.09.2013 21:53, schrieb Junio C Hamano:
> Jens, I see 1/2 is the same as the previous one you already acked.

Yep.

> Does this update to 2/2 look good to you?  Sorry, but I lost track
> of the discussion that led to this reroll, hence a ping.

v3 fixes the bug Matthieu noticed, I only had some remarks to the
new test Brian added. If you could replace his patch to t7401 with
the following diff it's an ack from me on this one too.

-------------------------8<---------------------------
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ac2434c..81ae7c9 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -104,6 +104,24 @@ EOF
 	test_cmp expected actual
 "

+test_expect_success 'no ignore=all setting has any effect' "
+	git config -f .gitmodules submodule.sm1.path sm1 &&
+	git config -f .gitmodules submodule.sm1.ignore all &&
+	git config submodule.sm1.ignore all &&
+	git config diff.ignoreSubmodules all &&
+	git submodule summary >actual &&
+	cat >expected <<-EOF &&
+* sm1 $head1...$head2 (1):
+  > Add foo3
+
+EOF
+	test_cmp expected actual &&
+	git config --unset diff.ignoreSubmodules &&
+	git config --remove-section submodule.sm1 &&
+	git config -f .gitmodules --remove-section submodule.sm1
+"
+
+
 commit_file sm1 &&
 head3=$(
 	cd sm1 &&
