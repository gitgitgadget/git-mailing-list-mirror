Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E31C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356915AbiFORCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357037AbiFORCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:02:48 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACDFFC
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312554;
        bh=ZrrhL/w710jhy2SG3C8tbBlUZiFDmG1XCiqrO1Tyg5k=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=GY06bNL8rFQdx8L7qPrUStBM33/sB9aGC+BX8pVn9tZnAFtjse/0cWvCvoVtT3H5y
         UdsWx6RMgWq9ytIXnmoapfZ3n0OVqhNGQokCwpliPFOYsXI5vcmGcz0WUF1mmXKL3C
         V+L0EgpAxqegTZmrDwrblwT9R7ZNOUkxeiMDYWNw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1nnQNK1TA4-00ymKR; Wed, 15
 Jun 2022 19:02:34 +0200
Message-ID: <1328fe72-1a27-b214-c226-d239099be673@web.de>
Date:   Wed, 15 Jun 2022 19:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 4/6] archive-tar: add internal gzip implementation
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
In-Reply-To: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RtljyghAEK2xia6rSMdhkJ+ZYqgZIInU+EXC/d0DdVQef4KUptW
 nXlaZhFOC2zeqaKeaufanSXN1lto3uW4CIvbmqo9VLJTSGDVfCN20Q0CGTrn11fYZnJvX5e
 oxqf+evlPMYco8DP0fgOlvwNzSMqplV2elwVid3bSO3OlZIeD+mUtd/Zfu8q9bE3q3VzlMe
 HAZobQk2cT6wnyNAKPBKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/t3iB4l0ak=:EgRAS6d/fx5LVYUUFkCVUe
 gdjyhlakz2L06yEH3z0fvWYqAKB3LFR2QkZjCdVytgIxBuR/5ynKPxiwo6aWKXZ4RTvQ+br11
 00uk8UsG/6hUsLimv+2Hr/QTucrTKoyXV8nwwFH6Zg8tHjO/xqoKw4S4BzI9HUH5e4RaodsFc
 sU4zFljTeiNHXTFnxvL5UG0l7Jf5L321PcP3fGSK4nDAarwZ1dB5Emu3VhdNFqiOP27qQ15jd
 V+I+vqtZkDMf8mb0CGq0Ut62WtF/Rje5uKNu+FbrY4BSXH/AJjyPsi87GJKsPfBTCUCEkjybJ
 ZX/G0+x9MfLEfJHrxbxQtZzMKEtD7iViB+hECeAcHcTse+STSEcu+eVwYsVHV+UDJKFETSKgk
 BhfMBi39MOKd5g0notPMhg6zDgA/B6sRaYAxxK1R65vpjHVs1srpoVenS42oZPEQyW/ZuMNBw
 ZXDsB+P8ZSGAZhUSIO0woEpWHc61Mk3/A9WKZntxOAeMWrybETiX0zW2Tht91Ca6r+UMSlSUq
 A7vaotMDeu/MKMlLqi7VGminCjQmm8CXO76CuAB3HKmjE+uMP6VYO0spaIvemxd+TPb89ZGLT
 F+i3PCGKOD8EJa03dYxQl7Ofl6mtV2Z3CYFSrM9uxSh+P1SWABnCNOx2KUHW5E6iZlzeLkdIo
 RjY4QpUl5veaqcGVb+DHrrHjqz67MgBjdVXIjiefRJWFoFVUp7iX6kS/WnNzV0FbJzymNr+y8
 97IEhLoJ73C6Z9wScR7SHc1OPJtGppH+mr5n9rsILRuJHL+JyDDmPTxiKlMV+VDvE1C1rCKJf
 pZ3kQnzCsNShZ17z+dMpcI0pnlAZWXeyInAUmfYo7/1zOX1u5Wwn81J1IUyi++OArBlYJfUmJ
 WaT3kZJMDZPsu8r7nBUnyGGejbQFlYsiywYsqbBlWO0SKQEf359f6DmQsZPvJ8Qb0qrSk+k0X
 2ffNa2mAkkUaJr3cWvSxqhk7DMvH/8mJu8VtkkpCkaUlW1Pc9BcbLEKlLkoPyKJRsAa/++Tww
 4fOtoqpQip5Hwtjqb1me5tuMMpnOfPNcU2U93LupPcR6AxDHjC4heC44W0d64aDswoNRAzZdY
 S5ntNj2bTX8a3Hu7IPPmkP+LehOFiFe8Vmq
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git uses zlib for its own object store, but calls gzip when creating tgz
archives.  Add an option to perform the gzip compression for the latter
using zlib, without depending on the external gzip binary.

Plug it in by making write_block a function pointer and switching to a
compressing variant if the filter command has the magic value "git
archive gzip".  Does that indirection slow down tar creation?  Not
really, at least not in this test:

$ hyperfine -w3 -L rev HEAD,origin/main -p 'git checkout {rev} && make' \
'./git -C ../linux archive --format=3Dtar HEAD # {rev}'
Benchmark #1: ./git -C ../linux archive --format=3Dtar HEAD # HEAD
  Time (mean =C2=B1 =CF=83):      4.044 s =C2=B1  0.007 s    [User: 3.901 =
s, System: 0.137 s]
  Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.059 s    10 runs

Benchmark #2: ./git -C ../linux archive --format=3Dtar HEAD # origin/main
  Time (mean =C2=B1 =CF=83):      4.047 s =C2=B1  0.009 s    [User: 3.903 =
s, System: 0.138 s]
  Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.066 s    10 runs

How does tgz creation perform?

$ hyperfine -w3 -L command 'gzip -cn','git archive gzip' \
'./git -c tar.tgz.command=3D"{command}" -C ../linux archive --format=3Dtgz=
 HEAD'
Benchmark #1: ./git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive --=
format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     20.404 s =C2=B1  0.006 s    [User: 23.943=
 s, System: 0.401 s]
  Range (min =E2=80=A6 max):   20.395 s =E2=80=A6 20.414 s    10 runs

Benchmark #2: ./git -c tar.tgz.command=3D"git archive gzip" -C ../linux ar=
chive --format=3Dtgz HEAD
  Time (mean =C2=B1 =CF=83):     23.807 s =C2=B1  0.023 s    [User: 23.655=
 s, System: 0.145 s]
  Range (min =E2=80=A6 max):   23.782 s =E2=80=A6 23.857 s    10 runs

Summary
  './git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive --format=3Dtg=
z HEAD' ran
    1.17 =C2=B1 0.00 times faster than './git -c tar.tgz.command=3D"git ar=
chive gzip" -C ../linux archive --format=3Dtgz HEAD'

So the internal implementation takes 17% longer on the Linux repo, but
uses 2% less CPU time.  That's because the external gzip can run in
parallel on its own processor, while the internal one works sequentially
and avoids the inter-process communication overhead.

What are the benefits?  Only an internal sequential implementation can
offer this eco mode, and it allows avoiding the gzip(1) requirement.

This implementation uses the helper functions from our zlib.c instead of
the convenient gz* functions from zlib, because the latter doesn't give
the control over the generated gzip header that the next patch requires.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt |  3 ++-
 archive-tar.c                 | 45 ++++++++++++++++++++++++++++++++++-
 t/t5000-tar-tree.sh           | 16 +++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index ff3f7b0344..b2d1b63d31 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -148,7 +148,8 @@ tar.<format>.command::
 	to the command (e.g., `-9`).
 +
 The `tar.gz` and `tgz` formats are defined automatically and use the
-command `gzip -cn` by default.
+command `gzip -cn` by default. An internal gzip implementation can be
+used by specifying the value `git archive gzip`.

 tar.<format>.remote::
 	If true, enable the format for use by remote clients via
diff --git a/archive-tar.c b/archive-tar.c
index 4e6a3deb80..53d0ef685c 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -38,11 +38,13 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 #define USTAR_MAX_MTIME 077777777777ULL
 #endif

-static void write_block(const void *buf)
+static void tar_write_block(const void *buf)
 {
 	write_or_die(1, buf, BLOCKSIZE);
 }

+static void (*write_block)(const void *) =3D tar_write_block;
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
@@ -430,6 +432,34 @@ static int write_tar_archive(const struct archiver *a=
r,
 	return err;
 }

+static git_zstream gzstream;
+static unsigned char outbuf[16384];
+
+static void tgz_deflate(int flush)
+{
+	while (gzstream.avail_in || flush =3D=3D Z_FINISH) {
+		int status =3D git_deflate(&gzstream, flush);
+		if (!gzstream.avail_out || status =3D=3D Z_STREAM_END) {
+			write_or_die(1, outbuf, gzstream.next_out - outbuf);
+			gzstream.next_out =3D outbuf;
+			gzstream.avail_out =3D sizeof(outbuf);
+			if (status =3D=3D Z_STREAM_END)
+				break;
+		}
+		if (status !=3D Z_OK && status !=3D Z_BUF_ERROR)
+			die(_("deflate error (%d)"), status);
+	}
+}
+
+static void tgz_write_block(const void *data)
+{
+	gzstream.next_in =3D (void *)data;
+	gzstream.avail_in =3D BLOCKSIZE;
+	tgz_deflate(Z_NO_FLUSH);
+}
+
+static const char internal_gzip_command[] =3D "git archive gzip";
+
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
@@ -440,6 +470,19 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
 	if (!ar->filter_command)
 		BUG("tar-filter archiver called with no filter defined");

+	if (!strcmp(ar->filter_command, internal_gzip_command)) {
+		write_block =3D tgz_write_block;
+		git_deflate_init_gzip(&gzstream, args->compression_level);
+		gzstream.next_out =3D outbuf;
+		gzstream.avail_out =3D sizeof(outbuf);
+
+		r =3D write_tar_archive(ar, args);
+
+		tgz_deflate(Z_FINISH);
+		git_deflate_end(&gzstream);
+		return r;
+	}
+
 	strbuf_addstr(&cmd, ar->filter_command);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7f8d2ab0a7..9ac0ec67fe 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -374,6 +374,22 @@ test_expect_success GZIP 'remote tar.gz can be disabl=
ed' '
 		>remote.tar.gz
 '

+test_expect_success 'git archive --format=3Dtgz (internal gzip)' '
+	test_config tar.tgz.command "git archive gzip" &&
+	git archive --format=3Dtgz HEAD >internal_gzip.tgz
+'
+
+test_expect_success 'git archive --format=3Dtar.gz (internal gzip)' '
+	test_config tar.tar.gz.command "git archive gzip" &&
+	git archive --format=3Dtar.gz HEAD >internal_gzip.tar.gz &&
+	test_cmp_bin internal_gzip.tgz internal_gzip.tar.gz
+'
+
+test_expect_success GZIP 'extract tgz file (internal gzip)' '
+	gzip -d -c <internal_gzip.tgz >internal_gzip.tar &&
+	test_cmp_bin b.tar internal_gzip.tar
+'
+
 test_expect_success 'archive and :(glob)' '
 	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
 	cat >expect <<EOF &&
=2D-
2.36.1
