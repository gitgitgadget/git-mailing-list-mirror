Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A4347A5
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD9AC
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 16:53:35 -0700 (PDT)
Received: (qmail 3619 invoked by uid 109); 16 Oct 2023 23:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Oct 2023 23:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17847 invoked by uid 111); 16 Oct 2023 23:53:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Oct 2023 19:53:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Oct 2023 19:53:33 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
Message-ID: <20231016235333.GA551672@coredump.intra.peff.net>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012160930.330618-2-sandals@crustytoothpaste.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:09:29PM +0000, brian m. carlson wrote:

> +int cmd__truncate(int argc, const char **argv)
> +{
> +	char *p = NULL;
> +	uintmax_t sz = 0;
> +	int fd = -1;
> +
> +	if (argc != 3)
> +		die("expected filename and size");
> +
> +	sz = strtoumax(argv[2], &p, 0);
> +	if (*p)
> +		die("invalid size");
> +
> +	fd = open(argv[1], O_WRONLY | O_CREAT, 0600);
> +	if (fd < 0)
> +		die_errno("failed to open file %s", argv[1]);
> +
> +	if (ftruncate(fd, (off_t) sz) < 0)
> +		die_errno("failed to truncate file");
> +	return 0;
> +}

Coverity flagged this as leaking the descriptor "fd" (which is obviously
true). I guess it doesn't matter much in practice, since we're exiting
the process directly afterwards. If it were a memory leak we'd free() it
anyway to shut up the leak detector, but I don't know if we want to be
as careful here (in theory it creates noise that distracts from real
problems, but Coverity is noisy enough that I don't even bother looking
at existing problems).

-Peff
