Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9461FCE
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725779323; cv=none; b=M7UD7ouCFWvfzurSpXZtIbFyp8OjWB1ffNl4oSN0cTd/WS0J7WZGC5u7ZArhHyCfaI06M+tkhHpYIcUOWKXu53LkFIQ0zzF/1JLvTqjTb+0E9PvDjhnt7mhgtc5pikEnpbphxnz/F2rmXoqw05K8bAbnXStKi7rRRCFIov2eE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725779323; c=relaxed/simple;
	bh=bXYQzW8ADbW+VuIrbh5TX/3i3EGmmCA+Ce7HlqhbGmA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DtSS4u7aM6BUcYZoGhl/0FFzdUWWqE1myB8rVxkskvADS2f7/1wgMPiHUHvZRreSTd7JLSzqMQCRwcbR3jj63o8skdfLvIPvy/eEMVT6s/y8Ok7Zc+cCQsvFRIQGJSo7lKRx8fC1Ulf1n3LbNTKOkMyTvRC8W0+Jj3GT9dw8gLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=BmwT7KRR; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="BmwT7KRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725779316; x=1726384116; i=l.s.r@web.de;
	bh=0lSCcjiwqr9yH+CSm8JA/z0n2gK11CgPLFoMQ627LWY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BmwT7KRR3CQD9ggk4QNEUmrmp30B8inlhkv9iIMDNfwVUcZjUDA/MtfwIonQqjdy
	 Vl2HLKpKEmyiVwzNG5eh4CgmKgbpAAeWOMdBX6RbnjU8caSCl/9qD0SDd6DuYU1MW
	 8MYWaqD6oNaPEW9gtakxhBC0A1Oprd3Yay+iGBC8SvdWc6O22+TfN1D0+Xjrl5sZ4
	 GgdBYzJIod+92bmLN1cA0ciUsVeva4kLdcrhMBRWkeQhovBC6K3NcVcxlsgrErQYh
	 TnUMvhGEcxJlnRtpUi58W8BqTSLfxSSE84Yck7WoPdEw31Wq0JTRCDRexIwVepiFB
	 GFlOfpYZLoQ0gRghjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1sQ2Rb4AHk-00TDr5; Sun, 08
 Sep 2024 09:08:36 +0200
Message-ID: <0864c86a-5562-4780-92c5-59d6c1a35aad@web.de>
Date: Sun, 8 Sep 2024 09:08:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] diff: report dirty submodules as changes in
 builtin_diff()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
Cc: Jorge Luis Martinez Gomez <jol@jol.dev>,
 David Hull <david.hull@friendbuy.com>
References: <130d4803-2818-4611-9258-951a18dd5717@web.de>
Content-Language: en-US
In-Reply-To: <130d4803-2818-4611-9258-951a18dd5717@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7dB3cTp1Ts9wGR/iXVsz9QmvkwdXJefWiVT48ho/UUKi1/eGgDS
 woMdhWzV8ahdtfOzOkWmKSd0JOxrYfVVpnGHjilJEd0SxGsmAMGUtBraMyU8bCkIl8eFnkZ
 OXlmadpiR0BfJIanroK1klmlsMJIA9b21IFAr0z1P/dmqwtcnCqYIIyuqUPM/sxT63KkMaE
 6Hmnd1j+YcIa1vRz5R9dQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JFfPWE9FAwI=;tjqKD+HPlAyQDT6SJ8uk9oz5Bta
 xHbWQbyE+Lzs0tQhQBd07PSofkntkJjYV4W0mYN7oK1UeVBL59aUsWxP4PbwWDp7o0ewxaAhl
 q5gli52JuH3BFH2a5r2u1F78qhDNZxli0aCcKwWK8z4jSqIE0UIshXa2kcKBUOanvm8s25rGE
 rexpBVNS2POuTzvkuyJMH7UbjEZVDBsPx/rjo6kzLCfuhuW8DhsvyAePoFrOJtW1b/dohCBfH
 pdzmMeMAJZPK8J7UuSAPYWutY5wa1b607YLdBGUGl53+XTyYkkAYsNukokGH0IPLZ6naBvQs8
 qo0RnD2BgLSQum4VDSQz1CCiZqY1Gx32QBxUsqkDtzMwvZPI3+nfEwekmKpfWwDrCmmmrzX9E
 AIFBIsEtKNloKtFJa2p2vz2IRhbGWGFKBZaGGFh7jaGayI/DXJKkyuU+HS8W+2wx1GJJlMUlu
 7L+jDk+I/q54UtferyEqPNnUDJS55w8bXZqpMdxxPV7wanRvSUaDiWky7/cglCe7wYMZTnjdQ
 24DWSlZJR4sRb1cQ/bOlXfAW78cJ6TQT1TUBLwK08xFNCJRL2oqyn2FQ0cax+UN8Z3Wr8n86N
 niWBLSRMU9eHiqXUOnmwc3DmmoKKD8VBrWB9chbHfYnuy5+hJxpjy6W3Y9DNd37jndpAKADmR
 bRp1sHWk+Rwxg3FjjuVGWr9KT8aqPfe6vYCr8eg+t+xM08872cyOo4E6qmtNkHt5iXNSOqslE
 EpmfLjNbvka8dpduN2srwrwCzKdHNQP4vnlu4t+xsagMnDRL4WVXvOtXCqxEO+H1FbljxxE5+
 LDzi8HE8cp0w2FlITydfagkw==

The diff machinery has two ways to detect changes to set the exit code:
Just comparing hashes and comparing blob contents.  The latter is needed
if certain changes have to be ignored, e.g. with --ignore-space-change
or --ignore-matching-lines.  It's enabled by the diff_options flag
diff_from_contents.

The slower mode as never considered submodules (and subrepos) as changes
with --submodule=3Ddiff or --submodule=3Dlog, which is inconsistent with
=2D-submodule=3Dshort (the default).  Fix it.

d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09) set diff_from_contents if external diff
programs are allowed.  This is the default e.g. for git diff, and so
that change exposed the inconsistency much more widely.

Reported-by: David Hull <david.hull@friendbuy.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c                 |  2 ++
 t/t4017-diff-retval.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/diff.c b/diff.c
index 1d2057d4cb..472479eb10 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -3565,6 +3565,7 @@ static void builtin_diff(const char *name_a,
 		show_submodule_diff_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
+		o->found_changes =3D 1;
 		return;
 	} else if (o->submodule_format =3D=3D DIFF_SUBMODULE_INLINE_DIFF &&
 		   (!one->mode || S_ISGITLINK(one->mode)) &&
@@ -3573,6 +3574,7 @@ static void builtin_diff(const char *name_a,
 		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
+		o->found_changes =3D 1;
 		return;
 	}

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 9a4f578614..d644310e22 100755
=2D-- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -159,4 +159,25 @@ do
 	"
 done

+test_expect_success 'setup dirty subrepo' '
+	git reset --hard &&
+	test_create_repo subrepo &&
+	test_commit -C subrepo subrepo-file &&
+	test_tick &&
+	git add subrepo &&
+	git commit -m subrepo &&
+	test_commit -C subrepo another-subrepo-file
+'
+
+for option in --exit-code --quiet
+do
+	for submodule_format in diff log short
+	do
+		opts=3D"$option --submodule=3D$submodule_format" &&
+		test_expect_success "git diff $opts returns 1 for dirty subrepo" "
+			test_expect_code 1 git diff $opts
+		"
+	done
+done
+
 test_done
=2D-
2.46.0
