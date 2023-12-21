Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55F634F1
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WHM+2c2q"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA0951862C;
	Thu, 21 Dec 2023 13:14:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KoLJMDXnCHSO
	hZFCkUW3D6G2UN/G31ZgkVa/cguYzfg=; b=WHM+2c2q050CVPE8sLZXr2WhZt0T
	wotHPtcIBr2HY6xVOHO9fHOJPchzXK7UYtP8Va8S9AfgB5MTgLL8KGZMaYHGU9NC
	qeDqCMlFPrmay9BSMFlXymmX5381LwejGI8zs8gaGuA+yj5cfEEu44qJvlcYfsRZ
	fKLX8Xc4JaULL5U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B2F8A1862B;
	Thu, 21 Dec 2023 13:14:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2D0918628;
	Thu, 21 Dec 2023 13:13:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [RFC/PATCH] archive: "--list" does not take further options
In-Reply-To: <20231221085948.GD545870@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Dec 2023 03:59:48 -0500")
References: <xmqqbkakqx6s.fsf@gitster.g> <xmqqttocp98r.fsf@gitster.g>
	<296e8d69-c1d7-4ad2-943a-dfc54940abc2@web.de>
	<20231221085948.GD545870@coredump.intra.peff.net>
Date: Thu, 21 Dec 2023 10:13:58 -0800
Message-ID: <xmqqmsu3mnix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B6AC132C-A02C-11EE-891E-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Thu, Dec 21, 2023 at 08:30:36AM +0100, Ren=C3=A9 Scharfe wrote:
>> ...
>> Don't we have one?  It would affect other unsupported options as well,
>> and this seems to work just fine, e.g.:
>> ...
> Right. The whole idea of upload-archive is to spawn a separate writer
> process and mux the conversation (including errors) back over the wire.

Thanks, both.  Just to tie the loose end, let me queue this and
merge it to 'next'.

----- >8 --------- >8 --------- >8 -----
Subject: [PATCH] archive: "--list" does not take further options

"git archive --list blah" should notice an extra command line
parameter that goes unused.  Make it so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c           |  2 ++
 t/t5000-tar-tree.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/archive.c b/archive.c
index ca11db185b..8da820d1ce 100644
--- a/archive.c
+++ b/archive.c
@@ -685,6 +685,8 @@ static int parse_archive_args(int argc, const char **=
argv,
 		base =3D "";
=20
 	if (list) {
+		if (argc)
+			die(_("extra command line parameter '%s'"), *argv);
 		for (i =3D 0; i < nr_archivers; i++)
 			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
 				printf("%s\n", archivers[i]->name);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 4b4c3315d8..72b8d0ff02 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -124,6 +124,16 @@ test_expect_success 'setup' '
 	EOF
 '
=20
+test_expect_success '--list notices extra parameters' '
+	test_must_fail git archive --list blah &&
+	test_must_fail git archive --remote=3D. --list blah
+'
+
+test_expect_success 'end-of-options is correctly eaten' '
+	git archive --list --end-of-options &&
+	git archive --remote=3D. --list --end-of-options
+'
+
 test_expect_success 'populate workdir' '
 	mkdir a &&
 	echo simple textfile >a/a &&
--=20
2.43.0-174-g055bb6e996

