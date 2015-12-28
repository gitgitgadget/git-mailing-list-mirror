From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] apply: make sure check_preimage() does not leave empty file on error
Date: Mon, 28 Dec 2015 10:35:06 -0800
Message-ID: <xmqqbn9al8v9.fsf@gitster.mtv.corp.google.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
	<1451181092-26054-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 19:35:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDcdb-0007Eu-HM
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 19:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbbL1SfL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 13:35:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60198 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751354AbbL1SfJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 13:35:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DA4F35EAB;
	Mon, 28 Dec 2015 13:35:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZRVBDLSu/CaC
	iAhpfH6f1XLm7mQ=; b=vJZuvhHLikiBLTZBdjGM4lT2UbMl2vnfW3Ky3Yf2ayMD
	WF5xT23j1L9AxRFykLq4OSRXAgQ4VSRMhaxYBi6cEJXdRHY7LjQ+SAjKVcnE93JS
	X7zO1diNJXQVHhzyNaRgPfGWK5/brizYYvv77tznRMjqDeLyX5UvxcWIyZWblrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xhdkyD
	9r4moViq8ITLGeqGtXEs2h6OQcnWL2sd71ZL0cHPVOgeMHKWMP7VaYDQhG/eKAPe
	Cu4e2uynpiZiVKsIoND7NuBQEWM6OaS9BCUFJ+ysBDuZCXOBHxi+QyJnRGx6UziK
	pA9wM2Oc3uUVc45+NHTVEXn9PamRt7e4Y+At4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5587235EAA;
	Mon, 28 Dec 2015 13:35:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFAD635EA9;
	Mon, 28 Dec 2015 13:35:07 -0500 (EST)
In-Reply-To: <1451181092-26054-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:51:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B84DAE66-AD91-11E5-A34F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283042>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index bb5ef2b..96c8755 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -95,5 +95,21 @@ test_expect_success 'apply adds new file on i-t-a =
entry' '
>  	)
>  '
> =20
> +test_expect_success 'apply:check_preimage() not creating empty file'=
 '
> +	git init check-preimage &&
> +	(
> +		cd check-preimage &&
> +		echo oldcontent >newfile &&
> +		git add newfile &&
> +		echo newcontent >newfile &&
> +		git diff >patch &&
> +		rm .git/index &&
> +		git add -N newfile &&
> +		rm newfile &&
> +		test_must_fail git apply -3 patch &&
> +		! test -f newfile
> +	)
> +'

Unlike "apply --index" (and "apply" without any option to work on
working tree), "apply -3" is allowed to write to the working tree
even when it fails, if the failure comes from a merge conflict and
that is by design.  In this case, the patch expects that there is an
existing file with 'oldcontent' so it should try to do a three-way
merge to go from an 'unspecified' content (i.e. the current state in
the index) in a way similar to going from 'oldcontent' to
'newcontent', and because we _have_ to make sure that the path that
holds the 'unspecified' content is clean between the index and the
working tree--but an earlier "add -N" said that "the index knows
about the path, I am not telling what its contents are yet", by
definition the index and the working tree cannot match so the
application _must_ fail, before even attempting to do a three-way
merge, hence it should not touch the working tree.

So expecting a failure from "apply -3" sounds like the right thing
to do, and obviously it should not leave any "newfile".  The test
also must check that the index has not been modified since the last
"git add -N" (most notably, we want to see 'newfile' still has the
I-T-A bit on).

More interesting cases to test would be:

 - Instead of "rm newfile", have ">newfile" to empty the contents
   before applying the patch with "apply -3".  We should expect the
   same "apply -3 fails", but we should see an empty 'newfile' in
   the working tree.  The index must be the same as the last "git
   add -N".

 - Instead of "rm newfile", have "echo oldcontent >newfile".  What
   should "apply -3" do?  The patch would be applicable with "apply"
   without any argument (hence without involving the index), but
   "-3" requires 'check_index', and again any entry with I-T-A bit
   on by definition does not match between the index and the working
   tree, so the application must fail, I think.
