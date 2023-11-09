Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81849FBE7
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E0D40
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:32:51 -0800 (PST)
Received: (qmail 25665 invoked by uid 109); 9 Nov 2023 07:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 07:32:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21050 invoked by uid 111); 9 Nov 2023 07:32:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 02:32:55 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 02:32:50 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <20231109073250.GA2698227@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
 <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4c75c492dd89fd7464db2b3028b2bb9e6addbf8.1699513524.git.ps@pks.im>

On Thu, Nov 09, 2023 at 08:09:52AM +0100, Patrick Steinhardt wrote:

> -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
> +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
> +			  '/usr/sbin/apache2' \
> +			  "$(command -v httpd)" \
> +			  "$(command -v apache2)"
>  do
> -	if test -x "$DEFAULT_HTTPD_PATH"
> +	if test -n "$DEFAULT_HTTPD_PATH" -a -x "$DEFAULT_HTTPD_PATH"

Sorry to be a pedant, but I'm not sure if we might have portability
problems with "-a". It's an XSI extension, and POSIX labels it as
obsolescent because it can create parsing ambiguities.

We do have a few instances, but only in corners of the test suite that
probably don't get as much exposure (t/perf and valgrind/valgrind.sh).
So maybe not worth worrying about, but it's easy to write it as:

  if test -n "$DEFAULT_HTTPD_PATH" && test -x "$DEFAULT_HTTPD_PATH"

-Peff
