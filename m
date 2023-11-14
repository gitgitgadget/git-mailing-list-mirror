Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58AA21357
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oK2fpeEM"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D310B7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 09:32:06 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E6D81C1D66;
	Tue, 14 Nov 2023 12:32:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6leORZmCYq5ClKwzIX2KRezpmbIv+xlAtXy9Zb
	5mDWI=; b=oK2fpeEMM/pDrrRnhwC6f1gXOlRx/03RTEPBd9kCz5nsVb0j1wpEnK
	GBTQqHh9PLMZY5L2FcAqNTpfzT1KN5z9U9fuxs7Puw7WR6qGmlcmgKLoV9DBsV+H
	eARBcpxUzHnOopYrVeIHgaKIuBN5jem7ZiJnxeTGLItoWwCbAi6vQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93F851C1D65;
	Tue, 14 Nov 2023 12:32:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3FBF1C1D64;
	Tue, 14 Nov 2023 12:32:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Jeff
 King <peff@peff.net>,  =?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?=
 <opohorel@redhat.com>
Subject: Re: [PATCH] send-email: avoid duplicate specification warnings
In-Reply-To: <20231114163826.207267-1-tmz@pobox.com> (Todd Zullinger's message
	of "Tue, 14 Nov 2023 11:38:19 -0500")
References: <20231114163826.207267-1-tmz@pobox.com>
Date: Wed, 15 Nov 2023 02:32:03 +0900
Message-ID: <xmqqjzqkxmuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BA56B95E-8313-11EE-9317-25B3960A682E-77302942!pb-smtp2.pobox.com

Todd Zullinger <tmz@pobox.com> writes:

> With perl-Getopt-Long >= 2.55, a warning is issued for options which are
> specified more than once.  In addition to causing users to see warnings,
> this results in test failures which compare the output.  An example,
> from t9001-send-email.37:
>
>   | +++ diff -u expect actual
>   | --- expect      2023-11-14 10:38:23.854346488 +0000
>   | +++ actual      2023-11-14 10:38:23.848346466 +0000
>   | @@ -1,2 +1,7 @@
>   | +Duplicate specification "no-chain-reply-to" for option "no-chain-reply-to"
>   | +Duplicate specification "to-cover|to-cover!" for option "to-cover"
>   | +Duplicate specification "cc-cover|cc-cover!" for option "cc-cover"
>   | +Duplicate specification "no-thread" for option "no-thread"
>   | +Duplicate specification "no-to-cover" for option "no-to-cover"
>   |  fatal: longline.patch:35 is longer than 998 characters
>   |  warning: no patches were sent
>   | error: last command exited with $?=1
>   | not ok 37 - reject long lines
>
> Remove the duplicate option specs.

As long as these manual implementation of "no-" are doing true
opposite of the positive one, it should be sufficient to remove
them, so I'd prefer to see you explicitly say that you did audit
them all to make sure.

For example,

>  		    "annotate!" => \$annotate,
> -		    "no-annotate" => sub {$annotate = 0},

this is an example of good pair.  With the former, "--no-annotate"
and "--annotate" result in $annotate set to false and true, and the
latter attempts to set $annotate to false upon "--no-annotate", so
the net result of removing the latter should be a no-op.

>  		    "suppress-from!" => \$suppress_from,
> -		    "no-suppress-from" => sub {$suppress_from = 0},

Ditto.

As it is very late at night here, I didn't do a though job to scan
and validate all of them (some did not have their positive
counterparts in the context), though.  Thanks for woking on this.
