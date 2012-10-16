From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] test-lib: allow variable export from lazy prereq
 tests
Date: Tue, 16 Oct 2012 09:16:36 -0700
Message-ID: <7vipaatmsb.fsf@alter.siamese.dyndns.org>
References: <k5gq60$q8c$1@ger.gmane.org>
 <ca07c5a1cf836826fc0ee53daf3e7f3dfe111ece.1350387132.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joachim Schmitz <jojo@schmitz-digital.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9p5-0007WQ-EA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab2JPQQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 12:16:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab2JPQQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:16:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4809B8A41;
	Tue, 16 Oct 2012 12:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+OVm9eFTsmrhZX9kKiydxM7yebw=; b=H0WR++
	lxVIpXQFLkK6bCWs69w3UTjdFtxr+NW5hfzq34THeP2Ma/wOMkMOrz9mSEf+3U5D
	Sir6jP9sGqTvl8FzYN43zmjUwGZcV/zlo0zKRehYiWKmlVauleCfestMEBN0jPC9
	QxUoV6McNcWbt4sKWAnUhEgCzyKQIXc1eEhHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ykcVQQO4NuKp3uXQxxapwAwNvHMpgrgl
	y9uULV7vvKH8/15tdq6ahQd/P3qDjiFMp5dogLLzGIi3V1v1Zm7gS0fxZVQiqVtn
	WcC2FrAzPk89/4nFE6ziFFV9CNfu5at7KQr4e4nbenSPLoe42cNiz7M2/NenSbyf
	b71hV0KVRMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 362138A3E;
	Tue, 16 Oct 2012 12:16:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87CE88A3D; Tue, 16 Oct 2012
 12:16:38 -0400 (EDT)
In-Reply-To: <ca07c5a1cf836826fc0ee53daf3e7f3dfe111ece.1350387132.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 16 Oct 2012 13:39:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD174596-17AC-11E2-BE2C-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207842>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I don't think this has any adverse side effects, but I'm begging for
> another set of eyeballs to have a look. (Test suite passes, of course.)

The lazy prereqs are designed to be used lazily, in any test that he
who wrote lazy-prereq did not anticipate.  It is run inside a subshell
to make it absolutely sure that whatever it does (like use of shell
variables, chdir around) will not be able to affect _any_ calling
context that is not anticipated by who writes lazy prerequisite.

Please don't do this.

>
>  t/test-lib-functions.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8889ba5..e587902 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -246,13 +246,15 @@ test_lazy_prereq () {
>  test_run_lazy_prereq_ () {
>  	script='
>  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
> -(
> +{
>  	cd "$TRASH_DIRECTORY/prereq-test-dir" &&'"$2"'
> -)'
> +}'
>  	say >&3 "checking prerequisite: $1"
>  	say >&3 "$script"
> +	orig_pwd="$(pwd)"
>  	test_eval_ "$script"
>  	eval_ret=$?
> +	cd "$orig_pwd"
>  	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
>  	if test "$eval_ret" = 0; then
>  		say >&3 "prerequisite $1 ok"
