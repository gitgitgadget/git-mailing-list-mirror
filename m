From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: git_config_from_file(): handle "-" filename as stdin
Date: Fri, 14 Feb 2014 10:27:11 -0800
Message-ID: <xmqqlhxdim80.fsf@gitster.dls.corp.google.com>
References: <1392384878-7080-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Fri Feb 14 19:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WENU7-0005F4-VM
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 19:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbaBNS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 13:27:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbaBNS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 13:27:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 576EE6A1B5;
	Fri, 14 Feb 2014 13:27:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UDIgKWPMEGPv2F+2FuPpJJpdtFo=; b=XU8Q9Q
	dqFdJtO9jxj3g7Zclj33lvr1bEIpjYpO0a0tjxjYxNLBhl4oDHujne0ErJpFAS34
	re9j80rUJdsJCyg30xIKSvyM2fq5hto5+9To2yTFL49x23lduHVzvNKaE6J9AmjL
	0Yjjg8hWdh60f5lDWMfDaGYKCaVm2m0Yo3HYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DtpAdDVilAqBbbdFg2bFGpaOpMakNfSc
	fLm60isFf7pil9FavvxfPWN0CGMacA+a/5B+NFCueDNW0gByR4hE4ABNAYyBUmHD
	3OnfTMtdEDMlne+lz2+DyCm6oiPjqXdf64vCGNTXdurCTykihwhkCo4M8rCYUcN9
	Li7VI04uc78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6DE46A1B2;
	Fri, 14 Feb 2014 13:27:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 660E56A1AD;
	Fri, 14 Feb 2014 13:27:13 -0500 (EST)
In-Reply-To: <1392384878-7080-1-git-send-email-kirill@shutemov.name> (Kirill
	A. Shutemov's message of "Fri, 14 Feb 2014 15:34:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9FCB33D2-95A5-11E3-B01E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242117>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> The patch extends git config --file interface to allow read config from
> stdin.

Thanks.  The external interface proposed by this change that behaves
the way your new test expects is a good addition to the system.  I
would describe it as:

  Subject: config: teach "git config --file -" to read from the standard input

I however think the patch implements it at the level that is too low
in the callchain.  It will affect a lot more than the dash given to
"git config --file -".  Fortunately, it does not make it possible
for users to make this mistake

	[include]
        	path = -

and scratch their heads, wondering why "git config" is not answering
until they hit ^D.  But that is _only_ because we check if a file
whose name is "-" actually exists in the current directory before
falling into this codepath (and usually no such file exists).  If
such a funnily-named file does exist, we read from that file, not
the standard input.  So that "include" codepath happens to be safe,
but who knows what dragons lie in other codepaths that call this
function.

I recall that an earlier implementation of "git diff --no-index"
that made "-" read one side to be compared from the standard input
had exactly the same issue of comparing filename with "-", which we
had to fix with code reorganization recently.  I'd prefer to see
this update to "git config --file -" done the right way from the
start.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 967359344dab..f1a63075e34f 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -484,6 +484,10 @@ test_expect_success 'alternative GIT_CONFIG (--file)' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success 'alternative GIT_CONFIG (--file=-)' '
> +	git config --file - -l < other-config > output &&

Please leave no SP between redirection operator and its file, i.e.

	git config --file - --list <other-config >output

Thanks.
