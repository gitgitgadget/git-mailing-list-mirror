Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E94C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 19:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJITL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJITL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 15:11:57 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E917E31
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 12:11:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D23A7156014;
        Sun,  9 Oct 2022 15:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=5k14JOrI2dAeoVqkBgMD0LCJ6
        NV6Rxz92ylpItvTlc4=; b=O5huF3U6stcXxmy6dFJVNvw4PRlaE4Yz8hQJgW6Lb
        sADM5t6RR/8FsFjDH9Kd7Qsfwh1pkkvLuZFGVZHXNaTOHmREpLkQeqivcG+RATD0
        xvNz2SRjcJwBxjT+qI7Pl5a9InJnTHmcHHHkvgjWmC2uRkx0Bk8J91t7b11uD3Nt
        jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9C86156012;
        Sun,  9 Oct 2022 15:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 136B3156011;
        Sun,  9 Oct 2022 15:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
X-Gnus-Delayed: Sun, 09 Oct 2022 11:22:34 -0700
Date:   Sun, 09 Oct 2022 12:11:53 -0700
Message-ID: <xmqqa6647qx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D216C7A-4806-11ED-8D7B-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> @@ -791,19 +791,23 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  	} else if (edit_description) {
>  		const char *branch_name;
>  		struct strbuf branch_ref =3D STRBUF_INIT;
> +		struct strbuf buf =3D STRBUF_INIT;
> =20
>  		if (!argc) {
>  			if (filter.detached)
>  				die(_("Cannot give description to detached HEAD"));
>  			branch_name =3D head;
> -		} else if (argc =3D=3D 1)
> -			branch_name =3D argv[0];
> +		} else if (argc =3D=3D 1) {
> +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
> +			branch_name =3D buf.buf;
> +		}
>  		else
>  			die(_("cannot edit description of more than one branch"));

Here branch_name could be pointing at buf.buf (or head).

>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf)) {
>  			strbuf_release(&branch_ref);
> +			strbuf_release(&buf);

But the contents of the buf becomes invalid at this point.

>  			if (!argc)
>  				return error(_("No commit on branch '%s' yet."),

In the post context of this hunk, we see that the '%s' above is
filled with branch_name, accessing the potentially invalid contents.

I'll put a squashable band-aid on top of the topic for now.

--- >8 ---

 * cmd_foo() should not return an negative value.

 * branch_name used in the calls to error() could point at buf.buf
   that holds the expansion of @{-1}, but buf was released way too
   early, leading to a use-after-free.

 * Style: if/else if/else cascade whose one arm has multiple
   statements and requires {braces} around it should have {braces}
   around all of its arms.

 * each arm in the top-level if/else if/else cascade for "git
   branch" subcommands were more or less independent, and there
   wasn't anything common that they need to execute after exiting
   the cascade.  Unconditionally returning from the arm for the
   edit-description subcommand seems to make the logic flow easier
   to read.

 builtin/branch.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 197603241d..17853225fa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -792,6 +792,7 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 		const char *branch_name;
 		struct strbuf branch_ref =3D STRBUF_INIT;
 		struct strbuf buf =3D STRBUF_INIT;
+		int ret =3D 1; /* assume failure */
=20
 		if (!argc) {
 			if (filter.detached)
@@ -800,29 +801,23 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		} else if (argc =3D=3D 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
 			branch_name =3D buf.buf;
-		}
-		else
+		} else {
 			die(_("cannot edit description of more than one branch"));
+		}
=20
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
-		if (!ref_exists(branch_ref.buf)) {
-			strbuf_release(&branch_ref);
-			strbuf_release(&buf);
-
-			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
-					     branch_name);
-			else
-				return error(_("No branch named '%s'."),
-					     branch_name);
-		}
-		strbuf_release(&branch_ref);
+		if (!ref_exists(branch_ref.buf))
+			error(!argc
+			      ? _("No commit on branch '%s' yet.")
+			      : _("No branch named '%s'."),
+			      branch_name);
+		else if (!edit_branch_description(branch_name))
+			ret =3D 0; /* happy */
=20
-		if (edit_branch_description(branch_name)) {
-			strbuf_release(&buf);
-			return 1;
-		}
+		strbuf_release(&branch_ref);
 		strbuf_release(&buf);
+
+		return ret;
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
--=20
2.38.0-167-g3030fd6006

