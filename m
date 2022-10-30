Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB3EC38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ3Ls0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:48:25 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98519B852
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130496; bh=2GRrFBWZ4Y2h4z5MGFMt+f4CSdPpDbxq5Rm/vTOXe3o=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=rhz8xBsz9lHXYQKix45ncal2YS8zrF12l7a4P9Ka/6snTGYrrPfFpmoN0RtpsyVnF
         /4050xdcw1tNTu65v3XodzTPn2H3+YbPqnC9lYU+mV+p+Ku5QEjzFi5m8FPFIN/s3T
         nMGeqMBMoSYAqUl9OV1Lmd3m9F6a4qFNkbpw1IIOyjvHtSd9VJBdWc6GmiEiQasI1W
         qgc1en3gQaJDJ8wgyAweFoT/7WrHFapEKHZ1nO+zphaG/NjbdEoWSQsIrWV0IiefU6
         2AwpAaCOUEtWcie+Mhr4CPi+bS6EJvU0Ahe/WSV4T3gRT0mtiDe8FbZ34JDmxaoWAU
         yRsOQvjIkqGfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1ovgNs2zY8-00B50h; Sun, 30
 Oct 2022 12:48:16 +0100
Message-ID: <434b9dde-8e87-6890-d2b1-581e88bd3c03@web.de>
Date:   Sun, 30 Oct 2022 12:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 05/12] bisect--helper: factor out do_bisect_run()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5x7WX3DD9YZObnYYsmgqnNb2VEOrOTdSkE/3uqMvGUCjisX7Sei
 Wm3MbMteBf940lf3S8evtbrQ7C58ovTFGLIelcd1Gq+wb1Oomn8Y8SyeoRx9CKDt/zfjFnp
 D290yD45EvR2Qqz9bYf41IxfX95NsnCGFoJ5oHQ1X8zgadab5HyF48d/xaw9iZp446UWlHy
 /HtZbf/NBF45DzvBCTs1w==
UI-OutboundReport: notjunk:1;M01:P0:NNhfd/re/fg=;a7Hwfp3eVZJiujoQcbRazJBcn09
 6ofUCA0pC53UX8InKcMDURacvQAWLYtv7FFrPO/Q2h3WlphaWxWlrGGC4uC9rPDED2LDNd1KK
 7ziCfxvt7kIrbVGka4NzrkeXWrvzwrpOtFWednNut+DWf+lnwh5SD0W0R7sC6TmBNySgr/rEz
 JCoxJAEZKYTmbdeR9CZnk6ZeZj4Jh2eukH5cnW9MEfY9gOPR6NiFDB1Jpj+xJw8vbZx5IVCI1
 zZEcKLz1dd6Q9J7h3tYoXTXU+X0NaoFS2/kKb1Uin9nRbgmMF8knX/1drkIiUUQV3xNumKGQj
 lsa16RiWccTwiRe7zhn49gymY+U8seXzkfw4UjAXZgYWYro57LBddwz2mBUKbVESX5qeP6blz
 AP8Dl7dj+NYaWN9E4Q0/jmfX4dgHh+8qgmYuqknFsZt4A78P1h3FuGyx7reaRryTPRBVtE+yo
 /4EGqLBdMCWcJtGNOM+sgSpY6rHGoo2jUr4HEGCD0R5VF3x0Nx+M++mOAouFZYC8DOyqBuQHl
 qxLvTG0DWV8dKOVMWy2rZQ46fxgorGRowlFsI2IRrqJg09Ca5PvVkzP8r8/GC93txu0et4O7L
 EGbiH+2UTROjvwms+EhLejr56+Hm8AUIgqMaCIUXvmuRF6tphcJPt0v8NdIIM++Tp/+bgwKkD
 1mGuiXgU+1egpqgKJLMCaVyFZy3JZVvk1S85EBX4NQoS1ZRXnQeuqgSGubTAb9RpHIPZ8YQxJ
 jAjMWMFz6gqhLJNJGKGUictOMfSOm6sl25QcrI/oakDjZVk/H8vEMbtKnH2v+l6Q5PnoRaCcA
 7LlLQTEi6G5RygyDgpPUwCMUituXbApdiZltuH/xetc2En6RG1hkf1QGXJrqfSA8cuHb5g7Jo
 3+rAHT04Ko2ZCWiDf39YigN7OgA8AsbO5rHIYqIcifC4VY0PIYuGW/B7RMtdJVSCNPe8vPpUU
 uyxXP4qSCHgncDHNd+1dtII1zaw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Deduplicate the code for reporting and starting the bisect run command
by moving it to a short helper function.  Use a string array instead of
a strvec to prepare the arguments, for simplicity.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/bisect--helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28ef7ec2a4..70d1e9d1ad 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1142,8 +1142,14 @@ static int get_first_good(const char *refname UNUSE=
D,
 	return 1;
 }

-static int verify_good(const struct bisect_terms *terms,
-		       const char **quoted_argv)
+static int do_bisect_run(const char *command)
+{
+	const char *argv[] =3D { command, NULL };
+	printf(_("running %s\n"), command);
+	return run_command_v_opt(argv, RUN_USING_SHELL);
+}
+
+static int verify_good(const struct bisect_terms *terms, const char *comm=
and)
 {
 	int rc;
 	enum bisect_error res;
@@ -1163,8 +1169,7 @@ static int verify_good(const struct bisect_terms *te=
rms,
 	if (res !=3D BISECT_OK)
 		return -1;

-	printf(_("running %s\n"), quoted_argv[0]);
-	rc =3D run_command_v_opt(quoted_argv, RUN_USING_SHELL);
+	rc =3D do_bisect_run(command);

 	res =3D bisect_checkout(&current_rev, no_checkout);
 	if (res !=3D BISECT_OK)
@@ -1177,7 +1182,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 {
 	int res =3D BISECT_OK;
 	struct strbuf command =3D STRBUF_INIT;
-	struct strvec run_args =3D STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run =3D 1;
@@ -1192,11 +1196,8 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)
 		return BISECT_FAILED;
 	}

-	strvec_push(&run_args, command.buf);
-
 	while (1) {
-		printf(_("running %s\n"), command.buf);
-		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);
+		res =3D do_bisect_run(command.buf);

 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1206,7 +1207,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res =3D=3D 126 || res =3D=3D 127)) {
-			int rc =3D verify_good(terms, run_args.v);
+			int rc =3D verify_good(terms, command.buf);
 			is_first_run =3D 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
@@ -1273,7 +1274,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 	}

 	strbuf_release(&command);
-	strvec_clear(&run_args);
 	return res;
 }

=2D-
2.38.1
