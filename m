Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12E2E652
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485518; cv=none; b=HdTsYdVxk7qiC/IHmxBq0T7mJxAOecsy/ByCwvUhnx/rO45IskqfnL+K+F8yFD74Fi6jN6NoNRMJurk836oeV7UM0vpJE4cTnmAZ1X/gGTQqqfzg/p/KTMEbrPORk46uj0OxyGFs4EJtJcsipG6oxTVN8h45uVKKZ1ZA+7IsagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485518; c=relaxed/simple;
	bh=BTHy6SOS3FNlS3GOAZdSgO/jsLrbxazX/S1iJrLmpAA=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eT8XoE05w11/lrgQ7UJEVe2v6XjEgjhLhJY31MfIJk/m8t+SfCSRFP7LzGkS0AAq3fVvbfFwq4NRTt0wIhutfq8yB2R45pbVVlO2HhDEOROamzbR26qhl7idkSe7ywUAUgxXPZ67MjI0ulK79mna8fkhy1BvWidJIFbt0QSNSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 419DVkZG3060158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 13:31:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kyle Lippincott'" <spectral@google.com>, <git@vger.kernel.org>
References: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
In-Reply-To: <CAO_smVji5aGjx1V-EGbumRRpOuGY0SkXZUn9g4LxKmMO3aw=Sg@mail.gmail.com>
Subject: RE: libification: how to avoid symbol collisions?
Date: Fri, 9 Feb 2024 08:31:41 -0500
Organization: Nexbridge Inc.
Message-ID: <000301da5b5c$5477d7f0$fd6787d0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKUbq48vojvy9SXqm0UJ5SmxsLjhK+N2ldg
Content-Language: en-ca

On Thursday, February 8, 2024 9:30 PM, Kyle Lippincott wrote:
>While thinking about libification, I was wondering what we can/need to =
do about
>symbols (specifically functions, since our libraries will likely have =
few to no extern
>variables) that need to escape their translation unit (.c file) but =
that we don't want
>to risk colliding with symbols from our "host" project.
>
>For any header that we're offering up as an API boundary we can have =
prefixed
>names, but there are symbols from git-compat-util.h with simple and =
likely
>common names like `die`, `usage`, error`, etc. I'm far from an expert =
on linkers, but
>I'm under the impression that even though we'll only be #including =
git-compat-
>util.h in our own .c files (so the compiler for the host project =
wouldn't see them),
>the produced static library will still be "providing" these symbols =
unless we mark
>them as `static` (and if we mark them as `static`, they can't be used =
outside of their
>translation unit). This means that if the host project has a version of =
`die` (or links
>against yet another library that does), we run into what C++ calls a =
One Definition
>Rule (ODR)
>violation: we have two providers of the symbol `die` with different
>implementations, and the behavior is undefined (no error needs to be =
generated as
>far as I know).
>
>With dynamic libraries I believe that we have more control over what =
gets exposed,
>but I don't know of functionality for this when linking statically. I'm =
assuming there
>is no such functionality, as projects like openssl (ty Randall for =
mentioning this)
>appear to have a convention of prefixing the symbols they put in their =
"public" API
>(i.e. in non-internal header files) with things like OSSL_, and of =
prefixing the symbols
>they put in their "private" APIs that can't be marked as `static` with =
`ossl_`. I'd love
>to be wrong about this. :)
>
>If I'm right that this is an issue, does this imply that we'd need to =
rename every non-
>static function in the git codebase that's part of a library to have a =
`git_` prefix, even
>if it won't be used outside of the git project's own .c files? Is there =
a solution that
>doesn't involve making it so that we have to type `git_` a billion =
times a day that's
>also maintainable? We could try to guess at how likely a name collision =
would be
>and only do this for ones where it's obviously going to collide, but if =
we get it wrong,
>I'm concerned that we'll run into subtle ODR violations that *at best* =
erode
>confidence in our library, and can actually cause outages, data =
corruption, and
>security/privacy issues.

I think we only need to do this for functions that are in the =
libification code-base for non-static symbols (and any data elements =
that may end up in a DLL some day). The bulk of the non-libified code =
base would only need to adapt to new symbol names if those symbols are =
specifically moved. die(), error(), are probably going to be impacted, =
but they can be aliased with #defines internally to git to git_die() or =
git_error(), for example.
--Randall

