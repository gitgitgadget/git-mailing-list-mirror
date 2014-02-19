From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] introduce GIT_INDEX_VERSION environment variable
Date: Tue, 18 Feb 2014 16:31:08 -0800
Message-ID: <xmqqsirg9c4z.fsf@gitster.dls.corp.google.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
	<1392492197-7724-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:31:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFv4N-0005fJ-B4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbaBSAbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:31:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59736 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbaBSAbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:31:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08C46EEB7;
	Tue, 18 Feb 2014 19:31:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2V8digy2fX6WPBPdEx4WrFAoXgI=; b=cIA003ZCccnVsvWEnwA3
	sxLpQD8Lp7VDweVMaHRmJ4OT5d/p0wzvP66lT43iH/iOMjCG/5ei+DCDTqfS+G2V
	GoNid2iFoE/L4rJzoIsUES36EGX+12gFt34Pn5PIgVQMqjCAtjD1BVK9z9cwY2f6
	HwA8Oe6x9awBP7N3sJDkjEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TFDsZxi7Fbs/BXQrfmmNlSm6U6qm6gE9euNq99dmMoluaF
	bMne0yjznPap1ohlmVMCh60842RiiCIUAkTw0JiJFDCI/wuwvPPcVssPXpfpUl6A
	scPd4pLpB4D/3Vql1zSylrjmaAuXRmZwJcIKdOHhgN3sAERJvr8LPEUhFK0pw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAF1E6EEB6;
	Tue, 18 Feb 2014 19:31:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D5F76EEB4;
	Tue, 18 Feb 2014 19:31:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21B11812-98FD-11E3-BBB9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242379>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index aec3726..bc9eeea 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -712,6 +712,11 @@ Git so take care if using Cogito etc.
>  	index file. If not specified, the default of `$GIT_DIR/index`
>  	is used.
>  
> +'GIT_INDEX_VERSION'::
> +	This environment variable allows the specification of an index
> +	version for new repositories.  It won't affect existing index
> +	files.  By default index file version 3 is used.
> +

This is half-correct, isn't it?  In-code variable may say version 3
but we demote it to version 2 unless we absolutely need to use the
version 3 ugliness.

> diff --git a/read-cache.c b/read-cache.c
> index 3f735f3..3993e12 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1223,6 +1223,22 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>  
>  #define INDEX_FORMAT_DEFAULT 3
>  
> +static unsigned int get_index_format_default()
> +{
> +	char *envversion = getenv("GIT_INDEX_VERSION");
> +	if (!envversion) {
> +		return INDEX_FORMAT_DEFAULT;
> +	} else {
> +		unsigned int version = strtol(envversion, NULL, 10);

If we are using strtol() to parse it carefully, we should make sure
it parses to the end by giving a non-NULL second argument and
checking where the parsing stopped.

> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> new file mode 100755
> index 0000000..37fd84d
> --- /dev/null
> +++ b/t/t1600-index.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +test_description='index file specific tests'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo 1 >a
> +'
> +
> +test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
> +	(
> +		GIT_INDEX_VERSION=1 &&
> +		export GIT_INDEX_VERSION &&
> +		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
> +		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
> +			warning: GIT_INDEX_VERSION set, but the value is invalid.
> +			Using version Z
> +		EOF
> +		test_i18ncmp expect.err actual.err
> +	)
> +'

If we already have an index in version N when this test starts, what
should happen?

Will queue on 'pu', with some suggested fixups.

Thanks.
