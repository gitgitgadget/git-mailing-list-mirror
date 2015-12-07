From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] git.c: make sure we do not leak GIT_* to alias scripts
Date: Mon, 07 Dec 2015 10:54:17 -0800
Message-ID: <xmqqzixmm6na.fsf@gitster.mtv.corp.google.com>
References: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
	<1449329538-18623-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sbeller@google.com, asottile@umich.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 19:54:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a60vY-00051u-Q3
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 19:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbbLGSyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 13:54:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755400AbbLGSyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 13:54:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6A33A31B65;
	Mon,  7 Dec 2015 13:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VOoRJUSGQ38w
	9ZTXS1EqIoDcPV0=; b=Q0Luw1soPh30xvJRr9rcwehbDRn8WfBTCLos8/+Eghj2
	MeyxpBJY0I27X2VRM4ahIXS/SHnFNSPzFBzGFEN7jPzhv/shm/0x7dpyM+LKNQDJ
	K5C6Mzv3L+CajWGIuSkhn0D8rgTM1Xp1Ps/N0UIgeBXAfaKz5wjHlXhMZRKT04s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R0UmuC
	n5h8xqq15WLNQdPn07jhn51JHQSt1p6TTAC/cdPKTZLz/BQ9Jcb7ZdzPOr0Ic81v
	x66D2XD3d/gdT8UQg+DYxcRuMthwrSQcINdEo+053FOuZTDSF27t6Q7OxR4/cUsX
	WCUESq7cI2FCBowT6g5UxOtfhkX+ojYkZa/x8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F41831B64;
	Mon,  7 Dec 2015 13:54:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CA67E31B5F;
	Mon,  7 Dec 2015 13:54:18 -0500 (EST)
In-Reply-To: <1449329538-18623-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 5 Dec
 2015 16:32:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBAA9DDE-9D13-11E5-BE35-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282105>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  Let's hope there will be no third report about this commit..

Hmm, why does this additional test fail only under prove but pass
without it?
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f91bbcf..19539fc 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -87,6 +87,33 @@ test_expect_success 'plain nested in bare through =
aliased command' '
>  	check_config bare-ancestor-aliased.git/plain-nested/.git false unse=
t
>  '
> =20
> +test_expect_success 'No extra GIT_* on alias scripts' '
> +	cat <<-\EOF >expected &&
> +	GIT_ATTR_NOSYSTEM
> +	GIT_AUTHOR_EMAIL
> +	GIT_AUTHOR_NAME
> +	GIT_COMMITTER_EMAIL
> +	GIT_COMMITTER_NAME
> +	GIT_CONFIG_NOSYSTEM
> +	GIT_EXEC_PATH
> +	GIT_MERGE_AUTOEDIT
> +	GIT_MERGE_VERBOSITY
> +	GIT_PREFIX
> +	GIT_TEMPLATE_DIR
> +	GIT_TEXTDOMAINDIR
> +	GIT_TRACE_BARE
> +	EOF
> +	cat <<-\EOF >script &&
> +	#!/bin/sh
> +	env | grep GIT_ | sed "s/=3D.*//" | sort >actual

This is more about coding discipline than style, but piping grep
output to sed is wasteful.  "sed -ne '/^GIT_/s/=3D.*//p'" or something
like that, perhaps?

I wondered what happens if the user has an unrelated stray variable
whose name happens to begin with GIT_ in her environment, but it
turns out that we cleanse them in test-lib.sh fairly early, so that
would be fine.  You need to tighten your "grep" pattern, though.

> +	exit 0
> +	EOF
> +	chmod 755 script &&
> +	git config alias.script \!./script &&
> +	( mkdir sub && cd sub && git script ) &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'plain with GIT_WORK_TREE' '
>  	mkdir plain-wt &&
>  	test_must_fail env GIT_WORK_TREE=3D"$(pwd)/plain-wt" git init plain=
-wt
