From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 12:00:52 -0800
Message-ID: <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 19 21:01:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLcSf-0008H7-OL
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 21:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbcASUA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 15:00:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932877AbcASUAz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 15:00:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 390B63D8A4;
	Tue, 19 Jan 2016 15:00:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vBD1ZnxnSNoqDm8H3jnUX5WtGyE=; b=aT0M8K
	8Erubm75SNj1r3hBNODWICRn1QDbx62ORYpP9Owpntn843+fJY7T36gxNSchRnB8
	jlUD9cH/RtyXMl7dNlfFHWKoxqlJbUqaK4wP+Bri++U9P5XNqI1mm46H89wLRUAH
	2fszoCUJ5PSBDITK21xZPzOFffBowXEoGfdp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMxsY3NLhuU3fDAwaGrwrBBR1QgAPGi5
	+Ybd8yW3LWBgqrzZjLJTOB2U+3cga+w22aIQKph4Nvl7klOU9sfHyWrfYbKTo1fH
	AwjdLQOySe7/2Dz8Zq4iC5dGcVDGbosYnPlPj3kJLiVwSc3aoPtB31MJnRMADpGf
	ZxALHVJAIig=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3111F3D8A3;
	Tue, 19 Jan 2016 15:00:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B8D23D8A2;
	Tue, 19 Jan 2016 15:00:53 -0500 (EST)
In-Reply-To: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 19 Jan 2016 10:24:29
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5884DEA2-BEE7-11E5-9B3E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284375>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Use the Travis-CI cache feature to store prove test results and make them
> available in subsequent builds. This allows to run previously failed tests
> first and run remaining tests in slowest to fastest order. As a result it
> is less likely that Travis-CI needs to wait for a single test at the end
> which speeds up the test suite execution by ~2 min.
>
> Unfortunately the cache feature is only available (for free) on the
> Travis-CI Linux environment.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

This is cute, but isn't it useful even outside Travis's context?  I
am not suggesting to touch anything other than .travis.yml file in
this patch, but if I wanted to get the benefit from the idea in this
patch when I run my tests manually, I can just tell prove to use the
cached states, no?

IOW, I am confused by the beginning of the log message that says
this is taking advantage of "the Travis-CI cache feature".  This
improvement looks to me like using the feature of "prove" that
allows us to run slower tests first, and does not have much to do
with Travis.

You are relying on the assumption that things under $HOME/ is stable
while things under t/ (or in our source tree in general) are not,
and I think that is a sensible thing to take advantage of, but are
we sure that they are running in an environment where "ln -s" would
work?  Otherwise, it may be more robust to copy $HOME/.prove to
t/.prove before starting to test and then copy it back once the
tests are done.

Thanks.

>
> diff --git a/.travis.yml b/.travis.yml
> index c3bf9c6..f34726b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,9 @@
>  language: c
>
> +cache:
> +  directories:
> +    - $HOME/.prove-cache
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
> +    mkdir -p $HOME/.prove-cache;
> +    ln -s $HOME/.prove-cache/.prove t/.prove;
>
>  before_script: make --jobs=2
>
> --
> 2.5.1
