From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 3/3] bisect--helper: `write_terms` shell function in C
Date: Tue, 24 May 2016 10:39:23 -0700
Message-ID: <xmqqbn3v5p9w.fsf@gitster.mtv.corp.google.com>
References: <1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
	<20160524072124.2945-1-pranit.bauva@gmail.com>
	<20160524072124.2945-4-pranit.bauva@gmail.com>
	<CAP8UFD1WZ=5e9u5awrHDG-vhMR5dw5NNY_yVEkp2o0rgx59nnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 19:39:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5GIm-0002Kt-8i
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 19:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756008AbcEXRj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 13:39:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753082AbcEXRj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 13:39:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 884D21D2E5;
	Tue, 24 May 2016 13:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xgBJ+7SJD2M3uMMI9DVb0xP1U0o=; b=Xjd5qg
	/MZBjHG58SCqAgVj/bqk6o4rzGG36BN+1PowGjxP/phL5XWFv9JnjAyfPNFkE8np
	36xy0rt4aGrp0QOB8jWZNK4TnBufQixZ9JSBNnpJrJRetKKKmiHj8V4bg1pwi7vL
	rWxXFP7EZnU2dcICSbCpenOaKRX30gY8PNupY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kIB+9hpJcf6psgoRjjPa8/wCqP81UhOX
	6H288XsOcjcx4Q7fmegiqNXlQjVdCgKbJ5/Shm8Tv83IX3HTX0yINlAoIEuVS7G4
	mM7FFlJupA0goVV9Zzu92hmibWeIQmgpnn4KMuwMSrUcyLIRqdZ2wshX9uELFCbz
	6bWPp0Pp+RY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DFFB1D2E3;
	Tue, 24 May 2016 13:39:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E73C71D2E2;
	Tue, 24 May 2016 13:39:25 -0400 (EDT)
In-Reply-To: <CAP8UFD1WZ=5e9u5awrHDG-vhMR5dw5NNY_yVEkp2o0rgx59nnQ@mail.gmail.com>
	(Christian Couder's message of "Tue, 24 May 2016 09:33:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 758BCA72-21D6-11E6-ACA0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295510>

Christian Couder <christian.couder@gmail.com> writes:

>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index 7d7965d..cd39bd0 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -210,7 +210,7 @@ bisect_start() {
>>         eval "$eval true" &&
>>         if test $must_write_terms -eq 1
>>         then
>> -               write_terms "$TERM_BAD" "$TERM_GOOD"
>> +               git bisect--helper --write-terms "$TERM_BAD" "$TERM_GOOD" || exit
>
> This `|| exit` is not needed because...
>
>>         fi &&
>>         echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
>
> ... there is an `|| exit` on the line above (which is chained using
> `&&` to the previous lines).

Could you please trim parts that you are not commenting on when
quoting?  Thanks.
