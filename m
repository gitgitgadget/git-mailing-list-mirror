From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6041: do not compress backup tar file
Date: Mon, 09 May 2016 11:46:46 -0700
Message-ID: <xmqq8tzjul0p.fsf@gitster.mtv.corp.google.com>
References: <1462813748-27538-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, megabreit@googlemail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 09 20:50:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azqCs-0005hn-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbcEISqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 14:46:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751961AbcEISqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 14:46:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8967218FD0;
	Mon,  9 May 2016 14:46:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yqqmrIntGU6Q+hwkfiu9HIU+170=; b=mooYU9
	wFDoGCECPRS3Py1yN7hGdMKK8RQQE9scQ7ktNKdLpGoE/JRLJruSNklQN1wZCtcT
	G03q5icMX5RHgx0NuhpvCLv206ZA+NRjM3TT1kDYsXPDuOLm4KznzYv9nvOEX+aa
	JSslxFRI3D4NdKyXOjqA0fRiB3lITShz3uNB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vwbR8TiW7mTgNvh6GxfEM22YuqBmwkvX
	TOyeWI99OozlSExkmfOd0ksT6wcMYOGE06ITCQDKh8XO4xEfY0j+14uPK4j/JuYq
	hcuNMcdDEkmQzzJjh6kwZIIY/zq9qz1wV46kr0XQvKAPPN8sRn1T+UQNi4FXD9Wx
	LoA/5j5Zs5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 806C818FCF;
	Mon,  9 May 2016 14:46:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A12018FCB;
	Mon,  9 May 2016 14:46:47 -0400 (EDT)
In-Reply-To: <1462813748-27538-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 9 May 2016 10:09:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6296E83C-1616-11E6-8CEB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294038>

Stefan Beller <sbeller@google.com> writes:

> diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
> index c6b7aa6..62b8a2e 100755
> --- a/t/t6041-bisect-submodule.sh
> +++ b/t/t6041-bisect-submodule.sh
> @@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
>  git_bisect () {
>  	git status -su >expect &&
>  	ls -1pR * >>expect &&
> -	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
> +	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
>  	GOOD=$(git rev-parse --verify HEAD) &&
>  	git checkout "$1" &&
>  	echo "foo" >bar &&
> @@ -20,7 +20,7 @@ git_bisect () {
>  	git bisect start &&
>  	git bisect good $GOOD &&
>  	rm -rf * &&
> -	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
> +	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
>  	git status -su >actual &&
>  	ls -1pR * >>actual &&
>  	test_cmp expect actual &&

While I am fine with taking this (and the other) change, which are
the only sensible response to these bug reports, this makes me
wonder two things and a half.

 * Why do we even run "tar", especially without having a
   test_when_finished clean-up?  Can't there be better ways to test
   this and the other one without creating a copy of everything in
   the test directory?

 * Are we sure the trash directory contents is kept manageable size?
   I am primarily worried about this "we are not sure what we will
   be clobbering, so let's blindly tar up everything and restore it
   later" pattern spreading and people mistakenly use it in tests
   that simulate our behaviour on a huge blob with a sparse but
   gigantic file.

 * Is an addition of 'test_snapshot $tarball *' and 'test_restore
   $tarball' pair too much unnecessary refactoring to cater to only
   two users of this "let's tar up everything" pattern, given that
   we want to _discourage_ use of this pattern in the longer term?
