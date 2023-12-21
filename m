Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2B1843
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lVY1JE+B"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B05E51BFACC;
	Wed, 20 Dec 2023 21:41:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MYpCOdmc9EDwt16kvXeC3zaUlFeOjv2IfMFPVZ
	i7rDs=; b=lVY1JE+BsiiVJlKVG2D6hQZKQ9OHlfJ/pnEtz0QvGey/WpzgMkAB/K
	SBPpwJ/4+E925TCgZhCoEblUh1AV0amJeUmOjyZk0zd4o8Zo/yOH42f+PUDvaJOQ
	hwdy1qRmKpXiGczH1oeOnzncY4X5qkA6ae7VawUIGgN8BmL3l2E/U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A68301BFACB;
	Wed, 20 Dec 2023 21:41:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BD191BFACA;
	Wed, 20 Dec 2023 21:41:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, Jeff King <peff@peff.net>
Subject: [RFC/PATCH] archive: "--list" does not take further options
In-Reply-To: <xmqqbkakqx6s.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	20 Dec 2023 15:19:23 -0800")
References: <xmqqbkakqx6s.fsf@gitster.g>
Date: Wed, 20 Dec 2023 18:41:56 -0800
Message-ID: <xmqqttocp98r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 821D4BBC-9FAA-11EE-8C56-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"git archive --list blah" should notice an extra command line
parameter that goes unused.  Make it so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This was done to convince myself that even though cmd_archive()
   calls parse_options with PARSE_OPT_KEEP_UNKNOWN_OPT and then
   uses the resulting argc/argv without apparent filtering of the
   "--end-of-options" thing, it is correctly handling it, either
   locally or remotely.

   - locally, write_archive() uses parse_archive_args(), which calls
     parse_options() without KEEP_UNKNOWN_OPT and "--end-of-options"
     is handled there just fine.

   - remotely, run_remote_archiver() relays the local parameters,
     including "--end-of-options" via the "argument" packet.  Then
     the arguments are assembled into a strvec and used by the
     upload-archive running on the other side to spawn an
     upload-archive--writer process with.
     cmd_upload_archive_writer() then makes the same write_archive()
     call; "--end-of-options" would still be in argv[] if the
     original "git archive --remote" invocation had one, but it is
     consumed the same way as the local case in write_archive() by
     calling parse_archive_args().

   I do not like the remote error behaviour this one adds at all.
   Do we use a more proper mechanism to propagate a remote error
   back for other subcommands we can reuse here?

 archive.c           |  7 +++++++
 t/t5000-tar-tree.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git c/archive.c w/archive.c
index 9aeaf2bd87..3244e9f9f2 100644
--- c/archive.c
+++ w/archive.c
@@ -641,6 +641,13 @@ static int parse_archive_args(int argc, const char **argv,
 		base = "";
 
 	if (list) {
+		if (argc) {
+			if (!is_remote)
+				die(_("extra command line parameter '%s'"), *argv);
+			else
+				printf("!ERROR! extra command line parameter '%s'\n",
+				       *argv);
+		}
 		for (i = 0; i < nr_archivers; i++)
 			if (!is_remote || archivers[i]->flags & ARCHIVER_REMOTE)
 				printf("%s\n", archivers[i]->name);
diff --git c/t/t5000-tar-tree.sh w/t/t5000-tar-tree.sh
index 918a2fc7c6..04592f45b0 100755
--- c/t/t5000-tar-tree.sh
+++ w/t/t5000-tar-tree.sh
@@ -124,6 +124,20 @@ test_expect_success 'setup' '
 	EOF
 '
 
+test_expect_success '--list notices extra parameters' '
+	test_must_fail git archive --list blah &&
+	# NEEDSWORK: remote error does not result in non-zero
+	# exit, which we might want to change later.
+	git archive --remote=. --list blah >remote-out &&
+	grep "!ERROR! " remote-out
+'
+
+test_expect_success 'end-of-options is correctly eaten' '
+	git archive --list --end-of-options &&
+	git archive --remote=. --list --end-of-options >remote-out &&
+	! grep "!ERROR! " remote-out
+'
+
 test_expect_success 'populate workdir' '
 	mkdir a &&
 	echo simple textfile >a/a &&
