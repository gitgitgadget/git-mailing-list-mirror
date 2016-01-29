From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] convert: legitimately disable clean/smudge filter with an empty override
Date: Fri, 29 Jan 2016 10:48:55 -0800
Message-ID: <xmqqwpqsi5m0.fsf@gitster.mtv.corp.google.com>
References: <1454055697-6742-1-git-send-email-larsxschneider@gmail.com>
	<1454055697-6742-2-git-send-email-larsxschneider@gmail.com>
	<xmqqh9hwjlha.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, sunshine@sunshineco.com,
	peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 29 19:49:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPE6Q-0003Bn-1n
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbcA2Ss6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:48:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753296AbcA2Ss5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:48:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 396053F814;
	Fri, 29 Jan 2016 13:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ww/R4iYwqbQqAcLoDFaSPiv9Mg4=; b=dpTfoi
	Wiz+MEvJufg+C5rEfqCo04Gb2/wGAa6Eo0Af83MALAGGZ6xDttT63DDb1O5k8SkL
	dyPfsmcTMzp1LC5ZY5Wzlc3hgfzijauTgrZpeqvMClmkckm8GHegSAnvTaB/clhu
	XBhuRf9+31iogYTXsw7XSC0n2Sa3Mkf2ocE7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBdTivyqQ1cDxLCI0/KvuBuanqZsiIvj
	s5ON0vKAFE+8tgSGzBlZj6/7YZ2XBEvNTscQQDuF9BOPeuAx9ytG3x3c0j3ASSOO
	d41TISAqCjkHo+OIbUtNEhJzimMDrSx1WpMVruQMqWhBW9QV09KBxbqMNPXarEb+
	tZYhjxZL46Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31AFD3F813;
	Fri, 29 Jan 2016 13:48:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92B423F80F;
	Fri, 29 Jan 2016 13:48:56 -0500 (EST)
In-Reply-To: <xmqqh9hwjlha.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Jan 2016 10:20:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F37EE640-C6B8-11E5-B154-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285086>

Junio C Hamano <gitster@pobox.com> writes:

> Instead, teach apply_filter() to treat an empty string given as a
> filter means the input must be returned as-is without conversion,
> and the operation must always succeed.

Ugh, that was a non-sentence.  

  Instead, teach apply_filter() to treat an empty string as a no-op
  filter that always returns successfully its input as-is without
  conversion.

was what I meant to say.

> -- >8 --
>
>>  
>>  	if (!dst)
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
>> index 718efa0..7bac2bc 100755
>> --- a/t/t0021-conversion.sh
>> +++ b/t/t0021-conversion.sh
>> @@ -252,4 +252,20 @@ test_expect_success "filter: smudge empty file" '
>>  	test_cmp expected filtered-empty-in-repo
>>  '
>>  
>> +test_expect_success 'disable filter with empty override' '
>> +	test_config_global filter.disable.smudge false &&
>> +	test_config_global filter.disable.clean false &&
>> +	test_config filter.disable.smudge false &&
>> +	test_config filter.disable.clean false &&
>> +
>> +	echo "*.disable filter=disable" >.gitattributes &&
>> +
>> +	echo test >test.disable &&
>> +	git -c filter.disable.clean= add test.disable 2>err &&
>> +	test_must_be_empty err &&
>> +	rm -f test.disable &&
>> +	git -c filter.disable.smudge= checkout -- test.disable 2>err &&
>> +	test_must_be_empty err
>> +'
>> +
>>  test_done
