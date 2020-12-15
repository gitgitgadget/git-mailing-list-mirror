Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F155C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC82A207A2
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgLOCoc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:44:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58727 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgLOCo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:44:28 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C33EF10F931;
        Mon, 14 Dec 2020 21:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Sz7KmKm77QmyEFS1ZAR7fjdCnHk=; b=Hqt3o/
        gmcxTmIgRQXbII8QnTvnAc2JUnLKYZCNLIv2RW3FdDdEfEZVSiWnc6WUmKnkZEiq
        w+as+9y8QMViikZ7ZVD3GNnTRSOwct7Nj7OGr7SqLX+4VnhTxyL0d3pcqhcZ2Ziv
        R4ie2kGx5h5FNW7Wc4kuQwimLtb3Bop/PXXn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kdIhD4FbhbD2yOOZK6ltX3vrsJoe2mPh
        adubnrt69fzfPvGQQyi9ufnAq141WcdRBs7ybxGAeiioAj22xCWgJE5xB4Htywf5
        TEbu7DaMfjOU7PYcFCQRBYAbyURQtvO8bJx0zDGkiyuGLBsWCErMGFX4qYY22wl7
        G9siYI6FOn0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBFAD10F930;
        Mon, 14 Dec 2020 21:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1242110F92E;
        Mon, 14 Dec 2020 21:43:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
Date:   Mon, 14 Dec 2020 18:43:36 -0800
In-Reply-To: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 14 Dec 2020 18:12:03 -0500")
Message-ID: <xmqqeejraiw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 557B8B76-3E7F-11EB-A694-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> 2.30.0-rc0 fails to compile strmap.o, and probably others, since this is in
> a header file:
>
> "git-compat-util.h", line 277: warning(1252):
>           missing return statement at end of non-void function "setitimer"

Thanks for reporting.  I guess nobody without setitimer bothered to
test, since 15b52a44 (compat-util: type-check parameters of no-op
replacement functions, 2020-08-06) which was a tad before 2.29 was
tagged.

diff --git c/git-compat-util.h w/git-compat-util.h
index 7d509c5022..58cd0761be 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -273,7 +273,8 @@ struct itimerval {
 
 #ifdef NO_SETITIMER
 static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
-	; /* nothing */
+	errno = ENOSYS;
+	return -1; /* not implemented */
 }
 #endif
 
Alternatively we could pretend that the call always succeeds by
without touching errno and returning 0.  That might be safer, but I
dunno which one we want, and I do not have a system affected by the
choice.

>   	return strmap_remove(&map->map, str, 0);
>   	       ^
> "strmap.h", line 168: error(210):
>           a void function may not return a value
>
>   	return strmap_remove(&set->map, str, 0);
>   	       ^
> "strmap.h", line 252: error(210):
>           a void function may not return a value

This is a GNU extension biting us, perhaps?

Apparently these came from 4fa1d501 (strmap: add functions
facilitating use as a string->int map, 2020-11-05).

> Aside from inlining bodies, this should not have compiled on any platform:
>
> static inline void strset_remove(struct strset *set, const char *str)
> {
>         return strmap_remove(&set->map, str, 0);
> }
>
> What is really intended here?

I think we should just drop "return"; a void function should be
called in void context without requiring a value, even if that
return expects no value.

diff --git i/strmap.h w/strmap.h
index c4c104411b..1e152d832d 100644
--- i/strmap.h
+++ w/strmap.h
@@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap *map, const char *str)
 
 static inline void strintmap_remove(struct strintmap *map, const char *str)
 {
-	return strmap_remove(&map->map, str, 0);
+	strmap_remove(&map->map, str, 0);
 }
 
 static inline int strintmap_empty(struct strintmap *map)
@@ -249,7 +249,7 @@ static inline int strset_contains(struct strset *set, const char *str)
 
 static inline void strset_remove(struct strset *set, const char *str)
 {
-	return strmap_remove(&set->map, str, 0);
+	strmap_remove(&set->map, str, 0);
 }
 
 static inline int strset_empty(struct strset *set)


> Sorry,
> Randall

Thanks.
