Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DAC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 12:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97075223E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 12:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLaMgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 07:36:35 -0500
Received: from mout.web.de ([212.227.15.14]:55771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgLaMge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 07:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609418079;
        bh=84XRkbq2dA1PIc6vRhE+FJsNNCYJsFUBZ4CfLpuNkDI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V95AbYsft+P0oVsdEy9yUKejN5UcEtSclmcjK9vLdjiPyE23sAScOqxYQBC7CEVOj
         Oaf/KuoI3JvfqjCaANE5GMHPwPoU3Gm8rWDfOW9DV5DlD+IUGzVJG2J6abEZa/Pory
         Wf1vrfh+qEoetfZL7nj5QlZUXY9YIQmfHNGwEnNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1kLtWe2Kwt-00Zslz; Thu, 31
 Dec 2020 13:34:39 +0100
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
Date:   Thu, 31 Dec 2020 13:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0TKm+LGNHuLQODY2PgNqk+CpBF+L101CYKWayfcioV3pVgZ0zTt
 3U/u4ZbLS/RClmT9hCAWiQlRtA/vY0LYcK6V4ssJ+EMICM8SJwViaphqG02Zdr3DCqgwV2c
 2T8Ur0VvM6qNGj8eo6vMj5M6wufBu/U3Idaj5NhJU1EXCuhlv7BC8cJjRLT7GC+yVvNbkCw
 riOkZjFk+/lJ/JRgBAUPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6i+ViTa/yo=:nwxMEs7dTU3ezc3/uWV9cc
 W4ozWNhT0aVdDQ0cAZq2++EH5lbDj741I15maZEUcQ9RboQuuvFHO0Tf7c83cPLYhPjcCf2j2
 KDXSV9Z+aphbt5Q1WzYxfRNkrpT8zRlEN37Q7f0aB0c7haPCA3gyqogy0wPqzTYQqEAzZ0wSx
 e0mZphSBy37/0SYaw4hJOBkjf9OvTZ4wng5PAITXv/nFFgT0n5n1LXVLAqQSqNPDyWP//A5gi
 1fb64KpLMQU4Q6lGlig3fDotYnYLLvuGnMF8iNbDn/IyM25YDLIHaWZwE19zM1GPO9FenktVZ
 uuzAusCLEXIxJ1BRsoguMwgRoY1388hYR6XAVk7pgCEORA0NnXw11BTTdYiJD14oR5z/dERKM
 HcJMveEz0wZibDXsiQy9FaOn7H4G8oApNGsW6otPSqOu8zncwuVWNPjp3bO6Q0O5uCh7+y1V3
 uJTHuahUgZ7gGh4gQC3x/wqYCYzScc9nJ3UTEtgSfD/zp560wDzlolqtC1mLAogrGLfBR7rOp
 aL8b6VloqKshjtwq7QciMgBm4A7I28FcFIv0AJFI0c4AFLl70uNpmEVIdWCCSl4UwXXLduWo1
 cBVHc2Ppf9lxUom/kYixV0dYHI4c50yLm3aVFF8xD05ZWXFc4m+7xpfyr4mXR0KWKy0vgAfdE
 Ob/fg1mWGk0iNq6gWI0WUgEknYKRf3BfcartB8hC3FlWJOw6vHST0oPstzAUECyb3GqSZSwv4
 /I/la3kwRBIh+uI13fMOQ0LngtZEka9jAeaVGtptkoZTCdl8/fwQqbR5XQmFiwWGTjT3hcDYh
 u7qa8xOEnUAJhYMxtco6omSQyWCHKswuv3B0GGvfNb0SJDx7rkJBfYDAPfwGGOGeOyjYglRVG
 SZEeI820EP+DZYSZoUQg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.12.20 um 20:26 schrieb Derrick Stolee via GitGitGadget:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The verify_cache() method is used both for debugging issues with the
> cached tree extension but also to avoid using the extension when there
> are unmerged entries. It also checks for cache entries out of order with
> respect to file-versus-directory sorting.
>
> In 996277c (Refactor cache_tree_update idiom from commit, 2011-12-06),
> the silent option was added to remove the progress indicators from the
> initial loop looking for unmerged entries. This was changed to be a flag
> in e859c69 (cache-tree: update API to take abitrary flags, 2012-01-16).
>
> In both cases, the silent option is ignored for the second loop that
> checks for file-versus-directory sorting. It must be that this loop is
> intended only for debugging purposes and is not actually helpful in
> practice.

So you're saying that the directory/file conflict check not honoring the
WRITE_TREE_SILENT flag would have been noticed as a bug and therefore
doesn't happen?

I'm not sure I can follow that logic.  I don't know how important that
check is, how often it found a conflict and how likely such a find is
overlooked or ignored, but disabling a check in silent mode that
affects the return code instead of only suppressing its messages seems
risky.

If we are sure that the check cannot trigger then we should remove it.
If we are not so sure, but a conflict would be Git's fault (and not the
user's) then we should always do the check and BUG out.  And otherwise
we should keep it.

> Since verify_cache() is called in cache_tree_update(), which is run
> during 'git commit', we could speed up 'git commit' operations by not
> iterating through this loop another time. Of course, noticing this loop
> requires an incredibly large index.
>
> To get a measurable difference, I needed to run this test on the
> Microsoft Office monorepo, which has over three million entries in its
> index. I used 'git commit --amend --no-edit' as my command and saw the
> performance go from 752ms to 739ms with this change.

Could you please check the performance impact of the following code
simplification?

diff --git a/cache-tree.c b/cache-tree.c
index a537a806c1..1105cfe6b7 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -187,10 +187,8 @@ static int verify_cache(struct cache_entry **cache,
 		 */
 		const char *this_name =3D cache[i]->name;
 		const char *next_name =3D cache[i+1]->name;
-		int this_len =3D strlen(this_name);
-		if (this_len < strlen(next_name) &&
-		    strncmp(this_name, next_name, this_len) =3D=3D 0 &&
-		    next_name[this_len] =3D=3D '/') {
+		const char *p;
+		if (skip_prefix(next_name, this_name, &p) && *p =3D=3D '/') {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
