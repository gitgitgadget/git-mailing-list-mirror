From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t4041 (diff-submodule-option): rewrite add_file()
 routine
Date: Tue, 27 Nov 2012 09:56:54 -0800
Message-ID: <7vlidnlyjd.fsf@alter.siamese.dyndns.org>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
 <1354005692-2809-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPPE-0004ws-SN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab2K0R46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:56:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514Ab2K0R45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:56:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E6DA996;
	Tue, 27 Nov 2012 12:56:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ir2J7w7Lg6dSnF2Cw4r1xboUQPc=; b=kWJo6b
	tShyP+v1uIzG9YK2l0dUVarnQDebgcQuvHj84IAHCrQMKBbH6+Cl0IHNf6s6WJQX
	Io2U3H9b3lyrhZYGRN5EtR7Vx3/Tm40Mjx0uCeVs7IMlVgyRsiS9CfQn+TANyHjw
	mqS1YAaaaeFEKycut4JucDeWb9+lgBz7qjTCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+u8w9j4K0lSt3/kFMugP3tsuMrz3U1n
	E5aer319fPEYOs5mJ7jfN/rm6pgNNlgxVDmpfi8DDPrwlZqXuVvVq4F++1VhSeD/
	Cj8tAZi03sIqEghrR7H4N3lMs4DDAKi4Wq+jo9SXGhNj/WObyr1RSgra6UI58zyL
	qOmeriR8LXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF8ACA995;
	Tue, 27 Nov 2012 12:56:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4723EA993; Tue, 27 Nov 2012
 12:56:56 -0500 (EST)
In-Reply-To: <1354005692-2809-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 27 Nov 2012 14:11:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D54A2DA8-38BB-11E2-B60E-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210581>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Instead of "cd there and then come back", use the "cd there in a
> subshell" pattern.  Also fix '&&' chaining in one place.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t4041-diff-submodule-option.sh |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index cfb71e5..103c690 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -11,18 +11,15 @@ This test tries to verify the sanity of the --submodule option of git diff.
>  . ./test-lib.sh
>  
>  add_file () {
> +	(cd "$1" &&
> +	    shift &&
> +	    for name; do
>  		echo "$name" > "$name" &&
>  		git add "$name" &&
>  		test_tick &&
>  		git commit -m "Add $name"
> +	    done >/dev/null &&
> +	    git rev-parse --short --verify HEAD)

While at it, why not do the "indent with a single tab", and other
style fixes?  e.g.

	(
		cd "$1" &&
                shift &&
                for name
                do
			echo "$name" >"$name" &&
                        git add $name" &&
                        test_tick &&
                        git commit -m "Add $name" || exit
		done >/dev/null &&
		git rev-parse --short --verify HEAD
	)

The "|| exit" is needed to catch failures inside the loop (not that
"git commit" there is likely to fail, so it is just for
completeness).
