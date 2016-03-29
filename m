From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] submodule foreach: correct path computation in recursive submodules
Date: Mon, 28 Mar 2016 22:44:58 -0700
Message-ID: <xmqq60w525yd.fsf@gitster.mtv.corp.google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 07:45:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akmSp-0006Ux-38
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 07:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbcC2FpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 01:45:05 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751986AbcC2FpE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 01:45:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C7AA455A8;
	Tue, 29 Mar 2016 01:45:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0wYavWDPg3MZRw5CUY1ylLMtQhg=; b=yaoj3O
	692mNFxlszFEZSCBGNX3Ec+Qd0M47vklUXIQIhs3tYFk5eriTIKhzrrqKMNDKEPp
	evoUGA0Bc7rfwtNPhuecWk/b4lsf1ktAJIQ2pQmEgiyBUNPuXEQY+uxgoVpXO/km
	ukA2ZWRI5gEzz5C8ebtwcsChw3pmvwC/WOo0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8CC48jcAg8W158Rw9LEit5dhsH8cBIo
	PKw+NFlShXtsCglRyMo9ciPkaKVnBtg5uAUX4QRGseLP4eNeHdF9HgJISldDQR//
	NXrJtmL4YrDj0CpcDmFt/v9bUuzPUBSGj9AXNWj08NtwN/hCa4ipxlufm1l8JpFx
	TSEecJCNFvg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 102F4455A3;
	Tue, 29 Mar 2016 01:45:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0676455A2;
	Tue, 29 Mar 2016 01:44:59 -0400 (EDT)
In-Reply-To: <1459207703-1635-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Mar 2016 16:28:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 603210E6-F571-11E5-BD32-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290101>

Stefan Beller <sbeller@google.com> writes:

> The test which is fixed by this patch would report
>     Entering 'nested1/nested2/../nested3'
> instead of the expected
>     Entering '../nested1/nested2/nested3'
>
> because the prefix is put unconditionally in front and after that a
> computed display path with is affected by `wt_prefix`. This is wrong as
> any relative path computation would need to be at the front. By emptying
> the `wt_prefix` in recursive submodules and adding the information of any
> relative path into the `prefix` this is fixed.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Nicely explained and executed.

FWIW, it is fine to have a fix and new tests to demonstrate the fix
to pre-existing breakages in a single step.  It is easier to review
when we can see the body of the test (as opposed to just the change
s/expect_failure/expect_success/) in the same patch as the change to
the code for a focused and small fix like these patches 1 & 2; it is
easy to partially revert the patch for such a focused and small fix
when a reviewer wants to verify that the new tests fail without the
code change.

>  git-submodule.sh             | 3 ++-
>  t/t7407-submodule-foreach.sh | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..2838069 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -417,10 +417,11 @@ cmd_foreach()
>  			say "$(eval_gettext "Entering '\$prefix\$displaypath'")"
>  			name=$(git submodule--helper name "$sm_path")
>  			(
> -				prefix="$prefix$sm_path/"
> +				prefix="$(relative_path $prefix$sm_path)/"

Make sure that "$prefix$sm_path" is given as a single string to
relative_path.  I'd probably write this like so:

-				prefix="$prefix$sm_path/"
+				prefix=$(relative_path "$prefix$sm_path")/

Thanks.
