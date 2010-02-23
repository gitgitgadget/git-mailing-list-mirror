From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: fix 'git pull --all' when current branch is
 tracking remote that is not last in the list of remotes
Date: Tue, 23 Feb 2010 15:02:59 -0800
Message-ID: <7vtyt75zdo.fsf@alter.siamese.dyndns.org>
References: <1266965731-4208-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:03:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3md-0006IF-0x
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab0BWXDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:03:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489Ab0BWXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:03:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED9409CC06;
	Tue, 23 Feb 2010 18:03:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=ODUbVV5QE8jVQ5YllsrOeIxXX00=; b=H5AOet
	JdDpX+kW+zNEgwGgtaIvOU09eKDnDvQMk0lGezTQI/qwJo8ou+xaRajZLDF+YjIE
	ELo49P40uySmF8hHrkZ+h5OiYC6rsbeWXPcoXG1B66ospbjkUDnWh2/9xQc35VdQ
	lUMliSyAmlZMAOKkbMwwYAkPmzTFv2/LProtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EI7oLUZASJ+X2WLsGyIR2NaumtSmu4XL
	VTyMiu2LaKO3AjatLbLnCn53NpHE82GxJm/LkOkwjsrDrZaeilmoVPxsqlgp60ww
	Ei4MWoiT1JoUpVtquCa2YuUoYOSEQV6R+W1ZFRFeBAOtk9vQSQ7TKWsIpVggFyxo
	UFOBSO023bk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB6989CC05;
	Tue, 23 Feb 2010 18:03:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3201D9CC04; Tue, 23 Feb
 2010 18:03:01 -0500 (EST)
In-Reply-To: <1266965731-4208-1-git-send-email-michael.lukashov@gmail.com>
 (Michael Lukashov's message of "Tue\, 23 Feb 2010 22\:55\:31 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98C7D35A-20CF-11DF-A05E-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140865>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> diff --git a/git-pull.sh b/git-pull.sh
> index 38331a8..fcde096 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -214,7 +214,11 @@ test true = "$rebase" && {
>  	done
>  }
>  orig_head=$(git rev-parse -q --verify HEAD)
> -git fetch $verbosity --update-head-ok "$@" || exit 1
> +if test -e "$GIT_DIR"/FETCH_HEAD
> +then
> +	rm "$GIT_DIR"/FETCH_HEAD 2>/dev/null
> +fi

When is it sane to ignore an error from this "rm", especially after you
made sure that it exists?
