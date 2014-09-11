From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Make sure that index-pack --strict checks tag objects
Date: Thu, 11 Sep 2014 10:58:57 -0700
Message-ID: <xmqqha0edony.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
	<cover.1410445430.git.johannes.schindelin@gmx.de>
	<2738eace005dce9002c1a1f5e87ad63aebdf83ef.1410445431.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:59:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS8eS-0003v8-8i
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbaIKR7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:59:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64134 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbaIKR7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:59:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2891B392EE;
	Thu, 11 Sep 2014 13:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/crs5khH0DI69WHHp8VIqFe9M8=; b=SO1HOL
	ic+FdpLY2lyBhkYnOaX6D7ijyE7M5ohzE86dVio3+n2MOi8ie/x2jDyUrQw89zvT
	UuoLGv5L7YpsMEhijHO5o+WarOs5TXeWzRN4XKnU6HdOTaglj7PtsCSfXuWTeyC4
	F2m8yxnguA6DvRM3CPgVv5f90oojTaNTd1eB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GLNBGInm0+cqmqeQ4Khq3+Nf7aQScXn+
	elmU2mX6fgpP4fokoL52OQ+Qi+PiUi5CIFAUBy/ChBtrPFjFogh/xhwyCmdkncnS
	cttuWMlsXmJsU5DUi1e2CbPyY5Y7AllMNQ+t4gEKCvbS/CyivITqgTx2/uERi9UT
	FoOOFZgXj90=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE164392EA;
	Thu, 11 Sep 2014 13:59:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C0CCF392BF;
	Thu, 11 Sep 2014 13:58:59 -0400 (EDT)
In-Reply-To: <2738eace005dce9002c1a1f5e87ad63aebdf83ef.1410445431.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Thu, 11 Sep 2014 16:26:45 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EA93440-39DD-11E4-81E1-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256860>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> One of the most important use cases for the strict tag object checking
> is when transfer.fsckobjects is set to true to catch invalid objects
> early on. This new regression test essentially tests the same code path
> by directly calling 'index-pack --strict' on a pack containing an
> tag object without a 'tagger' line.
>
> Technically, this test is not enough: it only exercises a code path that
> *warns*, not one that *fails*. The reason is that it would be exquisitely
> convoluted to test that: not only hash-object, but also pack-index
> actually *parse* tag objects when encountering them. Therefore we would
> have to actively *break* pack-index in order to test this. Or rewrite
> both hash-object and pack-index in shell script. Ain't gonna happen.

It is perfectly OK to feel and even say "I am not going to do that
in this series" here, but is not very welcome to cast such a
negative "Ain't gonna happen." attitude in stone in the log message
in our history.

When our toolset has become too tight without leaving enough escape
hatch to hinder further development, it is very sensible to at least
think about adding a new "--for-debug" option to hash-object and
pack-objects that allows us to deliberately create broken
datastreams to test against.

I think peff recently added helpers to t5303 to allow us test
corrupt pack streams, which is a way different from what you
envisioned above (i.e. "actively break pack-index") to test
breakages like the ones you were trying to test here.

Having said all that, I do think the series that added new warnings,
errors and a test for the new warnings is an improvement without a
test for the new errors.  So let's queue this, see if somebody comes
up a way to check for these error detection codepath on top of this
series.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t5302-pack-index.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index 4bbb718..4d033df 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -243,4 +243,23 @@ test_expect_success 'running index-pack in the object store' '
>      test -f .git/objects/pack/pack-${pack1}.idx
>  '
>  
> +test_expect_success 'index-pack --strict warns upon missing tagger in tag' '
> +    sha=$(git rev-parse HEAD) &&
> +    cat >wrong-tag <<EOF &&
> +object $sha
> +type commit
> +tag guten tag
> +
> +This is an invalid tag.
> +EOF
> +
> +    tag=$(git hash-object -t tag -w --stdin <wrong-tag) &&
> +    pack1=$(echo $tag $sha | git pack-objects tag-test) &&
> +    echo remove tag object &&
> +    thirtyeight=${tag#??} &&
> +    rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
> +    git index-pack --strict tag-test-${pack1}.pack 2> err &&

s/2> err/2>err/;

> +    grep "^error:.* expected .tagger. line" err
> +'
> +
>  test_done
