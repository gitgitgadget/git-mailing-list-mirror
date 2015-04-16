From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] utf8-bom: introduce skip_utf8_bom() helper
Date: Thu, 16 Apr 2015 11:23:31 -0700
Message-ID: <xmqqk2xchqzg.fsf@gitster.dls.corp.google.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
	<1429206774-10087-1-git-send-email-gitster@pobox.com>
	<1429206774-10087-2-git-send-email-gitster@pobox.com>
	<20150416181407.GA12517@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 20:23:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YioRu-0006j7-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbbDPSXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:23:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbbDPSXd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:23:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C84EA4ADCA;
	Thu, 16 Apr 2015 14:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bfUZcyzW5Ge/iEsVrms+YMO/yP0=; b=roTvIj
	cJCUKbdp3joBou3aIVKipsvFyyop9RwYJcvYZ6aN+RnjxEeb7n6BA6oT3Zh/P+iu
	cnjrHLUFSNupdY532TVOwCLdT3gWdK4FJ3IrZ2kXxt/xA8pEGiQfs1xam2OG0RhG
	hPQ6aTS9zHVMRzZ1b4xvz631YLUGSov6IdC28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H8KWSKtej5LgQnAx9R+6iv/xQRP+eYvL
	jcvA6ksePpAjZeUmRRYb2xu3l9rGrU4le9Tb5rILpel9zy2rMgJZYbX1XFDU0U5e
	4A96ppI3nIcUlyczVYnbCCZ04RKVjqbD5cBnpYJdefhpo1UHbFEnuJqOE5q8MmGH
	YUpHydJnSms=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C12B64ADC9;
	Thu, 16 Apr 2015 14:23:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 477584ADC8;
	Thu, 16 Apr 2015 14:23:32 -0400 (EDT)
In-Reply-To: <20150416181407.GA12517@peff.net> (Jeff King's message of "Thu,
	16 Apr 2015 14:14:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFF84B86-E465-11E4-8C39-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267320>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2015 at 10:52:52AM -0700, Junio C Hamano wrote:
>
>> @@ -576,10 +576,8 @@ int add_excludes_from_file_to_list(const char *fname,
>>  
>>  	el->filebuf = buf;
>>  
>> -	if (size >= 3 && !memcmp(buf, utf8_bom, 3))
>> -		entry = buf + 3;
>> -	else
>> -		entry = buf;
>> +	entry = buf;
>> +	skip_utf8_bom(&entry, size);
>>  
>>  	for (i = 0; i < size; i++) {
>>  		if (buf[i] == '\n') {
>
> I'm surprised that in both yours and the original that we do not need to
> subtract 3 from "size".

Or we start scanning from the beginning of "buf", i.e.

	for (i = 0; i < size; i++)

After you pointed it out, I wondered why we do not adjust the
initial value of "i" (without futzing with "size").  But...

> It looks like we advance "entry" here, not "buf", and then iterate over
> "buf". But I think that makes the later logic weird:
>
>    if (entry != buf + i && entry[0] != '#')
>
> because if there is a BOM, we end up with "entry > buf + i", which I
> think this code isn't expecting. I'm not sure it does anything bad, but
> I think it might be simpler as just:
>
>   /* save away the "real" copy for later, as we do now */
>   el->filebuf = buf;
>
>   /*
>    * now pretend as if the BOM was not there at all by advancing
>    * the pointer and shrinking the size
>    */
>   skip_utf8_bom(&buf, &size);
>
>   /*
>    * and now we do our usual magic with "entry"
>    */
>   entry = buf;
>   for (i = 0; i < size; i++)
>      ...

... this would work much better for this caller.

Thanks.
