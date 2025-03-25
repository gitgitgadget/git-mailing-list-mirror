Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5928634A
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892339; cv=none; b=rakuTZkwGwAE7v3C7lABVQP4yiietBlt1gkUFgu2+8msNH8gfiIZSfhfVSjE3utH8AfDFRnjaNBXZTqPu+4Zv7vOH13oORO+xH1BqV5idK0yrXvogG+Uqoce26r1+gJSsQDa3DCEJJtKXhbNMdG6gi9VoGlKN4X8Il4w/1bUZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892339; c=relaxed/simple;
	bh=RyjaDYQLK4ink2oW+3qSvfdV/vmiEwuda9bDF+LTqF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q3yDqJ/8Mc8XeVyxxmuLe088u6Bc6k7DB5Vc1cpmMaA9rovMM6QyvZHyEJjqUHifZfUvroaRR0tfan9hqN7UNaqAZR7Yu8T995I5eYTNv553k0QmI+gG2C5fy3IeCnKD12CX3mokDeZB4WoIGhpAbVYanpmxmw2XDvAtoH2REVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Met7r3cG; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Met7r3cG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1742892332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ07e3Ul0in3HXfUCLBHGPtt/mNtCZXjk6nhTNetlRs=;
	b=Met7r3cGXwGUapmMBYQR5mJmjtMEyeCRW8EIvQbqbPUrSAtNPag95ySpA1fz4/3GyRpBDQ
	fWTqxfrvZLlGa4MseHqJNbqzpuiz7AY5s/lFBLmVqCIEnciZ7J2PM9UQXHpKbUJWdPDE6a
	r3NZTtAcpZwbRl5StULAw+c+85dvzGw=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
In-Reply-To: <CAOLa=ZTHb6ZFmpDpSwzUTiDs44gY-W3aqBooAMyORK8Xs3YQxQ@mail.gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im>
 <87a59aww8j.fsf@iotcl.com>
 <CAOLa=ZTHb6ZFmpDpSwzUTiDs44gY-W3aqBooAMyORK8Xs3YQxQ@mail.gmail.com>
Date: Tue, 25 Mar 2025 09:45:17 +0100
Message-ID: <875xjxwlb6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> I'm curious, how would it be different, if they blame down to the same
> commit? My understanding was "unblamable" and "ignored" are tied to
> commits.

Let me include an example, let's blame `varint.h`.

First have a look at the non-porcelain format:

    $ git blame varint.h -l
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 1) #ifndef VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 2) #define VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 3)
    554544276a604c144df45efcb060c80aa322088c (Denton Liu     2019-04-29 04:28:14 -0400 4) int encode_varint(uintmax_t, unsigned char *);
    554544276a604c144df45efcb060c80aa322088c (Denton Liu     2019-04-29 04:28:14 -0400 5) uintmax_t decode_varint(const unsigned char **);
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 6)
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 7) #endif /* VARINT_H */

Now if we put `554544276a604c144df45efcb060c80aa322088c` in `.git-blame-ignore-revs`:

    $ git -c blame.markUnblamableLines=true -c blame.markIgnoredLines=true blame varint.h --ignore-revs-file .git-blame-ignore-revs -l
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 1) #ifndef VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 2) #define VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 3)
    ?d2c1898571a6a2324593e92163e8754880e0c1f (Junio C Hamano 2012-04-03 15:53:08 -0700 4) int encode_varint(uintmax_t, unsigned char *);
    ?d2c1898571a6a2324593e92163e8754880e0c1f (Junio C Hamano 2012-04-03 15:53:08 -0700 5) uintmax_t decode_varint(const unsigned char **);
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 6)
    d2c1898571a6a2324593e92163e8754880e0c1fb (Junio C Hamano 2012-04-03 15:53:08 -0700 7) #endif /* VARINT_H */

If we compare that to the porcelain format:

    $ git blame varint.h -l --porcelain
    d2c1898571a6a2324593e92163e8754880e0c1fb 1 1 3
    author Junio C Hamano
    author-mail <gitster@pobox.com>
    author-time 1333493588
    author-tz -0700
    committer Junio C Hamano
    committer-mail <gitster@pobox.com>
    committer-time 1333495484
    committer-tz -0700
    summary varint: make it available outside the context of pack
    filename varint.h
            #ifndef VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 2 2
            #define VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 3 3

    554544276a604c144df45efcb060c80aa322088c 4 4 2
    author Denton Liu
    author-mail <liu.denton@gmail.com>
    author-time 1556526494
    author-tz -0400
    committer Junio C Hamano
    committer-mail <gitster@pobox.com>
    committer-time 1557037206
    committer-tz +0900
    summary *.[ch]: remove extern from function declarations using spatch
    previous ffac537e6cbbf934b08745a378932722df287a53 varint.h
    filename varint.h
            int encode_varint(uintmax_t, unsigned char *);
    554544276a604c144df45efcb060c80aa322088c 5 5
            uintmax_t decode_varint(const unsigned char **);
    d2c1898571a6a2324593e92163e8754880e0c1fb 8 6 2

    d2c1898571a6a2324593e92163e8754880e0c1fb 9 7
            #endif /* VARINT_H */

And now with the `.git-blame-ignore-revs` file:

    $ git -c blame.markUnblamableLines=true -c blame.markIgnoredLines=true blame varint.h --ignore-revs-file .git-blame-ignore-revs -l --porcelain
    d2c1898571a6a2324593e92163e8754880e0c1fb 1 1 3
    author Junio C Hamano
    author-mail <gitster@pobox.com>
    author-time 1333493588
    author-tz -0700
    committer Junio C Hamano
    committer-mail <gitster@pobox.com>
    committer-time 1333495484
    committer-tz -0700
    summary varint: make it available outside the context of pack
    filename varint.h
            #ifndef VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 2 2
            #define VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 3 3

    d2c1898571a6a2324593e92163e8754880e0c1fb 6 4 2
            int encode_varint(uintmax_t, unsigned char *);
    d2c1898571a6a2324593e92163e8754880e0c1fb 7 5
            uintmax_t decode_varint(const unsigned char **);
    d2c1898571a6a2324593e92163e8754880e0c1fb 8 6 2

    d2c1898571a6a2324593e92163e8754880e0c1fb 9 7
            #endif /* VARINT_H */

So every line now blames down to commit
d2c1898571a6a2324593e92163e8754880e0c1fb. The lines which used to
blame down to 554544276a604c144df45efcb060c80aa322088c should be marked
as "ignored", but we only emit the details once for each commit. The
commit details (author, committer) are only relevant once, but the
"ignored" info can differ for each line (as you also can see in the
non-porcelain format).

We could make the output look something like:

    $ git -c blame.markUnblamableLines=true -c blame.markIgnoredLines=true blame varint.h --ignore-revs-file .git-blame-ignore-revs -l --porcelain
    d2c1898571a6a2324593e92163e8754880e0c1fb 1 1 3
    author Junio C Hamano
    author-mail <gitster@pobox.com>
    author-time 1333493588
    author-tz -0700
    committer Junio C Hamano
    committer-mail <gitster@pobox.com>
    committer-time 1333495484
    committer-tz -0700
    summary varint: make it available outside the context of pack
    filename varint.h
            #ifndef VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 2 2
            #define VARINT_H
    d2c1898571a6a2324593e92163e8754880e0c1fb 3 3

    d2c1898571a6a2324593e92163e8754880e0c1fb 6 4 2
    ignored
            int encode_varint(uintmax_t, unsigned char *);
    d2c1898571a6a2324593e92163e8754880e0c1fb 7 5
    ignored
            uintmax_t decode_varint(const unsigned char **);
    d2c1898571a6a2324593e92163e8754880e0c1fb 8 6 2

    d2c1898571a6a2324593e92163e8754880e0c1fb 9 7
            #endif /* VARINT_H */

It feels odd to me only the "ignored" info is emitted and the rest
of the details isn't. But that might be just me...

-- 
Toon
