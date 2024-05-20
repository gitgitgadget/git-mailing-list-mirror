Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EE137C21
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221817; cv=none; b=tpaZ0rQgnNfA9Ar48wh8I1Lx9/GLYNJa+YH4UAF+RKxx2zC0/BQ0hb5MuZi+u/D+T9DolYcsho6Ta2Im8VhKx5bfZBZCqip/ihfx8Byiml/rPSB1igb69giA3IHJFMKnwW/DsSxNtfzVSNzp+HUkDW8mL3gWHQ6xyYLbSeImID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221817; c=relaxed/simple;
	bh=zRYBVSCR7HnkvEppOERY6mDA3MoEj7Jna67piRKvypI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gsqa88PJbwqIJ0OjaZuMXV1IrCGeFM0vLagJlQPw324NyoSl1vek6p3lS8J5cUvq97tTXOPZvyllv8qlTLsSEqx7NVbVqWl24CPEIt6T6ax03BeSLnxvLV/5X3thOA3iclDWlsBAdIQ+t+bYKup9WrfFWk56eN917km9jtcqIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ga2vc2QA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ga2vc2QA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10CCC182FD;
	Mon, 20 May 2024 12:16:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zRYBVSCR7HnkvEppOERY6mDA3MoEj7Jna67piR
	KvypI=; b=Ga2vc2QANO+uYtf5o8VyzahVb4AWCRax3cMw25bI4wQQN22z0XbRjn
	YC7Gxx5FndWt8OHDZSSOF6jXehQ0/aQ7A9Vvz2tJSY1S5VRZ7Dc7Bi7r3aI6MMno
	89CcT7wels/Y7imd0IuRDSFWkaMZKusUGJT65afCSdVUfI8/W7MK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06F51182FC;
	Mon, 20 May 2024 12:16:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62C0B182FB;
	Mon, 20 May 2024 12:16:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sam
 James <sam@gentoo.org>,  Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo
 on Linux SPARC
In-Reply-To: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de> (John Paul
	Adrian Glaubitz's message of "Mon, 20 May 2024 13:11:09 +0200")
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
Date: Mon, 20 May 2024 09:16:47 -0700
Message-ID: <xmqqseyclaq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5BF9C08C-16C4-11EF-A252-25B3960A682E-77302942!pb-smtp2.pobox.com

John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> On SPARC systems running Linux, individual processors are denoted with
> "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:" so that
> the current regexp in ncores() returns 0. Extend the regexp to match
> lines with "CPUnn:" as well to properly detect the number of available
> cores on these systems.
>
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  t/chainlint.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> index 556ee91a15..63cac942ac 100755
> --- a/t/chainlint.pl
> +++ b/t/chainlint.pl
> @@ -718,7 +718,7 @@ sub ncores {
>  	# Windows
>  	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
>  	# Linux / MSYS2 / Cygwin / WSL
> -	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
> +	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';

Is the doubled || intended?  Doesn't it introduce an empty pattern
that slurps every single line of /proc/cpuinfo?

I was wondering if we want to first add the "reasonable fallback"
Eric mentioned ealier, and then build on top, whose result may look
like the attached.  You can enable the STDERR thing with your double
"||" added back and see what "cd t && perl chainlint.pl" produces.

Thanks.

diff --git i/t/chainlint.pl w/t/chainlint.pl
index 556ee91a15..775f06281b 100755
--- i/t/chainlint.pl
+++ w/t/chainlint.pl
@@ -718,7 +718,13 @@ sub ncores {
 	# Windows
 	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
 	# Linux / MSYS2 / Cygwin / WSL
-	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
+	do {
+		local @ARGV='/proc/cpuinfo';
+		my @num = grep(/^processor[\s\d]*:|^CPU[\d]*:/, <>);
+# print STDERR "FOUND <@num>\n";
+		return 1 if (!@num);
+		return scalar(@num);
+	} if -r '/proc/cpuinfo';
 	# macOS & BSD
 	return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
 	return 1;
