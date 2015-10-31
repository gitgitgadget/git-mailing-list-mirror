From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/5] t7060: add test for status --branch on a detached HEAD
Date: Sat, 31 Oct 2015 18:35:32 +0100
Message-ID: <5634FBE4.9030406@web.de>
References: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:35:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa45-0002QJ-Hw
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbbJaRfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:35:37 -0400
Received: from mout.web.de ([212.227.17.11]:52322 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbJaRfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:35:36 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MRUBA-1a3T4P36E4-00SgNg; Sat, 31 Oct 2015 18:35:33
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5634FB59.1000506@web.de>
X-Provags-ID: V03:K0:c+QaqjIqSyyqBajFop1IxAM5t2V1OqBxlMfKs2C0/q0gmUja66M
 bQ7BqJdDCstoDLUQGP+iWlzY2vyOkCHF1xFtKoYIdZM57TIkR1aZUUvF5AYXO2RSQhBtl1s
 IZkhLcOiU8Ec7zQXG+KbHp4zI4ukEFh5VtsxEjNSyIaGFtRhd32S5bQVoH53GbuI8cghrTg
 RJ7Wjw2Fj3MY7n1HdsbEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bezBEOEzCf4=:Ts9Szoc34rPaQByeXkB+PA
 XuDT/FK57IWe9segOnqKtkG66IkKVoHUQwWvzw+93SkjenySauU6//AWQqH7hoC813ohQoa0o
 /fmc/pToXRmvXN3GqYFucQNTjP4dfxaTJMBXOUqYAr+KuLhSXGM9x+7PisnWddreYJ4A48rC+
 rs5T5peU44iZb31m8Zy7qZDbVf2UG3/B+GhmKjcipMeykvTg0SpMKKBtVn+Mj3gk7IcOLXdAB
 wvgRIoEDgpZfKPZcvnEV8mpxsj3nFIO1jPPxNjPtjh+qwkIOGyiQQ78XU9tosI9vJIdQ1tWVy
 BvUtF/IsKfWqxbQ0Z7wlQQpWExrted7a8D3AVkdj5/0kTlEU8dt2/CD9Qc5pktBl1zjHcFj5o
 htLFXqK+fE49C2V6y9MKQX0GodhCRrejjzPzg2ItvJYaHhHV3KAVuJNdGLghilR/FXldSp2Z/
 y0R4sIisqH+ggwFFi5zzKXm9cHpL01HjeG+lTMjwnpBakrwDDBSOwt/Z5SrxgvOQu0iyEfF+J
 3xU7TM5AnCvG9fvBshFDlQTkFhnNlmGHztJQT/COnBsrTaC89tIRCtawMjb5hb4U7mtfqelUw
 R9MiGPTBDDZBjTfG6waknQJsiPTcuqQHFeRXX43Se7p3UfyYj+wgVvEPj6kWlnEmKYKN/UBvD
 PaL7TfaU1rV1n7YZsBhrOo1PObiNvY1/xPq33aqMebFwmCBNis2JqmZbeeNgjaPOwsOxSs/Ii
 SHhkpsJWfRMagpwa42c3p9su7EPwrj2N2Z/OeOKKYhuujzbBxzLoX3ta31t23EBwlxm4pTel 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280587>

This test fails when run under Valgrind because branch_get() gets passed
a bogus branch name pointer:

==62831== Invalid read of size 1
==62831==    at 0x4F76AE: branch_get (remote.c:1650)
==62831==    by 0x53499E: wt_shortstatus_print_tracking (wt-status.c:1654)
==62831==    by 0x53499E: wt_shortstatus_print (wt-status.c:1706)
==62831==    by 0x428D29: cmd_status (commit.c:1384)
==62831==    by 0x405D6D: run_builtin (git.c:350)
==62831==    by 0x405D6D: handle_builtin (git.c:536)
==62831==    by 0x404F10: run_argv (git.c:582)
==62831==    by 0x404F10: main (git.c:690)
==62831==  Address 0x5e89b0b is 6 bytes after a block of size 5 alloc'd
==62831==    at 0x4C28C4F: malloc (vg_replace_malloc.c:299)
==62831==    by 0x59579E9: strdup (strdup.c:42)
==62831==    by 0x52E108: xstrdup (wrapper.c:43)
==62831==    by 0x5322A6: wt_status_prepare (wt-status.c:130)
==62831==    by 0x4276E0: status_init_config (commit.c:184)
==62831==    by 0x428BB8: cmd_status (commit.c:1350)
==62831==    by 0x405D6D: run_builtin (git.c:350)
==62831==    by 0x405D6D: handle_builtin (git.c:536)
==62831==    by 0x404F10: run_argv (git.c:582)
==62831==    by 0x404F10: main (git.c:690)

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t7060-wtstatus.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 32d8176..e6af772 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -213,5 +213,19 @@ EOF
 	git checkout master
 '
 
+test_expect_failure 'status --branch with detached HEAD' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git status --branch --porcelain >actual &&
+	cat >expected <<-EOF &&
+	## HEAD (no branch)
+	?? .gitconfig
+	?? actual
+	?? expect
+	?? expected
+	?? mdconflict/
+	EOF
+	test_i18ncmp expected actual
+'
 
 test_done
-- 
2.6.2
