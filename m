Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17198 invoked by uid 107); 21 Feb 2010 22:20:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 17:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab0BUWUb (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 17:20:31 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46227 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0BUWUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 17:20:31 -0500
Received: by bwz1 with SMTP id 1so1247664bwz.21
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 14:20:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KkB3zxwgjwU0KF+B9Qt0ULnyoXqkNnOei5tUdrFQiV4=;
        b=oB2IL8/n6+DcfjYCdk70/rO6pOy2KrPTC69/ts3J293QaEZXP9qMti4BPR0LNfvPN8
         nRizIMXBtocaOpIVMxkcfC91+m/FOI8Jv/r9e8jnzvVG4WZageF9bNNH1TPlYZmYHRB3
         idT0SsiTCFGLI1H8PvgXrp3RM2qP9ZA9RyDxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SnfdJ1s7NFMQqpo8j3wl99IIffLxVqP+/d8aTq0JNzrVmrAXHtKCzuI2c9oc1hCibt
         DF02eLaFqYqR1PP2nT+yc23jwZum2wcpAHwjrLTJnW7kh8jNy3Dm/qZkTn+27n55lqET
         IQoMLGnCGjmkrMbUzVsWa2OgQVoE97cMzoXFs=
MIME-Version: 1.0
Received: by 10.204.140.197 with SMTP id j5mr440987bku.68.1266790829636; Sun, 
	21 Feb 2010 14:20:29 -0800 (PST)
In-Reply-To: <854olcqlim.fsf@oqube.com>
References: <1265869060330-4553010.post@n2.nabble.com>
	 <81b0412b1002110401mc77bd68w28034ca0e7fc537@mail.gmail.com>
	 <854olcqlim.fsf@oqube.com>
Date:	Sun, 21 Feb 2010 23:20:29 +0100
Message-ID: <81b0412b1002211420k7bc73e4aub84ed6829d4a1acd@mail.gmail.com>
Subject: Re: Problem adding a symlinkg
From:	Alex Riesen <raa.lkml@gmail.com>
To:	Arnaud Bailly <abailly@oqube.com>
Cc:	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Feb 20, 2010 at 10:55, Arnaud Bailly <abailly@oqube.com> wrote:
> readlink("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", "libprotobuf-lite.so.5.0.0"..., 59) = 25

The return value (25, positive) is no error. It is the length of the
symlink data.
This looks like an old Git (59 as buffer size, more recent version
should have used
56 as returned by stat earlier).

> lstat64("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so", {st_mode=S_IFLNK|0700, st_size=58, ...}) = 0
> write(2, "error: readlink(\"pb-ut"..., 104error: readlink("pb-util/protoc/Linux-x86-2.6.28/lib/libprotobuf-lite.so"): Invalid argument
> ) = 104

This looks like a bug in the version of Git you're using. It must be
fixed by now (at least
in 1.6.2, commit b760d3aa "Make 'index_path()' use 'strbuf_readlink()'").

I don't know why your lstat returns size for a symlink which is
different from what readlink returns,
but this is why it fails: the code that you seem to be using assumed
that must be the case.
Newer code just does not care and trusts the result of readlink.

Upgrade your Git, it is worth the time anyway.
