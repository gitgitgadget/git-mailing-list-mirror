Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254411F731
	for <e@80x24.org>; Mon,  5 Aug 2019 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfHEV2h (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 17:28:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64882 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHEV2h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 17:28:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4321615FF93;
        Mon,  5 Aug 2019 17:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NF95pKaiA7tI
        PFr+G+Nz+x6ra7k=; b=ZhviSuz/L7pjdtEvSOUMpZmPysp2TVQ36JMtB870agby
        laUSHlNMdNSAMvTigAoPAZIpQbUPgfYazye6Nfi7SOqUOpbFrHrjUBcgORYOTjrR
        n3LSU7Q9Mk1+g7jt18pWZRGGFigTjiMjiJTjM3dWck61Q5qJPZ4gbaFrRh9JNcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Mvrq2P
        PCg5j4NkBcFo05PYlrMGK1Ae/AgSt4IoyjxCFTH4KH9/ZryoLqkBLuH5wYGCx+q+
        jzXShevi1hawFS+L8QFbNElZ3Wt4jq5Y1HHXHZ+Pbm29tLVQB+L/Sv/F2rTtfEY7
        I/IIq36EdMUmL6193+L6DFymdrYNorFl5LjMI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AA8415FF92;
        Mon,  5 Aug 2019 17:28:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A392515FF91;
        Mon,  5 Aug 2019 17:28:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, frekui@gmail.com, michael.osipov@siemens.com,
        ibrahim.vanak@hpe.com, matheus.bernardino@usp.br,
        vleschuk@accesssoftek.com
Subject: Re: [RFC PATCH 2/2] grep: make default number of threads reflect runtime
References: <20190804211509.39229-1-carenas@gmail.com>
        <20190804211509.39229-3-carenas@gmail.com>
Date:   Mon, 05 Aug 2019 14:28:31 -0700
In-Reply-To: <20190804211509.39229-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 4 Aug 2019 14:15:09 -0700")
Message-ID: <xmqqa7cnmhds.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9AE9A66-B7C7-11E9-809B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> 5b594f457a (Threaded grep, 2010-01-25) added a hardcoded number of
> threads(8) to use in grep and 89f09dd34e (grep: add --threads=3D<num>
> option and grep.threads configuration, 2015-12-15) made it configurable
> through a knob as a workaround for systems where that default was not
> effective.
>
> Use instead the industry standard of 2x number of CPUs (to allow for
> IO wait) for the default.

Thanks. =20

While I am not bold enough to endorse the "industry standard is
twice the number of CPUs" claim, my gut feeling agrees with you that
8 threads may be too many for a 2 CPU box.

I think we cap the parallelism to the number of CPUs (not twice
that) in all the codepaths that currently call online_cpus(), and
some codepaths even cap it further to avoid creating tasks that are
too small (e.g. name-hash, index-pack).

There may not be a single one-size-fits-all scaling factor (as I/O
bound jobs tend to do better with a bit more workers than there are
cores, but adding more workers would not help when you are CPU
bound), but we'd be better off to have a mechanism to allow us to
later have a consistent way to auto-scale the number of workers?

Random ideas include (not mutually exclusive)

 - accept "[grep] threads =3D 2xCPU", in addition to "[grep] threads =3D
   8", to mean "this many workers per CPUs"?

 - add "cpuBound.numThreads" and "ioBound.numThreads" variables to
   configure the number of workers for cpu and io bound jobs, so
   that the users do not have to configure them for each command?

 - build an num_threads() API that is used by the current callers of
   online_cpus(), including the new one this patch adds, perhaps
   with a signature allows it to take configuration key (e.g. "git
   grep" would pass "grep.threads") and if the task is expected to
   be IO or CPU bound ("git grep" may pass "I am heavy on IO"), e.g.

	int num_threads(const char *config_key,
			enum { CPUBOUND, IOBOUND } task_type);

   to hide the complexity of the first two items?

> Using Debian 10 amd64 in a 2 CPU VirtualBox running in macOS 10.14.6
> and that might had been representative of the original author environme=
nt
> shows an overall performance improvement by avoiding thread trashing:

The above does not parse very well, at least to me.

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 2d27969057..5d72e03b2e 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -60,7 +60,7 @@ grep.extendedRegexp::
> =20
>  grep.threads::
>  	Number of grep worker threads to use.  If unset (or set to 0),
> -	8 threads are used by default (for now).
> +	2 threads per core are used by default.
> =20
>  grep.fullName::
>  	If set to true, enable `--full-name` option by default.
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 580fd38f41..0ed8da30f8 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -32,7 +32,6 @@ static char const * const grep_usage[] =3D {
> =20
>  static int recurse_submodules;
> =20
> -#define GREP_NUM_THREADS_DEFAULT 8
>  static int num_threads;
> =20
>  static pthread_t *threads;
> @@ -1068,7 +1067,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
>  	} else if (num_threads < 0)
>  		die(_("invalid number of threads specified (%d)"), num_threads);
>  	else if (num_threads =3D=3D 0)
> -		num_threads =3D HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT : 1;
> +		num_threads =3D HAVE_THREADS ? online_cpus() * 2 : 1;
> =20
>  	if (num_threads > 1) {
>  		if (!HAVE_THREADS)
