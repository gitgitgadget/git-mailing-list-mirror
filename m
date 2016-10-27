Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E402F20193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938478AbcJ0VtR (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:49:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53100 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935306AbcJ0VtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:49:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D987F49CEB;
        Thu, 27 Oct 2016 17:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Du8DzYjmk7nBejTf0T6mhewBMk=; b=uQ8sal
        bVg1hNkvj3KP+Avq3S+71iZRsHHbJEUNEE9ZTKHfI41P6pTG85Rpsjf59ztm4XHr
        pyto/mh5LCdY4nw+r4Yxn4Bp3SvZjllcb24umGY7Y715i/bm48U1SzB9i+wfO6ic
        8Pd6kbgFB6SJlh7hlwcQnVlgjSs/KhZJQdKE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oMW47Xm2bUou4zqkII9a64v0taKTRe67
        pS6UqeXZ3q8tl9wBVpRczqvT0BzHMmjdEbbyE0aRxhX24E0vAFefWUzYJWNf/sS9
        pRf9d+WSh29cx5FaaizrMhty52g//KkcjXS7rnZVLURlWAxO7DEKVoXkE6xS+CLF
        MatUlOZVjkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF79049CEA;
        Thu, 27 Oct 2016 17:49:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 490AF49CE9;
        Thu, 27 Oct 2016 17:49:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
        <20161025181621.4201-1-gitster@pobox.com>
        <20161025181621.4201-3-gitster@pobox.com>
        <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
        <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
        <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
        <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
        <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
        <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
        <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net>
Date:   Thu, 27 Oct 2016 14:49:12 -0700
In-Reply-To: <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Oct 2016 06:24:19 -0400")
Message-ID: <xmqq60od5up3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33B539BA-9C8F-11E6-A8B0-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +cc Linus as the original author of 144bde78e9 in case there is
> something subtle I'm missing, but this really just seems like it's
> an outdated optimization.
>
> -- >8 --
> Subject: [PATCH] sha1_file: stop opening files with O_NOATIME
>
> When we open object files, we try to do so with O_NOATIME.
> This dates back to 144bde78e9 (Use O_NOATIME when opening
> the sha1 files., 2005-04-23), which is an optimization to
> avoid creating a bunch of dirty inodes when we're accessing
> many objects.  But a few things have changed since then:
>
>   1. In June 2005, git learned about packfiles, which means
>      we would do a lot fewer atime updates (rather than one
>      per object access, we'd generally get one per packfile).
>
>   2. In late 2006, Linux learned about "relatime", which is
>      generally the default on modern installs. So
>      performance around atimes updates is a non-issue there
>      these days.
>
>      All the world isn't Linux, but as it turns out, Linux
>      is the only platform to implement O_NOATIME in the
>      first place.
>
> So it's very unlikely that this code is helping anybody
> these days.
>
> It's not a particularly large amount of code, but the
> fallback-retry creates complexity. E.g., we do a similar
> fallback for CLOEXEC; which one should take precedence, or
> should we try all possible combinations? Dropping O_NOATIME
> makes those questions go away.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

We may want to lose the surrounding for (;;) loop as there is only
one flag to retry without, which was the original code structure
back when 144bde78e9 ("Use O_NOATIME when opening the sha1 files.",
2005-04-23) was written and refactored by 44d1c19ee8 ("Make loose
object file reading more careful", 2008-06-14).

IOW, this on top.  The update to ce_compare_data() Lars has in
a0a6cb9662 ("read-cache: make sure file handles are not inherited by
child processes", 2016-10-24) could then made into a call to
git_open().

 sha1_file.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6f02a57d8b..e18ea053e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1553,24 +1553,17 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 
 int git_open(const char *name)
 {
-	static int sha1_file_open_flag = O_CLOEXEC;
-
-	for (;;) {
-		int fd;
-
-		errno = 0;
-		fd = open(name, O_RDONLY | sha1_file_open_flag);
-		if (fd >= 0)
-			return fd;
+	static int cloexec = O_CLOEXEC;
+	int fd;
 
+	errno = 0;
+	fd = open(name, O_RDONLY | cloexec);
+	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
 		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
-			sha1_file_open_flag &= ~O_CLOEXEC;
-			continue;
-		}
-
-		return -1;
+		cloexec &= ~O_CLOEXEC;
+		fd = open(name, O_RDONLY | cloexec);
 	}
+	return fd;
 }
 
 static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
