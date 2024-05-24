Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1912F360
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568301; cv=none; b=syN47LDy0EAcckbwHVK5vjckEYr9uCcJ7utNT6+z6lZ1lFo7irG5wtcwoXcX3F2BO0RK/ZoVNiFqE2m+DJueMn72EizJH7Uyophajzb6Y9bMnMr8L9BLW53xpyYV17L/D5pvhTSLhjFKlESfa1jYyKrCGCO3AbBdWNUjG4mXoGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568301; c=relaxed/simple;
	bh=oEc5Ldb32COrpJ2B5Pkary1wGHV5c0rinjLeyHW+0n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlPXjm8IYib7S8743mx5OU5Ex2G4gHcY44xiNBCf20pD97dZ0AIM1cUhJ7Tc92SgzfrurF5L9EDzoxAHWZZsGXw7I7lWaN00BDlSwA8bYUc5MtWNOCyU3tXXLgufJqc3A3I8Kle0vn7ejCB8IXVE4bpm+5HPmo+RjlxxC3pzRnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ui4z3FAi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ui4z3FAi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C21B926134;
	Fri, 24 May 2024 12:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oEc5Ldb32COrpJ2B5Pkary1wGHV5c0rinjLeyH
	W+0n8=; b=Ui4z3FAi5kKXqSheJTvfFDh2nHh2bECdX9G1GDAFORLYEOMABdu9uf
	MjgOhZ/ZXzFBp66Sk3IJPEtcnkijDaomeXe4MmMnIBbP6A6bhtoSy2ISkt9Ao5fh
	a67e2w8k+BS+q/pnJO0k5N9cEYxcoKGurg+5NttDbrLCxIyedmDS0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BB5A326133;
	Fri, 24 May 2024 12:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6AD826132;
	Fri, 24 May 2024 12:31:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/21] ci: add missing dependency for TTY prereq
In-Reply-To: <857b8b14ce519e3c473f1808da7daca95ebff8ea.1716541556.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 May 2024 12:03:15 +0200")
References: <cover.1716465556.git.ps@pks.im> <cover.1716541556.git.ps@pks.im>
	<857b8b14ce519e3c473f1808da7daca95ebff8ea.1716541556.git.ps@pks.im>
Date: Fri, 24 May 2024 09:31:35 -0700
Message-ID: <xmqqr0drmas8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17285BBA-19EB-11EF-9B00-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In "t/lib-terminal.sh", we declare a lazy prerequisite for tests that
> require a TTY. The prerequisite uses a Perl script to figure out whether
> we do have a usable TTY or not and thus implicitly depends on the PERL
> prerequisite, as well. Furthermore though, the script requires another
> dependency that is easy to miss, namely on the IO::Pty module. If that
> module is not installed, then the script will exit early due to an
> reason unrelated to missing TTYs.
>
> This easily leads to missing test coverage. But most importantly, our CI
> systems are missing this dependency and thus don't execute those tests
> at all. Fix this.
> ---
>  ci/install-dependencies.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ah, I should have read what I received first before starting to
respond to them ;-)  You'd want to sign it off, but other than that
looks good to me.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 2e7688ae8b..6ec0f85972 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -27,7 +27,7 @@ alpine-*)
>  	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
>  		pcre2-dev python3 musl-libintl perl-utils ncurses \
>  		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
> -		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
> +		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
>  	;;
>  fedora-*)
>  	dnf -yq update >/dev/null &&
> @@ -42,7 +42,7 @@ ubuntu-*)
>  		language-pack-is libsvn-perl apache2 cvs cvsps git gnupg subversion \
>  		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
>  		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
> -		libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
> +		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
>  		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
>  
>  	mkdir --parents "$CUSTOM_PATH"
