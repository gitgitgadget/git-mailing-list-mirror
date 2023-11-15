Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaxYGhlG"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993019E
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 11:20:30 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bbe0a453so90688897b3.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700076030; x=1700680830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5ArcC3UW4EufFT7CcLK38fuJ1avOFxdcxGb87hz1X4=;
        b=DaxYGhlG9eV/ITyAYwFH0Bvglge/nKcYp3jkt8EjlwXATW3oUzckzWEkHXeUiP0czM
         KVAq6/IzKyUCSOyMED5YZD4j/yM+edeth1pbUXD4DfGETYZlIjHmXUVAcJhedWrnOPhY
         N7RvGjDnROOLaWGp4wrLUJWnsYd38CKqhKH1Gtht48OSrXhP6EuQUOops30P65CxTH9E
         uAwYOgrGBvcyV4+qwHRQxw9c7O2tR27yOXDaDGYZNQizmJF1Yqz9bCJlKFjjVpAM0xWI
         VmD4WnvANGGAUnHbEV1r2zEsq8XuKFDgSd068WRfucD9sq/j6IQu5UG43TLYScN7DQkE
         XcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700076030; x=1700680830;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5ArcC3UW4EufFT7CcLK38fuJ1avOFxdcxGb87hz1X4=;
        b=nh6EIMl4P3Vgk1LAzLGD5sH5ZUvANl054staFd9qLt3ssZHWFbnCVZzcY1lihJ1ZJw
         VYxRrEAZjh9ZrAU/9jWGpGKipO7jy91J8+Ey5oLX1Yd+CdZ4D1lLdGk5A7bz2LXiVclD
         d22b8RImEBlIjGnVVV9Zt+8wgHDyImn16/Hop2NvXcxLC+ODxrZaEjHjN1JvbqrvHAhK
         A65UeU8MTh/tBJCoZwgsale2Mx9nqqT6i+GddXP4FvaDD3x4LsDQb5jj5xzDF03RmIo2
         6YztHkS4XJ5jfPIzoJuLVh1t2+mtJ3Y7X9FnVPBlEoONn9h9a/fxYAQuvZzucSHKGudB
         oPEg==
X-Gm-Message-State: AOJu0Yy7f+kLOj2305eqn2bUrF6C+Qe94qsuqk4Nw6x84f0N+kdtCYN6
	oP0JDaAek5lBZMylffyN6FzX9lPfbRuu+WbtKn01
X-Google-Smtp-Source: AGHT+IHRyFt/ZQSBiZ1kQBgufHkkzxbueH8cx/Iri3W5mhD+vGYjSDlHuQbr81DLWSEc+ZhMvLaOVPdZ5NqHFdzOyDIw
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:972:b10d:7d17:c47a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a156:0:b0:5a7:b15a:1a7d with
 SMTP id y83-20020a81a156000000b005a7b15a1a7dmr367319ywg.2.1700076030063; Wed,
 15 Nov 2023 11:20:30 -0800 (PST)
Date: Wed, 15 Nov 2023 11:20:26 -0800
In-Reply-To: <CAGE_+C4JWA0DrcV4rT7J6hXsbYPL2Po31wFPvLESe_sKq_16FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115192027.2468887-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/5] remote-curl: avoid hang if curl asks for more data
 after eof
From: Jonathan Tan <jonathantanmy@google.com>
To: "=?UTF-8?q?Ji=C5=99=C3=AD=20Hru=C5=A1ka?=" <jirka@fud.cz>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ji=C5=99=C3=AD Hru=C5=A1ka <jirka@fud.cz> writes:
> It has been observed that under some circumstances, libcurl can call
> our `CURLOPT_READFUNCTION` callback `rpc_out()` again even after
> already getting a return value of zero (EOF) back once before.
>=20
> Because `rpc->flush_read_but_not_sent` is reset to false immediately
> the first time an EOF is returned, the repeated call goes again to
> `rpc_read_from_out()`, which tries to read more from the child process
> pipe and the whole operation gets stuck - the child process is already
> trying to read a response back and will not write anything to the
> output pipe anymore, while the parent/remote process is now blocked
> waiting to read more too and never even finishes sending the request.
>=20
> The bug is fixed by moving the reset of the `flush_read_but_not_sent`
> flag to `post_rpc()`, only before `rpc_out()` would be potentially used
> the next time. This makes the callback behave like fread() and return
> a zero any number of times at the end of a finished upload.
>=20
> Signed-off-by: Jiri Hruska <jirka@fud.cz>

Thanks for splitting this out - this makes it much easier to review. I
can see that the patch indeed works, but some things need to be clearer
(described below).

In the commit message, I think we should add a historical note,
something like:

	`flush_read_but_not_sent` was introduced in a97d00799a (remote-curl:
	use post_rpc() for protocol v2 also, 2019-02-21), which needed a way to
	indicate that Git should not read from a certain child process anymore
	once "flush" has been received from the child process. This field was
	scoped to what was believed the minimum necessary - the interval between
	"flush" being received and EOF being reported to Curl.

	However, as described at the beginning of the commit message, we need
	the scope of this to be greater than that - in case Curl continues to
	ask us for more data, we still need to remember that "flush" has been
	received. Therefore, change this field from `flush_read_but_not_sent` to
	`flush_read`, which both is simpler and is a fix for this bug.

Feel free to use this verbatim, or adapt it as you wish (or write your
own).

As described in the historical note, I also think we need to change the
name of this field, since we are changing its semantics.

I am trying to be better at indicating when I think a prefix subset of
a patch set is worth merging on its own (so that, if some patches in
a patch set are good and some still need to be discussed, we have the
option of merging a prefix of a patch set). So, assuming my comments are
addressed, I think this patch is good to go in on its own, even if we
don't want some of the later patches. I'll review the rest of this patch
set later.
