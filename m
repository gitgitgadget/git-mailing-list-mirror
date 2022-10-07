Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ADC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJGPIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJGPIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 11:08:49 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A510251D
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665155323; bh=UsO7KqI/PPvZQ7qWfdnDGIBdpB+PlzAu4YYJnuDxXuw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mltmjTzwFFxtrc8cX2e2YdbgaQWG8ypSap8iDHM+mUr2uRFHugtvRhhOLAWjz5/d4
         SgQrN8AC8koQrST4LxpOsrixSOKHcBiJyXw2Tm0J/UdChBldu8hmErKztrlHgqb2Qa
         Dw+1TOl/TDBZ2nEq2lmPLwObAs/Hz9EFFPk8tbfs0zRotd8+4JeHXcqpLxjIMwbjG0
         5Xt9DlIY+ulu0ExD0B9DyGmIeTNgK8barKaTntaknUUlQgvgOIL5Mt4KvkS9KVXRjT
         bDSmjeLcb/mUXpaAfSR3lDJ94AnpTCLQle1OFUqtvGUa5WxRBvM3lzVUtoqrGDYUKm
         qlRXpGJjN6DnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1oaCAN1cK0-00Swhr; Fri, 07
 Oct 2022 17:08:43 +0200
Message-ID: <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
Date:   Fri, 7 Oct 2022 17:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v2] bisect--helper: plug strvec leak
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com> <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com> <xmqqk05cipq8.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqk05cipq8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qNssRt9mXdV+mRUqxAo68BYUxRcrn2GiDS+nffwBcYazUU6S6+T
 8bt8QYfq4ILymjpqUhLvjryCHU3dnZrGnPvlK5uERQ1MKFbaM44n9eh1VjIJV6rBh6T1LL6
 EZohbmrnh8DlxxF39FtJBZuKB+Dzy7KYaC6tXOM2fkmqsATvIqWc/x8Y4mEQefsFFHJnUoh
 A0YeyJ6qFQx6tFdsCLZGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lbZPQIREsH8=:VLB2xuXD8aU0/EqYH9SlJH
 FY2EgzMT7kED57JY0VCSEcTIGVeMvFrv7JTWVnBh0IvRqgBSsqvq6fCvVwoi4z9GbIUvpzJIz
 RWNXTb3TQO2CXo6Y0GkHr4LZY7fvjKO/CmUl4tY8js19Xw1WodXUMENJF+G8FfY6PtEGiOjC8
 pWcubZNBPufFJ3Gf9L06SHsinI/cX6V0pOji5Us0UdsmooHAP968a3E6ZvKO9TaF1jnqAVxMC
 0iPx5btd2LHo5+0sPCWTZ4k2xODyzqC5ftSGi4qeKemHRtYxM8H1Y/JsweEf0IpPI1+GFLsPr
 eoQmJ9NPE/DjrWemPKA0eFkowoTDGvnSXHyjpxbCPSbuBwWcfrbn2TJEmvvekPovzGCCyx45o
 A9uWYuSPTVobtQ2zT5pGDIVSWSIyymqpOWOGpgFy3LtsCv0Mr7P8/ieCldmGyyfHalwmz8yB+
 J6616sNm0ugc/gknRhnDo0Ws0fmXt+CLzZN60k71W/VRK60/yCfgIRHvZrQKy7TfdalICnjOk
 AN0ND82yZTq6lDRaMOvUyyCY1AAPpsmgtQra+T/08+lsA2V19vbGDuOqF52hKJCv9JDCojc7W
 k6cfdYE6/rbVLFUTXwxG6brYQBJkrljTyxmsmBAjbpZsN/CCY9Qjn8kRhRImQ27CvqbFMkO0E
 TpcnLaNg5gwRaU9YXiOhGrdO2NmJXO1QuhGwj7leqSYI2d/BCZ/3w34/JWN8y1X0/h7o1L0V8
 GaGK/n1t6NfiN5GsPk2Ntk95I8FlXTZUoWT6n9pYGp4DQ29+cTlmW/GksWrJLW1PF2fwrP7Sf
 JuZEpsIHSUD12J+JsUJkIVHeXUGhpHyta0v/8Zp0T/n9CDnXGVzWf4nEE1I1tssXC4ZIQRTKV
 TAOAJciuahUlT54DI5QMlMbpClt0dzVc++Woj2BiXYfvWLgVWLSKArThKO75wkMiIQLjnnb2g
 QbDWdZdlKCTRguODHu1MdtPAyHleApyEqzhuKAIpXfHe4xUHA0vv8QLQ5jh+v+l4dbkzAqoUq
 MPMiE4epMExdzOsJqLGjgpg9k9OKl89epsvpSZruHCyIVWV6dFSNBXglEa0yf2JiV7ayXtJvx
 iQhyhQo8/34/ui3pg1T6ESJ/0Kk4o6jLTgLtnKUULrcnJHejFdT7/qSkVFIUGXF4WeYzjP1D7
 eUlcszb7dztZxTU+EWUcVDpjnxOoXK7aRO7n0fdQ32Gep4MLepde/2JQXgWkRQ9qrJ8aGxTPc
 xf05OGrIPqo/mDW7m6z8wbFBtCtU7WEZi4F0SQLC1VobgQyn/mhkEYOJrb1jDqMOXHNe5uSXJ
 wu4d6c4KklABHM09r1qwlJfSVcHJxKX9H8RGFOk2CLeo5QPzS4F1cj2xj/SjM0FIl4trircZY
 M7+tUkxkYL+/NLENYxzgPgf11lCD7ce6Z8OfObBsj6hgU/yS9jXyFhajoFnWlN1gSi4jdy9hm
 tnfbusv7SmBrfZF/Yj3Y3AYZ0VTnCmALNRcrW8YPAHZumBMfRvntnVRS2QVCeUVa9u/TZQG9T
 8WmrpclwA1fwnTUJSKnkroE1+xmFAZfV4EikMgJrtRniG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strvec "argv" is used to build a command for run_command_v_opt(),
but never freed.  Use a constant string array instead, which doesn't
require any cleanup.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/bisect--helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 501245fac9..28ef7ec2a4 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -765,11 +765,10 @@ static enum bisect_error bisect_start(struct bisect_=
terms *terms, const char **a
 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
 		strbuf_trim(&start_head);
 		if (!no_checkout) {
-			struct strvec argv =3D STRVEC_INIT;
+			const char *argv[] =3D { "checkout", start_head.buf,
+					       "--", NULL };

-			strvec_pushl(&argv, "checkout", start_head.buf,
-				     "--", NULL);
-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
+			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
 				res =3D error(_("checking out '%s' failed."
 						 " Try 'git bisect start "
 						 "<valid-branch>'."),
=2D-
2.38.0

