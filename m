Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D8EFA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 16:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiJ0QgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiJ0QgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 12:36:06 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFB05BC97
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666888553; bh=2GRrFBWZ4Y2h4z5MGFMt+f4CSdPpDbxq5Rm/vTOXe3o=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=lplf4KUBfHxvpiVoDV7dPvm0e4DOo6VY2/lzvq5LJyw5yYBdtFkdqrHMRo2vevPwt
         R3zOmnpsj934TE6mPpK/HP4USbLRM90YNClUXNtUC8y+CuBfSDr6WlK5Pj7viLSHFB
         n7Z1vXBQzhjQ+iSGPj3XU5DQ9DFhO8aq2qp3AjNdue+v5/dDOmuwiRPO6e4L2OJuc6
         qJ4BypUqL6ohX6daPSzYIlck1AlVqXC8WE+lRaADEgju1vGor9y3evRzXe5p0pSFGX
         mn7ePvj+7c5m/rUWyPbRJU8AFM+oVfVGR1w4oer8qPPp64lNUrD2ed59u7UY9dbU4q
         2xBwb7bhFYohA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1oUN733HXU-00JtMT; Thu, 27
 Oct 2022 18:35:53 +0200
Message-ID: <033ebd37-40c7-01bc-e9bb-29d738532125@web.de>
Date:   Thu, 27 Oct 2022 18:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH 2/8] bisect--helper: factor out do_bisect_run()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
In-Reply-To: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aK0Nf2ANXr8FKrBxtAbMIOOklsn078xBGb9DWG9XjrRnp7h1oWZ
 D3uIvrB/Uu4v7tD3L0Xrs1a4cUZCSw2HRTyjuWtWbKRIbSNoC4AcfYXUKG13D+21nCrAGd/
 /6aS1+lXfeZi32sqqxCr0fRKPKkNFy1PUO+UzVegrK21D9UcEOeJ2zpC59ZVLzHpmgE2Ua5
 F4P/SxKnR+9zRyIngMPwg==
UI-OutboundReport: notjunk:1;M01:P0:hhb4nIaghRM=;5bS4Bv9fBYi55eM3+Tupg7i59Nh
 FB8G3t/kyZXCEApyG5P/k1QIJrlJJiw7TYzmtRlbsNgpz84YbJhYrOrdqUCwmXp4shiknWJ7M
 /kDkZwNghopkxnCK9GJrnNFjv2lH+T1DcmsgQh6ab0RfhdL39Zif78B37jaSG1XYkpxEF+5Fv
 7T8FDwHMj0U32te5KliTcJFspFIFU5j1Dp9I446en/uqKtBkd278DZ1DrmDNW4cs42SZ70wPg
 zFWQNW+ZqFPKvvNoQHp3JHqwrqj0++5ZvHPSCmrvSNbPW5jpEC5sJpxybV7QFeTqffHHshcwR
 83pBWlvZMny4450lx4qrKqkRtfDVDSR/JqeYmZ/DH3gNkBnQDHQwN2XsUMLZutq0aX6sb+4gv
 ASkJ2ggAv0gHll9cDy6xV4nl7cjMxlcCknkmKmO7aOBRGNFW+J4xD2WAWC+ic+WHSONfur9vM
 NlEAPWv1pecWM6c49H4hPjIb4+DwctbnMuddMftW/6e6liacrrlyGPv8FWloPKRe8J71OWdcQ
 9jkD9KeaCHwasA2iUzqOPxIP9A0ijDIDoRTHz2z9ZzOiB40dUbpaMRqEbeRRXZ067HmOq4eD0
 eSASk4ofH+AG7emWRQiehvAm0eDEZsRzoqsEXQEeLI89jNi1amPlnmUo86tqqeVDsRVTwO4SD
 x2d+aS7ZEkRElfAWKXytbcuwZH+Kc1CO5OyXgwCQCznr/4HrZ3Ymb65IF5PP7GL807fMyI/FO
 NPSuAl2E2lV6VNedb2ap5fJLK38ZQRKsNhJhPK+yNY0pQJK44z3fJOeDDhPY1uarExL2NEv+v
 QFdbyUK9oUJpIkCWht3QPKe+b4hhp1eKcZsM7kaetEC0CFkuY3wdkKwntheRHxT+ebruGsnlb
 gI8g5Jz0O8sa+CwLcrgxai4qLpYh5+XY+ye0X5GN7fWtL+1Kivx2f7pGVebifH1JgC/mMV+4p
 Mz6S2TTQoKS5o8cuas7aDgEah+w=
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
