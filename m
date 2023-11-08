Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED8DDA0
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vYxlZlCW"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71109199
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:59:51 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AFEE2125D;
	Wed,  8 Nov 2023 02:59:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uBPFyIdWWYk72QGeMiaQw+outicGSfvLRUC0Og
	YM750=; b=vYxlZlCWGGOw2+QvnCGVztVs8xXyKJAe85D23y3WKi2Lu37nXUjoGv
	mJzr/ILOd5L50ryfSMxnsnUVHezn1Nm7y3z3+u6Jt3YvLizwQQ2CbndTbkFXn+jd
	HgrhYobNZr+bXAADiutfjdAdnNzhKiB9vOC3uruMKAP9pEd8Ueul0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 03C9F2125C;
	Wed,  8 Nov 2023 02:59:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 966F32125B;
	Wed,  8 Nov 2023 02:59:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] t/lib-httpd: dynamically detect httpd and modules path
In-Reply-To: <ac059db8fedc6493c64f703814c7db11adb4385e.1699428122.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 8 Nov 2023 08:29:56 +0100")
References: <cover.1699428122.git.ps@pks.im>
	<ac059db8fedc6493c64f703814c7db11adb4385e.1699428122.git.ps@pks.im>
Date: Wed, 08 Nov 2023 16:59:46 +0900
Message-ID: <xmqqcywk7k0d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C9420434-7E0C-11EE-9CB3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In order to set up the Apache httpd server, we need to locate both the
> httpd binary and its default module path. This is done with a hardcoded
> list of locations that we scan. While this works okayish with distros
> that more-or-less follow the Filesystem Hierarchy Standard, it falls
> apart on others like NixOS that don't.
>
> While it is possible to specify these paths via `LIB_HTTPD_PATH` and
> `LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
> to figure out how to set those up. And in fact we can do better by
> dynamically detecting both httpd and its module path at runtime:
>
>     - The httpd binary can be located via PATH.
>
>     - The module directory can (in many cases) be derived via the
>       `HTTPD_ROOT` compile-time variable.
>
> Refactor the code to do so. If runtime detection of the paths fails we
> continue to fall back to the hardcoded list of paths.

Hmph.

I do not think we would want to punish the distros that follow the
FHS that was created explicitly to help developers by standardizing
locations of various things, with an approach this patch takes that
throws everthing with bathwater and rely on $PATH first.

Would it be sufficient to please NixOS if we simply append $(command
-v apache) or whatever after the well known candidate locations?

I know "command -v" is in POSIX, and on both bash and dash (the two
shells most distros use), it works as this patch expects, but its
portability is also a bit worrysome, especially because the whole
point of this patch is to support a platform that is, eh, on the
fringe.

So, I dunno.
