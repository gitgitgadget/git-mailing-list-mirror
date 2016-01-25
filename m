From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/19] mingw: avoid absolute path in t0008
Date: Sun, 24 Jan 2016 18:11:02 -0800
Message-ID: <xmqq60yibe89.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 03:11:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNWcZ-0000dn-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 03:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbcAYCLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 21:11:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754303AbcAYCLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 21:11:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC0E53F459;
	Sun, 24 Jan 2016 21:11:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ESiSowAYutk2mY7f3mnp2WCgke8=; b=hQ0fo0
	8oyQuDtiOAmROHoO+oph6cebWdV2038RaBNyMeqnMQ0ou8afGnL40PuHCXPYcHA8
	pXiL5THqstRh5nxy4/mzogBxxtwJDpV4q0YadN/CY3xtx9FbTAONuKiSlJF1R9NJ
	8CMTuPJ6w3ZidU5YeADpHxkHa+hmfNoJHo0a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Or8Roqs14aE1QlQpolKLANOxoLxCGT8p
	kW5doHpz5B+O3ER7sCpuj4hE0x+uik7vehEXnvuH9DsZAaEE2hIMhBQ+hkXUFrH9
	1bQSqweI4CU0U+H7VVU+ucvf5/fpWxcKlNcJn3Fw5LTO7//OKpEi0UI0WBNO7HSt
	k8NNsI7XY5s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B26EF3F458;
	Sun, 24 Jan 2016 21:11:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2867C3F456;
	Sun, 24 Jan 2016 21:11:04 -0500 (EST)
In-Reply-To: <7c35a7b9c65d9febb6af1b50907988974bca3fbd.1453650173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Sun, 24 Jan 2016 16:45:22 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E317DD7E-C308-11E5-9303-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284710>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>
> The test separator char is a colon which means any absolute paths on
> Windows confuse the tests that use global_excludes.
>
> Suggested-by: Karsten Blees <karsten.blees@gmail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0008-ignores.sh | 8 +++++++-

Is the fact that $global_excludes is specified using an absolute
path significant to the correctness of this test script?  This patch
suggests me that it is not (i.e. if the tests chdir's around, then
relative reference to global-excludes file would not work at all,
but apparently tests run with MINGW prereq does not exhibit such an
issue, so the remainder of the test would see the file we want it
see with the relative reference just fine).

And in that case, I think it would be more correct to use the
"global-excludes in the current directory" definition regardless of
MINGW prerequisite.  Adding a comment that says "The value of this
variable is a colon separated list, so avoid absolute path, because
..." is a very welcome addition while doing so.

A larger question is if it would make more sense for Git ported to
Windows environment to use semicolon (that is the element separator
for %PATH% in the Windows land, right?) instead where POSIXy port
would use colon as the separator.  A variable that is a list of
locations (e.g. $PATH) makes little sense when elements can only be
relative paths in practice.

>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 4ef5ed4..68749f5 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -5,7 +5,13 @@ test_description=check-ignore
>  . ./test-lib.sh
>  
>  init_vars () {
> -	global_excludes="$(pwd)/global-excludes"
> +	# On Windows, avoid using "C:" in the global-excludes paths.
> +	if test_have_prereq MINGW
> +	then
> +		global_excludes="global-excludes"
> +	else
> +		global_excludes="$(pwd)/global-excludes"
> +	fi
>  }
>  
>  enable_global_excludes () {
