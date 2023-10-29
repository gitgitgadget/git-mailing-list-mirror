Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8D12E7B
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KZ8c8gpg"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E50BD
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 15:31:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B8E62C08B;
	Sun, 29 Oct 2023 18:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Flo65EPVBfvA
	ROVhjDVcS2Pxg0n0g8fgtqPQ+EGCDbM=; b=KZ8c8gpgYuGGkAB35+edxTiqvVKz
	FNPqWgMg1EuXsw6d+QpVgQLVxNAYJAB3E9i4CdOIlUyKUEVF8tcmLfpGiGqXoU9m
	ryFkcbRgr3oQWH9EUlj6DXwaeaRoadvIGWID4o6QJm8Dyid3V6u6A2Uxgi3Dxzbs
	1ZIEse/p0Z/6s+A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 746D52C08A;
	Sun, 29 Oct 2023 18:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1695F2C078;
	Sun, 29 Oct 2023 18:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reflog: fix expire --single-worktree
In-Reply-To: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 28 Oct 2023 13:58:41 +0200")
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
Date: Mon, 30 Oct 2023 07:31:22 +0900
Message-ID: <xmqqa5s1hxhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E4415B90-76AA-11EE-99CC-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> ... and added a non-printable short flag for it, presumably by
> accident.

Very well spotted.

FWIW, with the following patch on top of this patch, all tests pass
(and without your fix, of course this notices the "\001" and breaks
numerous tests that use "git reflog").  So you seem to have found
the only one broken instance (among those that are tested, anyway).

 parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/parse-options.c w/parse-options.c
index 093eaf2db8..be8bedba29 100644
--- i/parse-options.c
+++ w/parse-options.c
@@ -469,7 +469,8 @@ static void parse_options_check(const struct option *=
opts)
 			optbug(opts, "uses incompatible flags "
 			       "LASTARG_DEFAULT and OPTARG");
 		if (opts->short_name) {
-			if (0x7F <=3D opts->short_name)
+			if (opts->short_name &&
+			    (opts->short_name < 0x21 || 0x7F <=3D opts->short_name))
 				optbug(opts, "invalid short name");
 			else if (short_opts[opts->short_name]++)
 				optbug(opts, "short name already used");
