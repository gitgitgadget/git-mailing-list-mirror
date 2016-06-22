Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1341D20189
	for <e@80x24.org>; Wed, 22 Jun 2016 19:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcFVTdJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 15:33:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726AbcFVTdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 15:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00C07263AF;
	Wed, 22 Jun 2016 15:33:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFDH1foOMdJDWtFfOPwX6U0QPxY=; b=suohTu
	U7qyah6nQ4ApFNKuPGDNC/0+QkKE0ttSCQYHJzUw1p9pTQcvZZwqe/LE1nqY6QJN
	PkQSfH+Jq+tAq92l2tqKZkytHWKLpinwWl5PI1g1+Pk+zGI2iLIuF9IySNRp9PT6
	vkQwS3HCls6iuSa+4g70xLkLPfkzQfPpOdhoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uchweTbkcEPIiABED3Ip3J25aW8qoB8n
	SGPhbMAU73rU1MxLBUNS/JUqXBrQP8k0VE67nUQRf0x2TJoUw5atUcbUV8ZSToQH
	458uWG8PODe/7qhtU6lfT3at7KT9/59yur6kSE67rQr/RrdIApopkgEtA8cs9G+L
	2xXUCQKJ0uM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDE34263AE;
	Wed, 22 Jun 2016 15:33:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79532263AD;
	Wed, 22 Jun 2016 15:33:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Use docker for _some_ testing?
References: <20160622190154.GA17442@duynguyen>
Date:	Wed, 22 Jun 2016 12:33:04 -0700
In-Reply-To: <20160622190154.GA17442@duynguyen> (Duy Nguyen's message of "Wed,
	22 Jun 2016 21:01:55 +0200")
Message-ID: <xmqqziqdkoi7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24DA3AE6-38B0-11E6-B008-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The story started with my problem on Debian, which I didn't have and
> didn't want to install a Debian VM just for that problem. So I made a
> docker image with the following script.
>
> Which makes me think, could we use something like this to make sure
> people (on Linux) can test more obscure cases? Sometimes there are
> featues that require some dependencies that are not always present on
> the developer's machine (http server is a big one, locales come close
> second, then there will be lmdb and watchman in future...). With this,
> said developer can do a final test run in docker covering as much as
> possible.
>
> Of course it can't cover everything. Different compiler versions are
> out. OS-specific changes are out (but wine would be still good to test
> some aspect of Windows port, or at least make sure it builds)
>
> Comments?

Nice.

> -- 8< --
> diff --git a/contrib/docker/locale.gen b/contrib/docker/locale.gen
> new file mode 100644
> index 0000000..ef08e00
> --- /dev/null
> +++ b/contrib/docker/locale.gen
> @@ -0,0 +1,2 @@
> +is_IS.UTF-8 UTF-8
> +is_IS ISO-8859-1
> \ No newline at end of file
> diff --git a/contrib/docker/run.sh b/contrib/docker/run.sh
> new file mode 100755
> index 0000000..83e5679
> --- /dev/null
> +++ b/contrib/docker/run.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +die() {
> +	echo "$@" >&2
> +	exit 1
> +}
> +
> +build_debian() {
> +	cat >Dockerfile <<-EOF
> +	FROM debian:latest
> +	RUN apt-get update && \
> +		apt-get install -y libcurl4-gnutls-dev libexpat1-dev \
> +		gettext libz-dev libssl-dev build-essential
> +	RUN apt-get install -y locales
> +	COPY locale.gen /etc/locale.gen
> +	RUN locale-gen
> +	RUN groupadd -r $(id -gn) -g $(id -g) && \
> +		useradd -u $(id -u) -r -d "$HOME" -g $(id -g) -s /sbin/nologin $(id -un)
> +	USER $(id -un)
> +	EOF
> +	docker build -t $IMAGE .  || die "failed to build docker image"
> +}
> +
> +DISTRO=debian
> +IMAGE=git-$DISTRO-$(id -un)
> +ROOT="$(realpath $(git rev-parse --show-cdup))"
> +
> +test "$(docker images --format='{{.Repository}}' $IMAGE)" = $IMAGE || \
> +	build_$DISTRO
> +docker run -it --rm -v "$ROOT":"$ROOT" -w "$(pwd)" $IMAGE bash
> -- 8< --
> --
> Duy
