From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] tests: test credential-store XDG support
Date: Tue, 03 Mar 2015 23:08:47 +0100
Message-ID: <vpqegp53f9s.fsf@anie.imag.fr>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
	<1425414299-24000-3-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSuzo-0008Dd-46
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbbCCWIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 17:08:52 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54242 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbbCCWIv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 17:08:51 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t23M8iHb019298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 23:08:44 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23M8lt5024030;
	Tue, 3 Mar 2015 23:08:47 +0100
In-Reply-To: <1425414299-24000-3-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 4 Mar 2015 04:24:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Mar 2015 23:08:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23M8iHb019298
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426025324.8866@0+vwtq+UrcwmKPCrLMoU8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264696>

Paul Tan <pyokagan@gmail.com> writes:

> +# Tests for when $XDG_CONFIG_HOME/git/credentials exists but
> +# ~/.git-credentials does not.

As much as possible, put text in the $1 of test_expect_success instead
of comments.

> +rm "$HOME/.git-credentials"
> +mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/git"
> +echo '' > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
> +helper_test store

Don't write code outside test_expect_success (read "Do's, don'ts &
things to keep in mind" in t/README).

> +test_expect_success '~/.git-credentials will not be created if XDG git-credentials exist' '
> +	test ! -e "$HOME/.git-credentials"
> +'

test_path_is_missing (see test-lib-functions.sh)

> +echo '' > "$HOME/.git-credentials"
> +echo '' > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"

Not even that outside test_expect_success ;-).

Also, no space after > (Documentation/CodingGuidelines).


> +test_expect_success 'Credentials are stored in XDG file if both XDG and HOME files exist' '
> +	check approve store <<-\EOF
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	read contents < "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
> +	test ! -z "$contents"
> +	read contents < "$HOME/.git-credentials"

No space after <.

> +	test -z "$contents"
> +'
> +test_expect_success 'Credentials from XDG file are used if the
> +	credentials exist in both XDG and HOME files' '

Blank line between tests please.

> +test_expect_success 'Credentials from both XDG and HOME files meeting the criteria are erased' '
> +	check reject $HELPER <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	EOF
> +	read contents < "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
> +	test -z "$contents"
> +	read contents < "$HOME/.git-credentials"
> +	test -z "$contents"
> +'

I'd rather do stg like

echo >expected
test_cmp expected "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
test_cmp expected $HOME/.git-credentials

so that a test failure shows a diagnosis.

Regards,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
