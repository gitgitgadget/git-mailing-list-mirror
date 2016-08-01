Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E410A1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcHAVlm (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:41:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750954AbcHAVlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 17:41:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51AD33292F;
	Mon,  1 Aug 2016 17:25:22 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5CbAyKlXbn2l
	PSy4vKwE1l6SE4E=; b=VqfNpxChIyYI5CFRru64d0Yjd+F6YMXPlmuFJOTDGmEp
	NOk/EcrXu/qqu/dk8p8CGi8KA3p1A4ScQUcOD/6d1Dz+EnRHaWCNg/LwEL9CXoTZ
	qWmgWsNokqzM/ePAAy/So3I3btAmMHcAMR1LikMNY/jvGsbIz8bCFB0vOyTRJ88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xut4SX
	toOFRdt5R2ZJfF4X/IQ+W1Dyx4VNS5V2VNnDhorOSMp0DVCEYnqj8rW211Ekmjl6
	xGP/KaELIKFwwB0uHK//juw+ClIpn2kKvmk4Fx+MLgteMvNmlCP8KQsdoipIdveb
	cZ8QfTNOf6YoS/Zsqr2XmQkzp4gGUtdKTmcJ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 484453292D;
	Mon,  1 Aug 2016 17:25:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF7693292C;
	Mon,  1 Aug 2016 17:25:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] t3700: add a test_mode_in_index helper function
References: <579d0a83.4bd3c8e4.bm002@wupperonline.de>
Date:	Mon, 01 Aug 2016 14:25:19 -0700
In-Reply-To: <579d0a83.4bd3c8e4.bm002@wupperonline.de> ("Ingo =?utf-8?Q?Br?=
 =?utf-8?Q?=C3=BCckl=22's?=
	message of "Sat, 30 Jul 2016 22:13:54 +0200")
Message-ID: <xmqqvazkgp1c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 73EBE4CA-582E-11E6-B889-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ingo Brückl <ib@wupperonline.de> writes:

Ingo Brückl <ib@wupperonline.de> writes:

> The case statement to check the file mode of a staged file appears
> a number of times.
>
> Simplify the test by utilizing a test_mode_in_index helper function.
>
> Signed-off-by: Ingo Brückl <ib@wupperonline.de>
> ---
>  t/t3700-add.sh | 54 ++++++++++++++++++++++--------------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)

Nice.

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 1fa5dfd..7b98483 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -7,6 +7,20 @@ test_description='Test of git add, including the -- option.'
>
>  . ./test-lib.sh
>
> +# Test the file mode "$1" of the file "$2" in the index.
> +test_mode_in_index () {
> +	case "$(git ls-files --stage "$2")" in
> +		$1\ *"$2")
> +			echo pass
> +			;;
> +		*)
> +			echo fail
> +			git ls-files --stage "$2"
> +			return 1
> +			;;
> +	esac
> +}

This case/esac is misindented, but no need to resend; I can fix it
up trivially while queuing the patches.  It may be both easier to
read and more robust to tweak the pattern like this, though:

# Test the file mode "$1" of the file "$2" in the index.
test_mode_in_index () {
	case "$(git ls-files --stage "$2")" in
	"$1 "*"	$2")
		echo pass
		;;
	*)
		echo fail
		git ls-files --stage "$2"
		return 1
		;;
	esac
}

Thanks.
