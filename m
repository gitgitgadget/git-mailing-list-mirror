From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] tests: test credential-store XDG support
Date: Tue, 03 Mar 2015 15:11:21 -0800
Message-ID: <xmqqa8ztad7q.fsf@gitster.dls.corp.google.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 00:11:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvyK-0001Ud-6C
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 00:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757330AbbCCXLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 18:11:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757174AbbCCXLX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 18:11:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED2FF3DDBA;
	Tue,  3 Mar 2015 18:11:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xcGB4CdtNTRPtN08kUgwK2nPYA4=; b=QeL1xF
	0W/S6kI6ubCcx495GIUY6fIayiGBjbOCPHaqsRbTRzayfQ8Xw0MCnXetiq42DiRT
	bZPR/oW/Wny/B2QMWAvEHdlQXwi0efhK7gLdfYQaGAwDbcFAcSKIi035L81Ec9nU
	mL/c5MdH8cjaJ9IfRWFSky5J7ttixAqJhQWEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ychX333QvfZXJ+84FUY/Uf8Vw0uqWnEk
	BfG5woLH2dKfl50b8yhUhWCG4MGbok6Gk4A4WnVqjLK8ZkFUIZ4xSAVtQgsTWTcx
	8sQq1GK/uhHS4g1D6K9Lxa+UtZ2P0/MupwaWYda6EBfTaVd9I5zp1MzfGLM0Ejwx
	w5S8Ew02bYA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E67DB3DDB8;
	Tue,  3 Mar 2015 18:11:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 711DF3DDB6;
	Tue,  3 Mar 2015 18:11:22 -0500 (EST)
In-Reply-To: <1425414299-24000-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 4 Mar 2015 04:24:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B9D9EEE-C1FA-11E4-BF7A-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264703>

Paul Tan <pyokagan@gmail.com> writes:

> * "helper_test store" is run for when $XDG_CONFIG_HOME/git/credentials
>   exists and ~/.git-credentials does not and the other way around.
> * Test that credentials are stored in XDG file if both XDG and HOME
>   files exist.
> * Test that credentials from XDG file are used if matching credentials
>   are found in both XDG and HOME files.
> * Test that credentials from HOME file are used if a matching credential
>   could not be found in the XDG file.
> * Test that when erasing credentials, matching credentials in both the
>   XDG and HOME files are erase.d
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---

Again, I agree with everything Matthieu said ;-)

> +test_expect_success 'XDG credentials will not be created if it does not exist' '
> +	test ! -e "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
> +'

You repeat this ${XDG_CONFIG_HOME:-$HOME/.config} all over, but is
that necessary?  The test environment is under your control, so if
you know you have XDG_CONFIG_HOME at this point in the test, don't
use the fallback.  If you want to test _both_, on the other hand,
then test both in separate tests.

> +# Tests for when both $XDG_CONFIG_HOME/git/credentials and
> +# ~/.git-credentials exists.
> +echo '' > "$HOME/.git-credentials"
> +echo '' > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"

Do you need one empty line in each of these file, or is existence of
these two files what you care?  If the latter, then just redirect
into it without any command, like this:

	>"$HOME/.git-credentials"

> +test_expect_success 'Credentials are stored in XDG file if both XDG and HOME files exist' '
> +	check approve store <<-\EOF
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	read contents < "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
> +	test ! -z "$contents"

In an earlier part of this patch, you used "test -s FILE".  Do you
have to use "read $it && test [!] -z $it" here?

> +	read contents < "$HOME/.git-credentials"
> +	test -z "$contents"

Missing && everywhere (not just this test).

	check approve store <<-\EOF &&
        ...
        EOF
        read ... &&
        ...

If "check approve" exited with a non-zero status, that won't be
noticed as long as .../git/credentials file happens to have the
contents that passes the later part of the test, which is not what
we want.
