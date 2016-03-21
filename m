From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 15:06:39 -0700
Message-ID: <xmqqwpovjxjk.fsf@gitster.mtv.corp.google.com>
References: <20160319182310.GA23124@spk-laptop>
	<20160320042912.GD18312@sigill.intra.peff.net>
	<20160320150703.GB5139@spk-laptop>
	<xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
	<20160321192904.GC20083@spk-laptop>
	<xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:06:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7yJ-00074B-AT
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbcCUWGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:06:43 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751777AbcCUWGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:06:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2826B4F4BA;
	Mon, 21 Mar 2016 18:06:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vRDKKt/NBkHi3YKPS/tre9t/yoY=; b=AVCvuW
	jlQYrxXcFlEc/S5rJIwQCi42/20Po2eLY7e/RJcuOH3ZHDPKjcYSn1gqoUCuJn3M
	3Ke8uOP3CLLTfXFHXb/738uZ4+2lx7yEEMVvHoAAE4XuZL643uY/AaqkywCn9kdu
	+T1KkTe1lRd1FfdoSrHmX8V8Zq3ijqV8fLBSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fo6DL1fuDUUNclFqlTb/wz7dEUGnm2pn
	WDycZeq5eC6L91pArYyzv82q2Dw+Zykhwv9hw8PS5Fxp+HUAGTYy34HjAubgmmc5
	E6sOhocOlXoN+L7eJCx/4Gr/K346Bs6WAOzxlidiHgwCGZT2kiA/OuKJMplHiVIP
	JZCoMy3Eugw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F5044F4B9;
	Mon, 21 Mar 2016 18:06:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 97D404F4B8;
	Mon, 21 Mar 2016 18:06:40 -0400 (EDT)
In-Reply-To: <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Mar 2016 12:43:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 307BEC48-EFB1-11E5-B111-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289469>

Junio C Hamano <gitster@pobox.com> writes:

>>> If you are forcing users to always leave a message and then further
>>> forcing users to always sign with the single new configuration, i.e.
>>> 
>>>     $ git tag v1.0
>>>     ... opens the editor to ask for a message ...
>>>     ... then makes the user sign with GPG ...
>>
>> I'm not forcing this type of user to enable global configuration, that will be
>> annoying for them of course.
>
> Good.

Eh, it seems that your test actually expects this kind of
interaction, though.

This piece from your PATCH v4:

    diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
    index cf3469b..7791d00 100755
    --- a/t/t7004-tag.sh
    +++ b/t/t7004-tag.sh
    @@ -775,6 +775,39 @@ test_expect_success GPG '-s implies annotated tag' '
            test_cmp expect actual
     '

    +get_tag_header config-implied-annotate $commit commit $time >expect
    +./fakeeditor >>expect
    +echo '-----BEGIN PGP SIGNATURE-----' >>expect
    +test_expect_success GPG \
    +	'git tag -s implied if configured with tag.gpgsign' \
    +	'test_config tag.gpgsign true &&
    +	GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&
    +	get_tag_msg config-implied-annotate >actual &&
    +	test_cmp expect actual
    +'
    +

wants to see that "git tag config-implied-annotate" (which looks
exactly like "git tag v1.0" we discussed above) runs the fakeeditor
and makes a signed tag.
