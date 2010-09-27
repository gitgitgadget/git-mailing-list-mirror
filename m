From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] blame,cat-file: Demonstrate --textconv is wrongly
 running converter on symlinks
Date: Mon, 27 Sep 2010 11:27:47 -0700
Message-ID: <7vocbjyrbw.fsf@alter.siamese.dyndns.org>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
 <4805c18603a79e265c1bb1a1858ece8c33b17e2b.1285351816.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Mon Sep 27 20:28:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0IQv-0003Kr-1Q
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 20:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab0I0S2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 14:28:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab0I0S2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 14:28:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2E64D9B59;
	Mon, 27 Sep 2010 14:28:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S7/PtaRGNr3MqMQqdNr4ujBnZso=; b=AlYc1Y
	Q3cliXPE2iwPHMvoTtR32+DWQpg9DWbevfdR84lsoAXdM78egjGtYwE/u9JjzNKX
	5Vwhx8Fg3d0JCSiUDk6GRETYR/P5tlhFapjt3hF7lUrluNKAZCFKtFbHPzgPvB10
	OdmH++FRX/WRULo5KCt54MA9jugFxdbfdz1pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOKpxY47TwOmF3eevp6GkTncNqqGrvai
	/9bilzI5GdtQfRBxLuSrSRwtnmZBTHzPFuNC8nVnWATVreZEBQX2vU4/UWbf6bqx
	UQspLRaFpG8NebtRw5Uv5t1sEUibMeH9xC0ooSEVWpqwUQY89fDGzRRep/WdzJYg
	uaT3psWxixg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4266ED9B51;
	Mon, 27 Sep 2010 14:27:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30AD0D9B4C; Mon, 27 Sep
 2010 14:27:49 -0400 (EDT)
In-Reply-To: <4805c18603a79e265c1bb1a1858ece8c33b17e2b.1285351816.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Fri\, 24 Sep 2010 22\:24\:09 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3560EEC-CA64-11DF-BAB0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157362>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
> index d0f8d62..7d42e96 100755
> --- a/t/t8006-blame-textconv.sh
> +++ b/t/t8006-blame-textconv.sh
> @@ -17,10 +17,12 @@ chmod +x helper
>  test_expect_success 'setup ' '
>  	echo "bin: test 1" >one.bin &&
>  	echo "bin: test number 2" >two.bin &&
> +	ln -s one.bin symlink.bin &&
>  	git add . &&
>  	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
>  	echo "bin: test 1 version 2" >one.bin &&
>  	echo "bin: test number 2 version 2" >>two.bin &&
> +	ln -sf two.bin symlink.bin &&
>  	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
>  '

Doesn't this need some test prereq marker?
