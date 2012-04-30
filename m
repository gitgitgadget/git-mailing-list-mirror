From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line
 termination mode
Date: Mon, 30 Apr 2012 15:58:00 -0700
Message-ID: <7vd36oesjr.fsf@alter.siamese.dyndns.org>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <1335817705-24718-1-git-send-email-jk@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Tue May 01 00:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzY1-000770-L8
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab2D3W6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 18:58:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757175Ab2D3W6E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 18:58:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F20963AD;
	Mon, 30 Apr 2012 18:58:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qxg5JHA5mUsC
	+UqF3Hw9seQ00Xg=; b=xhH72cxaj4x5rK2inEB9A5HLNmfZmtPFeHBG7gVFsM9Q
	2CDZjVCXhxG8k8ryFiFojOn4d26XmQISSRT43RN8qhZz3GrGCkrw8EvSJOQVHn47
	fhwn1mkxRZVAR10kOzhp1f2vFy4NYti8EG6jrtOAYD7O9PI1ymlKqkEpNX6UrGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EiBkZr
	wdWMda+tAtNeRA/9ycsHkeDusp/Bpi/nYo4vVR8Zgtm3m4/kTjkUCbTWQdt3ZtxB
	BYzGfBWrBkYzsVhumzT78p9+MdFiaqfSKR6FImczCcyWuZykRF9JKZ0Ums07beQ7
	pk9vY1qI+mGyJEYP6dVcYWBP3s+RsA1hMeO10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BEE63AB;
	Mon, 30 Apr 2012 18:58:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C2B963AA; Mon, 30 Apr 2012
 18:58:01 -0400 (EDT)
In-Reply-To: <1335817705-24718-1-git-send-email-jk@jk.gs> ("Jan
 =?utf-8?Q?Kr=C3=BCger=22's?= message of "Mon, 30 Apr 2012 22:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFEAD7F6-9317-11E1-AE5E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196625>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> When using a custom format in line termination mode (as opposed to li=
ne
> separation mode), the configured line terminator is not used, so thin=
gs
> like "git log --pretty=3Dtformat:%H -z" do not work properly.
>
> Make it use the line terminator the user ordered.
>
> Signed-off-by: Jan Kr=C3=BCger <jk@jk.gs>
> ---
>  Here are two simple tests, for both format: and tformat: with -z.

Thanks for being thorough. Very much appreciated.

Having said that, are we sure that

	printf "add bar\0initial"

works per specification, or merely works by accident in some
implementation?

In C, we have to write this as printf("add bar%cinitial", 0), and the
above makes my stomach feel a bit queasy.

Admittedly we have "printf "\0\0" in t6024 and we haven't seen anybody
complain for the past 6 years, so perhaps I shouldn't be worried too mu=
ch
about this.

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-forma=
ts.sh
> index 2ae9faa..03a73ba 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -71,4 +71,16 @@ test_expect_success 'alias loop' '
>  	test_must_fail git log --pretty=3Dtest-foo
>  '
> =20
> +printf "add bar\0initial" > expected
> +test_expect_success 'NUL separation' '
> +	git log -z --pretty=3D"format:%s" >actual &&
> +	test_cmp expected actual
> +'
> +
> +printf "add bar\0initial\0" > expected
> +test_expect_success 'NUL termination' '
> +	git log -z --pretty=3D"tformat:%s" >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
