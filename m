From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3312-notes-empty: Test that 'git notes' removes empty notes by default
Date: Wed, 05 Nov 2014 10:36:17 -0800
Message-ID: <xmqqr3xho5pa.fsf@gitster.dls.corp.google.com>
References: <1415151175-1682-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 19:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm5RW-0000Tm-MK
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 19:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaKESgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 13:36:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751244AbaKESgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 13:36:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EF161B288;
	Wed,  5 Nov 2014 13:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EwZZP9MgVSEOObE/kVZDkngzQmc=; b=JQqmBx
	vlfDhHV9kIKq6Nv27lUNPeJDWJf2Tp53fCesddKbDc8ByoINvfozL2m5PbGqNzjZ
	oMdNEn9Kul5wmyNPuvL1C3LQWvavCOWGGCYaL4EJxAbajsC/Oo7/a8nN9IBqdfor
	AGep/TzBTZvLAGSNj8JetymOkg6uWac77hPBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGuIpMlc9U396Y2vaCpYTJpw5p1dge6A
	8a8QnTQOrZOeMwUT/4Qfsp1rfI0C/P/ZvH2OP+ea/VTAtXRHRRTIs1xyOjl2Leld
	tjIrqp2GXbBBMAWHDceDFHPJemDxohyKGae9ELkjpYwSN32VBd/Sn2Bk4R3tKpsJ
	chm5IcceSH0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25B3D1B287;
	Wed,  5 Nov 2014 13:36:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D36E1B286;
	Wed,  5 Nov 2014 13:36:18 -0500 (EST)
In-Reply-To: <1415151175-1682-1-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 5 Nov 2014 02:32:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1D44BE2-651A-11E4-A4BA-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Add test cases documenting the current behavior when trying to
> add/append/edit empty notes. This is in preparation for adding
> --allow-empty; to allow empty notes to be stored.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  t/t3312-notes-empty.sh | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100755 t/t3312-notes-empty.sh

By definition, an empty note is empty ;-) and devoid of useful
information other than a single bit, its existence.  I would
understand a handful of tests that check "oh by the way, we should
also handle empty ones sensibly", but are you sure that a _new_
separate test script, not addition to existing test script, is worth
to check _only_ empty notes?

> diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
> new file mode 100755
> index 0000000..2806d27
> --- /dev/null
> +++ b/t/t3312-notes-empty.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description='Test adding/editing of empty notes'
> +. ./test-lib.sh
> +
> +cat >fake_editor.sh <<\EOF
> +#!/bin/sh
> +echo "$MSG" >"$1"
> +echo "$MSG" >& 2
> +EOF
> +chmod a+x fake_editor.sh
> +GIT_EDITOR=./fake_editor.sh
> +export GIT_EDITOR
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	empty_blob=$(git hash-object -w /dev/null)
> +'
> +
> +cleanup_notes() {
> +	git update-ref -d refs/notes/commits
> +}
> +
> +cat >expect_missing <<\EOF
> +commit d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
> +Author: A U Thor <author@example.com>
> +Date:   Thu Apr 7 15:13:13 2005 -0700
> +
> +    one
> +EOF
> +
> +verify_missing() {
> +	git log -1 > actual &&
> +	test_cmp expect_missing actual &&
> +	! git notes list HEAD
> +}
> +
> +for cmd in \
> +	'add' \
> +	'add -F /dev/null' \
> +	'add -m ""' \
> +	'add -c "$empty_blob"' \
> +	'add -C "$empty_blob"' \
> +	'append' \
> +	'append -F /dev/null' \
> +	'append -m ""' \
> +	'append -c "$empty_blob"' \
> +	'append -C "$empty_blob"' \
> +	'edit'
> +do
> +	test_expect_success "'git notes $cmd' removes empty note" "
> +		cleanup_notes &&
> +		MSG= git notes $cmd &&
> +		verify_missing
> +	"
> +done
> +
> +test_done
