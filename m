Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC45C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiFLGI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFLGI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:08:56 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4E21B7B7
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655014116;
        bh=xmhi2u/Xgh/67bSnp3cHzvvsNcqXHIzfxmiMRL/ycVw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Iza3q+qDSIP3bBvn1L6fuylGQaDTk8d+KUQvh7nBmT6JcwFQ11uheT5wPmhQDDREv
         9sgHNSIiRLzA8Ri/XTtj7zN1dGI4P197ctDOAJd2ew+3tCJQ1260XjIg281iX5+Omj
         h6WSpGiLEYWST1YXKUxacGKCN/aj9tcQjdhLqBKU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1ny86t49we-00Fbb7; Sun, 12
 Jun 2022 08:08:36 +0200
Message-ID: <75e76d0f-2ab0-ebf7-4a4e-7a6e0fca0b1a@web.de>
Date:   Sun, 12 Jun 2022 08:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 3/5] archive-tar: add internal gzip implementation
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
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I/CazHmT9gy6drh62Qk9Znyiap60EALm2e6/UAaWxMpYiE2GE1w
 iEiTAEZFSdhp0TpMiQjLoliC5oehAFQhJBmKMw27+4OZZcDZpjmuRHTZXUUHzO2LlPKUSWg
 +tojEb/+SFGcVkkQUTR4zzhwhPdwtUowOIbElDG9eEBiryHWJkGP3+Vpvrnl98d8s4pjShC
 ynDK0P4qaUzAwkwo6eTyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kShSi/1QB8o=:BqfPq940qQUZZJJm1mmkUu
 hEpRmVgQCNA23ndZzgYdGImGqJyp3hqz/6Gg+86eqBVwPbVhtjCJCdpYBrH0Pj9mPPDHL66mm
 y5128xJF89qBHd8PWdjdM5bBK5yp+JqBLvvbPfjWhYd4F77PkPE8vDiCsz+QC36s+B6hoedBl
 PHWajq6v4jVE/cn//Ehg2/50q/uPJ5sQ6pYCiS7uT8QPBt4wOf0BsmriknskkSbT8jn3EBPwX
 g8YWGQu0j0ywfSfM+fQX5Hwmj+WIqEdbmybE1pnP/PCqsLqNlxQt8y2lxEKBP9ZKdo5U7lUHA
 7unM+tlFozqDtcULqZYBIhU2/UeSJ88+stWGJFdIXIEZ/vr0EDeYWbciTdjFKYWVwlf2FLbAK
 +g3SrZdO32OC8trW6kTQbJnnfqYMJyECLknwyzE0VLuNAgBy1c3sUHBWs+DG7ZY+wvcVDiLWW
 rpa2Xa3roOudFm/j2JPRh6qtlf8qBUVE8zntaLU6NVXX9Ewbp9BUjtIb3xnetukF9Fx1gEjM1
 yen0sWvvlZc27nEk3Fm82kOAyPlrGv0iUaiTeBqbDY0XKsoDJXHajOjLOC7I1UUTrewcXD5ag
 JFFORUVNujF5p7OxNaCQkKHAWEw+pjGtDPDtyillKRZvxfLFFAmHcKWow9cZUhxANzBrpbphj
 pmMkBF/QmpY2MnlRDsRBu1D0jtd93QF17j9wQYd774RYQlL9aHy8CM4gLgZptZWQQAxtAyKzF
 u1NlEUdbuZVwTsSXSuObZSCgMoe2/WFAEWM4bS6P/Z6/i9HSMpbU2YAej1tmWtZnrqAekx0nY
 5Px2etYI5QjGP9VALOI24yfR1ua/UVFZsF6eGKZsLR/dh9wTUEbG3lHssTUWdBc9qlSXO+g/E
 Fn3U6zPXPuLksmcN9XLc6YDAjGMDkkxCNU1WIGbqX8yR39K8p4F8oGJr9nus3V7kkOKPsWgVJ
 vHMXCdkDxfNLJ57Z2YF5Kft9h9/6CwCwg/dLhvjHJ9OYtiVlhHsS18045IKvSrYHlVlsRW/z6
 nkpLwbXuEnRv8He/3ajPIBApsE/qTA4Si7LkfxvOtdfj0vm9pTtzOpZlb5LtbGrP2CYbTdHgU
 yB48dFSCfhaPzLYKgRM8FAj9v8pJPNn0hww
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
index 56989a2f34..5b017c2bdc 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -148,7 +148,8 @@ tar.<format>.command::
 	format is given.
 +
 The "tar.gz" and "tgz" formats are defined automatically and default to
-`gzip -cn`. You may override them with custom commands.
+`gzip -cn`. You may override them with custom commands. An internal gzip
+implementation can be used by specifying the value `git archive gzip`.

 tar.<format>.remote::
 	If true, enable `<format>` for use by remote clients via
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
