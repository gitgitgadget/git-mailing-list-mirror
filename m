Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F98126BE7
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726950230; cv=none; b=MdoKRNTXb5I6J7Q0mAmpxr4IbY8K42t86cSES3sHbg1g7UI7Ha/uM+Z5RmjWlBth/nFsl3sM8yf5h/bajDU3q7zBdC1yORlwID4Vr2Sg0+U2iC5A/S+4FXEEKVd87wjihgzy57sy7HSF9l61BRQsBoF+JQ9brWhJAMmRh44Akl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726950230; c=relaxed/simple;
	bh=9WikwmPjjiMcLhsK8WJNiXGNNBBEZHP2zBN/39YZYYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fJ/NDpK9pATEOUVSDsdT4bgNeZCtRwo95bM/LGIwpOMhGfn7/CwqI3rTsXTO+wQgpW0bQY48UB/w3f4MuoYhFvEUGb66fh6BXgv2o+ClSvyzSAlqNar4lXXTKsxVtMYYEjNpRxcqF3SwEveZ102mSGgkmIHDiGX0JituZYzIJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=SRtm/iPo; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="SRtm/iPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726950219; x=1727555019; i=l.s.r@web.de;
	bh=52wOD02eZU+ko5c8iZxHIDAJi5rK4q/sXqu0goCLJrM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SRtm/iPo6inxlG9yubdxGr4Tyjv3ybJCyGa76ZqDCOe4vjeFfu8D1UqJe2Jd+1G3
	 gRS3qwA97DgDRX5vo+8YcRRQalMsL/SYaWRwqP/bLU80cAB2XN8KWqVFYvGhoCAev
	 PVnpRmpM2LnoTkRJtecuAqT3T59hhjm/AI6hKtMPr1ILmAGfjhH2MXLKPj6f1cZih
	 giPs96gngq5WNFcsdA9aWODRoPukYqRFlJ6sx08DWV/aPUFNEc3nw3WSk7m923lqA
	 EODOU1eU2JLFiTZcDhsXoAvOFB37h2GSsKP2jTIl4WHS5swdKuqmnnlIokKWITs8O
	 lyeeS7AVRlJutfYORw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.77]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1soFYT2SmE-00GUqW; Sat, 21
 Sep 2024 22:23:39 +0200
Message-ID: <66c3e9fa-ecfe-4af2-a970-c1afdbc2b7f2@web.de>
Date: Sat, 21 Sep 2024 22:23:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] archive: load index before pathspec checks
To: Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org
References: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <4ace58897feee2d86839af1a36770e49810e59b8@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B1nHRbptX+4y75lgVSXy2t1vc+meYNckpMSWVzTPmnyRXdziqJ4
 i+7QJm+SxpRqfbIUvSZyK4cA0Qjxy6/CHTBcqc/uPde6JffnoYtJ/OQE7zjXQEmUqqGeWRT
 GKDyC91tZyW7liEEawUIyxVl8uCQT6OqP7Sq578sNMNci6OfuIvTdqEZS9w8Y3cBwA9kUP5
 NSzwRMEwOaXb2Zpx5ZgRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qrzmOKd3Nvc=;+JM6rp46MmynioMlQG3jNy6zY3U
 G8GXA/DDplns7TLEBaPgWaXOCwwgkg2mo5iPy/IsocKTm4kAC+qU90UowzTsp0B/EC9LTd7tm
 2XEgRELMiIoMeUecTDJoi8/+LHc43fsPDMV+o1LDHhqX/HTsLby0eW4AH+TED4uPWf/oTDmXN
 sjwlHJ0Okc9u+80OdW9tNy9tEXiNBbtlQ9xdNCqZqTtnLlSd/z02QzCiDtGS0xxngVQdEUkOo
 aItL1XTFOxp2OzhdGkIrlkdJm6y8LbrYel+ImnFCYn1e0DYOyuQ02pEAgUdI3iMSX0krY5HSF
 EshGv15+r6VNwUnbBWFAFIXqqL80+1aBwtAyzgQiwYb7RhGqTMsm6hNNIjkQ9e7xh2GhUoBJE
 m0lWhVJOKnc2NfvHROXXZ9dcJAUYstGkPMzgx427bKGXPcaEr6WqqofBosxuKut8pV0eedw6W
 iH7S+vtEV7pUtY41EXTvZQ8qLH6sHbwQ5HHfPFdPkusapYD0yNYuFeivakiVYYJmlK1LVi/5g
 yyf7JP+eGSbB02LEc156dyTmjYSfl+uGV20DoB2qoffTgWjsANRXxdwEZkFKDWwy1t/gM+PSP
 RGQk7TB5QtxkGqkTdTGp8LDcNtJQK5Fnlp6M1X8CZkCL5Y3sZrPiH9T5IPu5DlI0lZGDwpGx6
 fNwlQzz73ME7xdQXSz2dBKHVfSmuqhyi+W8ejSLzNp3SAcZK247Rlf/bAcdI6sgyKVR6KAl4w
 5S9JrQSQuE0dDSE5SZx3cQ8xKGRFsA0eIM+OP81DxhcyOtsqhWNPwWDxIDfXm6QTTDnjYJm8e
 r92g7BOcTfxtGeZigmK/zmHA==

git archive checks whether pathspec arguments match anything to avoid
surprises due to typos and later loads the index to get attributes.

This order was OK when these features were introduced by ba053ea96c
(archive: do not read .gitattributes in working directory, 2009-04-18)
and d5f53d6d6f (archive: complain about path specs that don't match
anything, 2009-12-12).

But when attribute matching was added to pathspec in b0db704652
(pathspec: allow querying for attributes, 2017-03-13), the pathspec
checker in git archive did not support it fully, because it lacks the
attributes from the index.

Load the index earlier, before the pathspec check, to support attr
pathspecs.

Reported-by: Ronan Pigott <ronan@rjp.ie>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c           | 39 ++++++++++++++++++++-------------------
 t/t5000-tar-tree.sh | 12 ++++++++++++
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/archive.c b/archive.c
index 9ba96aae4f..58f86bf75c 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -304,8 +304,6 @@ int write_archive_entries(struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
 	struct archiver_context context;
-	struct unpack_trees_options opts;
-	struct tree_desc t;
 	int err;
 	struct strbuf path_in_archive =3D STRBUF_INIT;
 	struct strbuf content =3D STRBUF_INIT;
@@ -331,23 +329,6 @@ int write_archive_entries(struct archiver_args *args,
 	context.args =3D args;
 	context.write_entry =3D write_entry;

-	/*
-	 * Setup index and instruct attr to read index only
-	 */
-	if (!args->worktree_attributes) {
-		memset(&opts, 0, sizeof(opts));
-		opts.index_only =3D 1;
-		opts.head_idx =3D -1;
-		opts.src_index =3D args->repo->index;
-		opts.dst_index =3D args->repo->index;
-		opts.fn =3D oneway_merge;
-		init_tree_desc(&t, &args->tree->object.oid,
-			       args->tree->buffer, args->tree->size);
-		if (unpack_trees(1, &t, &opts))
-			return -1;
-		git_attr_set_direction(GIT_ATTR_INDEX);
-	}
-
 	err =3D read_tree(args->repo, args->tree,
 			&args->pathspec,
 			queue_or_write_archive_entry,
@@ -540,6 +521,26 @@ static void parse_treeish_arg(const char **argv,
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));

+	/*
+	 * Setup index and instruct attr to read index only
+	 */
+	if (!ar_args->worktree_attributes) {
+		struct unpack_trees_options opts;
+		struct tree_desc t;
+
+		memset(&opts, 0, sizeof(opts));
+		opts.index_only =3D 1;
+		opts.head_idx =3D -1;
+		opts.src_index =3D ar_args->repo->index;
+		opts.dst_index =3D ar_args->repo->index;
+		opts.fn =3D oneway_merge;
+		init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
+		if (unpack_trees(1, &t, &opts))
+			die(_("unable to checkout working tree"));
+
+		git_attr_set_direction(GIT_ATTR_INDEX);
+	}
+
 	ar_args->refname =3D ref;
 	ar_args->tree =3D tree;
 	ar_args->commit_oid =3D commit_oid;
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7abba8a4b2..b9fda973f7 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -137,6 +137,8 @@ test_expect_success 'end-of-options is correctly eaten=
' '

 test_expect_success 'populate workdir' '
 	mkdir a &&
+	echo "a files_named_a" >.gitattributes &&
+	git add .gitattributes &&
 	echo simple textfile >a/a &&
 	ten=3D0123456789 &&
 	hundred=3D"$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten" &&
@@ -450,6 +452,16 @@ test_expect_success 'allow pathspecs that resolve to =
the current directory' '
 	test_cmp expect actual
 '

+test_expect_success 'attr pathspec in bare repo' '
+	test_expect_code 0 git --git-dir=3Dbare.git archive -v HEAD \
+		":(attr:files_named_a)" >/dev/null 2>actual &&
+	cat >expect <<-\EOF &&
+	a/
+	a/a
+	EOF
+	test_cmp expect actual
+'
+
 # Pull the size and date of each entry in a tarfile using the system tar.
 #
 # We'll pull out only the year from the date; that avoids any question of
=2D-
2.46.0
