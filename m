From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Demonstrate a bug in --word-diff where
 diff.*.wordregex is "sticky"
Date: Wed, 14 Mar 2012 12:24:10 -0700
Message-ID: <7vsjhboujp.fsf@alter.siamese.dyndns.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7to3-0001j5-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2CNTYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:24:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab2CNTYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:24:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5770A6A36;
	Wed, 14 Mar 2012 15:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cdnJX4gV+AXgICb2JiH0N6EaeSo=; b=Kz+K/P
	mf+VaTqy28zn/IGvfKkASI7vfCNYifXi01+zn6wJDFiv4r2lHue3JhDaiRcJFv0Z
	/t21hGIkrHSvNpWl4Uye2/G6CwYlTe70GvN+3kcl2OhqP9a+7ofPRVWZu0tzgZZ0
	qDiM0UNfTGcTr5ENcXPgXhoPEBON8e3kRFSRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSJx6jZqWHRHulJpiYeoIuk81XFKSnR8
	WqylTLg9NVWsHZH5auJPlj+kNEJy+CKR3b+1H8bzhTcRVdrtsiPESVE1RLSdVjEr
	dDYfZoKFAuHqWR4hgyqpqYmdJMijuzm62WzWNfO0iA8ylEXhj/VhRDSR3SsLgqyB
	ZuA8rXy26PQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF5B6A35;
	Wed, 14 Mar 2012 15:24:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB8AE6A34; Wed, 14 Mar 2012
 15:24:11 -0400 (EDT)
In-Reply-To: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed, 14 Mar 2012 19:24:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47579C54-6E0B-11E1-B19E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193152>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>
> The test case applies a custom wordRegex to one file in a diff, and expects
> that the default word splitting applies to the second file in the diff.
> But the custom wordRegex is also incorrectly used for the second file.
>
> [tr: unset the diff.wordRegex variable to make the test meaningful]
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Compared to your version, I added the first hunk.  Otherwise the
> diff.wordRegex=[[:alnum:]]+ setting carries over and makes the test
> fail even with the bug fixed.
>
> I deliberately put it as early as possible, rather than into the setup
> for your test, to avoid confusion next time someone patches that file.
>
>  t/t4034-diff-words.sh |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index 5c20121..69e81f3 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -293,6 +293,10 @@ test_expect_success '--word-diff=none' '
>  	word_diff --word-diff=plain --word-diff=none
>  '
>  
> +test_expect_success 'unset default driver' '
> +	git config --unset diff.wordregex
> +'

Isn't this unsafe if some of the tests before this one failed?

	test_unconfig diff.wordregex

By the way, I really loathe the change that gutted major parts out of
t/test-lib.sh and moved them to another file; now I have to eyeball two
files to write a response like this instead of one.

> +test_expect_failure 'wordRegex for the first file does not apply to the second' '
> +	echo "a diff=tex" >.gitattributes &&
> +	git config diff.tex.wordRegex "[a-z]+|." &&

The use of files "a" and "z" as an example of pair of a tex and non tex
input makes the test look overly artificial (why not a.tex vs z.txt or
something?), but other than that, looks cleanly done.

Thanks.

> +	cat >expect <<-\EOF &&
> +		diff --git a/a b/a
> +		index 9823d38..b09f967 100644
> +		--- a/a
> +		+++ b/a
> +		@@ -1 +1 @@
> +		a [-b-]{+bx+}; c
> +		diff --git a/z b/z
> +		index 9823d38..b09f967 100644
> +		--- a/z
> +		+++ b/z
> +		@@ -1 +1 @@
> +		a [-b;-]{+bx;+} c
> +	EOF
> +	git diff --word-diff HEAD~ >actual
> +	test_cmp expect actual
> +'
> +
>  test_done
