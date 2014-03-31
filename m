From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] patch-id-test: test --stable and --unstable flags
Date: Mon, 31 Mar 2014 12:29:04 -0700
Message-ID: <xmqqioqu5fr3.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<1396202583-2572-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:29:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhtZ-0002xP-Di
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaCaT3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:29:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42793 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbaCaT3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:29:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B1B678791;
	Mon, 31 Mar 2014 15:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A3mxH8Tuhp6gWbGGGrC0JYGSQ10=; b=wmOSsU
	aFZKfNIbglv8Xznv2xnymBQKsrfGnf3oS20DGgWlutke4fjmOYYKlCW2XrMkxwND
	lCThlFJUubnUkxycXoY4hG+ivECSiJdRLCHkl/1JbFBlMHu9JzjOkfjdPyuWEqZA
	6ZawtNK61a7nG8HsLaQf7+Tz2uWuGZgSyDF5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzvkTR4YvggtgP3GJISwc86LdmCwTBCZ
	okmTQFafk9RCOEOXITRTcVj19ms5VArh0+cEHpRfnJqEsYqlPYXB1d2+rMAKKrxH
	sXONfSyR12jEca36t2GTy8KwXoWReYlYF/7ZtifsUi4zsGTMDozYQBKX2K0fEwqi
	k1J6NoOSM3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1880D78790;
	Mon, 31 Mar 2014 15:29:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 411C978789;
	Mon, 31 Mar 2014 15:29:06 -0400 (EDT)
In-Reply-To: <1396202583-2572-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Sun, 30 Mar 2014 21:09:29 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B969DBA8-B90A-11E3-8C3F-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245515>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Verify that patch ID is now stable against diff split and reordering.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Changes from v2:
> 	added test to verify patch ID is stable against diff splitting
>
>  t/t4204-patch-id.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 109 insertions(+), 8 deletions(-)
>
> diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
> index d2c930d..1679714 100755
> --- a/t/t4204-patch-id.sh
> +++ b/t/t4204-patch-id.sh
> @@ -5,12 +5,46 @@ test_description='git patch-id'
>  . ./test-lib.sh
>  
>  test_expect_success 'setup' '
> -	test_commit initial foo a &&
> -	test_commit first foo b &&
> -	git checkout -b same HEAD^ &&
> -	test_commit same-msg foo b &&
> -	git checkout -b notsame HEAD^ &&
> -	test_commit notsame-msg foo c
> +	cat > a <<-\EOF &&

Please do not add an extra space between the redirection operator
(e.g. ">", "2>", etc.) and its operand.  The same style violations
everywhere in this patch.

> +		a
> +		a
> +		a
> +		a
> +		a
> +		a
> +		a
> +		a
> +		EOF

Please align EOF with the cat that receives it, and pretend that the
column the head of the cat is at is the leftmost column for the
payload, when writing <<- here-document, e.g.

        cat >a <<-\EOF &&
        a
        EOF

> +	(cat a; echo b) > ab &&
> +	(echo d; cat a; echo b) > dab &&
> +	cp a foo &&
> +	cp a bar &&

Probably a helper function would make it more apparent what is going
on?

	as="a a a a a a a a" && # eight a
	test_write_lines $as b >ab &&
	test_write_lines d $as b >dab &&
        test_write_lines $as >foo &&
        test_write_lines $as >bar &&

Or even better, use test_write_lines in places you do use the result
to overwrite foo/bar and get rid of ab and dab?

That helper can also be used to prepare bar-then-foo.

>  test_expect_success 'patch-id output is well-formed' '
> @@ -23,11 +57,33 @@ calc_patch_id () {
>  		sed "s# .*##" > patch-id_"$1"
>  }
>  
> +calc_patch_id_unstable () {
> +	git patch-id --unstable |
> +		sed "s# .*##" > patch-id_"$1"

Not a new problem, but can you align "git patch-id" and "sed" to the
same column?  Also, not using "/" when there is no slash involved in
the pattern makes readers waste their time wondering why the script
avoids it.

> +}
> +
> +calc_patch_id_stable () {
> +	git patch-id --stable |
> +		sed "s# .*##" > patch-id_"$1"
> +}
> +
> +

Extra blank line.

>  get_patch_id () {
> -	git log -p -1 "$1" | git patch-id |
> +	git log -p -1 "$1" -O bar-then-foo -- | git patch-id |
>  		sed "s# .*##" > patch-id_"$1"
>  }
>  
> +get_patch_id_stable () {
> +	git log -p -1 "$1" -O bar-then-foo | git patch-id --stable |
> +		sed "s# .*##" > patch-id_"$1"

Why doesn't it use calc_patch_id_stable?

> +}
> +
> +get_patch_id_unstable () {
> +	git log -p -1 "$1" -O bar-then-foo | git patch-id --unstable |
> +		sed "s# .*##" > patch-id_"$1"

Ditto.

> +}
> +
> +

Extra blank line.

>  test_expect_success 'patch-id detects equality' '
>  	get_patch_id master &&
>  	get_patch_id same &&
> @@ -52,10 +108,55 @@ test_expect_success 'patch-id supports git-format-patch output' '
>  test_expect_success 'whitespace is irrelevant in footer' '
>  	get_patch_id master &&
>  	git checkout same &&
> -	git format-patch -1 --stdout | sed "s/ \$//" | calc_patch_id same &&
> +	git format-patch -1 --stdout | sed "s/ \$//" |
> +		calc_patch_id same &&

What is this change about?
