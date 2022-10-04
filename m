Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4870EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJDQGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJDQGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:06:39 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451EB4F1B7
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664899589; bh=JoT6nsu+N67Bifsm6vWFW8uKqJmPyB9uCNOU0sYsMjw=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=koDylFzgbbRYESOUBmzAx8z51UOB6/+lKWT+L8K2VCKDwAW62XcH+MxJYtpAhsvP6
         A4261c2AHmWUQIkywbWg+4s6YJzp1A6c+RkgclZroHVILS8zXsT7E0t+uOaTf0qsbu
         hWu5nnwtdJWM/Tt6e54kP5hsyfSoJAVWx6w46+c2/9RUzlnDdNwSqHZpoHkZeKLE5y
         7opE1t95fu956AoMiN/QgGSF/eINg1V9imfQT2kdkVn2GTkqIlktuKRG0XRjIalJ2j
         2iUXBIT/HixuT0u8KcX5yIkC+f1NuxapeLXoWBakWbH+IVxbuntKsdRp89UZB1Vue+
         shw93rWTg/ViA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1olD2n1S04-00U4px; Tue, 04
 Oct 2022 18:06:29 +0200
Message-ID: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
Date:   Tue, 4 Oct 2022 18:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: PATCH] bisect--helper: plug strvec leak in bisect_start()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/p7DV+Bnn/Si23hFXxnlLEqv1C8u7VV6tPvsBtb+YuBfI1hvyCP
 sWjqGW42TOcIVi2njxC6nLRuKqttXVfRPvFfndAT3SLMe/QnFPJu4VtKD3XZRzdP/rsFRGa
 0IyWd6Bqo8J4xnegyuzlJTjdnSuSgfL/DcJrNBa3E/XuW+SZwFxKWtOgxT3MY3sswsDpuzl
 jDCKFOaVqWWzMcDR2IHSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ym1CJXAQPTw=:gj642em/cJuUc6GH6ctev0
 RtRXQgqCCYUbjNp3SknIcw2aDtnhbkLmiQ4IXGKtbW3Ke1oDyzCZHm17bfi44FPSJi9Y0sAYX
 CoSIlleT9nXdk5MAui2v0fGl42SgAaUNPazrLK/rzqNkGAJqsl6rsQrrYHVUJzuGm1zKb9uAS
 1JtGVx98o+S1rXGGn4lH5qifOFRCSSp8+r1vFtPLI9jhbuv4hkpkfqEUwoOIn/6Od0RE7I6b7
 BDKsj5zVvpudqtsAuKH2/IRlwt4K+tgtMJHIu7SheP3b8gFW//3KJCFNPsUv08cLL3OJk2LUt
 2DJDXG7FRANW4gYr898PU1matrr5iONBDb6hcJMWdIP3eliT8r6hhKakfDYicqNv1Pf1U+b7W
 23qD6YW/pfkg/AQDg9kBHwEFFwBREqwdwXEsABh8njb4dTVRjJNrT4HrSCMJySX6yWOFkX3/k
 TiZUYgJbXxorpfK8WaCBjwFtFttKPAzMxbzXmtNk6k5aAPzaKahxAgP6S6+nBerEVephtgAZ5
 dmvCXj9tvEJvLY7VqP2DMRpozzq1JBjUb0ltok0q53DOyYe4yzhfXHEfzyzAYhLbQJ+5hzN9R
 T70qNTElTfPjjgs4v9339yklvAojGnTkra4CcbZMBtvbyNGDmGi3kAr1ITGWkwMcKoNShsIrK
 ZtTFFCxO1dVrzH71yCiWP6aEfRgH+oZmJhvP/4FAZWhuKA/NAr2NM/mnKUtd9OsvWDV1rqulG
 tQ6E8jMiMsmrxr2iX5JQFgmbTZRjv6HgZGDbaZ5gHpgjEMF6hmlPgDltYH53j4BjdtmYWBEia
 GHsbbgq5wiTZNZ/o3XIZdV85OQxUutrBF7321LumI1hf+w1hhUCq72KBgIl1XyK+jcW6VVuv8
 v16Fa0riRykyjeIOK7+AKgI5CQX+P8I8uuHSLaYyb42N3FX/Q/tPBldohJ2Y3CSjvL6pKsCg1
 G9sAEdLyGPjFhb9u/1hf0bmB10J4idwlExPQxquy8pAUYi3rhdUM/bf6TwO4gsItwtqAB0wWr
 KHZK9JXMJ9mrpGdXHPETGdjOns6iOOAO5E3ELw0GhL7VBAlnAEn/Ij6M8iqy9cnJU7sDJHBX6
 Ixmy/nW93zmAP92ElcdeyrbY1lKWXaGF8HVLGuFzU5aCiDjP1Bl5w/q4sZS50Y6cUPomRI6iN
 PKkRQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strvec "argv" is used to build a command for run_command_v_opt(),
but never freed.  Use the "args" strvec of struct child_process and
run_command() instead, which releases the allocated memory both on
success and on error.  We just also need to set the "git_cmd" bit
directly.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/bisect--helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 501245fac9..9fe0c08479 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -765,11 +765,12 @@ static enum bisect_error bisect_start(struct bisect_=
terms *terms, const char **a
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			struct strvec argv =3D STRVEC_INIT;
+			struct child_process cmd =3D CHILD_PROCESS_INIT;

-			strvec_pushl(&argv, "checkout", start_head.buf,
+			cmd.git_cmd =3D 1;
+			strvec_pushl(&cmd.args, "checkout", start_head.buf,
 				     "--", NULL);
-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+			if (run_command(&cmd)) {
 				res =3D error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
=2D-
2.37.3
