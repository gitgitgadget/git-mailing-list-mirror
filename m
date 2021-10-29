Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D6C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080E360FED
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJ2WGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:06:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61215 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhJ2WGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:06:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F1D516B8C2;
        Fri, 29 Oct 2021 18:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8Tn8rHMMtJga
        DyiZPPOskzMTHPSPQFIAMj6z1yxWTPE=; b=RDfGgV8ghy1Zizw/0vO+GaAopcwo
        DiXhC+xLl/sw5TOKK47GUwoCpLZi3BNA9H3CLWgwXSeA0oErZCjIrDW6CESht5P+
        /o7fu5FPh5BG82D25FpspLkhZ0GnyBPktqU2RuowZEeeXu07Rroz6DGXhXTasGnz
        V05nkFch3uDzaIE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67A5016B8C1;
        Fri, 29 Oct 2021 18:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1586016B8C0;
        Fri, 29 Oct 2021 18:03:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
References: <20211029212705.31721-1-carenas@gmail.com>
        <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
        <YXxs4NZmpjhRkoYA@coredump.intra.peff.net>
        <xmqqbl37ijc7.fsf@gitster.g>
        <YXxvGfelee1pURQ7@coredump.intra.peff.net>
Date:   Fri, 29 Oct 2021 15:03:39 -0700
In-Reply-To: <YXxvGfelee1pURQ7@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Oct 2021 18:00:57 -0400")
Message-ID: <xmqq7ddvij44.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1379F96C-3904-11EC-BE02-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 29, 2021 at 02:58:48PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> > However, according to the unsetenv() manpage:
>> >
>> >   Prior to glibc 2.2.2, unsetenv() was prototyped as returning void;
>> >   more recent glibc versions follow the POSIX.1-compliant prototype
>> >   shown in the SYNOPSIS.
>> >
>> > So it is POSIX to return an int, but that gives us at least one plat=
form
>> > where unsetenv() returns void (or used to). glibc 2.2.2 is 2001-era,=
 so
>> > that may be old enough that we don't care. But it makes me wonder if
>> > other older or obscure platforms will run into this.
>>=20
>> Ahh, OK.  Well, we will hear from them soon enough.  It is not like
>> this is anything urgent.
>
> Yeah, I am OK proceeding along those lines, and seeing if anybody
> screams (though perhaps dropping xunsetenv() for -rc0 makes sense in th=
e
> interim).

Ahh, ok, the use of unsetenv() that assumes a modern unsetenv() is a
regression during this cycle.

Let's queue this then.

Thanks.

-- >8 --
From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Subject: [PATCH] wrapper: remove xunsetenv()

Remove the unused wrapper function.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h | 1 -
 wrapper.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 141bb86351..d70ce14286 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -879,7 +879,6 @@ char *xstrndup(const char *str, size_t len);
 void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
 void xsetenv(const char *name, const char *value, int overwrite);
-void xunsetenv(const char *name);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off=
_t offset);
 const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int =
fd, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index 1460d4e27b..36e12119d7 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -151,12 +151,6 @@ void xsetenv(const char *name, const char *value, in=
t overwrite)
 		die_errno(_("could not setenv '%s'"), name ? name : "(null)");
 }
=20
-void xunsetenv(const char *name)
-{
-	if (!unsetenv(name))
-		die_errno(_("could not unsetenv '%s'"), name ? name : "(null)");
-}
-
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >=3D INT_MAX; and even in
--=20
2.33.1-1021-g744e6a0a52

