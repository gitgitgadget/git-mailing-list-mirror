From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] version-gen: cleanup
Date: Thu, 12 Sep 2013 23:10:32 -0700
Message-ID: <xmqqy571j7t6.fsf@gitster.dls.corp.google.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
	<1379035046-6688-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 13:10:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKRH3-0005UL-BS
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 13:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IMLKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 07:10:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59170 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab3IMLKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 07:10:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370063F182;
	Fri, 13 Sep 2013 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=53Hwv3fVrD5fQB8nK62FKhiTCwg=; b=YWbyybkfV7dTXg0N8cbY
	Gw2XlLKP5w+mBwtnVvwEARdzLHynORlJwn5v42t8L4Tih2gcBHSeZll5Z6VsKF86
	kYmiR4pViF8lBhfu/7gdLk/xEcEq5wd66JwFDLdvzupr+dICMnObqNXHFNlw+Uc6
	xIp1SIOHnUtsXQegJ3Zye0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IiiMXQROl5aGaYRPHdAsvnnsi0yYFFVgtE6hU+l/anYGB5
	AfJSnxtWlxRrlAerhoSPF2M7m7pG5fuaLXGgKheKrAID8+4AH2DPpvdhq2uIDwN/
	b/sZ1UfKjxgGqo/iWhKPnZm3AZvkhKyOG1PZSgKjZMREsxP04920n7381jl88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E25D3F181;
	Fri, 13 Sep 2013 11:10:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 886F03F17A;
	Fri, 13 Sep 2013 11:10:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 24307CC8-1C65-11E3-9CF0-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234742>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +describe () {
> +	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) || return 1
>  	case "$VN" in
> +	*$LF*)
> +		return 1
> +		;;
>  	v[0-9]*)
>  		git update-index -q --refresh
>  		test -z "$(git diff-index --name-only HEAD --)" ||
> +		VN="$VN-dirty"
> +		return 0
> +		;;
>  	esac
> +}
> +
> +# First see if there is a version file (included in release tarballs),
> +# then try 'git describe', then default.
> +if test -f version
> +then
> +	VN=$(cat version) || VN="$DEF_VER"
> +elif test -d ${GIT_DIR:-.git} -o -f .git && describe
>  then

Makes sense; using a helper function makes the primary logic easier
to read.

> -test "$VN" = "$VC" || {
> -	echo >&2 "GIT_VERSION = $VN"
> -	echo "GIT_VERSION = $VN" >$GVF
> -}
> -
> -
> +test "$VN" = "$VC" && exit
> +echo >&2 "GIT_VERSION = $VN"
> +echo "GIT_VERSION = $VN" >$GVF

The point of this part is "if the version file is already up to
date, do not rewrite it only to smudge the mtime to confuse make",
so it would be much easier to read to write it like so:

	if test "$VN" != "$VC"
        then
		... two echoes ...
	fi

compared to "exiting in the middle" which is harder to follow,
especially if we consider that we may have to grow the remaining two
lines in the future.
