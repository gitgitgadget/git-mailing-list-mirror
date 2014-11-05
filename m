From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] t3312-notes-empty: Test that 'git notes' removes empty notes by default
Date: Wed, 05 Nov 2014 11:00:08 -0800
Message-ID: <xmqqmw85o4lj.fsf@gitster.dls.corp.google.com>
References: <1415176347-18694-1-git-send-email-johan@herland.net>
	<1415176347-18694-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 20:00:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm5oh-0004BO-8u
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 20:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbaKETAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 14:00:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751617AbaKETAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 14:00:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 503C51B870;
	Wed,  5 Nov 2014 14:00:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrZuRLiSGuADgPceAnw9676mWMw=; b=ij5Zlc
	h9pJn3zn4jcvJOTGjWm64tHAb4WVvhH2qS04Yo+cLV2zbudGO6QpWXZjHY1IfAzs
	cGEXHqdbr7upoScn4N/9VWT4IML4NWg3PtkaYlT1iaRfNHQepSFqni5OJkdL41NI
	1rr4nN58R1mDYeTj7E8ShhFFgUFJvhNkObwZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GZ+RI7d/HJm0Ns9lrdAd4AhtwY2jkegC
	kFDedc/YAdMZXoOG1iyCXLB3TvvzfjhWZq5db8ThEi/XqSLu0G3psZDYjyanRYGu
	5KvKzKovCuI7WdWmkGgkbhzJU/s11ego1qKFVZaYZsvmYWaNpG7ygKlO5j3ag6KF
	dhFLNA6QsDI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 468651B86E;
	Wed,  5 Nov 2014 14:00:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14B271B838;
	Wed,  5 Nov 2014 14:00:10 -0500 (EST)
In-Reply-To: <1415176347-18694-2-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 5 Nov 2014 09:32:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F715EA36-651D-11E4-9781-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Add test cases documenting the current behavior when trying to
> add/append/edit empty notes. This is in preparation for adding
> --allow-empty; to allow empty notes to be stored.
>
> Improved-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  t/t3312-notes-empty.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100755 t/t3312-notes-empty.sh
>
> diff --git a/t/t3312-notes-empty.sh b/t/t3312-notes-empty.sh
> new file mode 100755
> index 0000000..44074f6
> --- /dev/null
> +++ b/t/t3312-notes-empty.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='Test adding/editing of empty notes'
> +. ./test-lib.sh
> +
> +write_script fake_editor <<\EOF
> +	echo "$MSG" >"$1"
> +EOF
> +GIT_EDITOR=./fake_editor
> +export GIT_EDITOR
> +
> +test_expect_success 'setup' '
> +	test_commit one &&
> +	git log -1 >expect_missing &&
> +	empty_blob=$(git hash-object -w /dev/null)
> +'

> +cleanup_notes() {
> +	git update-ref -d refs/notes/commits
> +}
> +
> +verify_missing() {
> +	git log -1 > actual &&

Hmph, it was unclear what exactly you are trying to check with this
one and the other "git log -1 >expect_missing".

Perhaps a comment that says "We are interested in the trailing
'Notes: ...' in the output" is necessary here, or (probably even
better) use the --format='%N' to make it crystal clear?

> +	test_cmp expect_missing actual &&
> +	! git notes list HEAD

Isn't this test_must_fail (i.e. if somebody screws up to make "git
notes list" segfault, the test should fail, not taking the dying
with SEGV as a sign of success)?

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

Perhaps just a taste issue, but I would think

	while read cmd
        do
        	... that test eval with $cmd interpolation ...
	done <<-\EOF
        add
        add -F /dev/null
        ...
        EOF

would be easier to maintain and to read, without having to worry
about quoting and backslashing.

> +
> +test_done
