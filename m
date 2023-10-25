Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292041643A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83901BB
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:21:05 -0700 (PDT)
Received: (qmail 7214 invoked by uid 109); 25 Oct 2023 07:21:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Oct 2023 07:21:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 423 invoked by uid 111); 25 Oct 2023 07:21:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Oct 2023 03:21:09 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Oct 2023 03:21:04 -0400
From: Jeff King <peff@peff.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Luben Tuikov <luben.tuikov@amd.com>, git@vger.kernel.org,
	entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
Message-ID: <20231025072104.GA2145145@coredump.intra.peff.net>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
 <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
 <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024204318.gi6b4ygqbilm2yke@pengutronix.de>

On Tue, Oct 24, 2023 at 10:43:18PM +0200, Uwe Kleine-König wrote:

> I debugged a bit and if I do
> 
> 	mv .git/hooks/sendemail-validate .git/hooks/sendemail-validate.bak
> 
> git send-email --to 'Uwe Kleine-König <u.kleine-koenig@pengutronix.de>'
> starts to work for me, too.
> 
> I'd guess the content of my sendemail-validate script doesn't matter
> much, but for the record, it's:
> 
> 	#!/bin/sh
> 	# installed by patatt install-hook
> 	patatt sign --hook "${1}"
> 
> Does the problem reproduce on your end with a sendemail-validate script?

I can reproduce with:

  git init
  echo foo >file && git add file && git commit -m foo
  echo 'exit 0' >.git/hooks/sendemail-validate
  chmod +x .git/hooks/sendemail-validate
  git send-email --dry-run --to='pëff <peff@peff.net>' -1

Note that the bug will only trigger if Email::Valid is installed. I
think this is the same issue being discussed elsewhere. The call to
process_address_list() sanitizes it to use rfc2047 encoding, which is
necessary for it to be syntactically valid.

So the patch to move the validation later in the process here:

  https://lore.kernel.org/git/ee56c4df-e030-45f9-86a9-94fb3540db60@amd.com/

fixes it.

-Peff
