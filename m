From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] i18n win32: add git-am eval_gettext variable prefix
Date: Thu, 26 May 2011 07:13:05 -0700
Message-ID: <7vlixtzh1q.fsf@alter.siamese.dyndns.org>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
 <1306365594-22061-2-git-send-email-avarab@gmail.com>
 <4DDDF483.70805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 26 16:13:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPbJV-0004Vq-DD
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 16:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab1EZONU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 10:13:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab1EZONT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 10:13:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A0755C26;
	Thu, 26 May 2011 10:15:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zRTNO6G+luPXLL8lf6Lp90CNHSg=; b=BAlemt
	WyJ9VfSJPR8jDoRUCCD5yrp54F214Rv80QVKUVO1qFbFWQ8nmTbQ8lPk+x2C+aFI
	kAq2YLwXZ5FGan4y7PPIOSzgePz3LtI4AwmA1VTtnnNSfrvSVOBbOF/SKPIJImV8
	Oqd/hDMmukfd63hUZNc5plbcJLsx87vHXQWVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jNUv3tYR5Qb2+4aj8t4+lnRdbCj64ssx
	XkwtGpHnt09TKMuIJ22PqOZXZYM7wfvHIBjWnUPVtUUFTyqWaRN0S+4Ck1/HiSis
	xYuxHaXBN/NIKIMtPVcWccciewnEL4DeI1crVMAdL9WNFlaqQwMJAL692NNezAMP
	ZnQ3VhFMPbo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05B945C25;
	Thu, 26 May 2011 10:15:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C8C15C21; Thu, 26 May 2011
 10:15:14 -0400 (EDT)
In-Reply-To: <4DDDF483.70805@viscovery.net> (Johannes Sixt's message of "Thu,
 26 May 2011 08:34:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97065560-87A2-11E0-95F4-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174514>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I gather that the actual substitution of variable values is done by
> sh-i18n--envsubst, and not by the shell (right?). Let's look at an example:
>
> 	git sh-i18n--envsubst --variables '$foo and $bar'
>
> produces
>
> 	foo
> 	bar
>
> What if it produced
>
> 	GIT_I18N_VARIABLE_foo=$foo
> 	GIT_I18N_VARIABLE_bar=$bar
> 	export GIT_I18N_VARIABLE_foo GIT_I18N_VARIABLE_bar
>
> then the definition of eval_gettext() would look like
>
> eval_gettext () {
> 	printf "%s" "$1" | (
> 		export PATH
> 		eval "$(git sh-i18n--envsubst --variables "$1")"
> 		git sh-i18n--envsubst "$1"
> 	)
> }
>
> and the second call of sh-i18n--envsubst should replace $foo and $bar that
> it sees on stdin by the values of GIT_I18N_VARIABLE_foo and
> GIT_I18N_VARIABLE_bar from the environment.
>
> What do you think?

This started on windows that confuses between $path and $PATH, we wouldn't
be doing this, right?  In git-submodule.sh uses $path variable for
something other than the search-path, and the definition updated by you
would become in the larger picture:

	path=... ;# git-submodule uses the variable for not-a-search-path
        _I18N__path=$path
        export _I18N__path
        git sh-i18n--envsubst "... $_I18N__path"

Is the RHS of the second assignment safe on Windows?  Are environment
variables case insane but normal variables are safe?

If that is a non-issue, I think your change is a good thing to do.
