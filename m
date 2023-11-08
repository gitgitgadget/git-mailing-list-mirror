Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563D30338
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F21FD5
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 08:54:27 -0800 (PST)
Received: (qmail 17027 invoked by uid 109); 8 Nov 2023 16:54:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Nov 2023 16:54:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1272 invoked by uid 111); 8 Nov 2023 16:54:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Nov 2023 11:54:28 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Nov 2023 11:54:26 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t/lib-httpd: dynamically detect httpd and modules
 path
Message-ID: <20231108165426.GB1028115@coredump.intra.peff.net>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699455383.git.ps@pks.im>
 <cee8fbebf84422f73c38d55b5730053121b74e0f.1699455383.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cee8fbebf84422f73c38d55b5730053121b74e0f.1699455383.git.ps@pks.im>

On Wed, Nov 08, 2023 at 03:57:19PM +0100, Patrick Steinhardt wrote:

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
> Amend the code to do so. The new runtime-detected paths will only be
> used in case none of the hardcoded paths are usable.

If these improve detection on your platform, I think that is a good
thing and they are worth doing. But as a generic mechanism, I have two
comments:

> -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
> +for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(command -v httpd)"
>  do
>  	if test -x "$DEFAULT_HTTPD_PATH"
>  	then

The binary goes under the name "httpd", but also "apache2". But the PATH
search only looks for "httpd". Should we check "command -v apache2" as
well?

This also means we may run "test -x" on an empty string, but that is
probably OK in practice (we could guard it with "test -n", though).

> +if test -x "$DEFAULT_HTTPD_PATH"
> +then
> +	DETECTED_HTTPD_ROOT="$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_ROOT="\(.*\)"$/\1/p')"
> +fi

I was really pleased to see this and hoped it could replace the
kitchen-sink list of paths in the hunk below. But sadly I think it
depends on having a configured apache setup. On my Debian system, for
example, I have the "apache2-bin" package installed but not "apache"
(because only the latter actually sets up a system apache daemon, which
I don't want). And thus there is no config:

  $ /usr/sbin/apache2 -D HTTPD_ROOT
  apache2: Could not open configuration file /etc/apache2/apache2.conf: No such file or directory

So without a system config file to act as a template for our custom
config, I think we are stuck with guessing where the installer might
have put them.

-Peff
