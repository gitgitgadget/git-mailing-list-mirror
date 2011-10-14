From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Fix %config_path_settings handling
Date: Fri, 14 Oct 2011 16:23:50 -0700
Message-ID: <7v62jrxim1.fsf@alter.siamese.dyndns.org>
References: <4E982B27.8050807@drmicha.warpmail.net>
 <201110142049.32734.jnareb@gmail.com>
 <7vbotjz85o.fsf@alter.siamese.dyndns.org>
 <201110142253.32695.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Cord Seele <cowose@gmail.com>,
	Cord Seele <cowose@googlemail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 01:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REr6c-0003Qf-SM
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 01:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab1JNXXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 19:23:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250Ab1JNXXx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 19:23:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB9B751DA;
	Fri, 14 Oct 2011 19:23:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UH87hNpB56gDRjRxDvR5cLBVK/k=; b=iqRnw/ZhAxX8w5USbkiB
	nfZhBUK3TkqTuZ9fMNlemxrQ5ixH2e1X0NZbdf1rp55BNtDkxSdXD4q28i86z7+n
	uFOcHZVcXGEs9OPqO9ATdwnk3YWsUjtUH1Zw8CYiL37dt/v2TfWvbysCPARCuTby
	4ngJGnJXfCBL+r8MXDxqKQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IqZTNlL/m7PZEs+moXKCp8dD+gWm0vxL3W5SLQ/dZ3/BCo
	H9p+gKzh7sw6meTT8Nkk6CYy1r9IXVaOJ+5HR+cWgoYnuDwCHTAfnwvpQ+EUNs+Q
	YnH+8oIJlNu3McGoAt2LLQZc0CVdY9OA6uHnI6P/HfhlszvKr+AT9+iBORQzk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C204C51D9;
	Fri, 14 Oct 2011 19:23:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541DB51D6; Fri, 14 Oct 2011
 19:23:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 940193B0-F6BB-11E0-8E6F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183631>

Jakub Narebski <jnareb@gmail.com> writes:

> From: Cord Seele <cowose@gmail.com>
> ...
> Signed-off-by: Cord Seele <cowose@gmail.com>
> Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Thanks.

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 579ddb7..87b4acc 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1168,4 +1168,32 @@ test_expect_success $PREREQ '--force sends cover letter template anyway' '
>  	test -n "$(ls msgtxt*)"
>  '
>  
> +test_expect_success $PREREQ 'sendemail.aliasfiletype=mailrc' '
> +	clean_fake_sendmail &&
> +	echo "alias sbd  somebody@example.org" >.mailrc &&
> +	git config --replace-all sendemail.aliasesfile "$(pwd)/.mailrc" &&
> +	git config sendemail.aliasfiletype mailrc &&
> +	git send-email \
> +	  --from="Example <nobody@example.com>" \
> +	  --to=sbd \
> +	  --smtp-server="$(pwd)/fake.sendmail" \
> +	  outdir/0001-*.patch \
> +	  2>errors >out &&
> +	grep "^!somebody@example\.org!$" commandline1
> +'
> +
> +test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
> +	clean_fake_sendmail &&
> +	echo "alias sbd  someone@example.org" >~/.mailrc &&
> +	git config --replace-all sendemail.aliasesfile "~/.mailrc" &&
> +	git config sendemail.aliasfiletype mailrc &&
> +	git send-email \
> +	  --from="Example <nobody@example.com>" \
> +	  --to=sbd \
> +	  --smtp-server="$(pwd)/fake.sendmail" \
> +	  outdir/0001-*.patch \
> +	  2>errors >out &&
> +	grep "^!someone@example\.org!$" commandline1
> +'
> +
>  test_done
