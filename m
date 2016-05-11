From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] submodule add: label submodules if asked to
Date: Tue, 10 May 2016 18:13:15 -0700
Message-ID: <xmqqlh3hl7mc.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 03:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IiK-00009J-3W
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcEKBNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:13:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbcEKBNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:13:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9ADBA1AD5F;
	Tue, 10 May 2016 21:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+KiCUuOULns0OSGwVo3sGutDsRs=; b=gPpx0b
	wiDQqsONLG/8Htv7YhomckmEVne96Zv7seD6p5n74evv+JszpjPMHqjH22mQLVwO
	OXJQTRquVPhoyOuk20wX4aTK1U/tRV5pH/pfb2OQTJ7QTmaqXlltjqu3Du77pI3c
	XyhYAhL3qo16TzmCdNVyyOW1JkAgDcJluLQAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ojcSxb8ufOxl1f5+cfnCxo1FOoVJ0S0c
	B1kVeW97t7ly/lWRo7NlOKI682ZYRz/jalObzv4DhDih8M5mgXNREzVkMG7G91TO
	Faxeuneh4VB5NzW79pD9HYE1Gk5EiDBrc9OanGen0o/H1tQS1Lo6BH6uAefv8GLJ
	3vWpdN0Bm6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92D6B1AD5C;
	Tue, 10 May 2016 21:13:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BE361AD5B;
	Tue, 10 May 2016 21:13:18 -0400 (EDT)
In-Reply-To: <1462928397-1708-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B5928AC-1715-11E6-A5B0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294219>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 814ee63..0adc4e4 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1056,6 +1056,7 @@ test_expect_success 'submodule with UTF-8 name' '
>  '
>  
>  test_expect_success 'submodule add clone shallow submodule' '
> +	test_when_finished "rm -rf super" &&
>  	mkdir super &&
>  	pwd=$(pwd) &&
>  	(
> @@ -1094,5 +1095,48 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'submodule add records a label' '
> +	test_when_finished "rm -rf super" &&
> +	mkdir super &&
> +	pwd=$(pwd) &&
> +	(
> +		cd super &&
> +		git init &&
> +		git submodule add --label labelA file://"$pwd"/example2 submodule &&
> +		git config -f .gitmodules submodule."submodule".label >../actual &&
> +		echo labelA >../expect
> +	) &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<-EOF
> +labelA
> +labelB
> +EOF
> +
> +test_expect_success 'submodule add records multiple labels' '

The existing tests in this file may be littered with this bad
construct, but please do not add more example of running things
outside of test_expect_{success,failure} block unless there is a
good reason to do so.
