From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Wed, 13 Jan 2016 12:08:11 -0800
Message-ID: <xmqqvb6xmedw.fsf@gitster.mtv.corp.google.com>
References: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	<xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
	<20151104200249.GC16101@sigill.intra.peff.net>
	<CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
	<20151230073759.GA785@sigill.intra.peff.net>
	<CAEtYS8Qs2B3rP1PDGhoWGAgcj2c_pOTpt=s8qj9tWMjkLLFyhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:08:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRiO-0003y3-GB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 21:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbcAMUIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 15:08:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752824AbcAMUIN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 15:08:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A347E3B2E5;
	Wed, 13 Jan 2016 15:08:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j2xV+qdTztS61xUXzG17isHFBNQ=; b=cAWSyi
	nroDQ/hoO5upIKc9GOjKFfZI7qfN7vmUFOOloDuF/Mlam5UDcjudrt6MqAbGIyLg
	WBllcCFSbpkvwGqHrAaPjtC5LWN1vk/VdBrasm1Bs+dEc9vvYSIKjH5u7mhyYMto
	N98eGwU6YDWvu0CrOfP463yuHm3g9wzmE8BkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ejddNeb8MVPahtzIaoWrYkAUPUl140pI
	1DWBzWS/ltDMXQcQd87CjizhpfxUe7BfkOy9rquIcjqgwFaPa9JfKAEgjz1ORYlv
	Xrm4I5bfek6pV7BLBD9oWxbB+qO4tZ2FY9xLbofouazvvbNH5aYVWD5wUshmClgu
	bo6F8BbQp4Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B0D83B2E4;
	Wed, 13 Jan 2016 15:08:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D0813B2E3;
	Wed, 13 Jan 2016 15:08:12 -0500 (EST)
In-Reply-To: <CAEtYS8Qs2B3rP1PDGhoWGAgcj2c_pOTpt=s8qj9tWMjkLLFyhQ@mail.gmail.com>
	(Doug Kelly's message of "Wed, 13 Jan 2016 11:14:39 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F65400A-BA31-11E5-A216-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283979>

Doug Kelly <dougk.ff7@gmail.com> writes:

> Yeah, I know I never got to adding the mtime logic, but for a simple (naive,
> hard-coded) case, I did come up with a basic patch today.  I think this could
> be extended to a configuration option(?) which would allow a default longer
> than 10 seconds (an hour? a day?), then during the regression tests, we
> could provide a shorter timeout to ensure the guarding both works and also
> not wait forever for tests to complete.  Thoughts?

Please do not sleep in the tests.  Instead, please try to see if you
can use test-chmtime to set the timestamps of these files to the
necessary ages for the purpose of your tests.

Thanks.

>
> ---
>  builtin/gc.c     | 14 ++++++++++++--
>  t/t5304-prune.sh |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 79e9886..a4ce616 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -51,8 +51,18 @@ static struct string_list pack_garbage =
> STRING_LIST_INIT_DUP;
>  static void clean_pack_garbage(void)
>  {
>   int i;
> - for (i = 0; i < pack_garbage.nr; i++)
> - unlink_or_warn(pack_garbage.items[i].string);
> + /* Define a cutoff time for "new" garbage to prevent race conditions */
> + time_t cutoff = time(NULL) - 10;
> + for (i = 0; i < pack_garbage.nr; i++) {
> + struct stat s;
> + char *garbage = pack_garbage.items[i].string;
> + if (!stat(garbage, &s)) {
> + if (s.st_mtime < cutoff)
> + unlink_or_warn(garbage);
> + } else
> + fprintf(stderr, _("stat failed on pack garbage: %s"),
> + garbage);
> + }
>   string_list_clear(&pack_garbage, 0);
>  }
>
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index cbcc0c0..7b4650f 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -272,6 +272,7 @@ test_expect_success 'clean pack garbage with gc' '
>   : >.git/objects/pack/fake6.keep &&
>   : >.git/objects/pack/fake6.bitmap &&
>   : >.git/objects/pack/fake6.idx &&
> + sleep 10 &&
>   git gc &&
>   git count-objects -v 2>stderr &&
>   grep "^warning:" stderr | sort >actual &&
> @@ -291,6 +292,7 @@ test_expect_success 'ensure unknown garbage kept with gc' '
>   : >.git/objects/pack/foo.keep &&
>   : >.git/objects/pack/fake.pack &&
>   : >.git/objects/pack/fake2.foo &&
> + sleep 10 &&
>   git gc &&
>   git count-objects -v 2>stderr &&
>   grep "^warning:" stderr | sort >actual &&
