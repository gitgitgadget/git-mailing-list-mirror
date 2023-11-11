Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930E3D981
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pzH8lyOK"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA283C39
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:00:15 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFDE21BC114;
	Fri, 10 Nov 2023 19:00:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b14I7yx97DZF9wpsml2dNaI72bTi2swlQg4Id6
	zqeAc=; b=pzH8lyOK18tVvt/PeZMphNhe2MLB+QVMq4LdKS4cbJLmFsUgqt3QH8
	WHaPqYUmL/Yw8IIVzmaCboMu7HeSr59zewbNVHwqk7oFPfATgvOE8e57AT/vbutG
	X/ykF+RGNm1iyAo0hWythEBMjp0caTl3KqIh3oLHPDMs0HNEx8Nd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1EE31BC111;
	Fri, 10 Nov 2023 19:00:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE2A51BC108;
	Fri, 10 Nov 2023 19:00:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/3] t/lib-httpd: dynamically detect httpd and
 modules path
In-Reply-To: <41b9dada2e0b2e713328e6a4d31f713a2d3ffa38.1699596457.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 10 Nov 2023 09:17:00 +0100")
References: <cover.1699428122.git.ps@pks.im> <cover.1699596457.git.ps@pks.im>
	<41b9dada2e0b2e713328e6a4d31f713a2d3ffa38.1699596457.git.ps@pks.im>
Date: Sat, 11 Nov 2023 09:00:09 +0900
Message-ID: <xmqqo7g1tb06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48602EB6-8025-11EE-93B4-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +if test -x "$DEFAULT_HTTPD_PATH"
> +then
> +	DETECTED_HTTPD_ROOT="$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_ROOT="\(.*\)"$/\1/p')"
> +fi

With this patch, my test run starts like so:

    rm -f -r 'test-results'
    *** prove ***
    apache2: Could not open configuration file /etc/apache2/apache2.conf: No such file or directory
    ...

I find the error message leaking mildly annoying, and would suggest
doing something like the following on top.

diff --git c/t/lib-httpd.sh w/t/lib-httpd.sh
index 0a74922d7f..03493ee72b 100644
--- c/t/lib-httpd.sh
+++ w/t/lib-httpd.sh
@@ -68,7 +68,7 @@ done
 
 if test -x "$DEFAULT_HTTPD_PATH"
 then
-	DETECTED_HTTPD_ROOT="$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_ROOT="\(.*\)"$/\1/p')"
+	DETECTED_HTTPD_ROOT="$("$DEFAULT_HTTPD_PATH" -V 2>/dev/null | sed -n 's/^ -D HTTPD_ROOT="\(.*\)"$/\1/p')"
 fi
 
 for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
