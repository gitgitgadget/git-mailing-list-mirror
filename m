From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 03 Jul 2013 13:24:46 -0700
Message-ID: <7v38rve6i9.fsf@alter.siamese.dyndns.org>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<vpqfvvvq5bl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuTbj-00056E-AU
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286Ab3GCUYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:24:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933210Ab3GCUYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:24:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37DA12D131;
	Wed,  3 Jul 2013 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XG0N/59peR7vVzn9sHPsJUbOTKc=; b=mQ8Q7m
	lFgWd7OCOMAbhdXFPEe6sm3QbTyQ2g+jds5c6NVLae307QOUW4K4w1Tyvve1bGfz
	UjtqqTbmgA+mQDA+c95WjqtT2pfCEsf/7vq2xICrG6PNpwnrTNaXhv7UALYqQlL+
	Tr+aSlcYjp1lhHO0e+PoV9cBRd3AHk6Kxa5XA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x8F+MC3oHBvdZyPoXsrrCokmnmh5XrpU
	7UQfyu5DmoJ0jvrkaPWldn+tpBpXptimYW/PlUgZyNpnRja7WPeDZp+35PL6AU1D
	cg4GNQOxVJ2s9A982E4x8xOcGC40/BbC9DjUL0wUYv3Oj5jcVcfxFhW2TMokI4HS
	iND8hCcMMIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3C42D130;
	Wed,  3 Jul 2013 20:24:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2E02D12D;
	Wed,  3 Jul 2013 20:24:47 +0000 (UTC)
In-Reply-To: <vpqfvvvq5bl.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	03 Jul 2013 12:57:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B0B04C8-E41E-11E2-BF9E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229525>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> benoit.person@ensimag.fr writes:
>
>> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
>> index 53a8dd0..dbebe49 100644
>> --- a/wrap-for-bin.sh
>> +++ b/wrap-for-bin.sh
>> @@ -14,7 +14,7 @@ else
>>  	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
>>  	export GIT_TEMPLATE_DIR
>>  fi
>> -GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
>> +GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"$GITPERLLIB"
>
> Then you need to do something like this to prevent broken $GITPERLLIB in
> user's configuration from interfering with the testsuite:
>
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -92,6 +92,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
>         print join("\n", @vars);
>  ')
>  unset XDG_CONFIG_HOME
> +unset GITPERLLIB
>  GIT_AUTHOR_EMAIL=author@example.com
>  GIT_AUTHOR_NAME='A U Thor'
>  GIT_COMMITTER_EMAIL=committer@example.com

Yes, that is a good point.

It introduces a chicken-and-egg circularity for git-mw tests to use
the common test infrastructure by dot-sourcing this file, though,
no?
