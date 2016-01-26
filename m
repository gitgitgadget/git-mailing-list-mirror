From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 26 Jan 2016 10:44:17 -0800
Message-ID: <xmqqk2mwcha6.fsf@gitster.mtv.corp.google.com>
References: <1453802023-85055-1-git-send-email-larsxschneider@gmail.com>
	<1453802023-85055-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, mh@glandium.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 26 19:44:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO8bK-0008Cz-5E
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 19:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbcAZSoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 13:44:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751230AbcAZSoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 13:44:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FF8D3F797;
	Tue, 26 Jan 2016 13:44:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n6Mk3NgoTqDivsTrEvYdTfkxQR4=; b=Mcbe9W
	VjhNUAYR2DkIzjtV0W/CAylXDphRJpnkXtgqtwI6WMEK5PBIq0TGqENZTT7u+vYR
	6yLmYwp7u6fGjfEvhwcb3DIX8MU9glN9d7WKaQMFPHeCzkQwfv8WvzYScMuxNVMo
	sFwAfhlsSxy4qDcYOa1Bg00v7Vosy0eVvvVnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHHVaJc41coAyNz9mpE1WzpUNglyM3Lb
	9mebOHB7BT3gybDdE6hbPTYgRzt0E17PV4Cdy8gYO4/J9Ie2SLgGtaX3lEF/igjz
	8J9DgCVP/yQhTPDoorSZgFMX1buUaZ3mOLYZuLq5PVtenrvfcrllsCPrKzIq2RU/
	HuQIOfc416E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 274DE3F796;
	Tue, 26 Jan 2016 13:44:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A018D3F794;
	Tue, 26 Jan 2016 13:44:18 -0500 (EST)
In-Reply-To: <1453802023-85055-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 26 Jan 2016 10:53:42
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE96CB58-C45C-11E5-B02A-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284847>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The Travis-CI machines are in a clean state in the beginning of every run
> (transient by default). Use the Travis-CI cache feature to make the prove
> state persistent across consecutive Travis-CI runs on the same branch.
> This allows to run previously failed tests first and run remaining tests
> in slowest to fastest order. As a result it is less likely that Travis-CI
> needs to wait for a single test at the end which speeds up the test suite
> execution by ~2 min.
>
> Travis-CI can only cache entire directories. Prove stores the .prove file
> always in the t/ directory but we don't want to cache the entire t/ directory.
> Therefore we create a symlink from $HOME/travis-cache/.prove to t/.prove and
> cache the $HOME/travis-cache directory.
>
> Unfortunately the cache feature is only available (for free) on the
> Travis-CI Linux environment.

Thanks.  I wouldn't be confused with the above description like
before.

I see systems other than Linux listed in os: section; presumably our
$HOME would not persist and we wouldn't even have $HOME/travis-cache
directory when we run on them, so "mkdir -p" would be both necessary
and save to have whether the "cache" feature is available or not.
And the "ln -s" would be the same way--either we symlink to a file
that hasn't been born (either on a platform without "cache" feature,
or the first run on Linux) and that is perfectly fine.

And all the systems listed in os: section supports symlinks, so
the "mkdir -p && ln -s" is safe.

Looks sensible.  Thanks.

>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index c3bf9c6..610881e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,9 @@
>  language: c
>  
> +cache:
> +  directories:
> +    - $HOME/travis-cache
> +
>  os:
>    - linux
>    - osx
> @@ -18,7 +22,7 @@ env:
>      - P4_VERSION="15.2"
>      - GIT_LFS_VERSION="1.1.0"
>      - DEFAULT_TEST_TARGET=prove
> -    - GIT_PROVE_OPTS="--timer --jobs 3"
> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>      - GIT_TEST_OPTS="--verbose --tee"
>      - CFLAGS="-g -O2 -Wall -Werror"
>      - GIT_TEST_CLONE_2GB=YesPlease
> @@ -67,6 +71,8 @@ before_install:
>      p4 -V | grep Rev.;
>      echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
>      git-lfs version;
> +    mkdir -p $HOME/travis-cache;
> +    ln -s $HOME/travis-cache/.prove t/.prove;
>  
>  before_script: make --jobs=2
