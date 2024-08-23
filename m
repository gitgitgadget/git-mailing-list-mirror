Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD65192B91
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444485; cv=none; b=Kbdoo+WdSprYjde/wENTv/CFgITbgpeTTz7E6l7Idh2xY6cIEIN5zCayWiEoy1jrmhYTiGXPOAkOD1RJwQnHEGWyjOdhdviH7xSuSByNowVj4MzgTFI/LttZM6w7TT9G0fZovB0UTXHsIsDc2xd5Owc/1ZyizYqIjCUpewPsuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444485; c=relaxed/simple;
	bh=a1wBQueMbzNCyRy9etduLW4mo+QWs+py1WDyJ2WELXA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=oPwdTj/pRo+N62MalHAJXsuWBBGPbvqwPZAXbqPrGTio3kAg8h+x46dk5kH8RBgvIYHBqNtt6QpXEki89OO6f//qKWBvYCsX0DfNFVjYqu/Y+A8KbFgVSVS+ZdPXMB7vslV+Jn82IKBam7wRR+JaopyMRABlw7XS2wVSn9QoMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NTTU1W93; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NTTU1W93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724444471; x=1725049271; i=l.s.r@web.de;
	bh=1XtS0wv9HAMZ7k4qnm2oXUeE85WiYxGPL2VebrPcTyg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NTTU1W93StqGVnktq2/64sc4m64/ozNEpQsncIgE7/6Oifn98AsjgFaACG7JkqOb
	 cHA3MU4Y0t8OpE9RvTRlL3Lh67JyoXyNdR8gHdbOmh0+V7EcBGfNM3rZeuZKrRAst
	 xpwPCRv2TkPgpk8R6r/kYurOBrXJike/NT/+dd4XwHubiqKXKbKIDeVdUAJLH4TN5
	 w3Eyi2SAQpBSHxnLlJ0KdFg8qt4ZGVdcaxKJ26GzthExkJb/hj1ATJqfJ6sBEz+jF
	 HFyfsnDkUQdrYpM7M1xoo4iqKtaWyuJAYlV8v5tIgVxNank0KSdLJh99o5hgSTBpB
	 9zdVfriB6VtofiEkPQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([79.203.19.117]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1s5gnY2k9X-00z65L; Fri, 23
 Aug 2024 22:21:11 +0200
Message-ID: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>
Date: Fri, 23 Aug 2024 22:21:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote: plug memory leaks at early returns
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bW5uGUpiqwXD2e1xGQiUwxFD0b7/Xg81mrsDnt6fjbe+41XCgbu
 nXUbaltyW5flO1VhtIqPvG6OSfRnD0sQu4wYjdMnkVoNEMNweU4aiIramD0mk4U5ZIfV+HL
 kOM1tkED5GNNmetBHSiDiU6NVkaQVO+oOwcKkM3h1DgEKaa+l7p4Kf0nhInTy7D2Xq3Gyj3
 6FoatddZ3RLVOp+Q96bRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tYQRYXdmJQg=;JTomuxwEAarVUwBfoJU93yI5OkC
 mpCI96yvRRHwHTIHLPQwRL/T5Ac7eTm6AV9OQmET58AUldSfpww1N9RadNaw0JPsea2hfxFOd
 gUNpUmnwa8+tauN/Ti27RxMPqepbcpYxNDX3awW4uSHhSmeO2IKkWuTG4wspb9+MQ77edmi0T
 haO6g9U3vl7fgWGOEuqqMC1f/+9ZXwDLrj1hRPS0Tcm+UkYTo3vxd4/wY5ia2WQZbqnHVQ6kB
 S5hsBqB5exh71zGG0ZBBjWaNDKssFVzZH0SKV5IAGFmkTAr6UnmtAu2hMiN9BikwFQZfLDzOp
 ZLATYs3SFxXUPF8VpdNevHchJShXi7JWCWKcwHLGXWc9S6BUvjf1UrndBJVnKQvw2dlkGpWEX
 jI5D6Jzu+whzS6Iw9+d4j/PkewS45Pi2EcdKLALSEUvtk9X8efkLGB8UN6ZLvE8YgblbVVI9Z
 dq6rjzAUNNsVtZ8Q3uOSNjUmHm2fznmBp8XOb5DetnxHthTG80kz/ww0YYLxL80DZypQ5hALC
 pv7UlCLKMopGBxrX37m7HBiHxOSd8TW5hhqh2zuQyfISiEYGEr20TBem2GfouwxpCQqxRkimT
 rLnyS/iDVcl0sAsyak97tSaHXkxoFnTB1Dr7nC+lHPiZcKxz1urhxertyYWBfqPf1VyQj+VZR
 WIbQFhsUoOc64f1pugGEpokmtBMlXwCYG3p1PIcte1uPYZUfP80bmajGXKdDkBlnRS3FDjCAq
 bS4Y3a/JZ+/bMXXCGbqGgfVvGwonyZXk3haBXUct82yBY2rY+ebzjUhdb8Pcb+3a9F3Z0//Tv
 FV01pnsNtschsKqHdZ1DvcCg==

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/remote.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d1f9292ed2..0acc547d69 100644
=2D-- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -164,6 +164,7 @@ static int add(int argc, const char **argv, const char=
 *prefix)
 	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
 	const char *name, *url;
 	int i;
+	int result =3D 0;

 	struct option options[] =3D {
 		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
@@ -230,8 +231,10 @@ static int add(int argc, const char **argv, const cha=
r *prefix)
 			       fetch_tags =3D=3D TAGS_SET ? "--tags" : "--no-tags");
 	}

-	if (fetch && fetch_remote(name))
-		return 1;
+	if (fetch && fetch_remote(name)) {
+		result =3D 1;
+		goto out;
+	}

 	if (master) {
 		strbuf_reset(&buf);
@@ -241,14 +244,15 @@ static int add(int argc, const char **argv, const ch=
ar *prefix)
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);

 		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf=
2.buf, "remote add"))
-			return error(_("Could not setup master '%s'"), master);
+			result =3D error(_("Could not setup master '%s'"), master);
 	}

+out:
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
 	string_list_clear(&track, 0);

-	return 0;
+	return result;
 }

 struct branch_info {
@@ -715,6 +719,7 @@ static int mv(int argc, const char **argv, const char =
*prefix)
 	struct rename_info rename;
 	int i, refs_renamed_nr =3D 0, refspec_updated =3D 0;
 	struct progress *progress =3D NULL;
+	int result =3D 0;

 	argc =3D parse_options(argc, argv, prefix, options,
 			     builtin_remote_rename_usage, 0);
@@ -747,9 +752,11 @@ static int mv(int argc, const char **argv, const char=
 *prefix)

 	strbuf_addf(&buf, "remote.%s", rename.old_name);
 	strbuf_addf(&buf2, "remote.%s", rename.new_name);
-	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1)
-		return error(_("Could not rename config section '%s' to '%s'"),
-				buf.buf, buf2.buf);
+	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1) {
+		result =3D error(_("Could not rename config section '%s' to '%s'"),
+			       buf.buf, buf2.buf);
+		goto out;
+	}

 	if (oldremote->fetch.raw_nr) {
 		strbuf_reset(&buf);
@@ -870,7 +877,7 @@ static int mv(int argc, const char **argv, const char =
*prefix)
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
 	strbuf_release(&buf3);
-	return 0;
+	return result;
 }

 static int rm(int argc, const char **argv, const char *prefix)
=2D-
2.30.2
